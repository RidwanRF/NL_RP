local mysql = exports.nlrp_database:getConnection()



function infobox(element, text, type)

	--exports["mta_notifications"]:createNotification(element, text, type)

end



Event.AddHandler("onResourceStart", resourceRoot, function()

	loadedMarkers = {}



	for key, value in ipairs(availableTuningMarkers) do

		loadedMarkers[key] = Marker(value[1], value[2], value[3] - 1, "cylinder", 3, 183,255,0, 140)

	end



	Event.AddHandler("onMarkerHit", root, checkMarkerHit)



	for key, value in ipairs(getElementsByType("vehicle")) do

		exports.nlrp_handling:loadHandling(value)

		loadopticalTuningss(value)

		loadHandlingFlags(value)

		loadWheelSize(value)

		loadDriveType(value)



		for index = 0, 16 do

			if getVehicleUpgradeOnSlot(value, index) == 1080 then

				addVehicleUpgrade(value, 1080)

			end

		end



		if value:getData("veh:steeringLock") ~= 0 then

			setVehicleHandling(value, "steeringLock", value:getData("veh:steeringLock"), false)

		end

	end

end)



--[[Event.AddHandler("onPlayerJoin", root, function()

	for key, value in ipairs(getElementsByType("vehicle")) do

		loadWheelSize(value)

	end

end)]]



Event.AddHandler("onVehicleEnter", root, function(player)

	setVehicleHandling(source, false)

	exports.nlrp_handling:loadHandling(source)

	loadHandlingFlags(source)



	loadDriveType(source)

	loadWheelSize(source)



	toggleControl(player, "handbrake", true)



	if source:getData("veh:steeringLock") ~= 0 then

		setVehicleHandling(source, "steeringLock", source:getData("veh:steeringLock"), false)

	end



	for index = 0, 16 do

		if getVehicleUpgradeOnSlot(source, index) == 1080 then

			addVehicleUpgrade(source, 1080)

		end

	end



	local level = source:getData("tuning.airRideActive")

	local vehicle = source

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

end)



function checkMarkerHit(element)

	if isElement(element) then

		if element:getType() == "player" then

			for key, value in ipairs(loadedMarkers) do

				if source == value and element:getOccupiedVehicle() and element:getOccupiedVehicleSeat() == 0 then

					--destroyElement(value)

					value:setDimension(1)



					--element:getOccupiedVehicle():setData("veh:motor", false)

					--setVehicleEngineState(element:getOccupiedVehicle(), false)



					Trigger.Client(element, "hitMarker", element, element, key)

				end

			end

		end

	end

end



addEvent("tuning->opticalTunings", true)

addEventHandler("tuning->opticalTunings", root, function(vehicle, type, upgrade, slot)

	if vehicle then

		if upgrade then

		

			-- jármű betöltésnél kérd ki sql-ből az opticalTunings táblát és vehicle:setData("veh:opticalTunings", fromJSON(row["opticalTunings"])) -> jármű rendszer

			-- itt betöltésnél pedig az elementDatán végigmész for ciklussal és ha az érték nem 0 akkor addVehicleUpgrade(vehicle, érték)

			

			if type == "add" then

				addVehicleUpgrade(vehicle, upgrade)



				local optics = {}

				for index = 0, 16 do

					optics[index] = getVehicleUpgradeOnSlot(vehicle, index)

				end

				local opticsUpgrades = toJSON{optics[0], optics[1], optics[2], optics[3], optics[4], optics[5], optics[6], optics[7], optics[8], optics[9], optics[10], optics[11], optics[12], optics[13], optics[14], optics[15]}

				

				vehicle:setData("veh:opticalTunings", opticsUpgrades)

				

				dbExec(mysql, "UPDATE vehicles SET opticalTunings = ? WHERE vehicleID = ?", opticsUpgrades, vehicle:getData("vehicle.dbID"))

			elseif type == "remove" then

				removeVehicleUpgrade(vehicle, upgrade)

				--dbExec(mysql, "UPDATE vehicle SET opticalTunings = ? WHERE vehicleID = ?", toJSON({0, 0, 0, 0, 0, 0, 0, 0, 0}), vehicle:getData("vehicle.dbID"))

			

				local optics = {}

				for index = 0, 16 do

					optics[index] = getVehicleUpgradeOnSlot(vehicle, index)

				end

				local opticsUpgrades = toJSON{optics[0], optics[1], optics[2], optics[3], optics[4], optics[5], optics[6], optics[7], optics[8], optics[9], optics[10], optics[11], optics[12], optics[13], optics[14], optics[15]}

				

				vehicle:setData("veh:opticalTunings", opticsUpgrades)

				

				dbExec(mysql, "UPDATE vehicles SET opticalTunings = ? WHERE vehicleID = ?", opticsUpgrades, vehicle:getData("vehicle.dbID"))

			end

		end

	end

end)



