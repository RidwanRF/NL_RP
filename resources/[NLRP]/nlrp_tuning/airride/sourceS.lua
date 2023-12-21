addCommandHandler("airride", function(player, command, level)
	if getPedOccupiedVehicle(player) and getElementSpeed(getPedOccupiedVehicle(player), "kmh") < 5 then
		local vehicle = getPedOccupiedVehicle(player)
		
		if getVehicleOccupant(vehicle) == player then
			if getElementData(vehicle, "tuning.airRide") then
				if level and tonumber(level) >= 0 and tonumber(level) <= 5  then
					if isTimer(airRideActive) then
						return
					end
					
					triggerClientEvent(player, "playAirRideSound", player, vehicle)
					setElementFrozen(vehicle, true)
					
					airRideActive = setTimer(function()
						if tonumber(level) == 0 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", getOriginalHandling(getElementModel(vehicle))["suspensionLowerLimit"])
						elseif tonumber(level) == 1 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", 0.01)
						elseif tonumber(level) == 2 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.1)
						elseif tonumber(level) == 3 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.2)
						elseif tonumber(level) == 4 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.3)
						elseif tonumber(level) == 5 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.45)
						end

						setElementData(vehicle, "tuning.airRideActive", level)
						
						setElementFrozen(vehicle, false)
					end, 3000, 1)
				else
					--outputChatBox("#dc143c[Air-Ride]: #00ced1 Használat: /airride [0 - 5] (0 => Gyári hasmagasság)", player, 255, 255, 255, true)
				end
			end
		end
	end
end)

function getElementSpeed(element,unit)
    if (unit == nil) then
		unit = 0
	end 
	if (isElement(element))	then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100)
		else
			return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100 * 1.609344)
		end
	else 
		return false
	end
end