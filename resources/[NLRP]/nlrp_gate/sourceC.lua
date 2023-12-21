
local gateObjects = {
	-- ObjID, NÉV
	{980, "Kapu 1"},
	{969, "Kapu 2"},
	{971, "Kapu 3"},
	{975, "Kapu 4"},
	{976, "Kapu 5"},
	{988, "Kapu 6"},
	{989, "Kapu 7"},
	{3037, "Kapu 8"},
	{2957, "Kapu 9"},
	{2957, "Kapu 9"},
	{968, "Sorompó 1"},
	{2930, "Rácsos ajtó 1"},
	{1495, "Ajtó 1"},
	{1500, "Ajtó 2"},
	{1536, "Ajtó 3"},
	{1569, "Ajtó 4"},
}

local screenX, screenY = guiGetScreenSize()

local gateEditorMode = false
local gateEditorState
local fastMode = false
local nearbyGateMode = false


local gateData = {
	["objectID"] = 980,
	["open"] = {},
	["close"] = {},
	["time"] = 5,
	["int-dim"] = {},
}

function createPreviewGate(objID)
	if not gateEditorMode then
	
		destroyCreateWindow()
		
		local pX, pY, pZ = getElementPosition(localPlayer)
		local prX, prY, prZ = getElementRotation(localPlayer)
		local pInt = getElementInterior(localPlayer)
		local pDim = getElementDimension(localPlayer)
		
		gateEditorState = 1
		
		outputChatBox("#b7ff00GATE : #ffffffHelyezd el a kaput zárt pozicióban", 0, 0, 0, true)
		
		gateEditorMode = true
		
		if isElement(previewGateObj) then
			destroyElement(previewGateObj)
		end
		
		gateData["objectID"] = objID
		
		previewGateObj = createObject(objID, pX, pY, pZ, 0, 0, 0)
		setElementCollisionsEnabled(previewGateObj, false)
		setElementAlpha(previewGateObj, 170)
		setElementInterior(previewGateObj, pInt)
		setElementDimension(previewGateObj, pDim)
	end
end

function nearbyGates()
	if getElementData(localPlayer, "acc.adminLevel") >= 6 then
		if (nearbyGateMode) then
			outputChatBox("Kapu ID-k eltűntetve")
		else
			outputChatBox("Kapu ID-k megjelenítve")
		end
		nearbyGateMode = not nearbyGateMode
	end
end
addCommandHandler("nearbygates", nearbyGates)

function createGateWindow()
	showCursor(true)

	destroyCreateWindow()

	local windowWidth, windowHeight = 300, 400
	gateW = guiCreateWindow(50, screenY - windowHeight - 20, windowWidth, windowHeight, "Kapu létrehozás", false)
	local gateLabel = guiCreateLabel(0.1, 0.075, 1, 0.05, "Válaszd ki a kaput", true, gateW)
	gateList = guiCreateGridList(0.1, 0.15, 0.8, 0.5, true, gateW)
	gateOkBtn = guiCreateButton(0.1, 0.7, 0.8, 0.1, "Ok", true, gateW)
	gateNoBtn = guiCreateButton(0.1, 0.83, 0.8, 0.1, "Mégse", true, gateW)
	
	local guiListColumn1 = guiGridListAddColumn(gateList, "Obj ID", 0.25 )
	local guiListColumn2 = guiGridListAddColumn(gateList, "Név", 0.65 )
	
	for	k, gate in ipairs(gateObjects) do
		local row = guiGridListAddRow(gateList)
		guiGridListSetItemText(gateList, row, guiListColumn1, gate[1],false, true)
		guiGridListSetItemText(gateList, row, guiListColumn2, gate[2],false, true)
		
	end
	
	addEventHandler("onClientGUIClick", gateOkBtn, guiButtonsActions)
	addEventHandler("onClientGUIClick", gateNoBtn, guiButtonsActions)
end

function destroyCreateWindow()
	if isElement(gateW) then
		destroyElement(gateW)
	end
end

