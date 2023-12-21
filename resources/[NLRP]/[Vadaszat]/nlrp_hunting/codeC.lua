if fileExists("codeC.lua") then
	fileDelete("codeC.lua")
end

local timers = {}
local fontsize = 1
local font = dxCreateFont("files/font.ttf", 12)
local opensans = dxCreateFont("files/opensans.ttf", 12)
local clickTimer 
local clickType = 1
local clickedAnimalElement = nil
local clickedAnimalSecondElement = nil
local elementText = "ASD"

addEventHandler("onClientResourceStart",resourceRoot,function()
	ped = createPed(250,-1421.0469970703,-1523.2117919922,-101.73811340332)
	setElementFrozen(ped,true)
	setElementRotation(ped,0,0,344.88049316406)
	setElementInterior(ped,0)
	setElementDimension(ped,0)
	setElementData(ped,"nameEnabled",true)
	setElementData(ped,"name","fasz")
	colshape = createColCuboid(-1421.0469970703,-1523.2117919922,-101,1.0, 1.0, 2.0)
end)

addEventHandler("onClientColShapeHit",getRootElement(),function(thePlayer, matchingDimension)
	if source == colshape then
		if thePlayer == localPlayer and matchingDimension then
			if not isElement(getPedOccupiedVehicle(localPlayer)) then
				triggerServerEvent("giveVadaszMoney",localPlayer,localPlayer)
			end
		end
	end
end)


function finishLearningProcess(isSucceed)
	if isSucceed then
		local skin = getElementModel(clickedAnimalElement)
		local itemID = itemReceivers[skin][clickType]
		local animalTyp = itemReceivers[skin][5]
		outputChatBox("[NextLevel]:#ffffff Sikeresen szereztél egy #e5a00c"..animalTyp.." "..elementText.."t#ffffff, menj el #e5a00cSan Fierro#ffffff-ba és keresd meg a húsüzem alkalmazottját.",183,255,0,true)
		triggerServerEvent("hunter:destroyAnimal",root,clickedAnimalSecondElement)
		triggerServerEvent("server:giveItem",root,localPlayer,itemID)
	else
		setElementData(clickedAnimalElement, "hunter:use", false)
		setElementData(clickedAnimalElement, "hunter:clicks", 0)
	end
	triggerServerEvent("serverHunterAnim",localPlayer,localPlayer,2)
end

addEventHandler("onClientPedDamage", root,
    function(e)
		if getElementData(source, "hunter:animal") then
			cancelEvent()
			if e and getElementType(e) ~= "player" then
				return
			end
			if getElementData(e,"charAduty") == 1 then
				cancelEvent()
			else
				local x,y,z = getElementPosition(source)
				local px,py,pz = getElementPosition(e)
				local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if d < maxDist + 20 and not isElementFrozen(e) then
					local multipler = 1-d/maxDist
					local oldHealth = getElementData(source, "hunter:health")
					local damage = 4
					local weapon = getPedWeapon(e)
					for k,v in ipairs(weaponDamages) do
						if v[1] == weapon then
							damage = v[2] * multipler
						end
					end
					triggerServerEvent("hunter:startAttack", root, e, source)
					setElementData(source, "hunter:health", oldHealth - damage)
				end
			end
		end
	end
)

addEventHandler("onClientPlayerDamage", getLocalPlayer(),function(attacker,weapon,bodypart)
	if getElementData(attacker,"hunter:animal") == true then
		if getElementData(localPlayer,"charAduty") == 1 then
			cancelEvent()
		else
			if getElementModel(attacker) == 304 then
				setElementHealth(localPlayer,getElementHealth(localPlayer)-0.002)
			else
				setElementHealth(localPlayer,getElementHealth(localPlayer)-25)
			end
		end
	end
end)

local cursorX, cursorY = 0,0

function checkCursor()
	if not guiGetInputEnabled() and not isMTAWindowActive() and isCursorShowing( ) then
		return true
	else
		return false
	end
end

addEventHandler("onClientCursorMove", root,
	function(_,_,x,y)
		cursorX = x
		cursorY = y
	end
)

function inBox(xmin,ymin,xmax,ymax)
	if checkCursor() then
		x,y = cursorX, cursorY
		xmin = tonumber(xmin) or 0
		xmax = (tonumber(xmax) or 0)+xmin
		ymin = tonumber(ymin) or 0
		ymax = (tonumber(ymax) or 0)+ymin
		return x >= xmin and x <= xmax and y >= ymin and y <= ymax
	else
		return false
	end
