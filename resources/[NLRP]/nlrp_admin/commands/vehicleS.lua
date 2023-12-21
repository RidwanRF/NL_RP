addAdminCommand("fix", 3, "Jármű megjavítása")
addCommandHandler("fix", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					local vehicleId = getElementData(theVehicle, "vehicle.dbID") or "Ideiglenes"

					fixVehicle(theVehicle)
					setVehicleDamageProof(theVehicle, false)

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegjavította a járműved.", targetPlayer)
					outputInfoText("Sikeresen megjavítottad a kiválasztott járművet.", sourcePlayer)
				   
					exports.nlrp_core:sendMessageToAdmins(adminNick .." megjavította a(z) " .. vehicleId .. " azonosítóval rendelkező járművet.")
					exports.nlrp_logs:toLog("adminaction", adminNick .." megjavította a(z) " .. vehicleId .. " azonosítóval rendelkező járművet.")
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)
addAdminCommand("sfix", 9, "Jármű megjavítása")
addCommandHandler("sfix", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					local vehicleId = getElementData(theVehicle, "vehicle.dbID") or "Ideiglenes"

					fixVehicle(theVehicle)
					setVehicleDamageProof(theVehicle, false)

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegjavította a járműved.", targetPlayer)
					outputInfoText("Sikeresen megjavítottad a kiválasztott járművet.", sourcePlayer)
				   
					--exports.nlrp_core:sendMessageToAdmins(adminNick .." megjavította a(z) " .. vehicleId .. " azonosítóval rendelkező járművet.")
					--exports.nlrp_logs:toLog("adminaction", adminNick .." megjavította a(z) " .. vehicleId .. " azonosítóval rendelkező járművet.")
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("blow", 9, "Jármű felrobbantása")
addCommandHandler("blow",
	function(sourcePlayer, commandName, targetPlayer)
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)

					blowVehicle(theVehicle)

					outputInfoText("#b7ff00" .. getPlayerAdminNick(sourcePlayer) .. " #fffffffelrobbantotta a járműved.", targetPlayer)
					outputInfoText("Sikeresen felrobbantottad a kiválasztott járművet.", sourcePlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end)

addAdminCommand("jarmuszine", 6, "Jármű átszínezése")
addCommandHandler("jarmuszine",
	function(sourcePlayer, commandName, targetPlayer, r, g, b)
		r = tonumber(r)
		g = tonumber(g)
		b = tonumber(b)

		if not (targetPlayer and r and g and b) then
			outputUsageText(commandName, "[Játékos név / ID] [R] [G] [B]", sourcePlayer)
		else
			if (r > 255 or r < 0) or (g > 255 or g < 0) or (b > 255 or b < 0) then
				outputErrorText("Az R, G, B színkód 0-nál nem lehet kisebb, 255-nél nem lehet nagyobb.", sourcePlayer)
				return
			end

			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)

					setVehicleColor(theVehicle, 255,255,255)
					setElementData(theVehicle,"danihe->vehicles->bodyColor",{r,g,b})

					outputInfoText("#b7ff00" .. getPlayerAdminNick(sourcePlayer) .. " #fffffffmegváltoztatta a járműved színeit.", targetPlayer)
					outputInfoText("Sikeresen átszínezted a kiválasztott járművet.", sourcePlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end)

addAdminCommand("setvehpaintjob", 6, "Jármű paintjob megváltoztatása")
addCommandHandler("setvehpaintjob",
	function(sourcePlayer, commandName, targetPlayer, pjId)
		pjId = tonumber(pjId)

		if not (targetPlayer and pjId) then
			outputUsageText(commandName, "[Játékos név / ID] [Paintjob ID | 0 = eltávolítás]", sourcePlayer)
		else
			if pjId < 0 then
				outputErrorText("A paintjob ID nem lehet kisebb mint nulla.", sourcePlayer)
				return
			end

			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)

					setElementData(theVehicle, "vehicle.paintjob", pjId)

					outputInfoText("#b7ff00" .. getPlayerAdminNick(sourcePlayer) .. " #fffffffmegváltoztatta a járműved paintjobját.", targetPlayer)
					outputInfoText("Sikeresen megváltoztattad a kiválasztott jármű paintjobját.", sourcePlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end)

addAdminCommand("getcar", 1, "Jármű magadhoz teleportálása")
addCommandHandler("getcar", function(sourcePlayer, commandName, vehicleId)
	if havePermission(sourcePlayer, commandName, true) then
		if not tonumber(vehicleId) then
			outputUsageText(commandName, "[Jármű ID]", sourcePlayer)
		else
			vehicleId = tonumber(vehicleId)

			local targetVehicle = exports.nlrp_core:findVehicleByID(vehicleId)

			if targetVehicle then
				local x, y, z = getElementPosition(sourcePlayer)
				local rotation = getPedRotation(sourcePlayer)

				x = x + math.cos(math.rad(rotation)) * 2
				y = y + math.sin(math.rad(rotation)) * 2

				if getElementHealth(targetVehicle) == 0 then
					spawnVehicle(targetVehicle, x, y, z, 0, 0, rotation)
				else
					setElementPosition(targetVehicle, x, y, z)
					setVehicleRotation(targetVehicle, 0, 0, rotation)
				end
				
				setElementInterior(targetVehicle, getElementInterior(sourcePlayer))
				setElementDimension(targetVehicle, getElementDimension(sourcePlayer))

				local customInterior = tonumber(getElementData(sourcePlayer, "currentCustomInterior") or 0)

				if not customInterior or customInterior <= 0 then
					setElementData(targetVehicle, "currentCustomInterior", false)
				else
					setElementData(targetVehicle, "currentCustomInterior", customInterior)
				end

				local adminNick = getPlayerAdminNick(sourcePlayer)

				outputInfoText("Sikeresen magadhoz teleportáltad a kiválasztott járművet.", sourcePlayer)
			else
				outputErrorText("A kiválasztott jármű nem található.", sourcePlayer)
			end
		end
	end
end)

addAdminCommand("gotocar", 1, "Járműhöz teleportálás")
addCommandHandler("gotocar", function(sourcePlayer, commandName, vehicleId)
	if havePermission(sourcePlayer, commandName, true) then
		if not tonumber(vehicleId) then
			outputUsageText(commandName, "[Jármű ID]", sourcePlayer)
		else
			vehicleId = tonumber(vehicleId)

			local targetVehicle = exports.nlrp_core:findVehicleByID(vehicleId)

			if targetVehicle then
				local x, y, z = getElementPosition(targetVehicle)
				local rx, ry, rz = getVehicleRotation(targetVehicle)

				x = x + math.cos(math.rad(rz)) * 2
				y = y + math.sin(math.rad(rz)) * 2

				setElementPosition(sourcePlayer, x, y, z)
				setPedRotation(sourcePlayer, rz)
				setElementInterior(sourcePlayer, getElementInterior(targetVehicle))
				setElementDimension(sourcePlayer, getElementDimension(targetVehicle))

				local customInterior = tonumber(getElementData(targetVehicle, "currentCustomInterior") or 0)

				if customInterior and customInterior > 0 then
					triggerClientEvent(sourcePlayer, "loadCustomInterior", sourcePlayer, customInterior)
				end

				local adminNick = getPlayerAdminNick(sourcePlayer)

				outputInfoText("Sikeresen elteleportáltál a kiválasztott járműhöz.", sourcePlayer)
			else
				outputErrorText("A kiválasztott jármű nem található.", sourcePlayer)
			end
		end
	end
end)

addAdminCommand("respawnveh", 3, "Jármű helyére rakása")
addCommandHandler("respawnveh", function(sourcePlayer, commandName, vehicleId)
	if havePermission(sourcePlayer, commandName, true) then
		vehicleId = tonumber(vehicleId)

		if not vehicleId then
			outputUsageText(commandName, "[Jármű ID]", sourcePlayer)
		else
			local targetVehicle = exports.nlrp_core:findVehicleByID(vehicleId)

			if targetVehicle then
				local vehicleID = getElementData(targetVehicle, "vehicle.dbID") or 0

				respawnVehicle(targetVehicle)

				local adminNick = getPlayerAdminNick(sourcePlayer)
			   
				outputInfoText("Sikeresen a helyére teleportáltad a kiválasztott járművet.", sourcePlayer)

				exports.nlrp_core:sendMessageToAdmins(adminNick .." helyére rakta a(z) " .. vehicleID .. " azonosítóval rendelkező járművet.")
				exports.nlrp_logs:toLog("adminaction", adminNick .." helyére rakta a(z) " .. vehicleID .. " azonosítóval rendelkező járművet.")
			else
				outputErrorText("A kiválasztott jármű nem található.", sourcePlayer)
			end
		end
	end
end)

function reMap(x, in_min, in_max, out_min, out_max)
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

addAdminCommand("setvehoil", 2, "Jármű olajszintjének megváltoztatása")
addCommandHandler("setvehoil", function(sourcePlayer, commandName, targetPlayer, oilLevel)
	if havePermission(sourcePlayer, commandName, true) then
		oilLevel = tonumber(oilLevel)

		if not (targetPlayer and oilLevel and oilLevel >= 0 and oilLevel <= 100) then
			outputUsageText(commandName, "[Játékos név / ID] [Olajszint < 0 - 100 > ]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					local vehicleID = getElementData(theVehicle, "vehicle.dbID")

					local percent = oilLevel

					oilLevel = reMap(oilLevel, 0, 100, 515000, 0)

					setElementData(theVehicle, "lastOilChange", oilLevel)

					if percent == 0 then
						setElementHealth(theVehicle, 320)
					end

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("Sikeresen átállítottad a kiválasztott jármű olajszintjét. #b7ff00(" .. percent .. ")", sourcePlayer)
					outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a járműved olajszintjét. #b7ff00(" .. percent .. ")", targetPlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("fixvehbody", 3, "Jármű karosszériájának megjavítása")
addCommandHandler("fixvehbody", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					local currhealth = getElementHealth(theVehicle)
					
					fixVehicle(theVehicle)
					setElementHealth(theVehicle, currhealth)

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("Sikeresen megjavítottad a kiválasztott jármű karosszériáját.", sourcePlayer)
					outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegjavította a járműved karosszériáját.", targetPlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("setvehhp", 2, "Jármű életerejének megváltoztatása")
addCommandHandler("setvehhp", function(sourcePlayer, commandName, targetPlayer, health)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer or not tonumber(health) then
			outputUsageText(commandName, "[Játékos név / ID] [Százalék 0-100]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)

					health = tonumber(health)

					if health > 100 then
						health = 100
					elseif health < 32 then
						health = 32
					end

					setElementHealth(theVehicle, health * 10)

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("Sikeresen átállítottad a kiválasztott jármű életerejét. #b7ff00(" .. health .. "%)", sourcePlayer)
					outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a járműved életerejét. #b7ff00(" .. health .. "%)", targetPlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("setvehfuel", 2, "Jármű üzemanyag szintjének megváltoztatása")
addCommandHandler("setvehfuel", function(sourcePlayer, commandName, targetPlayer, fuelLevel)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer or not tonumber(fuelLevel) then
			outputUsageText(commandName, "[Játékos név / ID] [Üzemanyag]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)

					fuelLevel = tonumber(fuelLevel)

					local fuelTankSize = exports.nlrp_hud:getTheFuelTankSizeOfVehicle(getElementModel(theVehicle))

					if fuelLevel > fuelTankSize then
						fuelLevel = fuelTankSize
					end

					setElementData(theVehicle, "vehicle.fuel", tonumber(fuelLevel))

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("Sikeresen átállítottad a kiválasztott jármű üzemanyag szintjét. #b7ff00(" .. fuelLevel .. ")", sourcePlayer)
					outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a járműved üzemanyag szintjét. #b7ff00(" .. fuelLevel .. ")", targetPlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("unflipveh", 1, "Jármű visszafordítása")
addCommandHandler("unflipveh", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if isPedInVehicle(targetPlayer) then
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					local rx, ry, rz = getElementRotation(theVehicle)

					setElementRotation(theVehicle, 0, ry, rz)

					local adminNick = getPlayerAdminNick(sourcePlayer)

					outputInfoText("Sikeresen visszaforgattad a kiválasztott járművet.", sourcePlayer)
					outputInfoText("#b7ff00" .. adminNick .. " #ffffffvisszaforgatta a járműved.", targetPlayer)
				else
					outputErrorText("A kiválasztott játékos nem ül járműben.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("delveh", 6, "Jármű törlése")
addCommandHandler("delveh", function(sourcePlayer, commandName, vehicleId)
	if havePermission(sourcePlayer, commandName, true) then
		vehicleId = tonumber(vehicleId)

		if not vehicleId then
			outputUsageText(commandName, "[Jármű ID]", sourcePlayer)
		else
			local targetVehicle = exports.nlrp_core:findVehicleByID(vehicleId)

			if targetVehicle then
				local adminNick = getPlayerAdminNick(sourcePlayer)

				exports.nlrp_vehicles:deleteVehicle(vehicleId)

				outputInfoText("Sikeresen kitörölted a kiválasztott járművet.", sourcePlayer)

				exports.nlrp_logs:toLog("adminaction", getPlayerAdminNick(sourcePlayer) .." kitörölte a(z) " .. vehicleId .. " azonosítóval rendelkező járművet.")
			end
		end
	end
end)

addAdminCommand("makeveh", 6, "Jármű törlése")
addCommandHandler("makeveh", function(sourcePlayer, commandName, model, ownerId, groupId, r, g, b)
	if havePermission(sourcePlayer, commandName, true) then
		ownerId = tonumber(ownerId) or getElementData(sourcePlayer, "playerID")
		groupId = tonumber(groupId) or 0
		r = tonumber(r) or 0
		g = tonumber(g) or 0
		b = tonumber(b) or 0

		if not (model and ownerId and groupId and r and g and b) then
			outputUsageText(commandName, "[Model ID] [Tulajdonos] [Frakció ID] [R] [G] [B]", sourcePlayer)
			outputInfoText("Frakció ID: 0 esetén nem frakció jármű", sourcePlayer)
		else
			ownerId = math.floor(ownerId)
			groupId = math.floor(groupId)
			r = math.floor(r)
			g = math.floor(g)
			b = math.floor(b)

			if tonumber(model) then
				model = tonumber(model)

				if model < 400 or model > 611 then
					outputErrorText("A Model ID nem lehet kisebb mint 400 és nem lehet nagyobb mint 611!", sourcePlayer)
					return
				end
			else
				model = getVehicleModelFromName(string.lower(model))

				if not model then
					outputErrorText("Érvénytelen model név!", sourcePlayer)
					return
				end
			end

			local groups = false

			if groupId > 0 then
				groups = exports.nlrp_groups:getGroups()

				if not groups[groupId] then
					outputErrorText("A kiválasztott frakció nem létezik!", sourcePlayer)
					return
				end
			end

			local theOwner = exports.nlrp_core:findPlayer(sourcePlayer, ownerId)
			if theOwner then
				local x, y, z = getElementPosition(sourcePlayer)
				local rotation = getPedRotation(sourcePlayer)
				local interior = getElementInterior(sourcePlayer)
				local dimension = getElementDimension(sourcePlayer)

				x = x + math.cos(math.rad(rotation)) * 2
				y = y + math.sin(math.rad(rotation)) * 2

				exports.nlrp_vehicles:makeVehicle(model, theOwner, groupId, {x, y, z, 0, 0, rotation, interior, dimension}, r, g, b)

				if groupId > 0 and groups then
					outputInfoText("Sikeresen létrehoztál egy járművet! (Tulajdonos: " .. getPlayerCharacterName(theOwner) .. " | Frakció: " .. groups[groupId].name .. ")", sourcePlayer)
				else
					outputInfoText("Sikeresen létrehoztál egy járművet! (Tulajdonos: " .. getPlayerCharacterName(theOwner) .. " | Frakció: Nincs)", sourcePlayer)
				end
			end
		end
	end
end)