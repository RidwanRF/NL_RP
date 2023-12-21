local registerEvent = function(eventName, element, func)
	addEvent(eventName, true)
	addEventHandler(eventName, element, func)
end

registerEvent("nlrp_miningS:startMining", root, function()
    setPedAnimation(source, "baseball", "bat_4", -1, false)
    local x, y, z = getElementPosition(source)
    triggerClientEvent(root, "nlrp_miningC:playMiningSound", source)
    --print("Meghív")
end)

registerEvent("nlrp_miningS:stopMining", root, function()
    setPedAnimation(source)
end)

registerEvent("nlrp_miningS:giveOre", root, function(itemID)
    exports.nlrp_inventory:addItem(source, itemID, 1, false)
    local itemName = exports.nlrp_inventory:getItemName(itemID)
    exports.nlrp_hud:showAlert(source, "info", "A felvett " .. itemName .. " bekerült az inventorydba")
end)


registerEvent("nlrp_miningS:takeOres", root, function()
    local collectedMoney = 0
    for k, v in pairs(ores) do
        local itemID = v[4]
        local item = exports.nlrp_inventory:hasItem(source, itemID)
        if item then
            local itemName = exports.nlrp_inventory:getItemName(itemID)
            local itemCount = exports.nlrp_inventory:countItemsByItemID(source, itemID, true)

            for i = 1, itemCount do
                local money = math.random(v[3][1], v[3][2])
                exports.nlrp_core:giveMoney(source, money)
                collectedMoney = collectedMoney + money
            end
            triggerEvent("takeItem", source, source, "itemId", itemID, false)
        end
    end
    exports.nlrp_alert:showAlert(source, "info", "Sikeresen leadtad az érceidet", "Összessen " .. collectedMoney .. " Ft-ot kaptál értük")
end)