end

setTimer(
    function()
	    for k,v in ipairs(getElementsByType("ped")) do
		   if getElementData(v, "hunter:animal") then
		       if getElementData(v, "hunter:autoAttack") then
			       local x,y,z = getElementPosition(v)
				   local px,py,pz = getElementPosition(localPlayer)
			       local d = getDistanceBetweenPoints3D(x,y,z, px,py,pz)
			       if not getElementData(v, "hunter:attack") and d < maxDist then
				       triggerServerEvent("hunter:startAttack", root, localPlayer, v)
				   end
		       end
		   end
		end
    end, 2000, 0
)

addEventHandler("onClientElementDataChange", root,
   function(dName, oldValue)
       if getElementType(source) == "ped" and getElementData(source, "hunter:animal") then
	       if dName == "hunter:target" then
		       local e = getElementData(source, dName)
			   if isElement(e) then
			       npc_follow(source, e)
			   end
		   end
	   end
   end
)

addEvent("hunter:sound", true)
addEventHandler("hunter:sound", root,
   function(sound, x,y,z)
      local soundElement = playSound3D(sound, x,y,z, false)
	  setSoundMaxDistance(soundElement, maxInteract)
   end
)

local t_Data = {}
 
function npc_follow(npc) 
    local who = getElementData(npc, "hunter:target")
    local intX, intY, intZ = getElementPosition (who)
    local _, _, intRZ = getElementRotation (who)
    local t_Matrix = getElementMatrix (who)
   
    local intPedX = -4 * t_Matrix[2][1] + t_Matrix[4][1]
    local intPedY = -4 * t_Matrix[2][2] + t_Matrix[4][2]
    local intPedZ = -4 * t_Matrix[2][3] + t_Matrix[4][3]
   
    local num = #t_Data + 1
	
	t_Data[num] = {}
	t_Data[num].ped = npc

    t_Data[num].updateNPCTimer = setTimer(npc_updatePosition, 50, 0, num)
end

function npc_toggleFollow(num) 
    if (t_Data[num].ped) then
        if (t_Data[num].updateNPCTimer) then
            if (isTimer(t_Data[num].updateNPCTimer)) then
                killTimer (t_Data[num].updateNPCTimer)
            end
        end
        if (isElement(t_Data[num].ped)) then
            destroyElement (t_Data[num].ped)
        end
		setElementData (t_Data[num].ped, "hunter:attack", false)
        t_Data[num].ped = nil
		t_Data[num] = nil
        return true
    end
end

