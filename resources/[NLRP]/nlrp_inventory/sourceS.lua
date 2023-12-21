--[[


CREATE TABLE `items` (
	`dbID` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`itemId` INT(3) NOT NULL,
	`slot` INT(11) NOT NULL DEFAULT '0',
	`amount` INT(10) NOT NULL DEFAULT '1',
	`data1` TEXT NULL,
	`data2` TEXT NULL,
	`data3` TEXT NULL
	`ownerType` VARCHAR(8) NOT NULL,
	`ownerId` INT(11) NOT NULL,
) ENGINE=MyISAM;

CREATE TABLE `trashes` (
	`trashID` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`x` FLOAT NOT NULL,
	`y` FLOAT NOT NULL,
	`z` FLOAT NOT NULL,
	`rotation` FLOAT NOT NULL,
	`interior` INT(3) NOT NULL,
	`dimension` INT(5) NOT NULL
) ENGINE=InnoDB;

]]

local connection = exports.nlrp_database:getConnection()

local itemsTable = {}
local inventoryInUse = {}
local perishableTimer = false

local playerAttachments = {}
local storedTrashes = {}

addEvent("removeItemByDBID",true)
addEventHandler("removeItemByDBID",resourceRoot,
	function(player,dbid,slot)
		dbExec(connection, "DELETE FROM items WHERE dbID = ?", dbid)
		itemsTable[player][slot] = nil
	end
)

-- bírság
addEvent("ticketPerishableEvent2", true)
addEventHandler("ticketPerishableEvent2", getRootElement(),
	function(itemId)
		if isElement(source) and itemsTable[source] then
			local theItem = false

			for k, v in pairs(itemsTable[source]) do
				if v.dbID == itemId then
					theItem = v
					break
				end
			end

			if theItem then
				dbQuery(
					function(qh, sourcePlayer)
						dbFree(qh)

						if isElement(sourcePlayer) then
							local json_data = fromJSON(theItem.data1)

							if json_data then
								local fineAmount = tonumber(json_data.fine)

								exports.nlrp_core:takeMoneyEx(sourcePlayer, fineAmount * 10, "autoticket")

								exports.nlrp_hud:showInfobox(sourcePlayer, "error", "Nem fizetted be a bírságot ezért a tízszeresét azaz " .. fineAmount * 10 .. " Ft-t vontunk le.")
							end

							itemsTable[sourcePlayer][theItem.slot] = nil

							triggerItemEvent(sourcePlayer, "deleteItem", "player", {theItem.dbID})
						end
					end, {source}, connection, "DELETE FROM items WHERE dbID = ?", theItem.dbID
				)
			end
		end
	end)

-- parkolási bírság
addEvent("ticketPerishableEvent", true)
addEventHandler("ticketPerishableEvent", getRootElement(),
	function(itemId)
		if isElement(source) and itemsTable[source] then
			local theItem = false

			for k, v in pairs(itemsTable[source]) do
				if v.dbID == itemId then
					theItem = v
					break
				end
			end

			if theItem then
				dbQuery(
					function(qh, sourcePlayer)
						dbFree(qh)

						if isElement(sourcePlayer) then
							local json_data = fromJSON(theItem.data1)

							if json_data then
								local fineAmount = tonumber(json_data.fine)

								exports.nlrp_core:takeMoneyEx(sourcePlayer, fineAmount * 10, "autoticket")

								exports.nlrp_hud:showInfobox(sourcePlayer, "error", "Nem fizetted be a parkolási bírságot ezért a tízszeresét azaz " .. fineAmount * 10 .. " Ft-t vontunk le.")
							end

							itemsTable[sourcePlayer][theItem.slot] = nil

							triggerItemEvent(sourcePlayer, "deleteItem", "player", {theItem.dbID})
						end
					end, {source}, connection, "DELETE FROM items WHERE dbID = ?", theItem.dbID
				)
			end
		end
	end)

addEvent("requestVehicleTicket", true)
addEventHandler("requestVehicleTicket", getRootElement(),
	function(theVehicle, data)
		if isElement(source) then
			if data then
				local vehicleId = getElementData(theVehicle, "vehicle.dbID") or 0

				if vehicleId > 0 then
					dbQuery(
						function(qh, sourcePlayer)
							dbFree(qh)

							setElementData(theVehicle, "vehicleTicket", false)

							if isElement(sourcePlayer) then
								local currentTime = getRealTime().timestamp
								local elapsedMinute = (data.autoPayOut - currentTime) / 60

								addItem(sourcePlayer, 118, 1, false, toJSON(data), false, math.floor(perishableItems[118] - elapsedMinute))
							end
						end, {source}, connection, "UPDATE vehicles SET theTicket = '' WHERE vehicleID = ?", vehicleId
					)
				end
			end
		end
	end)

