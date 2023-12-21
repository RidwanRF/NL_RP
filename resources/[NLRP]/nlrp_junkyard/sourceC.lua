local yunkMarkers = {}

local yunkBlips = {}

local yunkMarkersPositions = {

	--X, Y, Z

	{2155.3823242188, -1976.5777587891, 13.551423072815}, --Roncstelep #1

}



function createYunkMarkers()

	for index, value in ipairs(yunkMarkersPositions) do

		yunkMarkers[index] = createMarker(yunkMarkersPositions[index][1], yunkMarkersPositions[index][2], yunkMarkersPositions[index][3]-1, "cylinder", 2.0, 255, 255, 255)

		yunkBlips[index] = createBlip(yunkMarkersPositions[index][1], yunkMarkersPositions[index][2], yunkMarkersPositions[index][3]-1, 62, 2, 255, 0, 0, 255, 0, 99999)

		setElementData(yunkMarkers[index], "yunk:marker", true)

	end

end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createYunkMarkers)



local yunkPanel = false

local font = dxCreateFont("files/myriadproregular.ttf", 9)

local font2 = dxCreateFont("files/myriadproregular.ttf", 11)

local font3 = dxCreateFont("files/myriadproregular.ttf", 11)



function convertNumber ( number )  

	local formatted = number  

	while true do      

		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    

		if ( k==0 ) then      

			break   

		end  

	end  

	return formatted

end



function onYunkMarkerHit(hitPlayer, dim)

	if localPlayer == hitPlayer and getElementData(source, "yunk:marker") == true then

		if isPedInVehicle(localPlayer) then

			local veh = getPedOccupiedVehicle(localPlayer)

			local seat = getPedOccupiedVehicleSeat(localPlayer)

			if (veh) and seat == 0 then

				if getElementData(veh, "veh:owner") == getElementData(localPlayer, "acc:id") and getElementData(veh, "veh:id") > 0 or getElementData(localPlayer, "acc:admin") >= 7 then

					realName = exports.nlrp_carshop:getVehicleRealName(getElementModel(veh))

					cost = exports.nlrp_carshop:getVehicleShopCost(getElementModel(veh)) / 2

					--outputChatBox(realName .. " | " .. convertNumber(cost) .. " $ be")

					

					yunkPanel = true

					addEventHandler("onClientRender", root, yunkPanelRender)

					setElementFrozen(veh, true)



				else

					outputChatBox("#b7ff00[NextLevel - Roncstelep]: #ffffffEz a jármű nem a tiéd.", 255, 255, 255, true)

				end

			end

		end

	end

end

addEventHandler("onClientMarkerHit", getRootElement(), onYunkMarkerHit)



function onYunkMarkerLeave(hitPlayer, dim)

	if localPlayer == hitPlayer and getElementData(source, "yunk:marker") == true then

		if yunkPanel == true then

			veh = getPedOccupiedVehicle(localPlayer)

			if (veh) then



				yunkPanel = false

				removeEventHandler("onClientRender", root, yunkPanelRender)

				setElementFrozen(veh, false)

			

				

			end

		end

	end

end

addEventHandler("onClientMarkerLeave", getRootElement(), onYunkMarkerLeave)



local buttons = {{"Elfogadás"}, {"Elutasítás"}}