function npc_updatePosition(e)
    if not isElement(t_Data[e].ped) or isElementFrozen(t_Data[e].ped) then
        return npc_toggleFollow(e)
    end
   
    local who = getElementData(t_Data[e].ped, "hunter:target")
	local t_PlayerPos
	if who then
        t_PlayerPos = {getElementPosition(who)}
    else
	    t_PlayerPos = getElementData(t_Data[e].ped, "hunter:defPos")
	end
    local t_PedPos = {getElementPosition(t_Data[e].ped)}
    local intDistance = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_PlayerPos))
	
	if intDistance > maxDist then
	    setElementData(t_Data[e].ped, "hunter:target", nil)
		setElementData(t_Data[e].ped, "hunter:attack", false)
	    t_PlayerPos = getElementData(t_Data[e].ped, "hunter:defPos")
	end
	
	local intDistance = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_PlayerPos))
	
	local t_LocalPos = {getElementPosition(localPlayer)}
	local localDist = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_LocalPos))
	
	if localDist > maxDist and intDistance <= 1 then
	    setPedControlState (t_Data[e].ped, 'forwards', false)
	    return npc_toggleFollow(e)
	end
	
	local t_LocalPos = getElementData(t_Data[e].ped, "hunter:defPos")
	local localDist = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_LocalPos))
	
	if localDist > maxDist * 3 then
	    setElementPosition (t_Data[e].ped, unpack(t_LocalPos))
	    setPedControlState (t_Data[e].ped, 'forwards', false)
	    return npc_toggleFollow(e)
	end
	
	if not who and intDistance <= 1 or isElementFrozen(t_Data[e].ped) then
	    setPedControlState (t_Data[e].ped, 'forwards', false)
		return npc_toggleFollow(e)
	end
	
    if (intDistance < 1) then
	    setPedControlState (t_Data[e].ped, 'forwards', false)
		local state = not getPedControlState(t_Data[e].ped, "fire")
		setPedControlState(t_Data[e].ped, "fire", state)
        return true
    end
   
    local intPedRot = -math.deg (math.atan2(t_PlayerPos[1] - t_PedPos[1], t_PlayerPos[2] - t_PedPos[2]))
    if intPedRot < 0 then intPedRot = intPedRot + 360 end;
   
    setElementRotation (t_Data[e].ped, 0, 0, intPedRot, 'default', true)
    setPedControlState (t_Data[e].ped, 'forwards', true)
   
    local bPathClear = true
    local t_Matrix = getElementMatrix (t_Data[e].ped)
   
    local int_RayX = t_Matrix[2][1] + t_Matrix[4][1]
    local int_RayY = t_Matrix[2][2] + t_Matrix[4][2]
    local int_RayZ = t_Matrix[2][3] + t_Matrix[4][3]
   
    for i = 1, 10 do
        local intSourceX, intSourceY, intSourceZ = t_PedPos[1], t_PedPos[2], t_PedPos[3]
        local intTargetX, intTargetY, intTargetZ = int_RayX, int_RayY, int_RayZ - 0.5 + i*0.2
       
        bPathClear = isLineOfSightClear (intSourceX, intSourceY, intSourceZ, intTargetX, intTargetY, intTargetZ, true, true, false, true)       
        if (not bPathClear) then
            break
        end
    end

    if (not bPathClear) then
        setPedControlState (t_Data[e].ped, 'jump', true)
    else
        setPedControlState (t_Data[e].ped, 'jump', false)
    end
   
    if (intDistance > 8) then
        setPedControlState (t_Data[e].ped, 'sprint', true)
    else
        setPedControlState (t_Data[e].ped, 'sprint', false)
    end
end

local interactElement
local interactStat = false
local distance = 30
local anim = false
local animX = 0
local animState = "Nem ismert."
local animText = animTexts[1][1]
local animNum = 1
local xPlus = 2
local animBoxX = 550
local animBoxY = 20
local animMaxX = animBoxX / 2
local ar,ag,ab,aa = 124, 197, 118, 180
local sx, sy = 0,0
local interactGui 
local selectedElement

addEventHandler("onClientClick", root,
    function(b, s, sx,sy,_,_,_, e)
	    if e and getElementType(e) == "ped" and getElementData(e, "hunter:animal") and isElementFrozen(e) and not interactStat then
			if getElementData(e,"visibleName") == "Csirke" then
				outputChatBox("Ez egy csirke, szóval baszhatod.")
			else
				local x,y,z = getElementPosition(e)
				local px,py,pz = getElementPosition(localPlayer)
				local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				local bPathClear = isLineOfSightClear(x,y,z, px,py,pz , true, true, false, true)
				if b == "right" and s == "down" and d < 1 and not anim and not getElementData(e, "hunter:use") and tonumber(getElementData(e, "hunter:clicks") or 0) == 0 then
					setElementFrozen(localPlayer,true)
					interactGui = guiCreateWindow(sx, sy, rectangleSize[1], 20, " Teszt ", false)
					guiSetAlpha(interactGui, 0)
					guiWindowSetSizable(interactGui, false)
					setElementData(e, "hunter:use", true)
					setElementData(e, "hunter:clicks", 1)
					interactElement = e
					selectedElement = e
					interactStat = true
				end
			end
		end
	end
)

setTimer(
    function()
	    if interactStat then
	        local x,y,z = getElementPosition(interactElement)
			local px,py,pz = getElementPosition(localPlayer)
			local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			local bPathClear = isLineOfSightClear(x,y,z, px,py,pz , true, true, false, true)
	        if d > maxInteract or not bPathClear then
			    setElementData(interactElement, "hunter:use", false)
				setElementData(interactElement, "hunter:clicks", 0)
		        interactStat = false
			end
		end
	end, 2000, 0
)