function guiButtonsActions(button, state)

	if (source == gateOkBtn) then
		local objectID = guiGridListGetItemText(gateList, guiGridListGetSelectedItem(gateList), 1)
		if tonumber(objectID) then
			createPreviewGate(tonumber(objectID))
			showCursor(false)
		else
			outputChatBox("#b7ff00GATE : #ffffffNem jelöltél ki egy kaput se", 0, 0, 0, true)
		end
		
	elseif (source == gateNoBtn) then
		destroyCreateWindow()
		showCursor(false)
	end
end

local mode
local pass

function createGateByCommand(commandName, grouporcode, groupcode)
	if getElementData(localPlayer, "acc.adminLevel") >= 6 then
		if (grouporcode and (grouporcode == "group" or grouporcode == "code")) then
			if (groupcode) then
				mode = grouporcode
				pass = groupcode
				createGateWindow()
			else
				outputChatBox("[HASZNÁLAT] #FFFFFF/creategate [group/code] #db2828[groupID/Pass]",255,255,255,true)
			end
		else
			outputChatBox("[HASZNÁLAT] #FFFFFF/creategate #db2828[group/code] #FFFFFF[groupID/Pass]",255,255,255,true)
		end
	else
		outputChatBox(":( Ehhez túl kicsi a pöcsöd",255,255,255,true)
	end
end
addCommandHandler("creategate", createGateByCommand)


function destroyPreviewGate()
	if isElement(previewGateObj) then
		destroyElement(previewGateObj)
	end
	
	
	gateEditorMode = false
	gateEditorState = 1
end


addEventHandler("onClientPreRender", root, function()
	if gateEditorMode then
		local gX, gY, gZ = getElementPosition(previewGateObj)
		local grX, grY, grZ = getElementRotation(previewGateObj)
		
		moveValue = 0.01
		
		if fastMode then
			moveValue = 0.1
		else
			moveValue = 0.01
		end
		
		if getKeyState("num_4") then
			setElementPosition(previewGateObj, gX + moveValue, gY, gZ)
		elseif getKeyState("num_6") then
			setElementPosition(previewGateObj, gX - moveValue, gY, gZ)
		elseif getKeyState("num_8") then
			setElementPosition(previewGateObj, gX, gY + moveValue, gZ)
		elseif getKeyState("num_2") then
			setElementPosition(previewGateObj, gX, gY - moveValue, gZ)
		elseif getKeyState("num_7") then
			setElementRotation(previewGateObj, grX, grY, grZ + moveValue)
		elseif getKeyState("num_1") then
			setElementRotation(previewGateObj, grX, grY, grZ - moveValue)
		elseif getKeyState("num_9") then
			setElementPosition(previewGateObj, gX, gY, gZ + moveValue)
		elseif getKeyState("num_3") then
			
			setElementPosition(previewGateObj, gX, gY, gZ - moveValue)	
		end
	end
end)


addEventHandler("onClientRender", root, function()
	
	selectedGateButton = -1
	
	if nearbyGateMode then
		for k, object in ipairs(getElementsByType("object", getResourceRootElement())) do
			if object and isElement(object) then

				local gateID = getElementData(object, "gate.id")
				
				if gateID then
					local playerX, playerY, playerZ = getElementPosition(localPlayer)
					local objectX, objectY, objectZ = getElementPosition(object)
					local objectDistance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, objectX, objectY, objectZ)
					
					if objectDistance <= 15 then
						local screenX, screenY = getScreenFromWorldPosition(objectX, objectY, objectZ + 1, 1)
						
						if screenX and screenY then
							local scaleMultiplier = 1 - (objectDistance / 10) * 0.5
							local buttonWidth = (dxGetTextWidth("Törlés", 1.2, "default") + 20) * scaleMultiplier
							local boxWidth, boxHeight = (dxGetTextWidth("#b7ff00[GATE] #FFFFFFID: " .. gateID .. " ", 1.2, "default", true) + 20) * scaleMultiplier, (dxGetFontHeight(1.0, "default") + 10) * scaleMultiplier
							local boxX, boxY = screenX - ((boxWidth + buttonWidth) / 2), screenY - (boxHeight / 2)
							
							--dxDrawText("GATE ID: " .. gateID .. " ", boxX + 1, boxY + 1, boxX + boxWidth + 1, boxY + boxHeight + 1, tocolor(0, 0, 0, 255), 1.2 * scaleMultiplier, "default", "center", "center", false, false, false, false, true)
							dxDrawText("#b7ff00GATE #FFFFFFID : " .. gateID .. " ", boxX, boxY, boxX + boxWidth, boxY + boxHeight, tocolor(255, 255, 255, 255), 1.2 * scaleMultiplier, "default", "center", "center", false, false, false, true, true)
						
							if cursorInBox(boxX + boxWidth, boxY, buttonWidth, boxHeight) then
								dxDrawRectangle(boxX + boxWidth, boxY, buttonWidth, boxHeight, tocolor(215, 89, 89, 255))
								selectedGateButton = gateID
							else
								dxDrawRectangle(boxX + boxWidth, boxY, buttonWidth, boxHeight, tocolor(215, 89, 89, 200))	
							end

							dxDrawText("Törlés", boxX + boxWidth, boxY, boxX + boxWidth + buttonWidth, boxY + boxHeight, tocolor(0, 0, 0, 255), 1.2 * scaleMultiplier, "default", "center", "center", false, false, false, false, true)

						end
					end
				end
			end
		end
	end
