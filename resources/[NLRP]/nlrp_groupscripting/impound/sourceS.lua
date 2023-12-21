local connection = false

addEventHandler("onResourceStart", getRootElement(),
    function (startedResource)
        if getResourceName(startedResource) == "nlrp_database" then
            connection = exports.nlrp_database:getConnection()
        elseif source == getResourceRootElement() then
            if getResourceFromName("nlrp_database") and getResourceState(getResourceFromName("nlrp_database")) == "running" then
                connection = exports.nlrp_database:getConnection()
            end
        end
    end
)

function registerEvent(eventName, element, ...)
	addEvent(eventName, true)
	addEventHandler(eventName, element, ...)
end

function impoundVehicle(player, vehicle, reason, price, canGet, impoundedDate, expiredDate, impoundedBy)
	if getElementData(vehicle, "vehicle.group") > 0 then
		outputChatBox("Nem tudod lefoglalni fasszopó", player, 255,255,255,true)
	else
		local impoundText = reason .. "/" .. price .. "/" .. tostring(canGet) .. "/" .. impoundedDate .. "/" .. expiredDate .. "/" .. impoundedBy
		dbExec(connection, "UPDATE vehicles SET impound = ? WHERE vehicleID = ?", impoundText, getElementData(vehicle, "vehicle.dbID"))
		setElementData(vehicle, "vehicle.impound", impoundText)
		exports.nlrp_alert:showAlert(player, "info", "Sikeresen lefoglaltad a járművet")

		for k, v in pairs(getVehicleOccupants(vehicle)) do
			removePedFromVehicle(v)
		end

		setElementDimension(vehicle, 65000)
	end
end
registerEvent("nlrp_impoundS:impoundVehicle", root, impoundVehicle)

local spawnPositions = {
    {1521.2928466797, -1655.3713378906, 13.546875, 270},
    {1521.2896728516, -1651.470703125, 13.546875, 270},
}

function getVehicle(player, vehicle, price)
    --outputChatBox(price .. " " .. tostring(player) .. " " .. tostring(vehicle))
    if exports.nlrp_core:takeMoney(player, price) then
        print("Kiváltva")
        removeElementData(vehicle, "vehicle.impound")
        dbExec(connection, "UPDATE vehicles SET impound = NULL WHERE vehicleID = ?", getElementData(vehicle, "vehicle.dbID"))
        local rnd = math.random(1, #spawnPositions)
        setElementPosition(vehicle, spawnPositions[rnd][1], spawnPositions[rnd][2], spawnPositions[rnd][3])
        setElementRotation(vehicle, 0, 0, spawnPositions[rnd][4])
        setElementDimension(vehicle, 0)
        setElementInterior(vehicle, 0)
    else
        print("No")
        exports.nlrp_alert:showAlert(player, "error", "Nincs elég pénzed a kiváltáshoz")
    end
end
registerEvent("nlrp_impoundS:getVehicle", root, getVehicle)
