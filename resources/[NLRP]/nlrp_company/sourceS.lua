
local connection = exports.nlrp_database:getConnection()


addEvent("getCompanyDatas",true)
addEventHandler("getCompanyDatas",resourceRoot,
	function(player,companyID,firstOpen)
		if isElement(player) and companyID then
			local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", companyID), -1)
			if #query > 0 then
				local transactions = dbPoll(dbQuery(connection, "SELECT * FROM companyTransactions WHERE companyID = ?", companyID), -1)
				local vehicles = {}
				triggerClientEvent(player,"returnCompany",player,query,transactions,vehicles,firstOpen)
			end
		end
	end
)

addEvent("createTrailer",true)
addEventHandler("createTrailer",resourceRoot,
	function(player,_r,id)
		local _r = math.random(1,#spawnPoses_trailer)
		setElementData(player,"company.trailer",
			createVehicle(id,spawnPoses_trailer[_r][1],spawnPoses_trailer[_r][2],spawnPoses_trailer[_r][3],0,0,spawnPoses_trailer[_r][4])
		)
	end
)

local old_handling = {}

addEventHandler("onTrailerAttach",root,
	function(vehicle)
		if vehicle then
			old_handling[vehicle] = getVehicleHandling(vehicle)["engineAcceleration"]
			setVehicleHandling(vehicle,"engineAcceleration",getVehicleHandling(vehicle)["engineAcceleration"]-4)
		end
	end
)

addEventHandler("onTrailerDetach",root,
	function(vehicle)
		if vehicle then
			if old_handling[vehicle] then
				setVehicleHandling(vehicle,"engineAcceleration",old_handling[vehicle])
				old_handling[vehicle] = nil
			end
		end
	end
)
--[[
addEventHandler("onElementDestroy",root,
	function()
		if getElementType(source) == "vehicle" then
			for _,player in ipairs(getElementsByType("player")) do
				local trailer = getElementData(player,"company.trailer") or false
				if trailer then
					if trailer == source then
						local _pVehicle = getPedOccupiedVehicle(player)
						if _pVehicle then
							if old_handling[_pVehicle] then
								setVehicleHandling(_pVehicle,"engineAcceleration",old_handling[_pVehicle])
							end
						end
					end
 				end
			end
		end
	end
) --]]

addEvent("sellVehicleToShop",true)
addEventHandler("sellVehicleToShop",resourceRoot,
	function(player,dbid)
		local veh = findVehicleByDBID(dbid)
		if veh then
			local companyID = getElementData(player,"char.CompanyID")
			local price = math.floor(getModelPriceFromShop(veh)*0.35)
			insertTransaction(companyID,getElementData(player,"char.Name"):gsub("_"," ") .. " eladott egy '" .. getVehicleNameFromShop(veh) .."' nevű járművet! (+" .. format(price) .. " Ft)")
			local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", companyID), -1)
			dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?", query[1].balance+price, companyID)

			dbExec(connection, "DELETE FROM companyVehicles WHERE id = ? LIMIT 1", dbid)
			destroyElement(veh)
		end
	end
)

local sellings = {}

addEvent("sellVehicleToPlayer",true)
addEventHandler("sellVehicleToPlayer",resourceRoot,
	function(player,targetID,price,dbid)
		local targetPlayer = exports.nlrp_core:findPlayer(targetID)
		local vehicle = findVehicleByDBID(dbid)
		if vehicle then
			if getElementDimension(vehicle) >= 30000 then
				if sellings[player] then
					exports.nlrp_hud:showInfobox(player,"error","Már folyamatban van egy eladásod!")
				else
					local _tplayer = player
					sellings[player] = {
						vehicle_dbid = dbid,
						timer = setTimer(function() cancelSelling(_tplayer) end,5*(60*1000),1),
						target = targetPlayer,
						price = price,
					}	

					outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen küldtél egy eladási ajánlatot #b7ff00'" .. getElementData(targetPlayer,"char.Name"):gsub("_"," ") .. "'#ffffff nevű játékosnak!",player,0,0,0,true)
					outputChatBox("#b7ff00 >> NextLevel:#ffffff Ha nem fogadja el az ajánlatot #b7ff005 percen#ffffff belül, érvénytelenné válik!",player,0,0,0,true)
				
					exports.nlrp_hud:showInfobox(targetPlayer,"info","Kaptál egy eladási ajánlatot! Részletek a chatbox-ban!")
					outputChatBox(" ",targetPlayer,0,0,0,true)
					outputChatBox("#b7ff00 >> NextLevel:#ffffff '" .. getElementData(targetPlayer,"char.Name"):gsub("_"," ") .. "' nevű játékos küldött neked egy eladási ajánlatot!",targetPlayer,0,0,0,true)
					outputChatBox("#b7ff00 >> NextLevel:#ffffff Jármű: #b7ff00" .. getVehicleNameFromShop(vehicle) .. "",targetPlayer,0,0,0,true)
					outputChatBox("#b7ff00 >> NextLevel:#ffffff Ára: #b7ff00" .. format(price) .. " #ffffffFt",targetPlayer,0,0,0,true)
					outputChatBox("#b7ff00 >> NextLevel:#ffffff Az ajánlat elfogadásához használd a #b7ff00/buyvehicle#ffffff az elutasításhoz pedig a #e43a3a/cancel#ffffff parancsot!",targetPlayer,0,0,0,true)
				end
			else
				exports.nlrp_hud:showInfobox(player,"error","A kiválasztott jármű jelenleg használatban van!")
			end
		end
	end
)

addCommandHandler("cancel",
	function(player,cmd)
		local row = findSellRowByTarger(player)
		if row then
			local sellPlayer = row[1]
			row = row[2]
			outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen vissza utasítottad az ajánlatot!",player,0,0,0,true)
			outputChatBox("#e43a3a >> NextLevel:#ffffff Vissza utasították az eladási ajánlatod!",sellPlayer,0,0,0,true)

			if isTimer(sellings[sellPlayer].timer) then killTimer(sellings[sellPlayer].timer) end
			sellings[sellPlayer] = nil
		else
			exports.nlrp_hud:showInfobox(player,"error","Jelenleg nincs aktív eladási ajánlatod!")
		end
	end
)

addCommandHandler("buyvehicle",
	function(player,cmd)
		local row = findSellRowByTarger(player)
		if row then
			local sellPlayer = row[1]
			row = row[2]

			local vehicle = findVehicleByDBID(row.vehicle_dbid)
			local company = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", getElementData(player,"char.CompanyID")), -1)
			if company then
				company = company[1]

				if company.balance >= row.price then
					local company_vehicles = getCompanyVehicles(company.id)
					if #company_vehicles < company.vehicleSlot then
						dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?", company.balance-row.price, company.id)
						dbExec(connection, "UPDATE companyVehicles SET companyID = ? WHERE id = ?", company.id, row.vehicle_dbid)

						setElementData(vehicle,"company.companyID",company.id)

						insertTransaction(company.id,getElementData(player,"char.Name"):gsub("_"," ") .. " vásárolt egy '" .. getVehicleNameFromShop(vehicle) .. "' típúsú járművet! ( -" .. format(row.price) .. " Ft )")

						company = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", getElementData(sellPlayer,"char.CompanyID")), -1)
						company = company[1]
						dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?", company.balance+row.price, company.id)
						insertTransaction(company.id,getElementData(player,"char.Name"):gsub("_"," ") .. " eladott egy '" .. getVehicleNameFromShop(vehicle) .. "' típúsú járművet! ( +" .. format(row.price) .. " Ft )")

						outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen megvásároltad a kiválasztott járművet!",player,0,0,0,true)
						outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen eladtad a kiválasztott járművet!",sellPlayer,0,0,0,true)
					
						if isTimer(sellings[sellPlayer].timer) then killTimer(sellings[sellPlayer].timer) end
						sellings[sellPlayer] = nil
					else
						exports.nlrp_hud:showInfobox(player,"error","Vállalkozásodnak nincs elegendő jármű slot-ja!")
					end
				else
					exports.nlrp_hud:showInfobox(player,"error","Vállalkozásodnak nincs elegendő pénze!")
				end
			end
		else
			exports.nlrp_hud:showInfobox(player,"error","Jelenleg nincs aktív eladási ajánlatod!")
		end
	end
)

cancelSelling = function(player)
	if sellings[player] then
		outputChatBox("#e43a3a >> NextLevel:#ffffff Lejárt az 5 perc, így a jármű nem került eladásra!",player,0,0,0,true)

		if isTimer(sellings[player].timer) then killTimer(sellings[player].timer) end
		sellings[player] = nil
	end
end

findSellRowByTarger = function(player)
	local row = false
	for p,v in pairs(sellings) do
		if v.target == player then
			row = {p,v}
		end
	end
	return row
end



addEvent("tryBuySlot",true)
addEventHandler("tryBuySlot",resourceRoot,
	function(player,companyID,type,count)
		if isElement(player) then
			if companyID and type and count then
				if getElementData(player,"char.PP") >= count*slotPrice then
					local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", companyID), -1)
					local slot = 0
					setElementData(player,"char.PP",getElementData(player,"char.PP")-count*slotPrice)
					if type == "member" then
						slot = query[1].memberSlot
						dbExec(connection, "UPDATE companys SET memberSlot = ? WHERE id = ?", slot+count, companyID)
						insertTransaction(companyID,getElementData(player,"char.Name"):gsub("_"," ") .. " vásárolt " .. count .." darab tag slot-ot!")
					elseif type == "vehicle" then
						slot = query[1].vehicleSlot
						dbExec(connection, "UPDATE companys SET vehicleSlot = ? WHERE id = ?", slot+count, companyID)
						insertTransaction(companyID,getElementData(player,"char.Name"):gsub("_"," ") .. " vásárolt " .. count .." darab jármű slot-ot!")
					elseif type == "level" then
						slot = query[1].level
						dbExec(connection, "UPDATE companys SET level = ?,xp = ? WHERE id = ?", slot+count,0, companyID)
						insertTransaction(companyID,getElementData(player,"char.Name"):gsub("_"," ") .. " vásárolt " .. count .." szintet a vállalkozásnak!")
					end
				else
					exports.nlrp_hud:showInfobox(player,"error","Nincs elegendő NL Coin-od a vásárláshoz!")
				end
			end
		end
	end
)

addEvent("setUpCompany",true)
addEventHandler("setUpCompany",resourceRoot,
	function(player,type,name)
		if isElement(player) and type and name then
			local companyID = getElementData(player,"char.CompanyID")
			dbExec(connection, "UPDATE companys SET name = ?,type = ? WHERE id = ?", name,type, companyID)
		end
	end
)

addEvent("getPlayerCompanyType",true)
addEventHandler("getPlayerCompanyType",resourceRoot,
	function(player)
		if isElement(player) then
			local companyID = getElementData(player,"char.CompanyID") or 0
			if companyID > 0 then
				local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", companyID), -1)
				if #query > 0 then
					local ranks = fromJSON(query[1].ranks)
					local returnValue = false
					
					if getElementData(player,"char.CompanyRank") == "5" then
						returnValue = query[1].type
					end
					if query[1].leader == getElementData(player,"char.ID") then
						returnValue = query[1].type
					end

					triggerClientEvent(player,"returnCompanyTypeForShop",player,returnValue,query[1].level,query[1].balance)
				end
			end
		end
	end
)

addEvent("updateBalance",true)
addEventHandler("updateBalance",resourceRoot,
	function(player,id,old_company_amount,amount,type)
		if isElement(player) then
			if type == "+" then
				dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?",old_company_amount+amount, id)
				setElementData(player,"char.Money",getElementData(player,"char.Money")-amount)
			elseif type == "-" then
				dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?",old_company_amount-amount, id)
				setElementData(player,"char.Money",getElementData(player,"char.Money")+amount)
			end
		end
	end
)

addEvent("editRanks",true)
addEventHandler("editRanks",resourceRoot,
	function(id,ranks)
		dbExec(connection, "UPDATE companys SET ranks = ? WHERE id = ?", toJSON(ranks), id)
	end
)

addEvent("changeCompanyText",true)
addEventHandler("changeCompanyText",resourceRoot,
	function(id,message)
		dbExec(connection, "UPDATE companys SET message = ? WHERE id = ?", message, id)
	end
)


addEvent("payTaxesForPlayer",true)
addEventHandler("payTaxesForPlayer",resourceRoot,
	function(sourcePlayer,player,day,oldTax)
		local time = getTimestamp()
		time = time+(86400*day)
		if isElement(player) then
			if oldTax > 0 then
				time = oldTax+(86400*day)
			end
			setElementData(player,"char.CompanyTaxPayed",time)
			dbExec(connection, "UPDATE characters SET company_tax_payed = ? WHERE charID = ?", time, getElementData(player,"char.ID"))
		else
			dbExec(connection, "UPDATE characters SET company_tax_payed = ? WHERE charID = ?", time, player)
		end
		loadCompanyMembers(sourcePlayer,getElementData(sourcePlayer,"char.CompanyID"))
	end
)

addEvent("editBalance",true)
addEventHandler("editBalance",resourceRoot,
	function(id,balance)
		dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?", balance,id)
	end
)

addEvent("kickPlayerFromCompany",true)
addEventHandler("kickPlayerFromCompany",resourceRoot,
	function(playerOrID)
		if isElement(playerOrID) then
			setElementData(playerOrID,"char.CompanyID",0)
			dbExec(connection, "UPDATE characters SET company = ? WHERE charID = ?", 0,getElementData(playerOrID,"char.ID"))

			outputChatBox(exports.nlrp_core:getServerTag("info") .. "Ki lettél rúgva a vállalkozásból!",playerOrID,0,0,0,true)
		else
			dbExec(connection, "UPDATE characters SET company = ? WHERE charID = ?", 0,playerOrID)
		end
	end
)

addEvent("promotePlayer",true)
addEventHandler("promotePlayer",resourceRoot,
	function(sourcePlayer,companyID,playerOrID,rank_now,playerName)
		if isElement(playerOrID) then
			setElementData(playerOrID,"char.CompanyRank",tostring(rank_now+1))
			dbExec(connection, "UPDATE characters SET company_rank = ? WHERE charID = ?", rank_now+1,getElementData(playerOrID,"char.ID"))
		else
			dbExec(connection, "UPDATE characters SET company_rank = ? WHERE charID = ?", rank_now+1,playerOrID)
		end
		insertTransaction(companyID,getElementData(sourcePlayer,"char.Name"):gsub("_"," ") .. " előléptette '" .. playerName:gsub("_"," ") .."' nevű tagot!")
	end
)

addEvent("decratePlayer",true)
addEventHandler("decratePlayer",resourceRoot,
	function(sourcePlayer,companyID,playerOrID,rank_now,playerName)
		if isElement(playerOrID) then
			setElementData(playerOrID,"char.CompanyRank",tostring(rank_now-1))
			dbExec(connection, "UPDATE characters SET company_rank = ? WHERE charID = ?", rank_now-1,getElementData(playerOrID,"char.ID"))
		else
			dbExec(connection, "UPDATE characters SET company_rank = ? WHERE charID = ?", rank_now-1,playerOrID)
		end
		insertTransaction(companyID,getElementData(sourcePlayer,"char.Name"):gsub("_"," ") .. " lefokozta '" .. playerName:gsub("_"," ") .."' nevű tagot!")
	end
)

addEvent("inviteToCompany",true)
addEventHandler("inviteToCompany",resourceRoot,
	function(player,targetPlayer,id,name)
		if isElement(player) then
			outputChatBox(exports.nlrp_core:getServerTag("info") .. "" .. getElementData(player,"char.Name"):gsub("_"," ") .. " felvett téged a " .. name .. " nevű vállalkozásba!",targetPlayer,0,0,0,true)
			setElementData(targetPlayer,"char.CompanyID",id)
			setElementData(targetPlayer,"char.CompanyRank","1")

			dbExec(connection, "UPDATE characters SET company = ? WHERE charID = ?", id,getElementData(targetPlayer,"char.ID"))

			loadCompanyMembers(player,id)
		end
	end
)

function loadCompanyMembers(player,id)
	local query = dbPoll(dbQuery(connection, "SELECT * FROM characters WHERE company = ?", id), -1)
	local players = {}
	for k,row in ipairs(query) do
		table.insert(players,
			{dbid=row.charID,name=row.name,rank=row.company_rank,lastOnline=row.lastOnline,taxPayed=row.company_tax_payed}
		)
	end
	triggerClientEvent(player,"returnCompanyMembers",player,players)
end
addEvent("loadCompanyMembers",true)
addEventHandler("loadCompanyMembers",resourceRoot,loadCompanyMembers)

function insertTransaction(companyID,text)
	dbExec(connection, "INSERT INTO companyTransactions SET companyID = ?, time = ?, text = ?",
		companyID,getTimestamp(),text)
end
addEvent("insertTransaction",true)
addEventHandler("insertTransaction",resourceRoot,insertTransaction)


addEventHandler("onResourceStart",resourceRoot,
	function()
		for id,row in ipairs(companyPed) do
			local ped = createPed(row.skin,row.pos[1],row.pos[2],row.pos[3],row.rot)
			setElementInterior(ped,row.int)
			setElementDimension(ped,row.dim)
			setElementFrozen(ped,true)

			setElementData(ped,"nlrp->company->ped",true)

			setElementData(ped,"ped.name",row.name)
			setElementData(ped,"pedNameType","Vállalkozás")
		end

		--[[
		for id,row in ipairs(finishJobPeds) do
			local ped = createPed(row.skin,row.pos[1],row.pos[2],row.pos[3])
			setElementInterior(ped,row.int)
			setElementDimension(ped,row.dim)
			setElementFrozen(ped,true)

			setElementData(ped,"nlrp->company->finishJob",true)
			setElementData(ped,"ped.name","Random Név")
			setElementData(ped,"pedNameType","Telepvezető")
		end ]]--
	end
)


addEvent("createNewCompany",true)
addEventHandler("createNewCompany",resourceRoot,
	function(player)
		if isElement(player) then
			setElementData(player,"char.Money",getElementData(player,"char.Money")-newCompanyPrice)
			exports.nlrp_inventory:giveItem(player,384,1)
			insertNewCompany(player)
		end
	end
)

function insertNewCompany(leader)
	local charID = getElementData(leader,"char.ID")
	
	local ranks = {
		[1] = {name="Üres Rang",precent=0},
		[2] = {name="Üres Rang",precent=0},
		[3] = {name="Üres Rang",precent=0},
		[4] = {name="Üres Rang",precent=0},
		[5] = {name="Tulajdonos",precent=100},
	}

	local company_insert = dbQuery(connection, "INSERT INTO companys SET name = ?, type = ?, leader = ?, balance = ?, ranks = ?",
		"Vállalkozás",false,charID,newCompanyPrice/2,toJSON(ranks))
	local result, num, insertID = dbPoll(company_insert, -1)
	setElementData(leader,"char.CompanyID",insertID)
	setElementData(leader,"char.CompanyRank","5")

	dbExec(connection, "UPDATE characters SET company = ? WHERE charID = ?", insertID, getElementData(leader,"char.ID"))
	dbExec(connection, "UPDATE characters SET company_rank = ? WHERE charID = ?", 5, getElementData(leader,"char.ID"))
end



--// Jármű lehívás

addEvent("spawnVehicle",true)
addEventHandler("spawnVehicle",resourceRoot,
	function(player,dbid)
		if player and dbid then
			local data = dbPoll(dbQuery(connection,"SELECT * FROM companyVehicles WHERE id = ?",dbid),-1)[1]
			if data then
				local vehicle = findVehicleByDBID(data.id)
				if vehicle then
					local rand = math.random(1,#spawnPoses)
					setElementPosition(vehicle,spawnPoses[rand][1],spawnPoses[rand][2],spawnPoses[rand][3])
					setElementRotation(vehicle,0,0,spawnPoses[rand][4])

					setElementDimension(vehicle,0)
					setElementInterior(vehicle,0)

					setElementCollisionsEnabled(vehicle,true)

					setElementData(vehicle,"lastOilChange",0)
					setElementData(vehicle,"vehicle.fuel",exports.nlrp_hud:getTheFuelTankSizeOfVehicle(getElementModel(vehicle)))
					setElementFrozen(vehicle,false)

					triggerClientEvent(player,"toggleVehicleCollisions",player,vehicle,false)

					setElementData(vehicle,"company.driver",player)

					setElementData(player,"char.SpawnedVehicle",vehicle)

					exports.nlrp_hud:showInfobox(player,"info","Sikeresen lekérted a kiválasztott járművet! Menj és rakodj fel egy fuvart!")

					insertTransaction(getElementData(player,"char.CompanyID"),getElementData(player,"char.Name"):gsub("_"," ") .. " lekért egy járművet! ( " .. getVehicleNameFromShop(vehicle) .. " - ID: " .. dbid .. " )")
				end
			end
		end
	end
)

function deLoadVehicle(vehicle)
	if vehicle then
		setElementFrozen(vehicle,true)
		setElementCollisionsEnabled(vehicle,false)
		setElementDimension(vehicle,30000+getElementData(vehicle,"company.vehicleID"))

		setElementData(vehicle,"company.driver",false)

		--if old_h[vehicle] then
			--setVehicleHandling(vehicle,"engineAcceleration",old_h[vehicle])
			--old_h[vehicle] = false
		--end
	end
end

addEvent("dropDownvehicle",true)
addEventHandler("dropDownvehicle",resourceRoot,
	function(p,v)
		if isElement(getElementData(p,"company.trailer")) then
			destroyElement(getElementData(p,"company.trailer"))
		end

		removePedFromVehicle(p)
		deLoadVehicle(v)
	end
)



local unloadTimers = {}

addEventHandler("onPlayerQuit",root,
	function()
		for k,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v,"company.driver") == source then
				local vehicle = v
				table.insert(unloadTimers,1,
					{
						timer = setTimer( function()
							deLoadVehicle(vehicle)
						end,unloadVehicleAfterQuit*1000,1),
						serial = getPlayerSerial(source),
					}
				)
			end
		end
	end
)

addEventHandler("onPlayerConnect",root,
	function(_,_,_,serial)
		for k,v in ipairs(unloadTimers) do
			if v.serial == serial then
				if isTimer(v.timer) then
					killTimer(v.timer)
				end

				table.remove(unloadTimers,k)
			end
		end
	end
)






addEvent("getPlayerPrecent",true)
addEventHandler("getPlayerPrecent",resourceRoot,
	function(player)
		if player then
			local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", getElementData(player,"char.CompanyID")), -1)
			if #query > 0 then
				query = query[1]
				local rank_id = getElementData(player,"char.CompanyRank")
				local ranks = fromJSON(query.ranks)
				if ranks[tostring(rank_id)] then
					triggerClientEvent(player,"returnPrecent",player,ranks[rank_id].precent)
				end
			end
		end
	end
)

--// Fuvarlevél adás
addEvent("giveLetter",true)
addEventHandler("giveLetter",resourceRoot,
	function(player,job,dx,dy,dz)
		local vehicle = getPedOccupiedVehicle(player)
		local company = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id =	 ?", getElementData(player,"char.CompanyID")), -1)
		company = company[1]
		local ranks = fromJSON(company.ranks)

		local data = {}
		data.plate = getVehiclePlateText(vehicle)
		data.vehicle_model = getVehicleNameFromShop(vehicle)
		data.max_weight = 40000
		data.driver = getElementData(player,"char.Name"):gsub("_"," ")
		data.date = getTimestamp()
		data.company_name = company["name"]
		local x,y,z = getElementPosition(player)
		data.start = getZoneName(x,y,z)
		data.destination = getZoneName(dx,dy,dz)
		data.product_name = job.name
		data.product_weight = job.weight
		data.product_id = "#NL" .. math.random(1000000,9999999)
		data.payment = (job.payment/100)*ranks[getElementData(player,"char.CompanyRank")].precent -- job.payment

		exports.nlrp_inventory:giveItem(player,240,1,toJSON(data),0,false)
	end
)

--// Fuvar levél leadása (Amikor ráhúzza az itemet a pedre)
function completeJob(player)
	local vehicle = getElementData(player,"char.SpawnedVehicle")
	local job = getElementData(player,"char.CurrentJob")


	job.payment = job.payment*(getElementHealth(vehicle)/1000)

	local company = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", getElementData(player,"char.CompanyID")), -1)
	company = company[1]
	local ranks = fromJSON(company.ranks)

	local playerPayment = (job.payment/100)*ranks[getElementData(player,"char.CompanyRank")].precent

	if job and vehicle then
		if getElementData(player,"company.trailer") then
			destroyElement(getElementData(player,"company.trailer"))

			if old_handling[vehicle] then
				setVehicleHandling(vehicle,"engineAcceleration",old_handling[vehicle])
				old_handling[vehicle] = nil
			end
		end
		triggerClientEvent(player,"completeJobClient",player)

		exports.nlrp_hud:showInfobox(player,"info","Sikeresen leadtad a fuvart, és kerestél " .. format(playerPayment) .. " Ft összeget!")
		setElementData(player,"char.Money",getElementData(player,"char.Money")+playerPayment)

		local toCompanyPrice = job.payment-playerPayment

		local rent = getElementData(vehicle,"company.rent") or -1
		if rent >= 0 then
			rent = rent - 1
			if rent > 0 then
				setElementData(vehicle,"company.rent",rent)
			else
				outputChatBox("#b7ff00 >> NextLevel:#ffffff A járműnek lejárt a bérleti szerződése!",player,0,0,0,true)
				dbExec(connection, "DELETE FROM companyVehicles WHERE id = ? LIMIT 1", getElementData(vehicle,"company.vehicleID"))
				destroyElement(vehicle)
			end
		end

		local exp = math.random(exports.nle_carshop:getVehicleExpFromShop(vehicle)[1],exports.nle_carshop:getVehicleExpFromShop(vehicle)[2])

		local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", getElementData(player,"char.CompanyID")), -1)
		if #query > 0 then
			query = query[1]

			local nextLevelEXP = getEXPToNextLevel(query.level)
			if query.xp+exp >= nextLevelEXP then
				dbExec(connection, "UPDATE companys SET xp = ? WHERE id = ?",(query.xp+exp)-nextLevelEXP, getElementData(player,"char.CompanyID"))
				dbExec(connection, "UPDATE companys SET level = ? WHERE id = ?",query.level+1, getElementData(player,"char.CompanyID"))
			else
				dbExec(connection, "UPDATE companys SET xp = ? WHERE id = ?", query.xp+exp, getElementData(player,"char.CompanyID"))
			end

			dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?", query.balance+toCompanyPrice, getElementData(player,"char.CompanyID"))
		end

		insertTransaction(getElementData(player,"char.CompanyID"),getElementData(player,"char.Name"):gsub("_"," ") .. " leadott egy fuvart! ( Bevétel: " .. format(job.payment) .. " Ft | Sofőr részesedése: " .. format(playerPayment) .. " Ft | EXP: +" .. exp .. ")")
	end
end


--// Napi jármű adó

payVehicleTaxes = function()
	local query = dbPoll(dbQuery(connection, "SELECT * FROM companys"), -1)
	for _,v in ipairs(query) do
		local tax = 0
		local count = 0
		for _,row in ipairs(dbPoll(dbQuery(connection,"SELECT * FROM companyVehicles WHERE companyID = ?",v.id),-1)) do
			tax = tax + exports.nle_carshop:getModelOriginalPrice(row.model)*vehicleTaxAmount
			count = count + 1
		end
		if tax > 0 then
			if v.balance-tax <= -10000000 then
				dbExec(connection, "DELETE FROM companys WHERE id = ?",v.id)
				dbExec(connection, "DELETE FROM companyVehicles WHERE companyID = ?",v.id)
				dbExec(connection, "DELETE FROM companyTransactions WHERE companyID = ?",v.id)

				for _,player in ipairs(getElementsByType("player")) do
					if getElementData(player,"char.CompanyID") == v.id then
						setElementData(player,"char.CompanyID",0)
					end
				end

				dbExec(connection,"UPDATE characters SET company = ? WHERE company = ?", 0,v.id)
			else
				insertTransaction(v.id,"Napi jármű adók levonva: -" .. format(tax) .. " Ft (" .. count .. " db jármű)")

				dbExec(connection,"UPDATE companys SET balance = ? WHERE id = ?", v.balance-tax,v.id)
			end
		end
	end
end

setTimer( function()
	if getRealTime().hour == 0 then
		payVehicleTaxes()
	end
end,(60*1000)*60,0)










checkPlayerTaxes = function(player,cmd,...)
	if exports.nlrp_groups:isPlayerInGroup(player,factionIds[1]) or exports.nlrp_groups:isPlayerInGroup(player,factionIds[2]) then
		if (...) then
			local name = table.concat({...}, " ")
			local targetPlayer = exports.nlrp_core:findPlayer(name)
			if targetPlayer then
				local p1 = Vector3(getElementPosition(player))
				local p2 = Vector3(getElementPosition(targetPlayer))
				if getDistanceBetweenPoints3D(p1,p2) <= 20 then
					local tax = getElementData(targetPlayer,"char.CompanyTaxPayed") or 0
					local date = getTimestamp()
					local formatted = formatDate("(Y/m/d - h:i:s)","'",tax)
					if tax == 0 then
						outputChatBox("#e43a3a >> NextLevel:#ffffff " .. getElementData(targetPlayer,"char.Name"):gsub("_"," ") .. "-nek/nak nincs befizetve a járuléka!",player,0,0,0,true)
					else
						if tax <= date then
							outputChatBox("#e43a3a >> NextLevel:#ffffff " .. getElementData(targetPlayer,"char.Name"):gsub("_"," ") .. "-nek/nak nincs befizetve a járuléka! Lejárt: " .. formatted,player,0,0,0,true)
						else
							outputChatBox("#b7ff00 >> NextLevel:#ffffff " .. getElementData(targetPlayer,"char.Name"):gsub("_"," ") .. "-nek/nak be van fizetve a járuléka eddig: " .. formatted,player,0,0,0,true)
						end
					end
				else
					outputChatBox("#e43a3a >> NextLevel:#ffffff A kiválasztott játékos túl messze van tőled!",player,0,0,0,true)
				end
			else
				outputChatBox("#e43a3a >> NextLevel:#ffffff Nem található játékos ezzel a névvel!",player,0,0,0,true)
			end
		else
			outputChatBox("#e43a3a >> NextLevel:#ffffff /" .. cmd .. " [Játékos név/id]",player,0,0,0,true)
		end
	end
end
addCommandHandler("jarulek",checkPlayerTaxes)
addCommandHandler("járulék",checkPlayerTaxes)




addEvent("_takeJob",true)
addEventHandler("_takeJob",resourceRoot,
	function(player,name)
		if player and name then
			local targetPlayer = exports.nlrp_core:findPlayer(name)
			if targetPlayer then
				local vehicle = findVehicleByDriver(targetPlayer)
				if vehicle then deLoadVehicle(vehicle) end
				local trailer = getElementData(targetPlayer,"company.trailer")
				if trailer then destroyElement(trailer) end

				outputChatBox("#e43a3a >> NextLevel:#ffffff " .. getElementData(player,"char.Name"):gsub("_"," ") .. " lefoglalta a fuvarodat!",targetPlayer,0,0,0,true)
				outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen lefoglaltad " .. getElementData(targetPlayer,"char.Name"):gsub("_"," ") .. " fuvarját!",player,0,0,0,true)

				setElementData(targetPlayer,"char.CurrentJob",false)
				setElementData(targetPlayer,"company.Jobstate","notStarted")
				setElementData(targetPlayer,"company.jobPackedDown",false)
				setElementData(targetPlayer,"company.trailer",false)
			else
				exports.nlrp_hud:showInfobox(player,"error","Ez a fuvar már nem aktuális!")
			end
		end
	end
)

findVehicleByDriver = function(p)
	local vehicle = false
	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v,"company.driver") == p then
			vehicle = v
		end
	end
	return vehicle
