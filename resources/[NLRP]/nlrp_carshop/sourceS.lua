
local parkingPositions = {
    {1975.5821533203, -2064.7827148438, 13.387405395508, 0, 0, 0},
    {1978.5821533203, -2064.7827148438, 13.387405395508, 0, 0, 0},
    {1983.5821533203, -2064.7827148438, 13.387405395508, 0, 0, 0},
    {1988.5821533203, -2064.7827148438, 13.387405395508, 0, 0, 0},
    {1992.5821533203, -2064.7827148438, 13.387405395508, 0, 0, 0},
    

}

local registerEvent = function(eventName, element, func)
	addEvent(eventName, true)
	addEventHandler(eventName, element, func)
end

function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving, isDriving and getPedOccupiedVehicle(ped) or nil
end

function getCarshopVeh(playersource)
	local driving, vehicle = isPedDrivingVehicle ( playersource )
	outputChatBox(getElementData(vehicle, "vehicle.carshop").." :)")
end
addCommandHandler("cs", getCarshopVeh)

function buyVehicle(buyerElement, vehicleID, vehicleCost, factionID)
    assert(getElementType(buyerElement) == "player", "Bad argument @ 'buyVehicle' [expected player at argument 1, got "..type(buyerElement).."]")
    assert(type(vehicleID) == "number", "Bad argument @ 'buyVehicle' [expected number at argument 2, got "..type(vehicleID).."]")
    assert(type(vehicleCost) == "number", "Bad argument @ 'buyVehicle' [expected number at argument 3, got "..type(vehicleCost).."]")

    if factionID and tonumber(factionID) then
            exports.nlrp_groups:setGroupMoney(factionID, -vehicleCost)
            local random = math.random(1, #parkingPositions)
            local position = {parkingPositions[random][1], parkingPositions[random][2], parkingPositions[random][3], parkingPositions[random][4], parkingPositions[random][5], parkingPositions[random][6], 0, 0}
            exports["nlrp_vehicles"]:makeVehicle(vehicleID, buyerElement, factionID, position, 255, 255, 255, 1)
            exports["nlrp_alert"]:showAlert(buyerElement, "info", "Gratulálok! Sikeresen megvetted a járművet " .. exports.nlrp_groups:getGroupPrefix(factionID) .. " részére!", "A jármű oda kint a parkolóban vár.")

    else
        if exports["nlrp_core"]:takeMoney(buyerElement, vehicleCost, "new vehicle") then
            local random = math.random(1, #parkingPositions)
            local position = {parkingPositions[random][1], parkingPositions[random][2], parkingPositions[random][3], parkingPositions[random][4], parkingPositions[random][5], parkingPositions[random][6], 0, 0}
            exports["nlrp_vehicles"]:makeVehicle(vehicleID, buyerElement, 0, position, 255, 255, 255, 1)
            exports["nlrp_alert"]:showAlert(buyerElement, "info", "Gratulálok! Sikeresen megvetted a járművet!", "A jármű oda kint a parkolóban vár.")
        else
            exports["nlrp_alert"]:showAlert(buyerElement, "error", "Sajnálom, de nincsen elegendő pénzed", "ahhoz, hogy megvedd ezt a járművet.")
        end
    end

    --[[if factionID and tonumber(factionID) then
            exports.nlrp_groups:setGroupMoney(factionID, -vehicleCost)
            local random = math.random(1, #parkingPositions)
            setTimer ( function()
            local x,y,z = getElementPosition(buyerElement)
            local position = {x,y,z, 13.5, 0, 0, 0, 0}
            exports["nlrp_vehicles"]:makeVehicle(vehicleID, buyerElement, factionID, position, 255, 255, 255)
            exports["nlrp_alert"]:showAlert(buyerElement, "info", "A frakció járműve megerkezett!", "Köszönjük a  vásárlásod!")
            end, 60000, 1 )

            exports["nlrp_alert"]:showAlert(buyerElement, "info", "Gratulálok! Sikeresen megvetted a járművet " .. exports.nlrp_groups:getGroupPrefix(factionID) .. " részére!", "1 perc múlva kiszállítjuk hozzád.")

    else
        if exports["nlrp_core"]:takeMoney(buyerElement, vehicleCost, "new vehicle") then
            local random = math.random(1, #parkingPositions)
            setTimer ( function()
            local x,y,z = getElementPosition(buyerElement)
            local position = {x,y,z, 13.5, 0, 0, 0, 0}
            exports["nlrp_vehicles"]:makeVehicle(vehicleID, buyerElement, 0, position, 255, 255, 255)
            exports["nlrp_alert"]:showAlert(buyerElement, "info", "A Jarmuved megérkezett!", "Köszönjük a vásárlásod!")
            end, 60000, 1 )
            exports["nlrp_alert"]:showAlert(buyerElement, "info", "Gratulálok! Sikeresen megvetted a járművet!", "1 perc múlva kiszállítjuk hozzád.")
        else
            exports["nlrp_alert"]:showAlert(buyerElement, "error", "Sajnálom, de nicns elengenőd pénzed", "ahhoz, hogy megvedd ezt a járművet.")
        end
    end]]--
end
registerEvent("nlrp_carshopS:buyVehicle", root, buyVehicle)