addEventHandler("onClientRender", root,
    function()
	    if interactStat then
		    local x,y,z = getElementPosition(interactElement)
		    local sx, sy = guiGetPosition(interactGui, false)
			local px,py,pz = getElementPosition(localPlayer)
			local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			if sx and sy and d < maxInteract then
			    local size = 1-d/maxDist
			    local x, y = rectangleSize[1] * size, rectangleSize[2] * size
			    dxDrawRectangle(sx, sy, x, y, tocolor(0,0,0,120))
				dxDrawRectangle(sx, sy-2, x, 2, tocolor(0,0,0,180))
				dxDrawRectangle(sx, sy+y, x, 2, tocolor(0,0,0,180))
				dxDrawRectangle(sx-2, sy-2, 2, y+4, tocolor(0,0,0,180))
				dxDrawRectangle(sx+x, sy-2, 2, y+4, tocolor(0,0,0,180))
				
				local x, y = rectangleSize[3] * size, rectangleSize[4] * size
				if inBox(sx+10, sy+10, x, y) then
				    dxDrawRectangle(sx+ 10, sy+10, x, y, tocolor(183,255,0,200))
				else
					dxDrawRectangle(sx+ 10, sy+10, x, y, tocolor(0,0,0,80))
				end
				dxDrawText("Megnyúzás", sx+10+x/2, sy + y/2+20, sx+10+x/2, sy + y/2, tocolor(255,255,255,255), 1, font, "center", "center")
				
                local x, y = rectangleSize[3] * size, rectangleSize[4] * size
				if inBox(sx + 10, sy + (y + 20), x, y) then
				    dxDrawRectangle(sx + 10, sy + (y + 20), x, y, tocolor(183,255,0,200))
				else
					dxDrawRectangle(sx + 10, sy + (y + 20), x, y, tocolor(0,0,0,80))
				end
				dxDrawText("Hús lemetszése", sx+10+x/2, sy + y/2 + (y + 30), sx+10+x/2, sy + y/2 + (y + 10), tocolor(255,255,255,255), 1, font, "center", "center")
				
				local x, y = rectangleSize[3] * size, rectangleSize[4] * size
				if inBox(sx+10, sy + (y*2 + 30), x, y) then
					dxDrawRectangle(sx+ 10, sy + (y*2 + 30), x, y, tocolor(183,255,0,200))
				else
					dxDrawRectangle(sx+ 10, sy + (y*2 + 30), x, y, tocolor(0,0,0,80))
				end
				dxDrawText("Bezárás", sx+10+x/2, sy + y/2 + (y*2 + 40), sx+10+x/2, sy + y/2 + (y*2  + 20), tocolor(255,255,255,255), 1, font, "center", "center")
			end
		end
	end
)

addEventHandler("onClientClick", root,
    function(b, s, _,_,_,_,_, e)
	    if interactStat then
		    if b == "left" and s == "down" then
			    local x,y,z = getElementPosition(interactElement)
		    	local sx, sy = guiGetPosition(interactGui, false)
				local px,py,pz = getElementPosition(localPlayer)
				local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if sx and sy and d < maxInteract then
				    local size = 1-d/maxDist
					local x, y = rectangleSize[3] * size, rectangleSize[4] * size
					if inBox(sx+10, sy+10, x, y) then
                        triggerServerEvent("serverHunterAnim",localPlayer,localPlayer,1)
						elementText = "bőr"
						clickedAnimalElement = interactElement
						clickedAnimalSecondElement = selectedElement
						interactStat = false
						setBalanceQTEState(true, 1)
						clickType = 1
						if isElement(interactGui) then
							destroyElement(interactGui)
						end
					elseif inBox(sx + 10, sy + (y + 20), x, y) then
						triggerServerEvent("serverHunterAnim",localPlayer,localPlayer,1)
					    elementText = "hús"
						clickedAnimalElement = interactElement
						clickedAnimalSecondElement = selectedElement
						interactStat = false
						setBalanceQTEState(true, 1)
						clickType = 2
						if isElement(interactGui) then
							destroyElement(interactGui)
						end
					elseif inBox(sx+10, sy + (y*2 + 30), x, y) then
				    	setElementFrozen(localPlayer,false)
						interactStat = false
						setElementData(interactElement, "hunter:use", false)
						setElementData(interactElement, "hunter:clicks", 0)
						if isElement(interactGui) then
							destroyElement(interactGui)
						end
					end
				end
			end
		end
	end
)

local ax, ay = guiGetScreenSize()

function abortAllStealthKills(targetPlayer)
	if getElementType ( targetPlayer ) == "ped" and (getElementData(targetPlayer, "hunter:animal")) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerStealthKill", getLocalPlayer(), abortAllStealthKills)