end


addCommandHandler("getccar",
	function(player,cmd,id)
		if getElementData(player,"acc.adminLevel") >= 1 then
			if id then
				if tonumber(id) then
					id = tonumber(id)
					local vehicle = findVehicleByDBID(id)
					if vehicle then
						if getElementDimension(vehicle) >= 30000 then
							outputChatBox("#e43a3a >> NextLevel:#ffffff A kiválasztott jármű nincs használatban, így nem get-elheted!",player,0,0,0,true)
						else
							local x,y,z = getPositionFromElementOffset(player,4,0,0.4)
							local rx,ry,rz = getElementRotation(player)

							if setElementPosition(vehicle,x,y,z) and setElementRotation(vehicle,rx,ry,rz) then
								outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen get-elted az adott járművet!",player,0,0,0,true)
							else
								outputChatBox("#e43a3a >> NextLevel:#ffffff Nem sikerült get-elni az adott járművet!",player,0,0,0,true)
							end
						end
					else
						outputChatBox("#e43a3a >> NextLevel:#ffffff Nem található jármű a megadott ID-vel!",player,0,0,0,true)
					end
				else
					outputChatBox("#e43a3a >> NextLevel:#ffffff Hibás jármű ID lett megadva!",player,0,0,0,true)
				end
			else
				outputChatBox("#e43a3a >> NextLevel:#ffffff /" .. cmd .. " [Jármű ID]",player,0,0,0,true)
			end
		end
	end
)

