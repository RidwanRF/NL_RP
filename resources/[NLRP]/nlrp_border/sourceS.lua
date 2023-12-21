local allBorders = {}

local allColshape = {}



function isBorderAllowed(thePlayer)

	if exports.nlrp_groups:isPlayerHavePermission(thePlayer, "border") then

	return true

	end

end



addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function ()

	for index, value in ipairs (bordersPos) do

		allBorders[index] = createObject(value[1], value[2], value[3], value[4]-0.3, value[5], value[6], value[7])

		setElementData(allBorders[index], "moved", false)

	end

	for index, value in ipairs (colPos) do

		allColshape[index] = createColCuboid(value[1], value[2], value[3]-1.0, 6, 6 ,3)

		setElementData(allColshape[index], "object->Colshape", index)

	end

end)



addEvent("moveObject", true)
addEventHandler("moveObject", root, function (player, ID, amount )
	if getElementData(allBorders[ID], "moved") then return end
	moveObject(allBorders[ID], 1000,bordersPos[ID][2], bordersPos[ID][3], bordersPos[ID][4]-0.3, bordersPos[ID][8], bordersPos[ID][9], bordersPos[ID][10])
	setElementData(player, "char.Money", getElementData(player, "char.Money") - amount)

	local vehicle = getPedOccupiedVehicle(player)
	for index, value in ipairs (getElementsByType("player")) do
		if tonumber(getElementData(value, "faction:toghatar") or 0) == 1 then
			local vehName = exports['nlrp_vehs']:getVehicleName(vehicle) or "Ismeretlen"
			local plate = getElementData(vehicle,"danihe->vehicles->plate") or "Ismeretlen rendszám"
			local r,g,b = unpack(getElementData(vehicle,"danihe->vehicles->bodyColor")) or 255,255,255
			local _,_,_,r1,g1,b1 = getVehicleColor(vehicle,true)
			--local r, g, b, r1, g1, b1 = getVehicleColor(getPedOccupiedVehicle(getPedOccupiedVehicle(player)), true)

			outputChatBox("#B7FF00[NLRP - Határ]: #FFFFFF Egy jármű átlépte a határt! Rendszáma: "..plate, value, 255, 255, 255, true)
			outputChatBox("#B7FF00[NLRP - Határ]: #FFFFFF Típus: #6699cc" .. vehName .. " #ffffffSzínek: ".. (RGBToHex(r, g, b)) .."szín 1".. (RGBToHex(r1, g1, b1)) .. " szín 2", value, 255, 255, 255, true)
		end
	end

	setElementData(allBorders[ID], "moved", true)
	setTimer(function()
		moveObject(allBorders[ID], 1000,bordersPos[ID][2], bordersPos[ID][3], bordersPos[ID][4]-0.3, 0, -bordersPos[ID][9], 0)
		setTimer(function()
			setElementData(allBorders[ID], "moved", false)
		end, 1000, 1 )
	end, 3000, 1)
end)

 

function toghatar(thePlayer)

	if (isBorderAllowed(thePlayer)) then -- muss verändert sein

		if (getElementData(thePlayer, "faction:toghatar") == 0) then

			setElementData(thePlayer, "faction:toghatar", 1)

			outputChatBox("#B7FF00[NLRP]:#ffffff Bekapcsoltad a határ ellenőrzés szöveget.", thePlayer, 255, 255, 255, true)

		else

			setElementData(thePlayer, "faction:toghatar", 0)

			outputChatBox("#B7FF00[NLRP]:#ffffff Kikapcsoltad a határ ellenőrzés szöveget.", thePlayer, 255, 255, 255, true)

		end

	end

end

addCommandHandler("toghatar", toghatar, false,false)





function RGBToHex(red, green, blue, alpha)



	-- Make sure RGB values passed to this function are correct

	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then

		return nil

	end



	-- Alpha check

	if alpha then

		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)

	else

		return string.format("#%.2X%.2X%.2X", red, green, blue)

	end



end