function loadopticalTuningss(vehicle)

	if vehicle and isElement(vehicle) and vehicle:getType() == "vehicle" then

		local opticsUpgrades = fromJSON(vehicle:getData("veh:opticalTunings")) or {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

		for key = 0, 16 do

			addVehicleUpgrade(vehicle, opticsUpgrades[key] or 0)

		end

	end

end



addEvent("tuning->airrideSave", true)

addEventHandler("tuning->airrideSave", root, function(vehicle, state)

	local states = 0

	if state == 2 then

		states = 1

	else

		states = 0

	end

	dbExec(mysql, "UPDATE vehicles SET airRide = ? WHERE vehicleID = ?", states, vehicle:getData("vehicle.dbID"))

end)



addEvent("tuning->LSDDoor", true)

addEventHandler("tuning->LSDDoor", root, function(vehicle, state)

	local states = 0

	if state == 2 then

		states = 1

	else

		states = 0

	end

	dbExec(mysql, "UPDATE vehicles SET LSDDoor = ? WHERE vehicleID = ?", states, vehicle:getData("vehicle.dbID"))

end)



addEvent("tuning->WheelWidth", true)

addEventHandler("tuning->WheelWidth", root, function(vehicle, side, type)

	if vehicle then

		if type then

			if type == "verynarrow" then type = 1

				elseif type == "narrow" then type = 2

				elseif type == "wide" then type = 4

				elseif type == "verywide" then type = 8

				elseif type == "default" then type = 0

			end

			if side then

				if side == "front" then

					setVehicleHandlingFlags(vehicle, 3, type)

				elseif side == "rear" then					

					setVehicleHandlingFlags(vehicle, 4, type)					

				else

					setVehicleHandlingFlags(vehicle, {3, 4}, type)

				end

			else

				setVehicleHandlingFlags(vehicle, {3, 4}, type)

			end

			if side == "rear" then

				side = "Rear"

			end

			if side == "front" then

				side = "Front"

			end

			dbExec(mysql, "UPDATE vehicles SET ??=? WHERE vehicleID = ?", "wheel"..side, type, vehicle:getData("vehicle.dbID"))

			if side == "Rear" then

				side = "rear"

			end

			if side == "Front" then

				side = "front"

			end

			vehicle:setData("veh:wheelSize_"..side, type)

		else

			--setVehicleHandlingFlags(vehicle, {3, 4}, 0)

		end

	end

end)



function loadWheelSize(vehicle)

	setVehicleHandlingFlags(vehicle, 3, vehicle:getData("veh:wheelSize_front") or 0)

	setVehicleHandlingFlags(vehicle, 4, vehicle:getData("veh:wheelSize_rear") or 0)

end



addEvent("tuning->Color", true)

addEventHandler("tuning->Color", root, function(vehicle, color, headlightColor)

	if vehicle then

		setElementData(vehicle,"veh.colorred", tonumber(color[1]))

		setElementData(vehicle,"veh.colorgreen", tonumber(color[2]))

		setElementData(vehicle,"veh.colorblue", tonumber(color[3]))

		setVehicleColor(vehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9])

		setVehicleHeadLightColor(vehicle, headlightColor[1], headlightColor[2], headlightColor[3])

		dbExec(mysql, "UPDATE vehicles SET r = ?,  g = ?,  b = ?, r1 = ?,  g1 = ?,  b1 = ? WHERE vehicleID = ?", color[1], color[2], color[3], color[4], color[5], color[6], vehicle:getData("vehicle.dbID"))

		dbExec(mysql, "UPDATE vehicles SET r3 = ?, g3 = ?, b3 = ? WHERE vehicleID = ?", headlightColor[1], headlightColor[2], headlightColor[3], vehicle:getData("vehicle.dbID"))

	end

end)



