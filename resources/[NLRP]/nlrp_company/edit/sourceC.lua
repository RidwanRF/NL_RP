﻿
local sx,sy = guiGetScreenSize();
local edits = {};

function dxCreateEdit(name,text,defaultText,x,y,w,h,font)
    local id = #edits + 1;

    edits[id] = {name,text,defaultText,x,y,w,h,font,false,0,0,100,getTickCount()};
    return id;
end

function renderEdits()
    for k,v in pairs(edits) do 
        local name,text,defaultText,x,y,w,h,font,active,tick,w2,backState,tickBack = unpack(v);
        --dxDrawRectangle(x,y,w,h,tocolor(0,0,0,150),true); --All BG
        local textWidth = dxGetTextWidth(text, 1, fonts[font], false) or 0;
        if active then 
            edits[k][11] = interpolateBetween(0, 0, 0, 1, 0, 0, (getTickCount()-tick)/200, "Linear"); 
            dxDrawRectangle(x-3,y,3,h*w2,tocolor(183,255,0,225),true);

            local carretAlpha = interpolateBetween(50, 0, 0, 255, 0, 0, (getTickCount()-tick)/1000, "SineCurve");
            local carretSize = dxGetFontHeight(1, fonts[font])*2.4;
            local carretPosX = textWidth > (w-10) and x + w - 10 or x + textWidth + 5
            dxDrawRectangle(carretPosX + 2, y + 2.5,2, h - 5, tocolor(200,200,200, carretAlpha), true);

            if getKeyState("backspace") then
                backState = backState - 1;
            else
                backState = 100;
            end
            if getKeyState("backspace") and (getTickCount() - tickBack) > backState then
                edits[k][2] = string.sub(text, 1, #text - 1);
                edits[k][13] = getTickCount();
            end
        else 
            if w2 > 0 then
                edits[k][11] = interpolateBetween(edits[k][11], 0, 0, 0, 0, 0, (getTickCount()-tick)/200, "Linear");
                dxDrawRectangle(x-3,y,3,h*w2,tocolor(183,255,0,225),true);
            end
        end

        if string.len(text) == 0 or textWidth == 0 then 
            dxDrawText(defaultText,x+5,y,w,y+h,tocolor(255,255,255,120),1,fonts[font],"left","center",false,false,true);
        else 
            if w > textWidth then 
                dxDrawText(text,x+5,y,w,y+h,tocolor(255,255,255),1,fonts[font],"left","center",false,false,true);
            else 
                dxDrawText(text,x+5,y,x+w-5,y+h,tocolor(255,255,255),1,fonts[font],"right","center",true,false,true);
            end
        end
    end
end
addEventHandler("onClientPreRender",root,renderEdits,true,"high");

setTimer(function()
    if #edits > 0 then 
        local guiState = 0;
        for k,v in pairs(edits) do 
            local name,text,defaultText,x,y,w,h,font,active,tick,w2,backState,tickBack = unpack(v);
            if active then 
                guiState = guiState + 1;
            end
        end
        if (guiState > 0) then 
            setElementData(localPlayer,"guiActive",true);
        else 
            setElementData(localPlayer,"guiActive",false); 
        end
    else 
        setElementData(localPlayer,"guiActive",false); 
    end
end,200,0);

addEventHandler("onClientKey",root,function(button,state)
    if button == "mouse1" and state and isCursorShowing() then
        for k,v in pairs(edits) do 
            local name,text,defaultText,x,y,w,h,font,active,tick = unpack(v);
            if not active then 
                if isMouseInPosition(x,y,w,h) then 
                    edits[k][9] = true;
                    edits[k][10] = getTickCount();
                end
            else 
                edits[k][9] = false;
                edits[k][10] = getTickCount();
            end
        end
    end
    
    if button == "tab" and state and isCursorShowing() then 
        if dxGetActiveEdit() then 
            local nextGUI = dxGetActiveEdit()+1;
            if edits[nextGUI] then 
                local current = dxGetActiveEdit();
                edits[current][9] = false;
                edits[current][10] = getTickCount();

                edits[nextGUI][9] = true;
                edits[nextGUI][10] = getTickCount();
            else
                local current = dxGetActiveEdit();
                edits[current][9] = false;
                edits[current][10] = getTickCount();

                edits[1][9] = true;
                edits[1][10] = getTickCount();
            end
        end
        cancelEvent();
    end

    for k,v in pairs(edits) do
        local name,text,defaultText,x,y,w,h,font,active,tick,w2 = unpack(v);
        if active then
            cancelEvent();
        end
    end
end);

addEventHandler("onClientCharacter", root, function(key)
    if isCursorShowing() then 
        for k,v in pairs(edits) do
            local name,text,defaultText,x,y,w,h,font,active,tick,w2 = unpack(v);
            if active then
                edits[k][2] = edits[k][2] .. key;
                --break;
            end
        end
    end
end);

function dxGetActiveEditName()
    local a = false;
    for k,v in pairs(edits) do 
        local name,text,defaultText,x,y,w,h,font,active,tick,w2 = unpack(v);
        if active then 
            a = name;
            break;
        end
    end
    return a;
end

function dxGetActiveEdit()
    local a = false;
    for k,v in pairs(edits) do 
        local name,text,defaultText,x,y,w,h,font,active,tick,w2 = unpack(v);
        if active then 
            a = k;
            break;
        end
    end
    return a;
end

function dxDestroyEdit(id)
    if tonumber(id) then 
        if not edits[id] then return false end;
        table.remove(edits,id)
        --outputDebugString("dxEditbox Destroyed. ID: "..id,0,0,100,100);
        return true;
    else 
        local edit = dxGetEdit(id);
        if not edits[edit] then return false end;
        table.remove(edits,edit);
        --outputDebugString("dxEditbox Destroyed. ID: "..edit,0,0,100,100);
        return true;
    end
end

function dxEditSetText(id,text)
    if tonumber(id) then 
        if not edits[id] then error("Not valid editbox") return false end;
        edits[id][2] = text;
        return true;
    else 
        local edit = dxGetEdit(id);
        if not edits[edit] then error("Not valid editbox") return false end;
        edits[edit][2] = text;
        return true;
    end
end

function dxGetEdit(name)
    local found = false;
    for k,v in pairs(edits) do 
        if v[1] == name then 
            found = k;
            break;
        end
    end
    return found;
end

function dxGetEditText(id)
    if tonumber(id) then 
        if not edits[id] then error("Not valid editbox") return false end;
        return edits[id][2];
    else 
        local edit = dxGetEdit(id);
        if not edits[edit] then error("Not valid editbox") return false end;
        return edits[edit][2];
    end
end

function dxSetEditPosition(id,x,y)
    if tonumber(id) then 
        if not edits[id] then error("Not valid editbox") return false end;
        edits[id][4] = x;
        edits[id][5] = y;
        return true;
    else
        local edit = dxGetEdit(id);
        if not edits[edit] then error("Not valid editbox") return false end;
        edits[edit][4] = x;
        edits[edit][5] = y;
        return true;
    end
end

function isMouseInPosition(x, y, w, h)
	if not isCursorShowing() then return end;
	local pos = {getCursorPosition()};
	pos[1], pos[2] = (pos[1] * sx), (pos[2] * sy);
	if pos[1] >= x and pos[1] <= (x + w) and pos[2] >= y and pos[2] <= (y + h) then
		return true;
    else 
        return false;
    end
end
