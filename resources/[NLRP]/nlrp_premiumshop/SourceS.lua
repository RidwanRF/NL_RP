local connection = exports['nlrp_database']:getConnection()

function PremiumPontbuyItem(player, item, amount ,db, data1)
	if (tonumber(item) == 47) then
		exports["nlrp_phone"]:addPhone(player)
	else
		if db then 
			if data1 then
			--	outputChatBox(data1)
				exports.nlrp_inventory:giveItem(player, item, db, data1)
			else
				exports.nlrp_inventory:giveItem(player, item, db)
			end
		else
			if data1 then
			--	outputChatBox(data1)
				exports.nlrp_inventory:giveItem(player, item, 1, data1)
			else
				exports.nlrp_inventory:giveItem(player, item, 1)
			end
		end
	end
	dbExec(connection,"UPDATE characters SET pp = ? WHERE accID = ?", player:getData("char.PP")-amount, getElementData(player,"acc.ID"))
end
addEvent("PremiumPontbuyItem", true)
addEventHandler("PremiumPontbuyItem", getRootElement(), PremiumPontbuyItem)