function processVehicleTickets()
	local currentTime = getRealTime().timestamp
	local vehicles = getElementsByType("vehicle")
	local notify = {}

	for k = 1, #vehicles do
		local v = vehicles[k]

		if v then
			local theTicket = getElementData(v, "vehicleTicket")

			if theTicket then
				local json_data = fromJSON(theTicket)
				local vehicleOwnerId = getElementData(v, "vehicle.owner") or 0

				if json_data and type(json_data) == "table" and vehicleOwnerId > 0 then
					local vehicleOwnerSource = exports.nlrp_accounts:getPlayerFromCharacterID(vehicleOwnerId)

					if isElement(vehicleOwnerSource) then
						if currentTime >= (json_data.autoPayOut or 0) then
							local fineAmount = tonumber(json_data.fine)

							exports.nlrp_core:takeMoneyEx(vehicleOwnerSource, fineAmount * 10, "autoticket")

							exports.nlrp_hud:showInfobox(vehicleOwnerSource, "error", "Nem fizetted be a parkolási bírságot ezért a tízszeresét azaz " .. fineAmount * 10 .. " Ft-t vontunk le.")

							setElementData(v, "vehicleTicket", false)

							local vehicleId = getElementData(v, "vehicle.dbID") or 0

							if vehicleId > 0 then
								dbExec(connection, "UPDATE vehicles SET theTicket = '' WHERE vehicleID = ?", vehicleId)
							end
						else
							if not notify[vehicleOwnerSource] then
								notify[vehicleOwnerSource] = {}
							end

							table.insert(notify[vehicleOwnerSource], json_data)
						end
					end
				end
			end
		end
	end

	local players = getElementsByType("player")

	for k = 1, #players do
		local v = players[k]

		if v and notify[v] then
			outputChatBox("#d75959<< FIGYELMEZTETÉS >> #ffffffTájékoztatjuk, hogy önnek #d75959" .. #notify[v] .. " db #ffffffintézetlen csekkje van az alábbi járművein:", v, 0, 0, 0, true)

			for k2, v2 in ipairs(notify[v]) do
				local remaining = math.floor((v2.autoPayOut - currentTime) % 172800 / 3600) + 1

				outputChatBox(" - Rendszám: #d75959" .. v2.numberplate .. " #ffffff| Lejáratig hátralévő idő: #d75959kb. " .. remaining .. " #ffffffóra.", v, 255, 255, 255, true)
			end
		end
	end
end

addEvent("ticketTheVehicle", true)
addEventHandler("ticketTheVehicle", getRootElement(),
	function(theVehicle, data)
		if isElement(source) then
			if isElement(theVehicle) and data then
				local vehicleId = getElementData(theVehicle, "vehicle.dbID") or 0

				if vehicleId > 0 then
					local vehicleOwnerId = getElementData(theVehicle, "vehicle.owner") or 0

					if vehicleOwnerId > 0 then
						data.autoPayOut = getRealTime().timestamp + 172800 -- (60 * 60 * 48) = 48 óra
						data = toJSON(data)

						dbQuery(
							function(qh, sourcePlayer)
								dbFree(qh)

								setElementData(theVehicle, "vehicleTicket", data)

								if isElement(sourcePlayer) then

								end
							end, {source}, connection, "UPDATE vehicles SET theTicket = ? WHERE vehicleID = ?", data, vehicleId
						)
					else
						exports.nlrp_hud:showInfobox(source, "e", "Erre a járműre nem állíthatsz ki csekket!")
					end
				else
					exports.nlrp_hud:showInfobox(source, "e", "Erre a járműre nem állíthatsz ki csekket!")
				end
			end
		end
	end)

addEventHandler("onResourceStart", getRootElement(),
	function(startedResource)
		if getResourceName(startedResource) == "nlrp_database" then
			connection = exports.nlrp_database:getConnection()
		elseif source == getResourceRootElement() then
			local nlrp_database = getResourceFromName("nlrp_database")

			if nlrp_database and getResourceState(nlrp_database) == "running" then
				connection = exports.nlrp_database:getConnection()
			end

			for k, v in ipairs(getElementsByType("player")) do
				takeAllWeapons(v)
			end

			dbQuery(loadTrashes, connection, "SELECT * FROM trashes")

			if isTimer(perishableTimer) then
				killTimer(perishableTimer)
			end

			perishableTimer = setTimer(processPerishableItems, 60000, 0)

			setTimer(processVehicleTickets, 1800000, 0)
		end
	end)

function processPerishableItems()
	for k, v in pairs(itemsTable) do
		if isElement(k) then
			if getElementType(k) == "vehicle" or getElementType(k) == "object" then
				for k2, v2 in pairs(itemsTable[k]) do
					if perishableItems[v2.itemId] then
						local perishableAmount = (tonumber(v2.data3) or 0) + 1

						if perishableAmount - 1 > perishableItems[v2.itemId] then
							triggerEvent("updateItemData3", k, k, v2.dbID, perishableItems[v2.itemId], true)
						end

						if perishableAmount <= perishableItems[v2.itemId] then
							triggerEvent("updateItemData3", k, k, v2.dbID, perishableAmount, true)
						elseif perishableEvent[v2.itemId] then
							triggerEvent(perishableEvent[v2.itemId], k, v2.dbID)
						end
					end
				end
			end
		else
			itemsTable[k] = nil
		end
	end
end

addCommandHandler("reloadmyweapon",
	function(sourcePlayer, commandName)
		reloadPedWeapon(sourcePlayer)
	end)

addEvent("requestTrashes", true)
addEventHandler("requestTrashes", getRootElement(),
	function()
		if isElement(source) then
			triggerClientEvent(source, "receiveTrashes", source, storedTrashes)
		end
	end)

function loadTrashes(qh)
	local result = dbPoll(qh, 0)

	if result then
		for k, v in pairs(result) do
			loadTrash(v)
		end
	end
end

function loadTrash(data)
	local objectElement = createObject(1359, data.x, data.y, data.z - 0.3, 0, 0, data.rotation)

	if isElement(objectElement) then
		local trashId = data.trashID

		setElementInterior(objectElement, data.interior)
		setElementDimension(objectElement, data.dimension)

		storedTrashes[trashId] = {}
		storedTrashes[trashId].trashId = trashId
		storedTrashes[trashId].objectElement = objectElement
		storedTrashes[trashId].interior = data.interior
		storedTrashes[trashId].dimension = data.dimension

		return true
	end

	return false
end

exports.nlrp_admin:addAdminCommand("createtrash", 6, "Szemetes létrehozása")
addCommandHandler("createtrash",
	function(localPlayer)
		if getElementData(localPlayer, "acc.adminLevel") >= 6 then
			local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
			local playerRotX, playerRotY, playerRotZ = getElementRotation(localPlayer)
			local playerInterior = getElementInterior(localPlayer)
			local playerDimension = getElementDimension(localPlayer)

			dbQuery(
				function (qh, sourcePlayer)
					local result = dbPoll(qh, 0, true)[2][1][1]

					if result then
						if loadTrash(result) then
							triggerClientEvent("createTrash", resourceRoot, result.trashID, result)

							if isElement(sourcePlayer) then
								outputChatBox(exports.nlrp_core:getServerTag("info") .. "Szemetes sikeresen létrehozva. ID: #acd373" .. result.trashID, sourcePlayer, 255, 255, 255, true)
							end
						end
					end
				end, {localPlayer}, connection, "INSERT INTO trashes (x, y, z, rotation, interior, dimension) VALUES (?,?,?,?,?,?); SELECT * FROM trashes ORDER BY trashID DESC LIMIT 1", playerPosX, playerPosY, playerPosZ, playerRotZ, playerInterior, playerDimension
			)
		end
	end)

exports.nlrp_admin:addAdminCommand("deletetrash", 6, "Szemetes törlése")
addCommandHandler("deletetrash",
	function(localPlayer, cmd, trashId)
		if getElementData(localPlayer, "acc.adminLevel") >= 6 then
			if not trashId then
				outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [Szemetes Azonosító]", localPlayer, 255, 255, 255, true)
			else
				trashId = tonumber(trashId)

				if trashId and storedTrashes[trashId] then
					triggerClientEvent("destroyTrash", localPlayer, trashId)

					destroyElement(storedTrashes[trashId].objectElement)

					storedTrashes[trashId] = nil

					dbExec(connection, "DELETE FROM trashes WHERE trashID = ?", trashId)

					outputChatBox(exports.nlrp_core:getServerTag("admin") .. "A kiválasztott szemetes sikeresen törölve.", localPlayer, 255, 255, 255, true)
				else
					outputChatBox(exports.nlrp_core:getServerTag("admin") .. "A kiválasztott szemetes nem létezik.", localPlayer, 255, 255, 255, true)
				end
			end
		end
	end)

addEvent("showTheItem", true)
addEventHandler("showTheItem", getRootElement(),
	function(item, players)
		if isElement(source) and item then
			triggerClientEvent(players, "showTheItem", source, item)
		end
	end)

function friskCommand(localPlayer, command, target)
	if getElementData(localPlayer, "loggedIn") then
		if not target then
			outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. command .. " [Játékos név / ID]", localPlayer, 255, 255, 255, true)
		else
			local targetPlayer = exports.nlrp_core:findPlayer(localPlayer, target)

			if targetPlayer and getElementData(targetPlayer, "loggedIn") then
				local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
				local playerInterior = getElementInterior(localPlayer)
				local playerDimension = getElementDimension(localPlayer)

				local targetPosX, targetPosY, targetPosZ = getElementPosition(targetPlayer)
				local targetInterior = getElementInterior(targetPlayer)
				local targetDimension = getElementDimension(targetPlayer)

				if getDistanceBetweenPoints3D(playerPosX, playerPosY, playerPosZ, targetPosX, targetPosY, targetPosZ) <= 3 and playerInterior == targetInterior and playerDimension == targetDimension then
					local playerName = getElementData(targetPlayer, "visibleName"):gsub("_", " ")
					local charMoney = getElementData(targetPlayer, "char.Money") or 0

					triggerClientEvent(localPlayer, "bodySearchGetDatas", localPlayer, itemsTable[targetPlayer] or {}, playerName, charMoney)

					exports.nlrp_chat:sendLocalMeAction(localPlayer, "megmotozott valakit. ((" .. playerName .. "))")
				end
			end
		end
	end
end
addCommandHandler("motozas", friskCommand)
addCommandHandler("motozás", friskCommand)
addCommandHandler("motoz", friskCommand)
addCommandHandler("frisk", friskCommand)

addEvent("friskPlayer", true)
addEventHandler("friskPlayer", getRootElement(),
	function(targetPlayer)
		if isElement(source) and isElement(targetPlayer) then
			local playerPosX, playerPosY, playerPosZ = getElementPosition(source)
			local playerInterior = getElementInterior(source)
			local playerDimension = getElementDimension(source)

			local targetPosX, targetPosY, targetPosZ = getElementPosition(targetPlayer)
			local targetInterior = getElementInterior(targetPlayer)
			local targetDimension = getElementDimension(targetPlayer)

			if getDistanceBetweenPoints3D(playerPosX, playerPosY, playerPosZ, targetPosX, targetPosY, targetPosZ) <= 3 and playerInterior == targetInterior and playerDimension == targetDimension then
				local playerName = getElementData(targetPlayer, "visibleName"):gsub("_", " ")
				local charMoney = getElementData(targetPlayer, "char.Money") or 0

				triggerClientEvent(source, "bodySearchGetDatas", source, itemsTable[targetPlayer] or {}, playerName, charMoney)

				exports.nlrp_chat:sendLocalMeAction(source, "megmotozott valakit. ((" .. playerName .. "))")
			end
		end
	end)

addEventHandler("onPlayerQuit", getRootElement(),
	function()
		if itemsTable[source] then
			itemsTable[source] = nil
		end

		if isElement(playerAttachments[source]) then
			destroyElement(playerAttachments[source])
			playerAttachments[source] = nil
		end
	end)

addEventHandler("onElementDestroy", getRootElement(),
	function()
		if itemsTable[source] then
			itemsTable[source] = nil
		end

		if isElement(playerAttachments[source]) then
			destroyElement(playerAttachments[source])
			playerAttachments[source] = nil
		end
	end)

addEvent("takeWeapon", true)
addEventHandler("takeWeapon", getRootElement(),
	function()
		if isElement(source) then
			setPlayerHudComponentVisible(source,"crosshair",false)
			removeWeaponSkinPlayerS(source)
			takeAllWeapons(source)
		end
	end)

addEvent("giveWeapon", true)
addEventHandler("giveWeapon", getRootElement(),
	function(itemId, weaponId, ammo,data1)
		if isElement(source) then
			takeAllWeapons(source)

			giveWeapon(source, weaponId, ammo, true)
			setPlayerHudComponentVisible(source,"crosshair",false)
			if weaponId == 34 then
				setPlayerHudComponentVisible(source,"crosshair",true)
			end

			--reloadPedWeapon(source)

			if availableItems[itemId].skin then
				addWeaponSkinToPlayer(source,availableItems[itemId].skin["texture"],availableItems[itemId].skin["skinImage"])
			end
		end
	end)

addEventHandler("onElementDataChange", getRootElement(),
	function(dataName, oldValue)
		if dataName == "canUseMegaphone" then
			if getElementData(source, dataName) then
				local playerInterior = getElementInterior(source)
				local playerDimension = getElementDimension(source)

				if isElement(playerAttachments[source]) then
					destroyElement(playerAttachments[source])
				end

				local obj = createObject(3090, 0, 0, 0)

				if isElement(obj) then
					setElementInterior(obj, playerInterior)
					setElementDimension(obj, playerDimension)
					setElementCollisionsEnabled(obj, false)
					setElementDoubleSided(obj, true)

					exports.nlrp_boneattach:attachElementToBone(obj, source, 12, 0.05, 0, 0.05, 0, 0, 0)

					playerAttachments[source] = obj
				end
			elseif oldValue then
				if isElement(playerAttachments[source]) then
					destroyElement(playerAttachments[source])
				end

				playerAttachments[source] = nil
			end
		end
	end)

