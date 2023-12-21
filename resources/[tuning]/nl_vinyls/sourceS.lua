local core = exports.reach_core
local connection = core:getConnection()

addEvent("takeMoneyFromPlayer",true)
addEventHandler("takeMoneyFromPlayer",resourceRoot,
	function(player,dataend,amount)
		setElementData(player,"char." .. dataend,getElementData(player,"char." .. dataend)-amount)
	end
)