end)

addEventHandler("onClientClick", root, function(button, state)
	if nearbyGateMode then
		if (state == "down") then
			if (button == "left") then
				if (selectedGateButton ~= -1) then
					triggerServerEvent("deleteGate", localPlayer, selectedGateButton)	
				end
			end
		end
	end
end)

addEventHandler("onClientKey", root, function(button, press)
	if gateEditorMode then
		if (button == "lshift") and (press) then
			cancelEvent()
			
			if fastMode then
				outputChatBox("#b7ff00[NextLevel - Gate]: #ffffffGyors pozicionálás kikapcsolva", 0, 0, 0, true)
			else
				outputChatBox("#b7ff00[NextLevel - Gate]: #ffffffGyors pozicionálás bekapcsolva", 0, 0, 0, true)
			end
			fastMode = not fastMode
		elseif (button == "enter") and (press) then
			cancelEvent()
			if (gateEditorState == 1) then
				
				local gX, gY, gZ = getElementPosition(previewGateObj)
				local grX, grY, grZ = getElementRotation(previewGateObj)
				
				gateData["close"] = {gX, gY, gZ, grX, grY, grZ}
				gateData["int-dim"] = {getElementInterior(previewGateObj), getElementDimension(previewGateObj)}
				
				gateEditorState = 2
				
				outputChatBox("#b7ff00GATE : #ffffffMost állítsd be a nyitási poziciót!", 0, 0, 0, true)
				
				
			elseif(gateEditorState == 2) then
				
				local gX, gY, gZ = getElementPosition(previewGateObj)
				local grX, grY, grZ = getElementRotation(previewGateObj)
				
				gateData["open"] = {gX, gY, gZ, grX, grY, grZ}
				gateData["int-dim"] = {getElementInterior(previewGateObj), getElementDimension(previewGateObj)}
				
				--outputChatBox(calculateDifferenceBetweenAngles(gateData["open"][6], gateData["close"][6]))
				triggerServerEvent("createGate", localPlayer, gateData["objectID"], gateData["open"], gateData["close"], gateData["time"], gateData["int-dim"], mode, pass)
				destroyPreviewGate()
			end
		elseif (button == "num_1") and (press) then
			cancelEvent()
		elseif (button == "backspace") and (press) then
			destroyPreviewGate()
			outputChatBox("#b7ff00GATE : #ffffffLétrehozás vissza vonva", 0, 0, 0, true)
		end
		
		
	end
end)




function cursorInBox(x, y, w, h)
	if x and y and w and h then
		if isCursorShowing() then
			if not isMTAWindowActive() then
				local cursorX, cursorY = getCursorPosition()
				
				cursorX, cursorY = cursorX * screenX, cursorY * screenY
				
				if cursorX >= x and cursorX <= x + w and cursorY >= y and cursorY <= y + h then
					return true
				end
			end
		end
	end
	
	return false
end






