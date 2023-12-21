local roadblocksarr = { }
local maxroadblocks = 2000

function roadblockCreateWorldObject(objectid, tempObjectPosX, tempObjectPosY, tempObjectPosZ, tempObjectPosRot)
	if(isRoadblockEditAllowed(client)) then
		local slot = 0
		for i = 1, maxroadblocks do
			if (roadblocksarr[i]==nil) then
				roadblocksarr[i] = createObject ( objectid, tempObjectPosX, tempObjectPosY, tempObjectPosZ, 0, 0, tempObjectPosRot )
				setElementData(roadblocksarr[i], "roadblock", "1")
				setElementInterior ( roadblocksarr[i], getElementInterior ( client ) )
				setElementDimension ( roadblocksarr[i], getElementDimension ( client ) )
				slot = i
				break
			end
		end
		if not (slot == 0) then
			outputChatBox("Útzár #" .. slot.. "lerakva.", client, 0, 255, 0)
		else
			outputChatBox("Túl sok útzár van lerakva. Kérlek szedj fel párat!", client, 0, 255, 0)
		end
	end
end
addEvent( "roadblockCreateWorldObject", true )
addEventHandler( "roadblockCreateWorldObject", getRootElement(), roadblockCreateWorldObject )

function getNearbyRoadblocks(thePlayer, commandName)
	if(isRoadblockEditAllowed(thePlayer)) then
		local posX, posY, posZ = getElementPosition(thePlayer)
		outputChatBox("Nearby Roadblocks:", thePlayer, 255, 126, 0)
		local found = false
		
		for i = 1, maxroadblocks do
			if not (roadblocksarr[i]==nil) then
				local x, y, z = getElementPosition(roadblocksarr[i])
				local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x, y, z)
				if (distance<=10) then
					outputChatBox("   Roadblock with ID " .. i .. ".", thePlayer, 255, 126, 0)
					found = true
				end
			end
		end
		
		if not (found) then
			outputChatBox("   Nincs.", thePlayer, 255, 126, 0)
		end
	end
end
addCommandHandler("nearbyrb", getNearbyRoadblocks, false, false)

function removeRoadblock(thePlayer, commandName, id)
	if(isRoadblockEditAllowed(thePlayer)) then
		if not (id) then
			outputChatBox("HASZNÁLATA: /" .. commandName .. " [Útzár  ID]", thePlayer, 255, 194, 15)
		else
			id = tonumber(id)
			if (roadblocksarr[id]==nil) then
				outputChatBox("No roadblock was found with this ID.", thePlayer, 255, 0, 0)
			else
				local object = roadblocksarr[id]
				destroyElement(object)
				roadblocksarr[id] = nil
				outputChatBox("Felszedve:" .. id .. "azonosítóval ellátót útzár.", thePlayer, 0, 255, 0)
			end
		end
	end
end
addCommandHandler("delrb", removeRoadblock, false, false)
addCommandHandler("delroadblock", removeRoadblock, false, false)

function removeAllRoadblocks(thePlayer, commandName)
	if(isRoadblockEditAllowed(thePlayer)) then
		for i = 1, maxroadblocks do
			if not (roadblocksarr[i]==nil) then
				local object = roadblocksarr[i]
				destroyElement(object)
			end
		end
		roadblocksarr = { }
		outputChatBox("Összes útzár felvszéve!", thePlayer, 0, 255, 0)
	end
end
addCommandHandler("delallrbs", removeAllRoadblocks, false, false)
addCommandHandler("delallroadblocks", removeAllRoadblocks, false, false)

function onRoadblockStart(thePlayer, commandName)
	if(isRoadblockEditAllowed(thePlayer)) then
		triggerClientEvent(thePlayer, "enableRoadblockGUI", getRootElement(), true)
	end
end
addCommandHandler("rbs", onRoadblockStart, false, false)

function isRoadblockEditAllowed(thePlayer)
	if exports.nlrp_groups:isPlayerHavePermission(thePlayer, "rbsek") then
		return true
	end
end