local availableObjectAttachments = {
	[1] = {
		model = 2703,
		pos = {12, 0, 0.0375, 0, 0, -90, 0}
	},
	[2] = {
		model = 2769,
		pos = {12, 0, 0.0375, 0.0375, 0, -180, 0}
	},
	[3] = {
		model = 1546,
		pos = {11, 0, 0.0375, 0.0375, -90, 0, -90}
	},
	[4] = {
		model = 1544,
		pos = {11, 0, 0.0375, 0.0375, -90, 0, -90},
		scale = 0.5
	},
	[5] = {
		model = 1509,
		pos = {11, 0, 0.0375, 0.0375, -90, 0, -90}
	},
	[6] = {
		model = 1485,
		pos = {11, -0.075, 0, 0.05, 0, 0, 0}
	}
}

addEvent("useItem", true)
addEventHandler("useItem", getRootElement(),
function(dbID, use)
		if isElement(source) and dbID then
			local item = false

			for k, v in pairs(itemsTable[source]) do
				if v.dbID == dbID then
					item = v
					break
				end
			end

			if item then
				local playerInterior = getElementInterior(source)
				local playerDimension = getElementDimension(source)
				local itemId = item.itemId

				if itemId == 71 then -- telefon
					if use then
						if not item.data1 or not tonumber(item.data1) then
							local x, y, z = getElementPosition(source)
							local city = getZoneName(x, y, z, true)
							local prenum = "202"

							if city == "San Fierro" then
								city = "203"
							else
								city = "20" .. math.random(4, 9)
							end

							itemsTable[source][item.slot].data1 = tonumber(prenum .. math.random(1000000, 9999999)) -- telefonszám
							itemsTable[source][item.slot].data2 = "-" -- adatok / üzenetek / hívásnapló stb
							itemsTable[source][item.slot].data3 = 0	-- egyenleg

							dbExec(connection, "UPDATE items SET data1 = ?, data2 = '-', data3 = '0' WHERE dbID = ?", itemsTable[source][item.slot].data1, item.dbID)
                            dbQuery(connection, "INSERT INTO phones SET number = ?, owner = ?", itemsTable[source][item.slot].data1, getElementData(source, "acc.dbID"))

							triggerClientEvent(source, "updateItemData1", source, "player", item.dbID, itemsTable[source][item.slot].data1)
						end

						triggerClientEvent(source, "openPhone", source, item.dbID, tonumber(item.data1), item.data2, item.data3)
					else
						triggerClientEvent(source, "openPhone", source, false)
					end
				elseif itemId == 122 then -- kötszer
					if (getElementData(source, "bloodLevel") or 100) < 100 then
						if not getElementData(source, "usingBandage") then
							setElementData(source, "usingBandage", true)
							setElementData(source, "bloodLevel", 100)
							setElementData(source, "isPlayerDeath", false)
							setElementData(source, "bulletDamages", false)
							--setElementData(source, "boneDamages", false)
							setElementData(source, "deathReason", false)
							setElementData(source, "customDeath", false)

							triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)

							exports.nlrp_hud:showAlert(source, "info", "Sikeresen felraktál egy kötést, ezzel ellátva a vérzést.")
						else
							exports.nlrp_hud:showAlert(source, "error", "Már van fent egy kötés!")
						end
					else
						exports.nlrp_hud:showAlert(source, "error", "Nem vérzel!")
					end
				elseif itemId == 85 then -- SZÉF
					local PosX, PosY, PosZ = getElementPosition(source)
					local Inter, Dim = getElementInterior(source), getElementDimension(source)
					if Dim > 0 then
					--	dbExec(connection, "INSERT INTO safes (Owner, PosX, PosY, PosZ, Int, Dim) VALUES (?,?,?,?,?,?)", tonumber(getElementData(source, "acc.dbID")),tostring(PosX), tostring(PosY), tostring(PosZ),Int,Dim)
						dbExec(connection, "INSERT INTO safes (Owner, PosX, PosY, PosZ, Interior, Dim) VALUES (?,?,?,?,?,?)", tonumber(getElementData(source, "acc.dbID")),PosX, PosY, PosZ, Inter,Dim)
						dbQuery(
							function (qh, targetPlayer)
								local result, rows = dbPoll(qh, 0)[1]
								if result then
									triggerEvent("takeItem", targetPlayer, targetPlayer, "dbID", item.dbID, 1)
									safe = createObject ( 2332, tonumber(result.PosX), tonumber(result.PosY), tonumber(result.PosZ)-0.5, 0, 0, 0 )
									setElementDimension ( safe, tonumber(result.Dim) )
									setElementInterior ( safe, tonumber(result.Interior), tonumber(result.PosX), tonumber(result.PosY), tonumber(result.PosZ)-0.5 )
									setElementData(safe, "isSafe", true)
									setElementData(safe, "isInteractable", true)
									setElementData(safe, "object.name", "Széf")
									setElementData(safe, "safe.dbID", result.ID)
									setElementData(safe, "safe.Owner", getElementData(targetPlayer, "acc.dbID"))
								end
							end, {source}, connection, "SELECT * FROM safes WHERE ID = LAST_INSERT_ID()"
						)
					else
						outputChatBox("[SZÉF] Csak Interiorban helyezheted le.",source)
					end
				elseif itemId == 310 then -- CRAFT
					thePlayer = source
					if hasItem(thePlayer, 312) then
						items = crafts[tonumber(item.data1)][2]
						yesItems = 0
						for i = 1,crafts[tonumber(item.data1)][2] do
							currentI = 3+i
							getTedItem = hasItemWithData(source, crafts[tonumber(item.data1)][currentI][1], "amount", crafts[tonumber(item.data1)][currentI][2])
							if getTedItem then
								yesItems = yesItems + 1
							end
						end
						if yesItems == items then
							for i = 1,crafts[tonumber(item.data1)][2] do
								currentI = 3+i
								getTedItem = hasItemWithData(source, crafts[tonumber(item.data1)][currentI][1], "amount", crafts[tonumber(item.data1)][currentI][2])
								if getTedItem then
									triggerEvent("takeItem", source, source, "dbID", getTedItem.dbID, crafts[tonumber(item.data1)][currentI][2])
								end
							end
							setPedAnimation(source, "COP_AMBIENT", "Copbrowse_loop", -1, true, false, false, false)
							setTimer(function()
								setPedAnimation(thePlayer)
								giveItem(thePlayer, crafts[tonumber(item.data1)][3], 1)
								outputChatBox("#3057E1[CRAFT] #FFFFFFSikeresen craftolál egy tárgyat: #12db81"..getItemName(crafts[tonumber(item.data1)][3]), thePlayer,255,255,255,true)
							end,5000,1)
						else
							outputChatBox("#3057E1[CRAFT] #FFFFFFSajnos nincsen meg minden kelléked a craftoláshoz.", source,255,255,255,true)
						end
					else
						outputChatBox("#3057E1[CRAFT] #FFFFFFSajnos nincsen meg minden kelléked a craftoláshoz.", source,255,255,255,true)
					end
				elseif itemId == 131 then -- NL FASZ 1
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 1)
				elseif itemId == 132 then -- NL FASZ 2
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 2)
				elseif itemId == 133 then -- NL FASZ 3
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 3)
				elseif itemId == 134 then -- NL FASZ 4
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 4)
				elseif itemId == 94 then -- ajándék
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 5)
				elseif itemId == 95 then -- Pénzes zsák
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 6)
				elseif itemId == 157 then -- Kincses
					triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
					giftNLPACK (source, 7)
				elseif itemId == 137 then
					if (getPedOccupiedVehicle(source)) then
						if hasItemWithData(source, 2, "data1", getElementData(getPedOccupiedVehicle(source), "vehicle.dbID")) then
							giveItem(source, 2, 1, getElementData(getPedOccupiedVehicle(source), "vehicle.dbID"))
							outputChatBox("[NLRP] #ffffff Sikeres kulcsmásolás", source, 183,255,0, true)
							triggerEvent("takeItem", source, source, "dbID", item.dbID, 1)
						else
							outputChatBox("[NLRP] #ffffffNincsen nálad az autóhoz való kulcs.", source, 183,255,0, true)
						end
					else
						outputChatBox("[NLRP] #ffffffNem ülsz az autóban.", source, 183,255,0, true)
					end

				elseif itemId == 86 then -- jelvény
					if use then
						setElementData(source, "badgeData", tostring(item.data1) .. " - " .. tostring(item.data2))

						exports.nlrp_chat:sendLocalMeAction(source, "felrakja a jelvényét.")
					else
						setElementData(source, "badgeData", false)

						exports.nlrp_chat:sendLocalMeAction(source, "leveszi a jelvényét.")
					end

				elseif itemId == 140 then -- jegy
					if use then
						setElementData(source, "badgeData", tostring(item.data1) .. " || " .. tostring(item.data2) .. " || " .. tostring(item.data3))
					else
						setElementData(source, "badgeData", false)
					end

				elseif itemId == 179 then -- jegy
					if use then
						setElementData(source, "badgeData", tostring(item.data1) .. " || " .. tostring(item.data2) .. " || " .. tostring(item.data3))
					else
						setElementData(source, "badgeData", false)
					end

				elseif itemId == 106 then -- Vitamin
					local health = getElementHealth(source)

					if health + 25 >= 100 then
						health = 100
					end

					setElementHealth(source, health)
				elseif itemId > 130 and itemId < 214 then -- FEGYVER
                    local weapnum = itemId - 130
                    if getElementData(source, "player.weapon") == weapnum then
                        setElementData(source, "player.weapon", 0)