addCommandHandler("gotoccar",
	function(player,cmd,id)
		if getElementData(player,"acc.adminLevel") >= 1 then
			if id then
				if tonumber(id) then
					id = tonumber(id)
					local vehicle = findVehicleByDBID(id)
					if vehicle then
						if getElementDimension(vehicle) >= 30000 then
							outputChatBox("#e43a3a >> NextLevel:#ffffff A kiválasztott jármű nincs használatban, így nem teleportálhatsz oda hozzá!",player,0,0,0,true)
						else
							local x,y,z = getPositionFromElementOffset(vehicle,4,0,0.4)

							if setElementPosition(player,x,y,z) then
								outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen elteleportáltál az adott járműhöz!",player,0,0,0,true)
							else
								outputChatBox("#e43a3a >> NextLevel:#ffffff Nem sikerült goto-zni az adott járműhöz!",player,0,0,0,true)
							end
						end
					else
						outputChatBox("#e43a3a >> NextLevel:#ffffff Nem található jármű a megadott ID-vel!",player,0,0,0,true)
					end
				else
					outputChatBox("#e43a3a >> NextLevel:#ffffff Hibás jármű ID lett megadva!",player,0,0,0,true)
				end
			else
				outputChatBox("#e43a3a >> NextLevel:#ffffff /" .. cmd .. " [Jármű ID]",player,0,0,0,true)
			end
		end
	end
)