Event.Add("tuning->driveType", true)

Event.AddHandler("tuning->driveType", root, function(vehicle, type)

	setVehicleHandling(vehicle, "driveType", type)

	if type == "fwd" then type = 1

		elseif type == "awd" then type = 2

		elseif type == "rwd" then type = 3

	end



	vehicle:setData("veh:driveType", type)

	dbExec(mysql, "UPDATE vehicles SET driveType = ? WHERE vehicleID = ?", type, vehicle:getData("vehicle.dbID"))

end)



addEvent("tuning->tempVariant", true)

addEventHandler("tuning->tempVariant", root, function(vehicle, variant)

	if vehicle then

		setVehicleVariant(vehicle, variant, variant)

		setVehicleEngineState(vehicle,getElementData(vehicle,"vehicle.engine"))

	end

end)



addEvent("tuning->Paintjob", true)

addEventHandler("tuning->Paintjob", root, function(vehicle, paintjob)

	dbExec(mysql, "UPDATE vehicles SET paintjob = ? WHERE vehicleID = ?", paintjob, vehicle:getData("vehicle.dbID"))

end)



addEvent("tuning->Variant", true)

addEventHandler("tuning->Variant", root, function(vehicle, variant)

	if vehicle then

		setVehicleVariant(vehicle, variant, variant)

		dbExec(mysql, "UPDATE vehicles SET var = ? WHERE vehicleID = ?", variant, vehicle:getData("vehicle.dbID"))

	end

end)



addEvent("tuning->NeonSave", true)

addEventHandler("tuning->NeonSave", root, function(vehicle, neon)

	if vehicle then

		dbExec(mysql, "UPDATE vehicles SET neonTuning = ? WHERE vehicleID = ?", neon, vehicle:getData("vehicle.dbID"))

	end

end)



addEvent("tuning->PlateText", true)

addEventHandler("tuning->PlateText", root, function(vehicleSource, text)

	if vehicleSource and text then

		dbExec(mysql, "UPDATE vehicles SET licensePlate = ? WHERE vehicleID = ?", text, vehicleSource:getData("vehicle.dbID"))

		setVehiclePlateText(vehicleSource, text)

		vehicleSource:setData("veh:plate", text)

	end

end)



addEvent("tuning->steeringLock", true)

addEventHandler("tuning->steeringLock", root, function(vehicleSource, steeringLock)

	if vehicleSource and steeringLock then

		dbExec(mysql, "UPDATE vehicles SET steeringLock = ? WHERE vehicleID = ?", steeringLock, vehicleSource:getData("vehicle.dbID"))

	end

end)



function loadDriveType(vehicle)

	local type = vehicle:getData("veh:driveType")

	if type == 1 then type = "fwd"

		elseif type == 2 then type = "awd"

		elseif type == 3 then type = "rwd"

	end



	setVehicleHandling(vehicle, "driveType", type)

end



Event.Add("createMarkerById", true)

Event.AddHandler("createMarkerById", root, function(id)

	--if not isElement(loadedMarkers[id]) then

		setTimer(function()

			--loadedMarkers[id] = Marker(availableTuningMarkers[id][1], availableTuningMarkers[id][2], availableTuningMarkers[id][3] - 1,

				--"cylinder", 3, 183,255,0, 140)



			loadedMarkers[id]:setDimension(0)

		end, 1000, 1)

	--end

end)