exports.nlrp_chat:sendLocalMeAction(source,"elrak egy fegyvert: "..getItemName(itemId))
                    else
                        setElementData(source, "player.weapon", weapnum)
exports.nlrp_chat:sendLocalMeAction(source,"elovesz egy fegyvert: "..getItemName(itemId))
                    end
                elseif itemId == 105 then -- Gyógyszer
					local health = getElementHealth(source)

					if health + 45 >= 100 then
						health = 100
					end

					setElementHealth(source, health)
				elseif isSpecialItem(itemId) then
					if isElement(playerAttachments[source]) then
						destroyElement(playerAttachments[source])
					end

					local animationTime = 0

					if isFoodItem(itemId) then
						animationTime = 3000
						setPedAnimation(source, "food", "eat_burger", animationTime, false, false, false, false)
					elseif isDrinkItem(itemId) then
						animationTime = 1375
						setPedAnimation(source, "VENDING", "VEND_Drink2_P", animationTime, false, false, false, false)
					elseif itemId == 97 or itemId == 98 or itemId == 125 then
						animationTime = 5000
						setPedAnimation(source, "smoking", "m_smkstnd_loop", animationTime, false, false, false, false)
					end

					setTimer(
						function (player)
							if isElement(player) then
								setPedAnimation(player, false)

								if isElement(playerAttachments[player]) then
									destroyElement(playerAttachments[player])
								end
							end
						end,
					animationTime + 200, 1, source)

					if itemId == 97 or itemId == 98 or itemId == 125 then
						exports.nlrp_chat:sendLocalMeAction(source, "szívott egy slukkot.")
					elseif availableItems[itemId] then
						if isFoodItem(itemId) then
							exports.nlrp_chat:sendLocalMeAction(source, "evett valamiből. ((" .. getItemName(itemId) .. "))")
							if getElementData(source, "char.Hunger")+25 < 100 then
								setElementData(source, "char.Hunger", getElementData(source, "char.Hunger") + 25)
							else
								setElementData(source, "char.Hunger", 100)
							end
						elseif isDrinkItem(itemId) then
							exports.nlrp_chat:sendLocalMeAction(source, "ivott valamiből. ((" .. getItemName(itemId) .. "))")
							if getElementData(source, "char.Thirst")+25 < 100 then
								setElementData(source, "char.Thirst", getElementData(source, "char.Thirst") + 25)
							else
								setElementData(source, "char.Thirst", 100)
							end
						end
					elseif isFoodItem(itemId) then
						exports.nlrp_chat:sendLocalMeAction(source, "evett valamiből.")
						if getElementData(source, "char.Hunger")+25 < 100 then
							setElementData(source, "char.Hunger", getElementData(source, "char.Hunger") + 25)
						else
							setElementData(source, "char.Hunger", 100)
						end
					elseif isDrinkItem(itemId) then
						exports.nlrp_chat:sendLocalMeAction(source, "ivott valamit.")
						if getElementData(source, "char.Thirst")+25 < 100 then
							setElementData(source, "char.Thirst", getElementData(source, "char.Thirst") + 25)
						else
							setElementData(source, "char.Thirst", 100)
						end
					end

					local attachment = false

					if itemId == 45 or itemId == 47 then -- Hamburger/Szendvics
						attachment = availableObjectAttachments[1]
					elseif itemId == 46 or itemId == 48 then -- Hot-Dog/Taco
						attachment = availableObjectAttachments[2]
					elseif (itemId >= 52 and itemId <= 59) or itemId == 70 then -- Dobozos üdítők/Kávé
						attachment = availableObjectAttachments[3]
					elseif itemId >= 60 and itemId <= 63 then -- Ásványvíz/Sörök
						attachment = availableObjectAttachments[4]
					elseif itemId >= 64 and itemId <= 69 then -- Vodka/Whiskey
						attachment = availableObjectAttachments[5]
					elseif itemId == 97 or itemId == 98 or itemId == 125 then -- Cigaretta
						attachment = availableObjectAttachments[6]
					end

					if itemId == 125 then
						setPedArmor ( source, getPedArmor(source) + 10 )
					end

					if itemId == 126 then
						setPedArmor ( source, getPedArmor(source) + 25 )
					end

					if attachment then
						local obj = createObject(attachment.model, 0, 0, 0)

						if isElement(obj) then
							setElementInterior(obj, playerInterior)
							setElementDimension(obj, playerDimension)
							setElementCollisionsEnabled(obj, false)
							setElementDoubleSided(obj, true)
							setObjectScale(obj, attachment.scale or 0.75)

							exports.nlrp_boneattach:attachElementToBone(obj, source, unpack(attachment.pos))

							playerAttachments[source] = obj
						end
					end

					if tonumber(item.data3) and isFoodItem(itemId) then
						if math.floor(100 - item.data3 / perishableItems[itemId] * 100) <= 65 then
							triggerClientEvent(source, "rottenEffect", source, item.data3 / (perishableItems[itemId] * 0.75))

							local health = getElementHealth(source) - math.random(3500, 7500) / item.data3

							if health <= 0 then
								health = 0
								setElementData(source, "customDeath", "ételmérgezés")
							end

							setElementHealth(source, health)
						end
					end
				end
			end
		end
	end)

function removePlayerDutyItems(playerElement)
	if isElement(playerElement) then
		local deletedItems = {}

		if not itemsTable[playerElement] then
			return
		end

		for k, v in pairs(itemsTable[playerElement]) do
			if v.data2 == "duty" and v.itemId ~= 86 then -- ha duty item, de nem jelvény (jelvényt off-dutyban is lehessen használni)
				table.insert(deletedItems, v.dbID)
				itemsTable[playerElement][v.slot] = nil
			end
		end

		if #deletedItems > 0 then
			dbExec(connection, "DELETE FROM items WHERE dbID IN (" .. table.concat(deletedItems, ",") .. ")")

			triggerItemEvent(playerElement, "deleteItem", "player", deletedItems)
		end
	end
end

function removeAllItem(sourceElement, dataType, data)
	if sourceElement then
		local elementType = getElementType(sourceElement)
		local dbID = getElementDatabaseId(sourceElement)

		if dbID and itemsTable[sourceElement] then
			local deletedItems = {}

			for k, v in pairs(itemsTable[sourceElement]) do
				if (tonumber(v[dataType]) or v[dataType]) == data then
					table.insert(deletedItems, v.dbID)
					itemsTable[sourceElement][v.slot] = nil
				end
			end

			if #deletedItems > 0 then
				triggerItemEvent(sourceElement, "deleteItem", elementType, deletedItems)
			end
		end
	end

	return false
end

function removeItemByData(sourceElement, itemId, dataType, data)
	if sourceElement then
		local elementType = getElementType(sourceElement)
		local dbID = getElementDatabaseId(sourceElement)

		if dbID and itemsTable[sourceElement] then
			local deletedItems = {}

			for k, v in pairs(itemsTable[sourceElement]) do
				if v.itemId == itemId and (tonumber(v[dataType]) or v[dataType]) == data then
					table.insert(deletedItems, v.dbID)
					itemsTable[sourceElement][v.slot] = nil
				end
			end

			if #deletedItems > 0 then
				dbExec(connection, "DELETE FROM items WHERE dbID IN (" .. table.concat(deletedItems, ",") .. ")")

				triggerItemEvent(sourceElement, "deleteItem", elementType, deletedItems)

				exports.nlrp_logs:logItemAction(sourceElement, itemId, false, "removeItemByData")
			end

			return true
		end
	end

	return false
end

function removeItemFromCharacter(characterId, itemId, dataType, data)
	if characterId and itemId and dataType and data then
		dbExec(connection, "DELETE FROM items WHERE itemId = ? AND ?? = ? AND ownerId = ? AND ownerType = 'player'", tonumber(itemId), dataType, data, characterId)

		local playerElement = exports.nlrp_accounts:getPlayerFromCharacterID(characterId)
		local deletedItems = {}

		if itemsTable[playerElement] then
			for k, v in pairs(itemsTable[playerElement]) do
				if v.itemId == itemId and (tonumber(v[dataType]) or v[dataType]) == data then
					table.insert(deletedItems, v.dbID)
					itemsTable[playerElement][v.slot] = nil
				end
			end
		else
			print("playerSource with characterId [" .. characterId .. "] not assigned.", playerElement)
		end

		if #deletedItems > 0 then
			if isElement(playerElement) then
				triggerItemEvent(playerElement, "deleteItem", "player", deletedItems)

				exports.nlrp_logs:logItemAction(playerElement, itemId, false, "removeItemFromCharacter")
			end
		end

		return true
	end

	return false
end