addCommandHandler("setcompany",
	function(player,cmd,pName,CompanyID)
		if getElementData(player,"acc.adminLevel") >= 9 then
			if pName and CompanyID then
				local targetPlayer = exports.nlrp_core:findPlayer(pName)
				if targetPlayer then
					if getElementData(targetPlayer,"loggedIn") then
						if tonumber(CompanyID) then
							CompanyID = tonumber(CompanyID)
							if CompanyID >= 1 then
								local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", CompanyID), -1)
								if #query > 0 then
									query = query[1]

									setElementData(targetPlayer,"char.CompanyID",CompanyID)
									setElementData(targetPlayer,"char.CompanyRank","1")
									dbExec(connection,"UPDATE characters SET company = ? WHERE charID = ?", CompanyID, getElementData(targetPlayer,"char.ID"))
									dbExec(connection,"UPDATE characters SET company_rank = ? WHERE charID = ?", 1, getElementData(targetPlayer,"char.ID"))

									outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen betetted a játékost vállalkozásba! (" .. query.name .. ")",player,0,0,0,true)
									outputChatBox("#b7ff00 >> NextLevel:#ffffff " .. getElementData(player, "acc.adminNick") .. " betett téged egy vállalkozásodba! (" .. query.name .. ")",targetPlayer,0,0,0,true)
								else
									outputChatBox("#e43a3a >> NextLevel:#ffffff Nem található vállalkozás a megadott ID-vel!",player,0,0,0,true)
								end
							elseif CompanyID == 0 then
								setElementData(targetPlayer,"char.CompanyID",CompanyID)
								setElementData(targetPlayer,"char.CompanyRank","1")
								dbExec(connection,"UPDATE characters SET company = ? WHERE charID = ?", CompanyID, getElementData(targetPlayer,"char.ID"))
								dbExec(connection,"UPDATE characters SET company_rank = ? WHERE charID = ?", 1, getElementData(targetPlayer,"char.ID"))

								outputChatBox("#b7ff00 >> NextLevel:#ffffff Sikeresen kivetted a játékost a vállalkozásból!",player,0,0,0,true)
								outputChatBox("#e43a3a >> NextLevel:#ffffff " .. getElementData(player, "acc.adminNick") .. " kivett téged a vállalkozásodból!",targetPlayer,0,0,0,true)
							end
						else
							outputChatBox("#e43a3a >> NextLevel:#ffffff Hibás vállalkozás ID lett megadva!",player,0,0,0,true)
						end
					else
						outputChatBox("#e43a3a >> NextLevel:#ffffff A kiválasztott játékos nincs bejelentkezve!",player,0,0,0,true)
					end
				else
					outputChatBox("#e43a3a >> NextLevel:#ffffff Nem található játékos a megadott névvel/ID-vel!",player,0,0,0,true)
				end
			else
				outputChatBox("#e43a3a >> NextLevel:#ffffff /" .. cmd .. " [Játékos Név/ID] [Vállalkozás ID]",player,0,0,0,true)
			end
		end
 	end
)