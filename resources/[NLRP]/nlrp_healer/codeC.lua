local s = {guiGetScreenSize()}
local sx, sy = guiGetScreenSize()
local box = {428, 270}
local panel = {s[1]/2 -box[1]/2,s[2]/2 - box[2]/2}
local font = dxCreateFont("fonts/font.ttf",12)
local showHeal = false

function renderHealPanel()
    local factionMembers = 0
	for k,v in ipairs(getElementsByType("player")) do
		if exports.nlrp_groups:isPlayerInGroup(v,5) then
			if getElementData(v,"groupDuty") then
				factionMembers = factionMembers + 1
			end
        end
    end
    if factionMembers < 1 then
    dxDrawImage(panel[1], panel[2], box[1], box[2], "files/background.png", 0,0,0, tocolor(0,0,0,255))

    local healtAmount = 50000
    dxDrawImage(panel[1], panel[2] - 25, box[1], box[2], "files/bar.png", 0,0,0, tocolor(0,0,0,180))
    --dxDrawImageSection(panel[1], panel[2] - 25,math.floor(healtAmount) * 4.28,box[2],0,0,math.floor(healtAmount) * 4.28,box[2],"files/bar-blue.png", 0,0,0, tocolor(255,255,255,200))
    
    if getElementHealth(localPlayer) <= 98 then
        dxDrawRectangle(panel[1] + 74, panel[2] + 68, - 5 + (100 - getElementHealth(localPlayer))  * 2.75, 30,tocolor(124,197,118,150))
    end

    dxDrawText("Ellátás igénylése", panel[1] + 211, panel[2] + 139, panel[1] + 211, panel[2] + 139, tocolor(0,0,0,255), 1, font, "center", "top", true, true, true, true)
    dxDrawText("Ellátás igénylése", panel[1] + 212, panel[2] + 138, panel[1] + 212, panel[2] + 138, tocolor(200,200,200,255), 1, font, "center", "top", true, true, true, true)
    if isInSlot(panel[1] + 75, panel[2] + 133, box[1] - 150, 30) then
        dxDrawImage(panel[1], panel[2] + 40, box[1], box[2], "files/bar-blue.png", 0,0,0, tocolor(255,255,255,175)) 
        dxDrawImage(panel[1], panel[2] + 40, box[1], box[2], "files/bar.png", 0,0,0, tocolor(0,0,0,200))
    else
        dxDrawImage(panel[1], panel[2] + 40, box[1], box[2], "files/bar.png", 0,0,0, tocolor(0,0,0,200))
    end

    dxDrawText("Panel bezárása", panel[1] + 213, panel[2] + 179, panel[1] + 213, panel[2] + 179, tocolor(0,0,0,255), 1, font, "center", "top", true, true, true, true)
    dxDrawText("Panel bezárása", panel[1] + 212, panel[2] + 178, panel[1] + 212, panel[2] + 178, tocolor(200,200,200,255), 1, font, "center", "top", true, true, true, true)
    if isInSlot(panel[1] + 75, panel[2] + 173, box[1] - 150, 30) then
        dxDrawImage(panel[1], panel[2] + 80, box[1], box[2], "files/bar-blue.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawImage(panel[1], panel[2] + 80, box[1], box[2], "files/bar.png", 0,0,0, tocolor(0,0,0,200))
    else
        dxDrawImage(panel[1], panel[2] + 80, box[1], box[2], "files/bar.png", 0,0,0, tocolor(0,0,0,200))
    end

  
    dxDrawText("Az ellátásod: 50000 Ft", panel[1] + 213, panel[2] + 106, panel[1] + 213, panel[2] + 106, tocolor(255,255,255,255), 1, font, "center", "top", true, true, true, true)
end
end
addEventHandler("onClientPlayerStealthKill", getLocalPlayer(),function(target)
	if getElementData(target,"isHealPed") then
		cancelEvent()
	end
end)
antiSpam = {}

addEventHandler("onClientClick", root,
    function(b, s)
        if showHeal then
            if b == "left" and s == "down" then
                local healtAmount = 50000
                if isInSlot(panel[1] + 75, panel[2] + 133, box[1] - 150, 30) then
                         local money = getElementData(localPlayer,"char.Money")
                        if getElementData(localPlayer,"char.Money") >= 50000 then
					    setElementData(localPlayer,"char.Money",money-50000)
					    showHeal = false
                        removeEventHandler("onClientRender", root, renderHealPanel)
                         setElementHealth(localPlayer,100)
                         setElementData(localPlayer, "usingBandage", true)
                         setElementData(localPlayer, "bloodLevel", 100)
                         setElementData(localPlayer, "isPlayerDeath", false)
                         setElementData(localPlayer, "bulletDamages", false)
                        --setElementData(source, "boneDamages", false)
                        setElementData(localPlayer, "deathReason", false)
                        setElementData(localPlayer, "customDeath", false)
                        toggleControl('sprint', true)
                        toggleControl('jump', true)
                        toggleControl('forwards', true)
                        toggleControl('left', true)
                        toggleControl('right', true)
                        toggleControl('backwards', true)
                        toggleControl('enter_passenger', true)
                        toggleControl('enter_exit', true)
                        toggleControl('fire', true)
                        toggleControl('aim_weapon', true)
                        toggleControl('jump', true)
                    end
                else
                    outputChatBox("Nincs elég pénzed",255,255,255,true)
                end
                elseif isInSlot(panel[1] + 75, panel[2] + 173, box[1] - 150, 30) then
                    showHeal = false
                    removeEventHandler("onClientRender", root, renderHealPanel)
                end
            end
        end
    
)

addEvent("showHealPanel",true)
addEventHandler("showHealPanel",getRootElement(),function()
    local factionMembers = 0
	for k,v in ipairs(getElementsByType("player")) do
		if exports.nlrp_groups:isPlayerInGroup(v,3) then
			if getElementData(v,"groupDuty") then
				factionMembers = factionMembers + 1
			end
        end
    end
    if factionMembers < 1 then
    	showHeal = true
        addEventHandler("onClientRender", root, renderHealPanel, true, "low")
        oneHealAmount = 2
    end
end)

addEvent("destHealPanel",true)
addEventHandler("destHealPanel",getRootElement(),function()
	showHeal = false
    removeEventHandler("onClientRender", root, renderHealPanel)
end)

local cursorState = isCursorShowing()
local cursorX, cursorY = sx/2, sy/2
if cursorState then
    local cursorX, cursorY = getCursorPosition()
    cursorX, cursorY = cursorX * sx, cursorY * sy
end

addEventHandler("onClientCursorMove", root, 
    function(_, _, x, y)
        cursorX, cursorY = x, y
    end
)

function inBox(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		--XY = {guiGetScreenSize()}
		--local cursorX, cursorY = getCursorPosition()
		--cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(inBox(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end