function yunkPanelRender()

	if yunkPanel then

	

		local monitorSize = {guiGetScreenSize()}

		local panelSize = {330, 200}

		local panelX, panelY = monitorSize[1]/2-panelSize[1]/2, monitorSize[2]/2-panelSize[2]/2

		local text = "Köszöntelek a roncstelepen.\nBe szeretnéd zúzatni #b7ff00" .. realName .. " #fffffftípusú járművedet?\n\n"

		local text2 = "A bezúzatásért #b7ff00" .. convertNumber(cost) .. "$#ffffff jár."

		local buttonSize = {250, 30}

		

		

		dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2], tocolor(0, 0, 0, 180))

		dxDrawRectangle(panelX, panelY, panelSize[1], 20, tocolor(0, 0, 0, 230))

		dxDrawText("#b7ff00NextLevel#ffffff - Roncstelep", panelX+panelSize[1]/2, panelY+10, panelX+panelSize[1]/2, panelY+10, tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, true)

		

		dxDrawText(text, panelX+panelSize[1]/2, panelY+25, panelX+panelSize[1]/2, panelY+25, tocolor(255, 255, 255, 255), 1, font, "center", "top", false, false, true, true)

		dxDrawText(text2, panelX+panelSize[1]/2, panelY+70, panelX+panelSize[1]/2, panelY+70, tocolor(255, 255, 255, 255), 1, font3, "center", "top", false, false, true, true)

		

		for i, v in ipairs(buttons) do

			if isInBox(panelX+35, panelY+120+((i-1)*40), buttonSize[1], buttonSize[2]) and v[1] == "Elfogadás" then

				dxDrawRectangle(panelX+35, panelY+120+((i-1)*40), buttonSize[1], buttonSize[2], tocolor(183,255,0, 230))

				dxDrawText(v[1], panelX+35+buttonSize[1]/2, panelY+120+((i-1)*40)+15, panelX+35+buttonSize[1]/2,panelY+120+((i-1)*40)+15, tocolor(0, 0, 0, 255), 1, font2, "center", "center", false, false, true, true)

			

			elseif isInBox(panelX+35, panelY+120+((i-1)*40), buttonSize[1], buttonSize[2]) and v[1] == "Elutasítás" then

				dxDrawRectangle(panelX+35, panelY+120+((i-1)*40), buttonSize[1], buttonSize[2], tocolor(214, 69, 65, 230))

				dxDrawText(v[1], panelX+35+buttonSize[1]/2, panelY+120+((i-1)*40)+15, panelX+35+buttonSize[1]/2,panelY+120+((i-1)*40)+15, tocolor(0, 0, 0, 255), 1, font2, "center", "center", false, false, true, true)

			

			else

				dxDrawRectangle(panelX+35, panelY+120+((i-1)*40), buttonSize[1], buttonSize[2], tocolor(0, 0, 0, 230))

				dxDrawText(v[1], panelX+35+buttonSize[1]/2, panelY+120+((i-1)*40)+15, panelX+35+buttonSize[1]/2,panelY+120+((i-1)*40)+15, tocolor(255, 255, 255, 255), 1, font2, "center", "center", false, false, true, true)



			end

		end

	end

end



function yunkClick( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )

    if button == "left" and state == "down" and yunkPanel then

	

		local monitorSize = {guiGetScreenSize()}

		local panelSize = {330, 200}

		local panelX, panelY = monitorSize[1]/2-panelSize[1]/2, monitorSize[2]/2-panelSize[2]/2

		local text = "Köszöntelek a roncstelepen.\nBe szeretnéd zúzatni #b7ff00" .. realName .. " #fffffftípusú járművedet?\n\n"

		local text2 = "A bezúzatásért #b7ff00" .. convertNumber(cost) .. "$ #ffffffjár."

		local buttonSize = {250, 30}

		veh = getPedOccupiedVehicle(localPlayer)

		seat = getPedOccupiedVehicleSeat(localPlayer)

		if seat ~= 0 then return end

		

		for i, v in ipairs(buttons) do

			if dobozbaVan(panelX+35, panelY+120+((i-1)*40), 250, 30, absoluteX, absoluteY) then

				if v[1] == "Elfogadás" then

					--outputChatBox("Elfogadás")

					

					setElementFrozen(veh, false)

					yunkPanel = false

					removeEventHandler("onClientRender", root, yunkPanelRender)

					outputChatBox(" ", 255, 255, 255, true)

					outputChatBox("#b7ff00[NextLevel - Roncstelep]: #ffffffElfogadtad az ajánlatot.", 255, 255, 255, true)

					outputChatBox("#b7ff00[NextLevel - Roncstelep]: #ffffffA járműved #b7ff00" .. convertNumber(cost) .. "$ #ffffffösszegért cserébe bezúzásra került.", 255, 255, 255, true)

					triggerServerEvent("junk:deleteVehicle", localPlayer, localPlayer, veh, cost)

					--removePedFromVehicle(localPlayer)

				elseif v[1] == "Elutasítás" then

					--outputChatBox("Elutasítás")

					

					setElementFrozen(veh, false)

					yunkPanel = false

					removeEventHandler("onClientRender", root, yunkPanelRender)

					outputChatBox(" ", 255, 255, 255, true)

					outputChatBox("#b7ff00[NextLevel - Roncstelep]: #ffffffElutasítottad #ffffffaz ajánlatot. A járműved nem kerül bezúzásra.", 255, 255, 255, true)

					--exports._notifications:createNotification("Elutasítottad az ajánlatot. A járműved nem kerül bezúzásra.", 4)

				end

			end

		end

	end

end

addEventHandler ("onClientClick", getRootElement(), yunkClick )



function dobozbaVan(dX, dY, dSZ, dM, eX, eY)

	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then

		return true

	else

		return false

	end

end



function isInBox(xS,yS,wS,hS)

	if(isCursorShowing()) then

		XY = {guiGetScreenSize()}

		local cursorX, cursorY = getCursorPosition()

		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]

		if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then

			return true

		else

			return false

		end

	end	

end