addEvent("takeItem", true)
addEventHandler("takeItem", getRootElement(),
	function(sourceElement, itemKey, itemValue, amount)
		if isElement(source) then
			if isElement(sourceElement) then
				if itemKey and itemValue then
					amount = tonumber(amount)

					local deletedItems = {}

					for k, v in pairs(itemsTable[sourceElement]) do
						if v[itemKey] and v[itemKey] == itemValue then
							if amount and itemsTable[sourceElement][v.slot].amount - amount > 0 then
								itemsTable[sourceElement][v.slot].amount = itemsTable[sourceElement][v.slot].amount - amount

								dbExec(connection, "UPDATE items SET amount = ? WHERE ?? = ?", itemsTable[sourceElement][v.slot].amount, itemKey, itemValue)

								triggerItemEvent(sourceElement, "updateItemAmount", getElementType(sourceElement), v.dbID, itemsTable[sourceElement][v.slot].amount)

								exports.nlrp_logs:logItemAction(sourceElement, itemsTable[sourceElement][v.slot].itemId, itemsTable[sourceElement][v.slot].amount, "updateAmount")
							else
								exports.nlrp_logs:logItemAction(sourceElement, itemsTable[sourceElement][v.slot].itemId, amount, "takeItem")

								table.insert(deletedItems, itemsTable[sourceElement][v.slot].dbID)

								itemsTable[sourceElement][v.slot] = nil
							end
						end
					end

					if #deletedItems > 0 then
						dbExec(connection, "DELETE FROM items WHERE dbID IN (" .. table.concat(deletedItems, ",") .. ")")

						triggerItemEvent(sourceElement, "deleteItem", getElementType(sourceElement), deletedItems)
					end
				end
			end
		end
	end)

addEvent("updateItemData3", true)
addEventHandler("updateItemData3", getRootElement(),
	function(sourceElement, dbID, newData, sync)
		if isElement(sourceElement) then
			dbID = tonumber(dbID)
			
			if dbID and newData then
				for k, v in pairs(itemsTable[sourceElement]) do
					if v.dbID == dbID then
						itemsTable[sourceElement][v.slot].data3 = newData
						dbExec(connection, "UPDATE items SET data3 = ? WHERE dbID = ?", newData, dbID)

						if sync then
							--if getElementType(sourceElement) ~= "player" then
								triggerItemEvent(sourceElement, "loadItems", itemsTable[sourceElement], getElementType(sourceElement))
							--end
						end

						break
					end
				end
			end
		end
	end)

addEvent("updateItemData2", true)
addEventHandler("updateItemData2", getRootElement(),
	function(sourceElement, dbID, newData, sync)
		if isElement(sourceElement) then
			dbID = tonumber(dbID)

			if dbID and newData then
				for k, v in pairs(itemsTable[sourceElement]) do
					if v.dbID == dbID then
						itemsTable[sourceElement][v.slot].data2 = newData
						dbExec(connection, "UPDATE items SET data2 = ? WHERE dbID = ?", newData, dbID)

						if sync then
							if getElementType(source) ~= "player" then
								triggerItemEvent(sourceElement, "loadItems", itemsTable[sourceElement], getElementType(source))
							end
						end

						break
					end
				end
			end
		end
	end)

addEvent("updateItemData1", true)
addEventHandler("updateItemData1", getRootElement(),
	function(sourceElement, dbID, newData, sync)
		if isElement(sourceElement) then
			dbID = tonumber(dbID)

			if dbID and newData then
				for k, v in pairs(itemsTable[sourceElement]) do
					if v.dbID == dbID then
						itemsTable[sourceElement][v.slot].data1 = newData
						dbExec(connection, "UPDATE items SET data1 = ? WHERE dbID = ?", newData, dbID)

						if sync then
							if getElementType(source) ~= "player" then
								triggerItemEvent(sourceElement, "loadItems", itemsTable[sourceElement], getElementType(source))
							end
						end

						break
					end
				end
			end
		end
	end)


addEvent("updateItemAmount", true)
addEventHandler("updateItemAmount", getRootElement(),
	function(sourceElement, dbID, newAmount)
		if isElement(source) then
			if isElement(sourceElement) then
				dbID = tonumber(dbID)
				newAmount = tonumber(newAmount)

				if dbID and newAmount then
					for k, v in pairs(itemsTable[sourceElement]) do
						if v.dbID == dbID then
							itemsTable[sourceElement][v.slot].amount = newAmount
							dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", newAmount, dbID)
							break
						end
					end
				end
			end
		end
	end)

addEvent("moveItem", true)
addEventHandler("moveItem", getRootElement(),
	function(dbID, itemId, sourceSlot, targetSlot, stackAmount, sourceElement, targetElement)
		if isElement(source) then
			dbID = tonumber(dbID)

			if dbID then
				local sourceType = getElementType(sourceElement)
				local sourceDbId = getElementDatabaseId(sourceElement)

				-- mozgatás/stackelés a megnyitott inventoryban
				if sourceElement == targetElement then
					if itemsTable[sourceElement][sourceSlot] and dbID == itemsTable[sourceElement][sourceSlot].dbID then
						if not itemsTable[sourceElement][targetSlot] then
							-- mozgatás
							if stackAmount >= itemsTable[sourceElement][sourceSlot].amount or stackAmount <= 0 then
								dbExec(connection, "UPDATE items SET ownerType = ?, ownerId = ?, slot = ? WHERE dbID = ?", sourceType, sourceDbId, targetSlot, dbID)

								itemsTable[sourceElement][targetSlot] = itemsTable[sourceElement][sourceSlot]
								itemsTable[sourceElement][targetSlot].slot = targetSlot
								itemsTable[sourceElement][sourceSlot] = nil

								if sourceType == "player" and getElementType(targetElement) == "player" then
									triggerClientEvent(source, "movedItemInInventory", source, true)
								end
							-- stackelés
							elseif stackAmount > 0 then
								itemsTable[sourceElement][sourceSlot].amount = itemsTable[sourceElement][sourceSlot].amount - stackAmount

								dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", itemsTable[sourceElement][sourceSlot].amount, dbID)

								addItem(sourceElement, itemId, stackAmount, targetSlot, itemsTable[sourceElement][sourceSlot].data1, itemsTable[sourceElement][sourceSlot].data2, itemsTable[sourceElement][sourceSlot].data3)
							end
						else
							outputChatBox(exports.nlrp_core:getServerTag("info") .. "A kiválasztott slot foglalt.", source, 255, 255, 255, true)

							triggerClientEvent(source, "failedToMoveItem", source, targetSlot, sourceSlot, stackAmount)
						end
					end
				-- átmozgatás egy másik inventoryba
				else
					local targetType = getElementType(targetElement)
					local targetDbId = getElementDatabaseId(targetElement)
					local canTransfer = true

					if targetType == "vehicle" and isVehicleLocked(targetElement) then
						canTransfer = false
						exports.nlrp_hud:showInfobox(source, "error", "A kiválasztott jármű csomagtartója zárva van.")
					end

					if canTransfer then
						if itemsTable[sourceElement][sourceSlot] and dbID == itemsTable[sourceElement][sourceSlot].dbID then
							if not itemsTable[targetElement] then
								itemsTable[targetElement] = {}
							end

							targetSlot = findEmptySlot(targetElement, itemId)

							if targetSlot then
								local statement = false

								if stackAmount >= itemsTable[sourceElement][sourceSlot].amount or stackAmount <= 0 then
									statement = "move"
									stackAmount = itemsTable[sourceElement][sourceSlot].amount
								elseif stackAmount > 0 then
									statement = "split"
								end

								if getInventoryWeight(targetElement) + (getItemWeight(itemId) * stackAmount) < getWeightLimit(targetType, targetElement) then
									if statement == "move" then
										dbExec(connection, "UPDATE items SET ownerType = ?, ownerId = ?, slot = ? WHERE dbID = ?", targetType, targetDbId, targetSlot, dbID)

										itemsTable[targetElement][targetSlot] = itemsTable[sourceElement][sourceSlot]
										itemsTable[targetElement][targetSlot].slot = targetSlot
										itemsTable[sourceElement][sourceSlot] = nil

										triggerItemEvent(targetElement, "addItem", targetType, itemsTable[targetElement][targetSlot])
										triggerItemEvent(sourceElement, "deleteItem", sourceType, {dbID})

										exports.nlrp_logs:logItemAction(source, itemId, stackAmount, "moveItem:move")
									elseif statement == "split" then
										dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", itemsTable[sourceElement][sourceSlot].amount - stackAmount, dbID)

										itemsTable[sourceElement][sourceSlot].amount = itemsTable[sourceElement][sourceSlot].amount - stackAmount

										addItem(targetElement, itemId, stackAmount, targetSlot, itemsTable[sourceElement][sourceSlot].data1, itemsTable[sourceElement][sourceSlot].data2, itemsTable[sourceElement][sourceSlot].data3)

										triggerItemEvent(sourceElement, "updateItemAmount", sourceType, dbID, itemsTable[sourceElement][sourceSlot].amount)

										exports.nlrp_logs:logItemAction(source, itemId, stackAmount, "moveItem:split")
									end

									transferItemMessage(itemsTable[targetElement][targetSlot], sourceElement, targetElement, sourceType, targetType)
								else
									exports.nlrp_hud:showInfobox(source, "error", "A kiválasztott inventory nem bír el több tárgyat!")
								end
							else
								exports.nlrp_hud:showInfobox(source, "error", "Nincs szabad slot a kiválasztott inventoryban!")
							end
						end
					end

					triggerClientEvent(source, "unLockItem", source, sourceType, sourceSlot)
				end
			end
		end
	end)

