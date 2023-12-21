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

addEvent("nlrp_skinshopS:buySkin", true)
addEventHandler("nlrp_skinshopS:buySkin", root, function(skin, price, player)
    if skin and price and getElementType(source) == "player" then
        if exports.nlrp_core:takeMoney(source, price) then
            dbQuery(
                function(queryHandle, player, skinID)
                    setElementModel(player, skin)
                    exports.nlrp_alert:showAlert("info", "Sikeresen megvásároltad a ruházatot.")
                    dbFree(queryHandle)
                end, {source, skin}, connection, "UPDATE characters SET skin = ? WHERE id = ?", skin, getElementData(source, "char.ID")
            )
        else
            exports.nlrp_alert:showAlert("error", "Nincs elég pénzed a vásárláshoz.")
        end
    end
end)