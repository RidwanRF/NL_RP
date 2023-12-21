
local connection = exports.nlrp_database:getConnection()


tryToBuyVehicle = function(player,row,r,g,b,minLevel,rent)
	if row then
		if not minLevel then minLevel = 1 end
		local companyID = getElementData(player,"char.CompanyID")
		local query = dbPoll(dbQuery(connection, "SELECT * FROM companys WHERE id = ?", companyID), -1)
		if #query > 0 then
			local company = query[1]

			if rent > 0 then
				row.price = rent*(exports.nle_carshop:getModelRentPrice(row.id))
			end

			if company.balance >= row.price then
				if company.level >= minLevel then
					if #getCompanyVehicles(company.id) < company.vehicleSlot then
						dbExec(connection, "UPDATE companys SET balance = ? WHERE id = ?", company.balance - row.price, companyID)
						insertTransaction(companyID,getElementData(player,"char.Name"):gsub("_"," ") .. " vásárolt egy '" .. exports.nlrp_vehs:getVehicleNameFromModel(row.id) .. "' típúsú járművet! ( -" .. format(row.price) .. " Ft )")
					
						local insertQuery = dbQuery(connection, "INSERT INTO companyVehicles SET model=?,companyID=?,rent=?,color=?",
							row.id,companyID,rent,toJSON({r,g,b}) )
						local result, num, insertID = dbPoll(insertQuery, -1)
						if insertID then
							loadCompanyVehicle(insertID)
							exports.nlrp_hud:showInfobox(player,"info","Sikeresen megvásároltál egy " .. exports.nlrp_vehs:getVehicleNameFromModel(row.id) .. " típúsú járművet!")
							--triggerClientEvent(player,"successVehicleBought",player)
						end
					else
						exports.nlrp_hud:showInfobox(player,"error","Nincs több hely autót venni a vállalkozásnak!")
					end
				else
					exports.nlrp_hud:showInfobox(player,"error","Vállalkozásod szintje nem elég magas ehhez a járműhöz!")
				end
			else
				exports.nlrp_hud:showInfobox(player,"error","Nincs elegendő egyenlege a vállalkozásnak!")
			end
		end
	end
end
addEvent("tryToBuyVehicle",true)
addEventHandler("tryToBuyVehicle",resourceRoot,tryToBuyVehicle)

function loadCompanyVehicle(dbid)
	if dbid then
		local data = dbPoll(dbQuery(connection,"SELECT * FROM companyVehicles WHERE id = ?",dbid),-1)[1]
		if data then
			local x,y,z = math.random(-1000,1000),math.random(-1000,1000),math.random(-1000,1000)
			local vehicle = createVehicle(data.model,x,y,z)
			setElementFrozen(vehicle,true)
			setElementCollisionsEnabled(vehicle,false)
			setElementDimension(vehicle,30000+data.id)
			local r,g,b = unpack(fromJSON(data.color))
			setElementData(vehicle,"danihe->vehicles->bodyColor",{r,g,b})
			setVehicleColor(vehicle,r,g,b)

			local licensePlate = data.licensePlate
			if not licensePlate or licensePlate == "teszt" then
				licensePlate = createRandomPlateText()
			end

			setElementData(vehicle,"company.vehicleID",data.id)
			setElementData(vehicle,"company.companyID",data.companyID)
			setElementData(vehicle,"company.rent",data.rent)
			setElementData(vehicle,"company.driver",false)

			if data.headlight then
				setVehicleHeadLightColor(vehicle, unpack(fromJSON(data.headlight)))
			end

			--// Danihe tuningok
			exports.nle_handling:loadHandlingForVehicle(vehicle)

			setElementData(vehicle,"danihe->tuning->airride",tonumber(data["airride"]))
			setElementData(vehicle,"danihe->tuning->airride_level",3)

			--// Teljesítmény Tuningok
			local avaibleTunes = exports.nle_tuning:getPerformanceTuneDatas()
			for k,v in ipairs(fromJSON(data.tunings)) do
				setElementData(vehicle,avaibleTunes[k],v)
			end

			local nitro = fromJSON(data["nitro"])
			setElementData(vehicle,"danihe->tuning->nitro",nitro[1])
			setElementData(vehicle,"danihe->tuning->nitroprecent",nitro[2])


			setElementData(vehicle,"danihe->vehicles->neon",data.neon)

			setElementData(vehicle,"danihe->vehicles->drivetype",data["drivetype"])

			setElementData(vehicle,"danihe->tuning->tiresmokeLeft",fromJSON(data["tiresmokeLeft"]))
			setElementData(vehicle,"danihe->tuning->tiresmokeRight",fromJSON(data["tiresmokeRight"]))

			setVehicleHandling(vehicle,"steeringLock",data["steeringLock"])

			setElementData(vehicle,"danihe->vehicles->stickers",fromJSON(data["stickers"]))


			setElementData(vehicle,"danihe->vehicles->plate",licensePlate)
			setElementData(vehicle,"danihe->vehicles->plateStyle",data["plateStyle"])

			setElementData(vehicle,"danihe->vehicles->wheelsFront",fromJSON(data["wheelsFront"]))
			setElementData(vehicle,"danihe->vehicles->wheelsBack",fromJSON(data["wheelsBack"]))

			setElementData(vehicle,"danihe->vehicles->variant",data.variant)

			--// Rádió
			setElementData(vehicle,"danihe->radio->state",false)
			setElementData(vehicle,"danihe->radio->channel",1)
			setElementData(vehicle,"danihe->radio->volume",100)
		end
	end