Event.Add("Performance->Upgrade", true)

Event.AddHandler("Performance->Upgrade", root, function(vehicle, menu, key)

	if not vehicle:getData("veh:performance_"..menu["upgradeData"]) then

		vehicle:setData("veh:performance_"..menu["upgradeData"], 0)

	end



	if vehicle:getData("veh:performance_"..menu["upgradeData"]) > key and source:getData("acc.ID") ~= vehicle:getData("vehicle.owner") then

		exports.nlrp_hud:showAlert(source,"info", "Csak a jármű tulajdonosa szerelheti le ezt a kiegészítőt.")

		return

	end



	if vehicle:getData("veh:performance_"..menu["upgradeData"]) == key then

		exports.nlrp_hud:showAlert(source,"info", "Ez a kiegészítő már megtalálható a járműveden/járművedben.")

		return

	end



	if menu["subMenu"][key]["priceIgMoney"] then

		takeMoney(source, menu["subMenu"][key]["tuningPrice"])

	else

		takePremium(source, menu["subMenu"][key]["tuningPrice"])

	end

	exports.nlrp_hud:showAlert(source,"info", "Sikeresen megvásároltad ezt a kiegészítőt a járművedre/járművedbe.")



	vehicle:setData("veh:performance_"..menu["upgradeData"], key)



	upgradeHandlingFlags(vehicle, menu, key)

end)



function upgradeHandlingFlags(vehicle, menu, level)

	level = level - 1



	for key, value in ipairs(menu["handlingFlags"]) do		

		setVehicleHandling(vehicle, value[1],

			getVehicleHandlingProperty(vehicle, value[1]) + value[2] * level)

	end



	dbExec(mysql, "UPDATE vehicles SET ??=? WHERE vehicleID=?", menu["upgradeData"], level + 1, vehicle:getData("vehicle.dbID"))

end



function loadHandlingFlags(vehicle)

	if isElement(vehicle) and vehicle:getType() == "vehicle" then

		for index, data in ipairs(tuningMenu[1]["subMenu"]) do

			local currentFlagLevel = vehicle:getData("veh:performance_"..data["upgradeData"]) or 0



			for key, value in ipairs(tuningMenu[1]["subMenu"][index]["handlingFlags"]) do	

				setVehicleHandling(vehicle, value[1],

					getVehicleHandlingProperty(vehicle, value[1]) + value[2] * currentFlagLevel)

			end	

		end



		--[[setVehicleHandling(vehicle, "tractionMultiplier", 

			getVehicleHandlingProperty(vehicle, "tractionMultiplier") - 0.13)

		setVehicleHandling(vehicle, "tractionLoss", 

			getVehicleHandlingProperty(vehicle, "tractionMultiplier") - 0.078)]]--

	end

end



addEvent("tuning->HandlingUpdate", true)

addEventHandler("tuning->HandlingUpdate", root, function(vehicle, property, value)

	if vehicle then

		if property then

			if value then

				setVehicleHandling(vehicle, property, value, false)

			else

				setVehicleHandling(vehicle, property, getOriginalHandling(getElementModel(vehicle))[property], false)

			end

		end

	end

end)



function setVehicleHandlingFlags(vehicle, byte, value)

	if vehicle then

		local handlingFlags = string.format("%X", getVehicleHandling(vehicle)["handlingFlags"])

		local reversedFlags = string.reverse(handlingFlags) .. string.rep("0", 8 - string.len(handlingFlags))

		local currentByte, flags = 1, ""

		

		for values in string.gmatch(reversedFlags, ".") do

			if type(byte) == "table" then

				for _, v in ipairs(byte) do

					if currentByte == v then

						values = string.format("%X", tonumber(value))

					end

				end

			else

				if currentByte == byte then

					values = string.format("%X", tonumber(value))

				end

			end

			

			flags = flags .. values

			currentByte = currentByte + 1

		end

		

		setVehicleHandling(vehicle, "handlingFlags", tonumber("0x" .. string.reverse(flags)), false)

	end

end