
addEvent("buyItemFromShop",true)
addEventHandler("buyItemFromShop",resourceRoot,
	function(player,id,count,price)
		if player then
			setElementData(player,"char.PP",getElementData(player,"char.PP")-price)
			exports.nlrp_inventory:giveItem(player,id,count)
			local name,_,_ = exports.nlrp_inventory:getItemInfoForShop(id)
			local text = "Sikeresen megvásároltál egy tárgyat. (" .. name:gsub("#%x%x%x%x%x%x","") .. ")"
			exports.nlrp_hud:showInfobox(player,"info",text)
		end
	end
)

addEvent("setWalkstyle",true)
addEventHandler("setWalkstyle",resourceRoot,
	function(player,id)
		if player then
			setPedWalkingStyle(player,id)
		end
	end
)
addEvent("setFightstyle",true)
addEventHandler("setFightstyle",resourceRoot,
	function(player,id)
		if player then
			setPedFightingStyle(player,id)
		end
	end
)