end

addEventHandler("onResourceStart",resourceRoot,
	function()
		local Query = dbPoll(dbQuery(connection,"SELECT * FROM companyVehicles"),-1)
		if (Query) then
			for _,data in ipairs(Query) do
				loadCompanyVehicle(data.id)
			end
		end	
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function()
		for _,vehicle in ipairs(getElementsByType("vehicle")) do
			local dbid = getElementData(vehicle,"company.vehicleID")
			if dbid then
				local c = {getVehicleColor(vehicle,true)}

				local bc = getElementData(vehicle,"danihe->vehicles->bodyColor") or {255,255,255}

				local performanceTunes = {}
				local avaibleTunes = exports.nle_tuning:getPerformanceTuneDatas()
				for k,v in ipairs(avaibleTunes) do
					performanceTunes[k] = getElementData(vehicle,v) or 0
				end

				local datas = {
					tunings = toJSON(performanceTunes),
					stickers = toJSON(getElementData(vehicle,"danihe->vehicles->stickers") or {}),
					airride = getElementData(vehicle,"danihe->tuning->airride") or 0,
					neon = getElementData(vehicle,"danihe->vehicles->neon") or 0,
					steeringLock = getVehicleHandling(vehicle)["steeringLock"] or 30,
					driveType = getElementData(vehicle,"danihe->vehicles->drivetype") or "def",
					nitro = toJSON({getElementData(vehicle,"danihe->tuning->nitro") or 0,getElementData(vehicle,"danihe->tuning->nitroprecent") or 0}),
					wheelsFront = toJSON(getElementData(vehicle,"danihe->vehicles->wheelsFront")),
					wheelsBack = toJSON(getElementData(vehicle,"danihe->vehicles->wheelsBack")),
					licensePlate = getElementData(vehicle,"danihe->vehicles->plate") or "Danihe",
					plateStyle = getElementData(vehicle,"danihe->vehicles->plateStyle") or 1,
					color = toJSON({bc[1],bc[2],bc[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12]}),
					tiresmokeLeft = toJSON(getElementData(vehicle,"danihe->tuning->tiresmokeLeft") or {170,170,170}),
					tiresmokeRight = toJSON(getElementData(vehicle,"danihe->tuning->tiresmokeRight") or {170,170,170}),
					variant = getElementData(vehicle,"danihe->vehicles->variant") or 0,
				}

				local columns = {}
				local columnValues = {}

				for k,v in pairs(datas) do
					table.insert(columns, k .. " = ?")
					table.insert(columnValues, v)
				end
				table.insert(columnValues, dbid)

				dbExec(connection, "UPDATE companyVehicles SET " .. table.concat(columns, ", ") .. " WHERE id = ?", unpack(columnValues))
			end
		end
	end
)