function transferItemMessage(item, fromElement, toElement, fromElementType, toElementType)
	local itemName = ""

	if availableItems[item.itemId] then
		itemName = " (" .. getItemName(item.itemId) .. ")"
	end

	if fromElementType == "player" and toElementType == "player" then
		exports.nlrp_chat:sendLocalMeAction(fromElement, "átadott egy tárgyat " .. getElementData(toElement, "visibleName"):gsub("_", " ") .. "-nak/nek." .. itemName)

		setPedAnimation(fromElement, "DEALER", "DEALER_DEAL", 3000, false, false, false, false)
		setPedAnimation(toElement, "DEALER", "DEALER_DEAL", 3000, false, false, false, false)
	elseif fromElementType == "player" and toElementType == "vehicle" then
		exports.nlrp_chat:sendLocalMeAction(fromElement, "berakott egy tárgyat a jármű csomagtartójába." .. itemName)
	elseif fromElementType == "player" and toElementType == "object" then
		exports.nlrp_chat:sendLocalMeAction(fromElement, "berakott egy tárgyat a széfbe." .. itemName)
	elseif fromElementType == "vehicle" then
		exports.nlrp_chat:sendLocalMeAction(toElement, "kivett egy tárgyat a jármű csomagtartójából." .. itemName)
	elseif fromElementType == "object" then
		exports.nlrp_chat:sendLocalMeAction(toElement, "kivett egy tárgyat a széfből." .. itemName)
	end
end

function countItemsByItemID(sourceElement, itemId, countAmount)
	local x = 0

	if itemsTable[sourceElement] then
		for k, v in pairs(itemsTable[sourceElement]) do
			if v.itemId == itemId then
				if countAmount then
					x = x + v.amount
				else
					x = x + 1
				end
			end
		end
	end

	return x
end

function hasItemWithData(sourceElement, itemId, dataType, data)
	if itemsTable[sourceElement] then
		data = tonumber(data) or data
		if dataType == "amount" then
			for k, v in pairs(itemsTable[sourceElement]) do
				if v.itemId == itemId and (tonumber(v[dataType]) or v[dataType]) >= data then
					return v
				end
			end
		else
			for k, v in pairs(itemsTable[sourceElement]) do
				if v.itemId == itemId and  (tonumber(v[dataType]) or v[dataType]) == data then
					return v
				end
			end
		end
	end

	return false
end

function hasItem(sourceElement, itemId)
	if itemsTable[sourceElement] then
		for k, v in pairs(itemsTable[sourceElement]) do
			if v.itemId == itemId then
				return v
			end
		end
	end

	return false
end

addEvent("closeInventory", true)
addEventHandler("closeInventory", getRootElement(),
	function(sourceElement, streamedPlayers)
		if isElement(sourceElement) then
			inventoryInUse[sourceElement] = nil

			if getElementType(sourceElement) == "vehicle" then
				setVehicleDoorOpenRatio(sourceElement, 1, 0, 350)
			end
		end
	end)

addEvent("requestItems", true)
addEventHandler("requestItems", getRootElement(),
	function(sourceElement, ownerId, ownerType, streamedPlayers)
		if isElement(source) then
			local gotRequest = true

			if ownerType == "vehicle" and isVehicleLocked(sourceElement) then
				gotRequest = false
			end

			if not gotRequest then
				exports.nlrp_hud:showInfobox(source, "error", "A kiválasztott inventory zárva van, esetleg nincs kulcsod hozzá.")
				return
			end

			if isElement(inventoryInUse[sourceElement]) then
				exports.nlrp_hud:showInfobox(source, "error", "A kiválasztott inventory már használatban van!")
				return
			end

			inventoryInUse[sourceElement] = source

			if itemsTable[sourceElement] then
				triggerClientEvent(source, "loadItems", source, itemsTable[sourceElement], ownerType, sourceElement, true)
			else
				loadItems(sourceElement, ownerId)
			end

			if ownerType == "vehicle" then
				setVehicleDoorOpenRatio(sourceElement, 1, 1, 500)

				exports.nlrp_chat:sendLocalMeAction(source, "belenézett egy jármű csomagtartójába.")
			end
		end
	end)

function triggerItemEvent(sourceElement, eventName, ...)
	local sourcePlayer = sourceElement

	if getElementType(sourceElement) == "player" then
		triggerClientEvent(sourceElement, eventName, sourceElement, ...)
	elseif isElement(inventoryInUse[sourceElement]) then
		sourcePlayer = inventoryInUse[sourceElement]

		triggerClientEvent(inventoryInUse[sourceElement], eventName, inventoryInUse[sourceElement], ...)
	end

	if eventName == "addItem" or eventName == "deleteItem" or eventName == "updateItemAmount" then
		if isElement(sourcePlayer) and getElementType(sourceElement) == "player" then
			triggerClientEvent(sourcePlayer, "movedItemInInventory", sourcePlayer, eventName ~= "updateItemAmount")
		end
	end
end

function loadItems(sourceElement, ownerId)
	if isElement(sourceElement) then
		local ownerType = getElementType(sourceElement)

		if itemsTable[sourceElement] then
			if ownerType == "player" then
				triggerClientEvent(sourceElement, "loadItems", sourceElement, itemsTable[sourceElement], ownerType)
			elseif isElement(inventoryInUse[sourceElement]) then
				triggerClientEvent(inventoryInUse[sourceElement], "loadItems", inventoryInUse[sourceElement], itemsTable[sourceElement], ownerType, sourceElement, true)
			end

			--outputDebugString("Request items cache from - " .. tostring(sourceElement))
		else
			itemsTable[sourceElement] = {}

			--outputDebugString("Request items from - " .. tostring(sourceElement))

			dbQuery(
				function (query, sourceElement)
					local result = dbPoll(query, 0)

					if isElement(sourceElement) then
						local lost, restored = 0, 0

						for k, v in pairs(result) do
							if availableItems[v.itemId][5] then
								if not v.data3 then
									v.data3 = toJSON({
										serial = generateWeaponSerial(),
										warns = 0,
										health = 100,
									})
									dbExec(connection, "UPDATE items SET data3 = ? WHERE dbID = ?", v.data3, v.dbID)
								end
							end

							if not itemsTable[sourceElement][v.slot] then
								addItemEx(sourceElement, v.dbID, v.slot, v.itemId, v.amount, v.data1, v.data2, v.data3)
							else
								local emptySlot = findEmptySlot(sourceElement, v.itemId)

								if emptySlot then
									addItemEx(sourceElement, v.dbID, emptySlot, v.itemId, v.amount, v.data1, v.data2, v.data3)

									dbExec(connection, "UPDATE items SET slot = ? WHERE dbID = ?", emptySlot, v.dbID)

									restored = restored + 1
								end

								lost = lost + 1
							end
						end

						if ownerType == "player" then
							triggerClientEvent(sourceElement, "loadItems", sourceElement, itemsTable[sourceElement], ownerType)

							if lost > 0 then
								outputChatBox(exports.nlrp_core:getServerTag("info") .. "#32b3ef" .. lost .. " #ffffffdarab elveszett tárggyal rendelkezel.", sourceElement, 255, 255, 255, true)

								if restored > 0 then
									outputChatBox(exports.nlrp_core:getServerTag("info") .. "Ebből #32b3ef" .. restored .. " #ffffffdarab lett visszaállítva.", sourceElement, 255, 255, 255, true)
								end

								if lost - restored > 0 then
									outputChatBox(exports.nlrp_core:getServerTag("info") .. "Nem sikerült visszaállítani #32b3ef" .. lost - restored .. " #ffffffdarab tárgyad, mert nincs szabad slot az inventorydban.", sourceElement, 255, 255, 255, true)
									outputChatBox(exports.nlrp_core:getServerTag("info") .. "A következő bejelentkezésedkor ismét megpróbáljuk.", sourceElement, 255, 255, 255, true)
								end

								if lost == restored then
									outputChatBox(exports.nlrp_core:getServerTag("info") .. "Az összes hibás tárgyadat sikeresen visszaállítottuk. Kellemes játékot kívánunk! :).", sourceElement, 255, 255, 255, true)
								end
							end
						elseif isElement(inventoryInUse[sourceElement]) then
							triggerClientEvent(inventoryInUse[sourceElement], "loadItems", inventoryInUse[sourceElement], itemsTable[sourceElement], ownerType, sourceElement, true)
						end
					end
				end, {sourceElement}, connection, "SELECT * FROM items WHERE ownerId = ? AND ownerType = ? ORDER BY slot", ownerId, ownerType
			)
		end
	end
end

addEvent("requestCache", true)
addEventHandler("requestCache", getRootElement(),
	function()
		if isElement(source) then
			local ownerId = getElementDatabaseId(source)

			if tonumber(ownerId) then
				loadItems(source, ownerId)
			end
		end
	end)

function getInventoryItemsCount(sourceElement)
	local items = 0

	if itemsTable[sourceElement] then
		for k, v in pairs(itemsTable[sourceElement]) do
			items = items + 1
		end
	end

	return items
end

function getInventoryWeight(sourceElement)
	local weight = 0

	if itemsTable[sourceElement] then
		for k, v in pairs(itemsTable[sourceElement]) do
			weight = weight + getItemWeight(v.itemId) * v.amount
		end
	end

	return weight
end

function findEmptySlot(sourceElement, itemId)
	if getElementType(sourceElement) == "player" and isKeyItem(itemId) then
		return findEmptySlotOfKeys(sourceElement)
	elseif getElementType(sourceElement) == "player" and isPaperItem(itemId) then
		return findEmptySlotOfPapers(sourceElement)
	else
		local emptySlot = false

		for i = 0, defaultSettings.slotLimit - 1 do
			if not itemsTable[sourceElement][i] then
				emptySlot = tonumber(i)
				break
			end
		end

		if emptySlot then
			if emptySlot <= defaultSettings.slotLimit then
				return emptySlot
			else
				return false
			end
		else
			return false
		end
	end
end

