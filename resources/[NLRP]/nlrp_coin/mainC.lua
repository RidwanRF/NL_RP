local s = Vector2(guiGetScreenSize())
local size = Vector2(300,170)
local showCoin = false
local guiAlpha = 255
local coinTables = {
    {"",false,false},
    {"Coin Vársárlása",true,false},
    {"Coin Eladása",true,false},
    {"Kilépés",true,true},
}

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        for k,v in ipairs(pedPos) do
            coinPed = createPed(v[1],v[2],v[3],v[4],v[5])
            setElementInterior(coinPed,v[6])
            setElementDimension(coinPed,v[7])
            setElementData(coinPed,"ped.name",v[8])
            setElementData(coinPed,"ped >> slot",true)
        end
    end
)

function rederCoin()
    if showCoin then
        local main = Vector2(s.x/2-size.x/2,s.y/2-size.y/2)
        dxDrawRectangle(main.x,main.y,size.x,size.y,tocolor(25,25,25))
        dxDrawRectangle(main.x,main.y,size.x,30,tocolor(0,0,0,70))
        centeredText(serverName,main.x,main.y,size.x,30,tocolor(255,255,255),1,serverFont,true)
        centeredText("+",main.x+size.x-35,main.y,size.x,30,tocolor(255,255,255),1,serverFont,true,true)
        for k,v in ipairs(coinTables) do
            if isMouseInPosition(main.x+4,main.y+34*k,size.x-8,30) and v[2] then
                if not v[3] then
                    hoverColor = tocolor(serverRgbColor[1],serverRgbColor[2],serverRgbColor[3],180)
                else
                    hoverColor = tocolor(220,73,73,180)
                end
            else
                hoverColor = tocolor(35,35,35)
            end
            dxDrawRectangle(main.x+4,main.y+34*k,size.x-8,30,hoverColor)
            centeredText(v[1],main.x+4,main.y+34*k,size.x-8,30,tocolor(255,255,255),1,serverFont,true)
            if k == 1 then
                if guiActive then
                    if string.find(guiGetText(editBox),"%D") then
                        guiSetText(editBox,"")
                    end

                    local guiProgress = ((getTickCount()-currentTick)/guiTime) 
                    local guiAlpha = interpolateBetween(255,0,0,0,0,0,guiProgress,"Linear")
                    if guiAlpha == 0 then
                        currentTick = getTickCount() 
                        guiTime = 1000
                    end
                    centeredText("|",main.x+dxGetTextWidth(guiGetText(editBox),0.55,serverFont,true)+7,main.y+34*k,size.x-8,30,tocolor(255,255,255,guiAlpha),1,serverFont) 
                end
                if string.len(guiGetText(editBox)) > 0 then
                    centeredText(formatMoney(guiGetText(editBox)),main.x+4,main.y+34*k,size.x-8,30,tocolor(255,255,255),1,serverFont,true)
                else
                    centeredText(guiGetText(editBox),main.x+4,main.y+34*k,size.x-8,30,tocolor(255,255,255),1,serverFont,true)
                end
            end
            if k == 3 then
                if isMouseInPosition(main.x+size.x-20,main.y,15,30) then
                    createTooltip(formatMoney(getElementData(localPlayer,coinData) or 0).." Coin \n"..formatMoney(getElementData(localPlayer,moneyData) or 0).." "..moneyValute)
                end
            end
        end
    end
end

addEventHandler("onClientClick",root,
    function(key,state,_,_,_,_,_,element)
        if key == "right" and state == "up" then
            if element and getElementData(element,"ped >> slot") then
                if not showCoin then
                    addEventHandler("onClientRender",root,rederCoin)
                    showCoin = true
                    editBox = guiCreateEdit(-1000,-1000,100,100,"",false)
                    guiEditSetMaxLength(editBox,10)
                end
            end
        end
        if key == "left" and state == "down" then
            if showCoin then
                local main = Vector2(s.x/2-size.x/2,s.y/2-size.y/2)
                for k,v in ipairs(coinTables) do
                    if isMouseInPosition(main.x+4,main.y+34*k,size.x-8,30) then
                        if k == 1 then
                            guiBringToFront(editBox)
                            currentTick = getTickCount() 
                            guiTime = 1000
                            guiActive = true
                        elseif k == 2 then
                            if getElementData(localPlayer,moneyData) >= tonumber(guiGetText(editBox)*coinValue) then
                                triggerServerEvent("serverElementData",resourceRoot,localPlayer,moneyData,getElementData(localPlayer,moneyData)-(guiGetText(editBox)*coinValue))
                                triggerServerEvent("serverElementData",resourceRoot,localPlayer,coinData,(getElementData(localPlayer,coinData) or 0)+guiGetText(editBox))
                                outputChatBox(serverColor.."[Információ]"..whiteColor.." Sikeresen vásároltál "..serverColor..formatMoney(guiGetText(editBox))..whiteColor.." coint!",255,255,255,true)
                            else
                                outputChatBox("#d75959[Hiba]"..whiteColor.." Nincs elegendő kézpénzed!",255,255,255,true)
                            end
                        elseif k == 3 then
                            if (getElementData(localPlayer,coinData) or 0) >= tonumber(guiGetText(editBox)) then
                                triggerServerEvent("serverElementData",resourceRoot,localPlayer,coinData,getElementData(localPlayer,coinData)-(guiGetText(editBox)))
                                triggerServerEvent("serverElementData",resourceRoot,localPlayer,moneyData,getElementData(localPlayer,moneyData)+(guiGetText(editBox)*coinValue))
                                outputChatBox(serverColor.."[Információ]"..whiteColor.." Sikeresen eladtál "..serverColor..formatMoney(guiGetText(editBox))..whiteColor.." coint!",255,255,255,true)
                            else
                                outputChatBox("#d75959[Hiba]"..whiteColor.." Nincs elegendő coin mennyiséged!",255,255,255,true)
                            end
                        elseif k == 4 then
                            removeEventHandler("onClientRender",root,rederCoin)
                            showCoin = false
                            if isElement(editBox) then
                                destroyElement(editBox)
                            end
                        end
                    elseif isMouseInPosition(0,0,s.x,s.y) and not isMouseInPosition(main.x+4,main.y+34,size.x-8,30) then
                        if guiActive then
                            guiActive = false
                        end
                    end
                end
            end
        end
    end
)
