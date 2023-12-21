addEventHandler("onResourceStart",resourceRoot,function()
	local huntman = createPed(168,-1813.2136230469, -135.46450805664, 6.129) 
    setElementInterior(huntman,0)
    setElementDimension(huntman,0)    
	setElementRotation(huntman,0,0,270)
	setElementFrozen(huntman,true)
	setElementData(huntman, "visibleName", "Hús és bőrfeldolgozó alkalmazott") -- Ped neve, írd át ha szeretnéd
	setElementData(huntman,"huntman",true)
end)

local registerEvent = function(eventName, element, func)
	addEvent(eventName, true)
	addEventHandler(eventName, element, func)
end

registerEvent("takeHuntingItems", root, function()
    local collectedMoney = 0
    for k, v in pairs(hunts) do
        local itemID = v[3]
        local item = exports.nlrp_inventory:hasItem(source, itemID)
        if item then
            local itemName = exports.nlrp_inventory:getItemName(itemID)
            local itemCount = exports.nlrp_inventory:countItemsByItemID(source, itemID, true)

            for i = 1, itemCount do
                local money = math.random(v[2][1], v[2][2])
                exports.nlrp_core:giveMoney(source, money)
                collectedMoney = collectedMoney + money
            end
            triggerEvent("takeItem", source, source, "itemId", itemID, false)
        end
    end
    exports.nlrp_alert:showAlert(source, "info", "Sikeresen leadtad az itemeket", "Összessen " .. collectedMoney .. ",-Ft-ot kaptál értük")
end)