function findEmptySlotOfKeys(sourceElement)
	local emptySlot = false

	for i = defaultSettings.slotLimit, defaultSettings.slotLimit * 2 - 1 do
		if not itemsTable[sourceElement][i] then
			emptySlot = tonumber(i)
			break
		end
	end

	if emptySlot then
		if emptySlot <= defaultSettings.slotLimit * 2 then
			return emptySlot
		else
			return false
		end
	else
		return false
	end
end

function findEmptySlotOfPapers(sourceElement)
	local emptySlot = false

	for i = defaultSettings.slotLimit * 2, defaultSettings.slotLimit * 3 - 1 do
		if not itemsTable[sourceElement][i] then
			emptySlot = tonumber(i)
			break
		end
	end

	if emptySlot then
		if emptySlot <= defaultSettings.slotLimit * 3 then
			return emptySlot
		else
			return false
		end
	else
		return false
	end
end

function addItemEx(sourceElement, dbID, slot, itemId, amount, data1, data2, data3)
	itemsTable[sourceElement][slot] = {}
	itemsTable[sourceElement][slot].dbID = dbID
	itemsTable[sourceElement][slot].slot = slot
	itemsTable[sourceElement][slot].itemId = itemId
	itemsTable[sourceElement][slot].amount = amount
	itemsTable[sourceElement][slot].data1 = data1
	itemsTable[sourceElement][slot].data2 = data2
	itemsTable[sourceElement][slot].data3 = data3
	itemsTable[sourceElement][slot].inUse = false
	itemsTable[sourceElement][slot].locked = false
end

function giveItem(sourceElement, itemId, amount, data1, data2, data3)
	addItem(sourceElement, itemId, amount, false, data1, data2, data3)
end


local weapon_serials = {}
generateWeaponSerial = function()
	local _serial = string.upper(generateString(13))
	if weapon_serials[_serial] then
		return generateWeaponSerial()
	else
		weapon_serials[_serial] = true
 		return _serial
	end
end

function addItem(sourceElement, itemId, amount, slotId, data1, data2, data3)
	if isElement(sourceElement) and itemId and amount then
		itemId = tonumber(itemId)
		amount = tonumber(amount)

		if not itemsTable[sourceElement] then
			itemsTable[sourceElement] = {}
		end

		if not slotId then
			slotId = findEmptySlot(sourceElement, itemId)
		elseif tonumber(slotId) then
			if itemsTable[sourceElement][slotId] then
				slotId = findEmptySlot(sourceElement, itemId)
			end
		end

		if slotId then
			local ownerType = getElementType(sourceElement)
			local ownerId = getElementDatabaseId(sourceElement)

			if tonumber(ownerId) then
				itemsTable[sourceElement][slotId] = {}
				itemsTable[sourceElement][slotId].locked = true

				if availableItems[itemId][5] then
					data3 = toJSON{serial=generateWeaponSerial(),health=100,warns=0}
				end

				dbQuery(
					function (qh, sourceElement)
						if isElement(sourceElement) then
							local result = dbPoll(qh, 0, true)[2][1][1]

							if result then
								addItemEx(sourceElement, result.dbID, result.slot, result.itemId, result.amount, result.data1, result.data2, result.data3)

								triggerItemEvent(sourceElement, "addItem", getElementType(sourceElement), result)
							end
						end
					end, {sourceElement}, connection, "INSERT INTO items (itemId, slot, amount, data1, data2, data3, ownerType, ownerId) VALUES (?,?,?,?,?,?,?,?); SELECT * FROM items ORDER BY dbID DESC LIMIT 1", itemId, slotId, amount, data1, data2, data3, ownerType, ownerId
				)

				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end
addEvent("addItem", true)
addEventHandler("addItem", getRootElement(), addItem)

addCommandHandler("additem",
	function(sourcePlayer, commandName, targetPlayer, itemId, amount, data1, data2, data3)
		if getElementData(sourcePlayer, "acc.adminLevel") >= 10 then
			if not (targetPlayer and itemId) then
				outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. commandName .. " [Játékos név / ID] [Item ID] [Mennyiség] [ < Data 1 | Data 2 | Data 3 > ]", sourcePlayer, 255, 255, 255, true)
			else
				itemId = tonumber(itemId)
				amount = tonumber(amount)

				if itemId and amount then
					targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

					if targetPlayer then
						local state = addItem(targetPlayer, itemId, amount, false, data1, data2, data3)

						if state then
							outputChatBox(exports.nlrp_core:getServerTag("admin") .. "Az item sikeresen odaadva.", sourcePlayer, 255, 255, 255, true)
						else
							outputChatBox(exports.nlrp_core:getServerTag("admin") .. "Az item odaadás meghiúsult.", sourcePlayer, 255, 255, 255, true)
						end
					end
				end
			end
		end
	end)

local vehicles = {
--	{ID, xPos, yPos, zPos, sirenLeftX, sirenLeftY, sirenLeftZ, sirenLeftColorR, sirenLeftColorG, sirenLeftColorB, sirenRightX, sirenRightY, sirenRightZ, sirenRightColorR, sirenRightColorG, sirenRightColorB},

         {445, -0.3, -0.12, 0.73, -0.3, -0.12, 0.73, 0, 0, 255, -0.3, -0.12, 0.73, 0, 0, 255},		--BMW M5	          
         {529, -0.4, -0.12, 0.88, -0.4, -0.12, 0.88, 0, 0, 255, -0.4, -0.12, 0.88, 0, 0, 255},		--S63 AMG	          
		 {554, -0.63, 0.38, 1.115, -0.63, 0.38, 1.115, 0, 0, 255, 0, 1.35, 0.57, 0, 0, 255},		--Ford Raptor        
		 {579, -0.65, 0.2, 1.725, -0.65, 0.2, 1.725, 0, 0, 255, -0.65, 0.2, 1.725, 0, 0, 255}, 			--G wagen
         --{479, -0.3, 0.25, 0.58, -0.3, 0.25, 0.58, 0, 0, 255, -0.3, 0.25, 0.58, 0, 0, 255}, 		-- Regina Üres
         --{566, -0.3, 0.1, 0.75, -0.3, 0.1, 0.75, 0, 0, 255, -0.3, 0.1, 0.75, 0, 0, 255}, 			--tahoma üres
         {580, -0.3, 0, 0.88, -0.3, 0, 0.88, 0, 0, 255, -0.3, 0, 0.88, 0, 0, 255}, 					--Audi RS4
         {540, -0.3, 0.1, 0.9, -0.3, 0.1, 0.9, 0, 0, 255, -0.3, 0.1, 0.9, 0, 0, 255}, 				--Subaru Impreza ST
         {413, -0.54, 1, 0.98, -0.54, 1, 0.98, 0, 0, 255, -0.54, 1, 0.98, 0, 0, 255}, 				--Ford F150		 
}

function createVehicleSirens(playerSource, commandName)
	local veh = getPedOccupiedVehicle(playerSource)
	if veh then
		for i = 1, #vehicles do
			if vehicles[i][1] == getElementModel(veh) then
				local siren = createObject ( 1851, 0, 9, 4, 0, 0, 0 )
				attachElements ( siren, veh, vehicles[i][2], vehicles[i][3], vehicles[i][4] )
				addVehicleSirens(veh, 2, 3, false, false, true, true)
				setVehicleSirens(veh,1,vehicles[i][5], vehicles[i][6], vehicles[i][7], vehicles[i][8], vehicles[i][9], vehicles[i][10],255,255)
				setVehicleSirens(veh,2,vehicles[i][11], vehicles[i][12], vehicles[i][13], vehicles[i][14], vehicles[i][15], vehicles[i][16],255,255)
				setElementData(veh, "veh->siren", siren)
			end
		end
	end
end
addCommandHandler ( "sirenon", createVehicleSirens )

function destroyVehicleSirens(playerSource, commandName)
	local veh = getPedOccupiedVehicle(playerSource)
	if veh then
		if getElementData(veh, "veh->siren") then
			destroyElement(getElementData(veh, "veh->siren"))
			removeVehicleSirens(veh)
			setElementData(veh, "veh->siren", nil)
		end
	end
end
addCommandHandler ( "sirenoff", destroyVehicleSirens )

function togVehicleSiren(playerSource)
	local veh = getPedOccupiedVehicle(playerSource)
	if getElementData(veh, "veh->siren") then
		destroyVehicleSirens(playerSource, "asd")
	else
		createVehicleSirens(playerSource, "asd")
	end
end
addEvent( "togVehicleSiren", true )
addEventHandler( "togVehicleSiren", resourceRoot, togVehicleSiren ) -- Bound to this resource only, saves on CPU usage.

function removeVehicleSiren()
	if getElementData(source, "veh->siren") then
		destroyElement(getElementData(source, "veh->siren"))
		setVehicleSirensOn ( source, false )
		removeVehicleSirens(source)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), removeVehicleSiren)

------------

local vehicles2 = {
--	{ID, xPos, yPos, zPos, sirenLeftX, sirenLeftY, sirenLeftZ, sirenLeftColorR, sirenLeftColorG, sirenLeftColorB, sirenRightX, sirenRightY, sirenRightZ, sirenRightColorR, sirenRightColorG, sirenRightColorB},

         {445, -0.3, -0.12, 0.73, -0.3, -0.12, 0.73, 255, 102, 0, -0.3, -0.12, 0.73, 255, 102, 0},
         {479, -0.3, 0.25, 0.58, -0.3, 0.25, 0.58, 255, 102, 0, -0.3, 0.25, 0.58, 255, 102, 0},
         {566, -0.3, 0.25, 0.58, -0.3, 0.25, 0.58, 255, 102, 0, -0.3, 0.25, 0.58, 255, 102, 0},
         {413, -0.54, 1, 0.98, -0.54, 1, 0.98, 255, 102, 0, -0.54, 1, 0.98, 255, 102, 0}, --Ford F150
}

