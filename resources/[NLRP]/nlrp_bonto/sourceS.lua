
local connection = exports.nlrp_database:getConnection()

addEvent("lótyiAdás",true)
addEventHandler("lótyiAdás",resourceRoot,
    function(player,amount,vehicle)
        if isElement(player) and isElement(vehicle) then
            setElementData(player,"char.Money",getElementData(player,"char.Money")+amount)

            exports.nlrp_inventory:removeItemByData(player,2,"data1",getElementData(vehicle,"vehicle.dbID"))

            dbExec(connection, "DELETE FROM vehicles WHERE vehicleID=?",getElementData(vehicle,"vehicle.dbID"))
            destroyElement(vehicle)
        end
    end
)