
local vehicles = {}

lockpickVehicle = function(player,cmd)
	local vehicle = getNearestVehicle(player,lockpickDistance)
	if vehicle then
		if vehicles[player] == vehicle then
			exports.nlrp_chat:sendLocalMeAction(player,"elővesz egy kulcskészletet, majd elkezdi bütykölni a zárat..")

			local p = Vector3(getElementPosition(vehicle))
			for k,v in ipairs(getElementsByType("player")) do
				if exports.nlrp_groups:isPlayerInGroup(v,1) or exports.nlrp_groups:isPlayerInGroup(v,28) then
					outputChatBox(" >> Bejelzett egy " .. exports.nlrp_vehs:getVehicleNameFromModel(getElementModel(vehicle)) .. " riasztója, " .. getZoneName(p) .. " környékén!",v,255,255,0,true)
				end
			end

			local a_element = player
			setPedAnimation(a_element,"bomber","bom_plant",-1,true,false,false)
			setTimer( function()
				setPedAnimation(a_element)
				setVehicleLocked(vehicles[a_element],false)
				setElementData(vehicles[a_element],"vehicle.locked",false)
			end,lockpickTime*1000,1)

			triggerClientEvent(player,"startLockpicking",player)
		else
			exports.nlrp_hud:showInfobox(player,"error",ped_data.name .. " nem erre az autóra gondolt..")
		end
	else
		exports.nlrp_hud:showInfobox(player,"error","Nincs a közeledben feltörhető autó!")
	end
end
addCommandHandler("feltör",lockpickVehicle)
addCommandHandler("feltor",lockpickVehicle)

addEvent("tryToFinsihQuest",true)
addEventHandler("tryToFinsihQuest",resourceRoot,
	function(player)
		if player then
			local vehicle = getPedOccupiedVehicle(player)
			if vehicle then
				if vehicle == vehicles[player] then
					local payment = 0
					if vehicle_prices[getElementModel(vehicle)] then payment = vehicle_prices[getElementModel(vehicle)] end

					local carHP = math.ceil(getElementHealth(vehicle)/10)
					if carHP < 100 then
						payment = payment*(carHP)/100
					end

					setElementData(player,"char.Money",getElementData(player,"char.Money")+payment)
					exports.nlrp_hud:showInfobox(player,"info","Sikeresen leadtad a járművet. Jármű állapota: " .. carHP .. "%.Fizetséged: " .. format(payment) .. "ft")

					destroyElement(vehicles[player])
					vehicles[player] = nil

					triggerClientEvent(player,"finishedQuest",player)
				else
					exports.nlrp_hud:showInfobox(player,"error",ped_data.name .. " nem erre az autóra gondolt..")
				end
			end
		end
	end
)

addEvent("spawnTheVehicle",true)
addEventHandler("spawnTheVehicle",resourceRoot,
	function(player,id,x,y,z,rot,r,g,b)
		vehicles[player] = createVehicle(id,x,y,z,0,0,rot)
		setElementData(vehicles[player],"nlrp->jobVehicle",true)
		setVehicleColor(vehicles[player],r,g,b)

		setElementData(vehicles[player],"nlrp->healthBar",true)

		setVehicleLocked(vehicles[player],true)
		setElementData(vehicles[player],"vehicle.locked",true)

		setElementData(vehicles[player],"quest.vehicleOwner",player)
	end
)

addEvent("destroyVehicle",true)
addEventHandler("destroyVehicle",resourceRoot,
	function(player)
		if vehicles[player] then
			destroyElement(vehicles[player])
			vehicles[player] = nil
			triggerClientEvent(player,"finishedQuest",player)
		end
	end
)

addEvent("giveKeyToVehicle",true)
addEventHandler("giveKeyToVehicle",resourceRoot,
	function(player)
		if isElement(player) then
			exports.nlrp_inventory:giveItem(player,378,1)
		end
	end
)

--// Item szállítás

local itemVehicles = {}

addEventHandler("onVehicleEnter",root,
	function(player,seat,jacked)
		if itemVehicles[player] then
			if itemVehicles[player] == source then
				local vehicle = source
				setTimer( function()
					local p = Vector3(getElementPosition(vehicle))
					for k,v in ipairs(getElementsByType("player")) do
						if exports.nlrp_groups:isPlayerInGroup(v,1) or exports.nlrp_groups:isPlayerInGroup(v,28) then
							outputChatBox(" >> Gyanús járművet (" .. exports.nlrp_vehs:getVehicleNameFromModel(getElementModel(vehicle)) .. ") észleltek, " .. getZoneName(p) .. " környékén!",v,255,255,0,true)
						end
					end
				end,30*1000,1)
			end
		end
	end
)

destroyItemVehicle = function(player)
	if itemVehicles[player] then
		destroyElement(itemVehicles[player])
		itemVehicles[player] = nil
		triggerClientEvent(player,"finishedQuest",player)
	end
end
addEvent("destroyItemVehicle",true)
addEventHandler("destroyItemVehicle",resourceRoot,destroyItemVehicle)

addEvent("spawnItemVehicle",true)
addEventHandler("spawnItemVehicle",resourceRoot,
	function(player)
		if not itemVehicles[player] then
			local r = math.random(1,#vehicle_pos)
			itemVehicles[player] = createVehicle(vehicle_ids[math.random(1,#vehicle_ids)],vehicle_pos[r][1],vehicle_pos[r][2],vehicle_pos[r][3],0,0,vehicle_pos[r][4])
		
			setVehicleLocked(itemVehicles[player],false)
			setElementData(itemVehicles[player],"vehicle.locked",false)

			setElementData(itemVehicles[player],"vehicle.dbID",76000541+getElementData(player,"char.ID"))

			local itemID = availableItems[math.random(1,#availableItems)].id
			local itemCount = math.random(1,49)
			for i = 0,itemCount-1 do
				exports.nlrp_inventory:addItem(itemVehicles[player],itemID,1,i)
			end
		end
	end
)

addEvent("tryToFinsihItemQuest",true)
addEventHandler("tryToFinsihItemQuest",resourceRoot,
	function(player)
		if player then
			local vehicle = getPedOccupiedVehicle(player)
			if vehicle then
				if vehicle == itemVehicles[player] then
					destroyItemVehicle(player)
					exports.nlrp_hud:showInfobox(player,"info","Sikeresen leadtad a járműved!")
					triggerClientEvent(player,"finishedQuest",player)
				else
					exports.nlrp_hud:showInfobox(player,"info","Ezt a járművet nem adhatod le!")
				end
			end
		end
	end
)

addEvent("giveMoneyForItems",true)
addEventHandler("giveMoneyForItems",resourceRoot,
	function(player,amount)
		setElementData(player,"char.Money",getElementData(player,"char.Money")+amount)
	end
)

addEventHandler("onPlayerQuit",root,
	function()
		if vehicles[source] then
			destroyElement(vehicles[source])
			vehicles[source] = nil
		end

		if itemVehicles[source] then
			destroyElement(itemVehicles[source])
			itemVehicles[source] = nil
		end
	end
)