function createVehicleSirens2(playerSource, commandName)
	local veh = getPedOccupiedVehicle(playerSource)
	if veh then
		for i = 1, #vehicles2 do
			if vehicles2[i][1] == getElementModel(veh) then
				local siren2 = createObject ( 1851, 0, 9, 4, 0, 0, 0 )
				attachElements ( siren2, veh, vehicles2[i][2], vehicles2[i][3], vehicles2[i][4] )
				addVehicleSirens(veh, 2, 3, false, false, true, true)
				setVehicleSirens(veh,1,vehicles2[i][5], vehicles2[i][6], vehicles2[i][7], vehicles2[i][8], vehicles2[i][9], vehicles2[i][10],255,255)
				setVehicleSirens(veh,2,vehicles2[i][11], vehicles2[i][12], vehicles2[i][13], vehicles2[i][14], vehicles2[i][15], vehicles2[i][16],255,255)
				setElementData(veh, "veh->siren2", siren2)
			end
		end
	end
end
addCommandHandler ( "sirenon2", createVehicleSirens2 )

function toggleTaxiLight(playerSource, commandName)
	local veh = getPedOccupiedVehicle(playerSource)
	if veh then
		for i = 1, #vehicles2 do
			if vehicles2[i][1] == getElementModel(veh) then
				local taxi = createObject ( 1852, 0, 9, 4, 0, 0, 0 )
				attachElements ( taxi, veh, vehicles2[i][2], vehicles2[i][3], vehicles2[i][4] )
				setVehicleTaxiLightOn(veh, 2, 3, false, false, true, true)
				setVehicleTaxiLightOn(veh,1,vehicles2[i][5], vehicles2[i][6], vehicles2[i][7], vehicles2[i][8], vehicles2[i][9], vehicles2[i][10],255,255)
				setVehicleTaxiLightOn(veh,2,vehicles2[i][11], vehicles2[i][12], vehicles2[i][13], vehicles2[i][14], vehicles2[i][15], vehicles2[i][16],255,255)
				setElementData(veh, "veh->taxi", taxi)
			end
		end
	end
end
addCommandHandler("taxilight",toggleTaxiLight)

function destroyVehicleSirens2(playerSource, commandName)
	local veh = getPedOccupiedVehicle(playerSource)
	if veh then
		if getElementData(veh, "veh->siren2") then
			destroyElement(getElementData(veh, "veh->siren2"))
			removeVehicleSirens(veh)
			setElementData(veh, "veh->siren2", nil)
		end
	end
end
addCommandHandler ( "sirenoff2", destroyVehicleSirens2 )

function togVehicleSiren2(playerSource)
	local veh = getPedOccupiedVehicle(playerSource)
	if getElementData(veh, "veh->siren2") then
		destroyVehicleSirens2(playerSource, "asd2")
	else
		createVehicleSirens2(playerSource, "asd2")
	end
end
addEvent( "togVehicleSiren2", true )
addEventHandler( "togVehicleSiren2", resourceRoot, togVehicleSiren2 ) -- Bound to this resource only, saves on CPU usage.

function removeVehicleSiren2()
	if getElementData(source, "veh->siren2") then
		destroyElement(getElementData(source, "veh->siren2"))
		setVehicleSirensOn ( source, false )
		removeVehicleSirens(source)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), removeVehicleSiren2)

function togRadio(playerSource, state)
  setElementData(playerSource, "SpeakIntoRadio", state)
end
addEvent( "togRadio", true )
addEventHandler( "togRadio", resourceRoot, togRadio )

function addBadget(player,cmd,data1,data2)
	if getElementData(player,"acc.adminLevel") >= 3 or exports.nlrp_groups:isPlayerInGroup(player,1) or exports.nlrp_groups:isPlayerInGroup(player,2) or exports.nlrp_groups:isPlayerInGroup(player,3) or exports.nlrp_groups:isPlayerInGroup(player,4) or exports.nlrp_groups:isPlayerInGroup(player,5) or exports.nlrp_groups:isPlayerInGroup(player,19)then
		if data1 and data2 then
			giveItem(player,86,1,data1,data2)
			outputChatBox(exports.nlrp_core:getServerTag("sarp") .. "Sikeresen készítettél egy jelvényt!",player,0,0,0,true)
		else
			outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [Cím 1] [Cím 2]",player,0,0,0,true)
		end
	end
end
addCommandHandler("addjelveny",addBadget)
addCommandHandler("addjelvény",addBadget)

function addCopyPaper(player,cmd,data1,data2,data3)
	if getElementData(player,"acc.adminLevel") >= 7 then
		if data1 and data2 and data3 then
			giveItem(player,179,1,data1,data2,data3)
			outputChatBox(exports.nlrp_core:getServerTag("sarp") .. "Sikeresen készítettél egy nyomtatványt!",player,0,0,0,true)
		else
			outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [Cím 1] [Cím 2] [Cim 3]",player,0,0,0,true)
		end
	end
end
addCommandHandler("addnyomtatvany",addCopyPaper)
addCommandHandler("addnyomtatvány",addCopyPaper)



local randomdologajiba = {
	--{1}, --kulcs
	--{2}, --kulcs
	{9}, --glock
	{10}, --Silencer
	{11}, --Dezi
	{12}, --Uzi
	{14}, --MPX
	{126}, --koko
	{125}, --fű
	--{85}, -- széf
	--{131}, -- NL Pack 1
	{95}, -- pénzes zsák
	{157}, -- kincses láda(pp láda)

}

function giftNLPACK (player, pack)
	if pack == 1 then
		giveItem(player, 9, 1)
		giveItem(player, 9, 1)
		giveItem(player, 3, 100)
		setElementData(player, "char.Money", getElementData(player, "char.Money") + 10000000)
		setElementData(player, "char.PP", getElementData(player, "char.PP") + 3500)

	elseif pack == 2 then
		giveItem(player, 12, 1)
		giveItem(player, 12, 1)
		giveItem(player, 4, 200)
		setElementData(player, "char.Money", getElementData(player, "char.Money") + 20000000)
		setElementData(player, "char.PP", getElementData(player, "char.PP") + 6000)

	elseif pack == 3 then
		giveItem(player, 15, 1)
		giveItem(player, 15, 1)
		giveItem(player, 5, 300)
		setElementData(player, "char.Money", getElementData(player, "char.Money") + 40000000)
		setElementData(player, "char.PP", getElementData(player, "char.PP") + 12000)

	elseif pack == 4 then
		giveItem(player, 16, 1)
		giveItem(player, 16, 1)
		giveItem(player, 15, 1)
		giveItem(player, 15, 1)
		giveItem(player, 5, 200)
		giveItem(player, 6, 200)
		setElementData(player, "char.Money", getElementData(player, "char.Money") + 60000000)
		setElementData(player, "char.PP", getElementData(player, "char.PP") + 25000)

	elseif pack == 6 then
		setElementData(player, "char.Money", getElementData(player, "char.Money") + math.random (1000000,15000000))
	elseif pack == 7 then
		setElementData(player, "char.PP", getElementData(player, "char.PP") + math.random (200,1000))
	elseif pack == 5 then
			pocs = 1, #randomdologajiba do
			giveItem(player, randomdologajiba[math.random(1,#randomdologajiba)][1], 1)
		end
	end
end


addEvent("completeJob",true)
addEventHandler("completeJob",resourceRoot,
	function(player)
		exports.nlrp_company:completeJob(player)
	end
)


addEvent("editBalance",true)
addEventHandler("editBalance",resourceRoot,
	function(player,data,amount)
		setElementData(player,"char." .. data,getElementData(player,"char." .. data)-amount)
	end
)



addEvent("playRepairSound",true)
addEventHandler("playRepairSound",resourceRoot,
	function(sourceP,x,y,z)
		for k,v in ipairs(getElementsByType("player")) do
			triggerClientEvent(v,"returnSound",v,x,y,z)
		end
	end
)


addEvent("fixVehicleWithCard",true)
addEventHandler("fixVehicleWithCard",resourceRoot,
	function(veh)
		fixVehicle(veh)
	end
)

addEvent("unflipVehicleWithCard",true)
addEventHandler("unflipVehicleWithCard",resourceRoot,
	function(veh)
		local rx, ry, rz = getElementRotation(veh)
		setElementRotation(veh, 0, ry, rz)
	end
)


addEvent("putArmor",true)
addEventHandler("putArmor",resourceRoot,
	function(player)
		setPedArmor(player,100)
	end
)

addEvent("healCard",true)
addEventHandler("healCard",resourceRoot,
	function(playerElement)
		setElementHealth(playerElement, 100)
		setElementData(playerElement, "isPlayerDeath", false)
		setElementData(playerElement, "bulletDamages", false)
		--setElementData(playerElement, "boneDamages", false)
		setElementData(playerElement, "bloodLevel", 100)
		setElementData(playerElement, "deathReason", false)
		setElementData(playerElement, "customDeath", false)
	end
)



removeOneItemByID = function(player,itemId)
	if player and itemId then
		triggerClientEvent(player,"removeOneItemByID",player,itemId)
	end
end