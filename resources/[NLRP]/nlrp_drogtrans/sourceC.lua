local asdTimer

function objectClick(button, state, absX, absY, wx, wy, wz, element)
	if not asdTimer then
		if element and getElementType(element) == "object" and getElementData(element, "object.isDrogZsak") then
			if state == "down" and button == "left" then
				local x, y, z = getElementPosition(getLocalPlayer())
				if getDistanceBetweenPoints3D(x, y, z, wx, wy, wz) <= 2 then
					setElementData(localPlayer, "char.drogLoot", getElementData(element, "object.drogLoot"))
					outputChatBox("#b7ff00[NextLevel]: #ffffffFelvettél egy drogal teli tömböt, menj és add le!", 255, 0, 0, true)
					setPedAnimation(localPlayer, "bomber", "bom_plant", 1200, true, true, true, true, 0, false)
					triggerServerEvent("destroyDrogCrate", root, getElementData(element, "object.drogID"))
					triggerServerEvent("createDrogInInv", root, localPlayer)
					asdTimer = setTimer( function()
						asdTimer = nil
					end, 1200, 1)
				end
			end
		end
	else
		--outputChatBox("#D7A360[NextLevel]: #ffffff2 percenként csak egy dobozt vehetsz fel!.", 255, 0, 0, true)
	end
end
addEventHandler("onClientClick", getRootElement(), objectClick, true)

function playSoundHorn()
	local sound = playSound3D("sounds/shiphorn.mp3", -3055.3544921875, 525.8837890625, 3.8256225585938)
	setSoundMaxDistance(sound, 1000)
end
addEvent("playHorn", true)
addEventHandler("playHorn", getRootElement(), playSoundHorn)