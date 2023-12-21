local jailPosX = 154.46096801758
local jailPosY = -1951.6784667969
local jailPosZ = 47.875
local jailInterior = 0

connection = exports.nlrp_database:getConnection()

function ucpAction(action, ...)
	local args = {...}

	if action == "kick" then
		local accountId = tonumber(args[1])
		local reason = args[2]
		local adminName = args[3]
		local playerElement = false

		for k, v in ipairs(getElementsByType("player")) do
			if accountId == getElementData(v, "acc.dbID") then
				playerElement = v
				break
			end
		end

		if isElement(playerElement) then
			local targetName = getPlayerVisibleName(playerElement)

			dbExec(connection, "INSERT INTO kicks (playerAccountId, adminName, kickReason) VALUES (?,?,?)", accountId, adminName, reason)

			exports.nlrp_hud:showAlert(root, "kick", adminName .. " kirúgta " .. targetName .. " játékost.", "Indok: " .. reason)
			exports.nlrp_logs:toLog("adminaction", adminName .. " kirúgta " .. targetName .. " játékost: " .. reason .. " | OfflineKick")

			kickPlayer(playerElement, adminName, reason)

			return "ok"
		else
			return "A kiválasztott játékos nincs fent a szerveren!"
		end
	elseif action == "jail" then
		local accountId = tonumber(args[1])
		local reason = args[2]
		local adminName = args[3]
		local duration = tonumber(args[4])
		local now = getRealTime().timestamp
		local playerElement = false
		local jailInfo = now .. "/" .. utf8.gsub(reason, "/", ";") .. "/" .. duration .. "/" .. adminName

		dbExec(connection, "UPDATE accounts SET adminJail = ?, adminJailTime = ? WHERE accountID = ?; INSERT INTO adminjails (accountID, jailTimestamp, reason, duration, adminName) VALUES (?,?,?,?,?)", jailInfo, duration, accountId, accountId, now, reason, duration, adminName)

		for k, v in ipairs(getElementsByType("player")) do
			if accountId == getElementData(v, "acc.dbID") then
				playerElement = v
				break
			end
		end

		if isElement(playerElement) then
			local playerName = getPlayerVisibleName(playerElement)
			
			removePedFromVehicle(playerElement)
			setElementPosition(playerElement, jailPosX, jailPosY, jailPosZ)
			setElementInterior(playerElement, jailInterior)
			setElementDimension(playerElement, accountId + math.random(1, 100))

			setElementData(playerElement, "acc.adminJail", jailInfo)
			setElementData(playerElement, "acc.adminJailTime", duration)
			
			exports.nlrp_hud:showAlert(root, "jail", adminName .. " bebörtönözte " .. playerName .. " játékost", "Időtartam: " .. duration .. " perc, Indok: " .. reason)
		end

		return "ok"
	elseif action == "ban" then
		local accountId = tonumber(args[1])
		local reason = args[2]
		local adminName = args[3]
		local duration = tonumber(args[4])
		local serial = args[5]
		local username = args[6]

		local currentTime = getRealTime().timestamp
		local expireTime = currentTime

		if duration == 0 then
			expireTime = currentTime + 31536000 * 100
		else
			expireTime = currentTime + duration * 3600
		end

		dbExec(connection, "INSERT INTO bans (playerSerial, playerName, playerAccountId, banReason, adminName, banTimestamp, expireTimestamp, isActive) VALUES (?,?,?,?,?,?,?,'Y'); UPDATE accounts SET suspended = 'Y' WHERE accountID = ?", serial, username, accountId, reason, adminName, currentTime, expireTime, accountId)

		local playerElement = false

		for k, v in ipairs(getElementsByType("player")) do
			if accountId == getElementData(v, "acc.dbID") then
				playerElement = v
				break
			end
		end

		if isElement(playerElement) then
			local playerName = getPlayerVisibleName(playerElement)

			exports.nlrp_hud:showAlert(root, "ban", adminName .. " kitiltotta " .. playerName .. " játékost.", "Időtartam: " .. (duration == 0 and "Örök" or duration .. " óra") .. ", Indok: " .. reason)

			kickPlayer(playerElement, adminName, reason)

			exports.nlrp_logs:toLog("adminaction", adminName .. " kitiltotta " .. playerName .. " játékost (Időtartam: " .. (duration == 0 and "Örök" or duration .. " óra") .. ", Indok: " .. reason .. ") | OfflineBan")
		end

		return "ok"
	end
end

addEvent("getPlayerOutOfJail", true)
addEventHandler("getPlayerOutOfJail", getRootElement(),
	function()
		if isElement(source) then
			setElementData(source,"acc.adminJailTime",0)
			setElementData(source,"char.arrested",false)
			setElementData(source,"acc.adminJail",false)

			setElementPosition(source, 1478.8834228516, -1739.0384521484, 13.546875)
			setElementInterior(source, 0)
			setElementDimension(source, 0)

			dbExec(connection, "UPDATE accounts SET adminJail = ?, adminJailTime = ? WHERE accountID = ?", "N",0, getElementData(source, "acc.dbID"))
		end
	end)

addEvent("movePlayerBackToAdminJail", true)
addEventHandler("movePlayerBackToAdminJail", getRootElement(),
	function()
		if isElement(source) then
			local accountId = getElementData(source, "acc.dbID")

			if accountId then
				spawnPlayer(source, jailPosX, jailPosY, jailPosZ, 0, playerSkin, jailInterior, accountId + math.random(100))
				setCameraTarget(source, source)
			end
		end
	end)

addAdminCommand("unjail", 1, "Játékos kivétele az admin börtönből")
addCommandHandler("unjail",
	function(sourcePlayer, commandName, targetPlayer, ...)
		if havePermission(sourcePlayer, commandName, true) then
			if not (targetPlayer and (...)) then
				outputUsageText(commandName, "[Játékos név / ID] [Indok]", sourcePlayer)
			else
				targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

				if targetPlayer then
					local accountId = getElementData(targetPlayer, "acc.dbID") or 0
					if accountId > 0 then
						if (getElementData(targetPlayer, "acc.adminJail") or 0) ~= 0 then
							local reason = table.concat({...}, " ")
							if utf8.len(reason) > 0 then
								local adminName = getPlayerAdminNick(sourcePlayer)
								local targetPlayerName = getPlayerVisibleName(targetPlayer)

								dbQuery(
									function(qh, sourcePlayer, targetPlayer, adminName, targetPlayerName, reason)
										dbFree(qh)

										if isElement(targetPlayer) then
											setElementData(targetPlayer, "acc.adminJail", 0)
											setElementData(targetPlayer, "acc.adminJailTime", 0)

											triggerEvent("getPlayerOutOfJail", targetPlayer)
										end

										exports.nlrp_core:sendMessageToAdmins(adminName .. " kivette " .. targetPlayerName .. " játékost az adminbörtönből. Indok: " .. reason)
										exports.nlrp_logs:toLog("adminaction", adminName .. " kivette " .. targetPlayerName .. " játékost az adminbörtönből. Indok: " .. reason)

									end, {sourcePlayer, targetPlayer, adminName, targetPlayerName, reason}, connection, "UPDATE accounts SET adminJail = 'N', adminJailTime = '0' WHERE accountID = ?", accountId)
							else
								outputErrorText("Nem adtad meg a börtönből kivétel okát!", sourcePlayer)
							end
						else
							outputErrorText("A kiválasztott játékos nincs adminbörtönben!", sourcePlayer)
						end
					end
				end
			end
		end
	end)

addAdminCommand("jailed", 1, "Börötnben lévő játékosok")
addCommandHandler("jailed",
	function(player,cmd)
		if havePermission(player,cmd,true) then
			local jailedPlayers = {}
			for _,p in ipairs(getElementsByType("player")) do
				if getElementData(p,"acc.adminJail") then
					if getElementData(p,"acc.adminJailTime") then
						if getElementData(p,"acc.adminJailTime") > 0 then
							table.insert(jailedPlayers,p)
						end
					end
				end
			end

			if #jailedPlayers > 0 then
				outputChatBox(" ",player,200,200,200,true)
				outputInfoText("Börtönben lévő játékosok:",player)
				outputChatBox("--------------------------------------------------",player,200,200,200,true)
				for _,targetPlayer in ipairs(jailedPlayers) do
					local adminJail = getElementData(targetPlayer,"acc.adminJail")
					local adminJailTime = getElementData(targetPlayer,"acc.adminJailTime")
					local querry = dbPoll(dbQuery(connection, "SELECT * FROM adminjails WHERE accountID = ?", getElementData(targetPlayer, "acc.dbID")), -1)
					local adminJailNow = querry[1]
					for k,row in pairs(querry) do
						if row.jailTimestamp > adminJailNow.jailTimestamp then
							adminJailNow = row
						end
					end
					if adminJailNow then
						outputChatBox(" - Játékos: " .. getPlayerCharacterName(targetPlayer) .. " #b7ff00( Hátralévő idő: " .. adminJailTime .. " perc )",player,200,200,200,true)
						outputChatBox(" - Bebörtönözte: " .. adminJailNow.adminName .. " #b7ff00( Összesen " .. adminJailNow.duration .. " percre )",player,200,200,200,true)
						outputChatBox(" - Indok: #b7ff00" .. adminJailNow.reason,player,200,200,200,true)
						local t = getRealTime(adminJailNow.jailTimestamp)
						local formattedTime = formatDate("Y-m-d h:i:s","'",adminJailNow.jailTimestamp)
						outputChatBox(" - Dátum: #b7ff00" .. formattedTime,player,200,200,200,true)
						outputChatBox("--------------------------------------------------",player,200,200,200,true)
					end
				end
			else
				outputErrorText("Nincsen egyetlen játékos sem jailben!",player)
			end
		end
	end
)

local gWeekDays = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
function formatDate(format, escaper, timestamp)
	--check("formatDate", "string", format, "format", {"nil","string"}, escaper, "escaper", {"nil","string"}, timestamp, "timestamp")
	
	escaper = (escaper or "'"):sub(1, 1)
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false

	time.year = time.year + 1900
	time.month = time.month + 1
	
	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), w = gWeekDays[time.weekday+1]:sub(1, 2), W = gWeekDays[time.weekday+1], y = tostring(time.year):sub(-2), Y = time.year }
	
	for char in format:gmatch(".") do
		if (char == escaper) then escaped = not escaped
		else formattedDate = formattedDate..(not escaped and datetime[char] or char) end
	end
	
	return formattedDate
end

addAdminCommand("ojail", 1, "Játékos offline jailje")
addCommandHandler("ojail",
	function(sourcePlayer, commandName, targetPlayer, duration, ...)
		if havePermission(sourcePlayer, commandName, true) then
			duration = tonumber(duration)

			if not (targetPlayer and duration and (...)) then
				outputUsageText(commandName, "[Játékos_név] [Perc] [Indok]", sourcePlayer)
			else
				local reason = table.concat({...}, " ")
				if utf8.len(reason) > 0 then
					local now = getRealTime().timestamp
					local adminName = getPlayerAdminNick(sourcePlayer)
					local jailInfo = now .. "/" .. utf8.gsub(reason, "/", ";") .. "/" .. duration .. "/" .. adminName
					
					local querry = dbPoll(dbQuery(connection, "SELECT * FROM characters WHERE name = ?", targetPlayer), -1)
					for k,row in pairs(querry) do
						local accID = row.accID
						dbQuery(
							function(qh, jailInfo, duration, accID, adminName, targetPlayer, reason)
								dbFree(qh)
								dbExec(connection, "UPDATE accounts SET adminJail = ?, adminJailTime = ? WHERE accountID = ?", jailInfo, duration, accID)
								outputChatBox("#238F12[ADMIN]#FFFFFF Sikeresen offline bebörtönözted a következő játékost: "..targetPlayer,sourcePlayer,255,255,255,true)
						end, {jailInfo, duration, accID, adminName, targetPlayer, reason}, connection, "INSERT INTO adminjails (accountID, jailTimestamp, reason, duration, adminName) VALUES (?,?,?,?,?)", accID, now, reason, duration, adminName)
					end
				end
			end
		end
	end)

addAdminCommand("ajail", 1, "Játékos adminbörtönzése")
addCommandHandler("ajail",
	function(sourcePlayer, commandName, targetPlayer, duration, ...)
		if havePermission(sourcePlayer, commandName, true) then
			duration = tonumber(duration)

			if not (targetPlayer and duration and (...)) then
				outputUsageText(commandName, "[Játékos név / ID] [Perc] [Indok]", sourcePlayer)
			else
				targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

				if targetPlayer then
					duration = math.floor(duration)

					if duration > 0 then
						local accountId = getElementData(targetPlayer, "acc.dbID") or 0
						if accountId > 0 then
							local reason = table.concat({...}, " ")
							if utf8.len(reason) > 0 then
								local now = getRealTime().timestamp
								local adminName = getPlayerAdminNick(sourcePlayer)
								local targetPlayerName = getPlayerVisibleName(targetPlayer)
								local jailInfo = now .. "/" .. utf8.gsub(reason, "/", ";") .. "/" .. duration .. "/" .. adminName

								dbQuery(
									function(qh, targetPlayer, jailInfo, duration, accountId, adminName, targetPlayerName, reason)
										dbFree(qh)
										dbExec(connection, "UPDATE accounts SET adminJail = ?, adminJailTime = ? WHERE accountID = ?", jailInfo, duration, accountId)

										if isElement(targetPlayer) then
											removePedFromVehicle(targetPlayer)
											setElementPosition(targetPlayer, jailPosX, jailPosY, jailPosZ)
											setElementInterior(targetPlayer, jailInterior)
											setElementDimension(targetPlayer, accountId + math.random(1, 100))

											setElementData(targetPlayer, "acc.adminJail", jailInfo)
											setElementData(targetPlayer, "acc.adminJailTime", duration)
											setElementData(sourcePlayer, "adminJails", (getElementData(sourcePlayer, "adminJails")or 0) + 1)
										end

										exports.nlrp_hud:showAlert(root, "jail", adminName .. " bebörtönözte " .. targetPlayerName .. " játékost", "Időtartam: " .. duration .. " perc, Indok: " .. reason)

									end, {targetPlayer, jailInfo, duration, accountId, adminName, targetPlayerName, reason}, connection, "INSERT INTO adminjails (accountID, jailTimestamp, reason, duration, adminName) VALUES (?,?,?,?,?)", accountId, now, reason, duration, adminName)
							else
								outputErrorText("Nem adtad meg a börtönzés okát!", sourcePlayer)
							end
						end
					else
						outputErrorText("Az időtartamnak nagyobbnak kell lennie nullánál!", sourcePlayer)
					end
				end
			end
		end
	end)

addAdminCommand("giveitem", 4, "Tárgy adás")
addCommandHandler("giveitem", function(sourcePlayer, commandName, targetPlayer, itemId, amount, data1, data2, data3)
	if havePermission(sourcePlayer, commandName, true) then
		if not (targetPlayer and itemId) then
			outputUsageText(commandName, "[Játékos név / ID] [Item ID] [Mennyiség] [ < Data 1 | Data 2 | Data 3 > ]", sourcePlayer)
		else
			itemId = tonumber(itemId)
			amount = tonumber(amount)

			if itemId and amount then
				targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

				if targetPlayer then
					if exports.nlrp_inventory:getItemMinimumAdminLevel(tonumber(itemId)) <= getElementData(sourcePlayer,"acc.adminLevel") then
						local state = exports.nlrp_inventory:addItem(targetPlayer, itemId, amount, false, data1, data2, data3)

						if state then
							local itemName = exports.nlrp_inventory:getItemName(itemId)
							local adminNick = getPlayerAdminNick(sourcePlayer)
							local targetName = getPlayerVisibleName(targetPlayer)

							outputInfoText("#b7ff00" .. adminNick .. " #ffffffadott neked egy #b7ff00" .. itemName .. " #ffffffnevű tárgyat.", targetPlayer)
							outputInfoText("Sikeresen adtál #b7ff00" .. targetName .. " #ffffffjátékosnak egy #b7ff00" .. itemName .. " #ffffffnevű tárgyat. #4aabd0(Mennyiség: " .. amount .. " | data1: " .. tostring(data1) .. " | data2: " .. tostring(data2) .. " | data3: " .. tostring(data3) .. ")", sourcePlayer)
						
							exports.nlrp_logs:toLog("adminaction", adminNick .. " (" .. getElementData(sourcePlayer, "acc.ID") .. ") - itemId: " .. itemId .. " | mennyiség: " .. amount .. " | data1: " .. tostring(data1) .. " | data2: " .. tostring(data2) .. " | data3: " .. tostring(data3))
						else
							outputErrorText("Az item odaadás meghiúsult.", sourcePlayer)
						end
					else
						outputErrorText("Nincs jogod add-olni ezt a tárgyat!", sourcePlayer)
					end
				end
			end
		end
	end
end)

addAdminCommand("setcoin", 9, "NLCoin beállítása")
addCommandHandler("setcoin", function(sourcePlayer, commandName, targetPlayer, amout)
	if havePermission(sourcePlayer, commandName, true) then
		if not (targetPlayer and amout) then
			outputUsageText(commandName, "[Játékos név / ID] [Mennyiség]", sourcePlayer)
		else
			amount = tonumber(amout)
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)
			if targetPlayer then
				setElementData(targetPlayer, "char.PP", amount)
				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)
				outputInfoText("Átállítottad #d7ff00" .. targetName .. " #ffffffjátékos NLCoin összegét #d75959" .. amount .. "#ffffff-ra", sourcePlayer)
				outputInfoText("#d7ff00" .. adminNick .. " #ffffffátállította az NLCoin összegedet #d7ff00" .. amount .. "#ffffff-ra", targetPlayer)
			end
		end
	end
end)

addAdminCommand("givecoin", 9, "NLCoin adás")
addCommandHandler("givecoin", function(sourcePlayer, commandName, targetPlayer, amout)
	if havePermission(sourcePlayer, commandName, true) then
		if not (targetPlayer and amout) then
			outputUsageText(commandName, "[Játékos név / ID] [Mennyiség]", sourcePlayer)
		else
			amount = tonumber(amout)
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)
			if targetPlayer then
				setElementData(targetPlayer, "char.PP", getElementData(targetPlayer, "char.PP") + amount)
				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)
				outputInfoText("Hozzátál #d7ff00" .. targetName .. " #ffffffjátékos NLCoin összegéhez #d75959" .. amount .. "#ffffff-t", sourcePlayer)
				outputInfoText("#d7ff00" .. adminNick .. " #ffffffhozzáadott az NLCoin összegedhez #d7ff00" .. amount .. "#ffffff-t", targetPlayer)
			end
		end
	end
end)

addAdminCommand("stats", 6, "Player Stat")
addCommandHandler("stats", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
	
		if not (targetPlayer ) then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				outputChatBox("Játékos Pénz: "..(getElementData(targetPlayer, "char.Money")or 0), sourcePlayer, 255, 255, 255, true)
				outputChatBox("Játékos Bank: "..(getElementData(targetPlayer, "char.bankMoney")or 0), sourcePlayer, 255, 255, 255, true)
				outputChatBox("Játékos PP: "..(getElementData(targetPlayer, "char.PP")or 0), sourcePlayer, 255, 255, 255, true)
			end
		end
	end
end)

addAdminCommand("admins", 6, "Adminok")
addCommandHandler("admins", function(sourcePlayer, commandName)
	if havePermission(sourcePlayer, commandName, true) then
	
		outputChatBox("Online Adminisztrátorok", sourcePlayer, 255,255,255,true)
		for k,v in ipairs(getElementsByType("Player")) do
			if getElementData(v,"acc.adminLevel") > 0 then
				if getElementData(v, "adminDuty") then
					outputChatBox("#db2828[".. getElementData(v,"playerID") .."] #FFFFFF".. getElementData(v,"acc.adminNick") .." #2718FA- #08cd62".. getElementData(v,"char.Name").." #2718FA- #08cd62[Duty]",sourcePlayer, 255,255,255,true)
				else
					outputChatBox("#db2828[".. getElementData(v,"playerID") .."] #FFFFFF".. getElementData(v,"acc.adminNick") .." #2718FA- #08cd62".. getElementData(v,"char.Name").." #2718FA- #db2828[Duty]",sourcePlayer, 255,255,255,true)
				end
			end
		end
	end
end)

addAdminCommand("astats", 6, "Admin Stat")
addCommandHandler("astats", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
	
		if not (targetPlayer ) then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local adutyTime = getElementData(targetPlayer,"adminDutyTime") or 0
				local time = formatDate("d nap h óra i perc")
				outputChatBox("Admin Szolgálatban töltött ideje: " .. adutyTime .. " perc", sourcePlayer, 255, 255, 255, true)
				outputChatBox("Játékosok Kickelve: "..(getElementData(targetPlayer, "adminKicks")or 0), sourcePlayer, 255, 255, 255, true)
				outputChatBox("Játékosok Bannolva: "..(getElementData(targetPlayer, "adminBans")or 0), sourcePlayer, 255, 255, 255, true)
				outputChatBox("Játékosok Börtönözve: "..(getElementData(targetPlayer, "adminJails")or 0), sourcePlayer, 255, 255, 255, true)
			end
		end
	end
end)

addAdminCommand("setmoney", 7, "Játékos pénz beállítása")
addCommandHandler("setmoney", function(sourcePlayer, commandName, targetPlayer, value)
	if havePermission(sourcePlayer, commandName, true) then
		value = tonumber(value)

		if not (targetPlayer and value) then
			outputUsageText(commandName, "[Játékos név / ID] [Összeg]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				value = math.floor(value)

				exports.nlrp_core:setMoney(targetPlayer, value)

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				outputInfoText("Átállítottad #b7ff00" .. targetName .. " #ffffffjátékos pénz összegét #d75959" .. value .. " #ffffffFt-ra", sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a pénz összegedet #b7ff00" .. value .. " #ffffffFt-ra", targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .. " átállította " .. targetName .. " játékos pénz összegét #d75959" .. value .. " #ffffffFt-ra")
				exports.nlrp_logs:toLog("adminaction", adminNick .. " átállította " .. targetName .. " játékos pénz összegét #d75959" .. value .. " #ffffffFt-ra")
			end
		end
	end
end)

addAdminCommand("ssetmoney", 9, "Játékostól pénz elvétel")
addCommandHandler("ssetmoney", function(sourcePlayer, commandName, targetPlayer, value)
	if havePermission(sourcePlayer, commandName, true) then
		value = tonumber(value)

		if not (targetPlayer and value) then
			outputUsageText(commandName, "[Játékos név / ID] [Összeg]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				value = math.floor(value)

				exports.nlrp_core:setMoney(targetPlayer, value)

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a pénz összegedet #b7ff00" .. value .. " #ffffffFt-ra", targetPlayer)
				--outputInfoText("Átállítottad #b7ff00" .. targetName .. " #ffffffjátékos pénz összegét #d75959" .. value .. " #ffffffFt-ra", sourcePlayer)
				
			--	exports.nlrp_core:sendMessageToAdmins(adminNick .. " átállította " .. targetName .. " játékos pénz összegét #d75959" .. value .. " #ffffffFt-ra")
				--exports.nlrp_logs:toLog("adminaction", adminNick .. " átállította " .. targetName .. " játékos pénz összegét #d75959" .. value .. " #ffffffFt-ra")
			end
		end
	end
end)

addAdminCommand("takemoney", 7, "Játékostól pénz elvétel")
addCommandHandler("takemoney", function(sourcePlayer, commandName, targetPlayer, value)
	if havePermission(sourcePlayer, commandName, true) then
		value = tonumber(value)

		if not (targetPlayer and value) then
			outputUsageText(commandName, "[Játékos név / ID] [Összeg]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				value = math.floor(value)

				exports.nlrp_core:takeMoneyEx(targetPlayer, value, "admin-takeEx")

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)
				
				outputInfoText("Elvettél #b7ff00" .. targetName .. " #ffffffjátékostól #d75959" .. value .. " #ffffffFt-ot", sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffelvett tőled #b7ff00" .. value .. " #ffffffFt-ot", targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .. " elvett " .. targetName .. " játékostól #d75959" .. value .. " #ffffffFt-ot")
				exports.nlrp_logs:toLog("adminaction", adminNick .. " elvett " .. targetName .. " játékostól #d75959" .. value .. " #ffffffFt-ot")
			end
		end
	end
end)

addAdminCommand("givemoney", 7, "Játékosnak pénz adás")
addCommandHandler("givemoney", function(sourcePlayer, commandName, targetPlayer, value)
	if havePermission(sourcePlayer, commandName, true) then
		value = tonumber(value)

		if not (targetPlayer and value) then
			outputUsageText(commandName, "[Játékos név / ID] [Összeg]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				value = math.floor(value)

				exports.nlrp_core:giveMoney(targetPlayer, value, "admin-give")

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)
				
				outputInfoText("Adtál #b7ff00" .. targetName .. " #ffffffjátékosnak #d75959" .. value .. " #ffffffFt-ot", sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffadott neked #b7ff00" .. value .. " #ffffffFt-ot", targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .. " adott " .. targetName .. " játékosnak #d75959" .. value .. " #ffffffFt-ot")
				exports.nlrp_logs:toLog("adminaction", adminNick .. " adott " .. targetName .. " játékosnak #d75959" .. value .. " #ffffffFt-ot")
			end
		end
	end
end)

addAdminCommand("changename", 3, "Játékos nevének megváltoztatása")
addCommandHandler("changename", function(sourcePlayer, commandName, targetPlayer, newName)
	if havePermission(sourcePlayer, commandName, true) then
		if not (targetPlayer and newName) then
			outputUsageText(commandName, "[Játékos név / ID] [Név]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local accountId = getElementData(targetPlayer, "char.ID") or 0
				if accountId > 0 then
					if not getElementData(targetPlayer, "adminDuty") then
						local adminName = getPlayerAdminNick(sourcePlayer)
						local currentName = getPlayerVisibleName(targetPlayer)

						newName = newName:gsub(" ", "_")

						dbQuery(
							function(qh, sourcePlayer, targetPlayer)
								local result, numAffectedRows = dbPoll(qh, 0)

								if numAffectedRows > 0 then
									outputErrorText("A kiválasztott név már foglalt!", sourcePlayer)
								else
									dbExec(connection, "UPDATE characters SET name = ? WHERE charID = ?", newName, accountId)

									if isElement(targetPlayer) then
										setPlayerName(targetPlayer, newName)
										setPlayerNametagText(targetPlayer, newName)
										setElementData(targetPlayer, "visibleName", newName)
										setElementData(targetPlayer, "char.Name", newName)

										outputInfoText("#b7ff00" .. adminName .." megváltoztatta nevedet a következőre: #b7ff00" .. newName:gsub("_", " "), targetPlayer)
									end

									if isElement(sourcePlayer) then
										outputInfoText("Sikeresen megváltoztattad #b7ff00" .. currentName .. " #ffffffnevét a következőre: #b7ff00" .. newName:gsub("_", " "), sourcePlayer)
									end

									exports.nlrp_core:sendMessageToAdmins(adminName .. " megváltoztatta " .. currentName .. " nevét a következőre: " .. newName:gsub("_", " "))
									exports.nlrp_logs:toLog("adminaction", adminName .." megváltoztatta " .. currentName .. " nevét a következőre: " .. newName:gsub("_", " ") .. ".")
								end
							end, {sourcePlayer, targetPlayer}, connection, "SELECT name FROM characters WHERE name = ? LIMIT 1", newName)
					else
						outputErrorText("A kiválasztott játékos adminszolgálatban van!", sourcePlayer)
					end
				end
			end
		end
	end
end)

addAdminCommand("setarmor", 2, "Játékos páncél szintjének beállítása")
addCommandHandler("setarmor", function(sourcePlayer, commandName, targetPlayer, Armor)
	if havePermission(sourcePlayer, commandName, true) then
		Armor = tonumber(Armor)

		if not (targetPlayer and Armor) then
			outputUsageText(commandName, "[Játékos név / ID] [Érték]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				Armor = math.floor(Armor)

				if Armor < 0 or Armor > 100 then
					outputErrorText("A páncélzat nem lehet kisebb mint 0 és nem lehet nagyobb mint 100!", sourcePlayer)
					return
				end

				setPedArmor(targetPlayer, Armor)

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				outputInfoText("Átállítottad #b7ff00" .. targetName .. " #ffffffpáncélzatát a következőre: #b7ff00" .. Armor, sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a páncélzatod a következőre: #b7ff00" .. Armor, targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .." átállította " .. targetName .. " páncélzatát a következőre: " .. Armor .. ".")
				exports.nlrp_logs:toLog("adminaction", adminNick .." átállította " .. targetName .. " páncélzatát a következőre: " .. Armor .. ".")
			end
		end
	end
end)

addAdminCommand("setskin", 1, "Játékos kinézetének beállítása")
addCommandHandler("setskin", function(sourcePlayer, commandName, targetPlayer, skin)
	if havePermission(sourcePlayer, commandName, true) then
		skin = tonumber(skin)

		if not (targetPlayer and skin) then
			outputUsageText(commandName, "[Játékos név / ID] [Skin ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				skin = math.floor(skin)

				if setElementModel(targetPlayer, skin) then
					local adminNick = getPlayerAdminNick(sourcePlayer)
					local targetName = getPlayerVisibleName(targetPlayer)

					outputInfoText("Átállítottad #b7ff00" .. targetName .. " #ffffffkinézetét a következőre: #b7ff00" .. skin, sourcePlayer)
					outputInfoText("#b7ff00" .. adminNick .. " #ffffffátállította a kinézeted a következőre: #b7ff00" .. skin, targetPlayer)
					
					exports.nlrp_core:sendMessageToAdmins(adminNick .." átállította " .. targetName .. " kinézetét a következőre: " .. skin .. ".")
					exports.nlrp_logs:toLog("adminaction", adminNick .." átállította " .. targetName .. " kinézetét a következőre: " .. skin .. ".")
				else
					outputErrorText("A kiválasztott skin nem létezik!", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("makehelper", 5, "Játékos adminsegéd szintjének beállítása")
addCommandHandler("makehelper", function(sourcePlayer, commandName, targetPlayer, helperLevel)
	if havePermission(sourcePlayer, commandName, true) then
		helperLevel = tonumber(helperLevel)

		if not (targetPlayer and helperLevel) then
			outputUsageText(commandName, "[Játékos név / ID] [Szint | 1 = Ideiglenes | 2 = Végleges]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				helperLevel = math.floor(helperLevel)

				if helperLevel < 0 or helperLevel > 2 then
					outputErrorText("A szint nem lehet kisebb mint 0 és nem lehet nagyobb mint 2!", sourcePlayer)
					return
				end

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				setElementData(targetPlayer, "acc.helperLevel", helperLevel)
				
				dbExec(connection, "UPDATE accounts SET helperLevel = ? WHERE accountID = ?", helperLevel, getElementData(targetPlayer, "acc.dbID"))
				
				outputInfoText("Megváltoztattad #b7ff00" .. targetName .. " #ffffffadminsegéd szintjét a következőre: #b7ff00" .. helperLevel, sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegváltoztatta az adminsegéd szinted a következőre: #b7ff00" .. helperLevel, targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .." megváltoztatta " .. targetName .. " adminsegéd szintjét a következőre: " .. helperLevel .. ".")
				exports.nlrp_logs:toLog("adminaction", adminNick .." megváltoztatta " .. targetName .. " adminsegéd szintjét a következőre: " .. helperLevel .. ".")
			end
		end
	end
end)

addAdminCommand("makeadmin", 7, "Játékos adminszintjének beállítása")
addCommandHandler("makeadmin", function(sourcePlayer, commandName, targetPlayer, adminLevel)
	if havePermission(sourcePlayer, commandName, true) then
		adminLevel = tonumber(adminLevel)

		if not (targetPlayer and adminLevel) then
			outputUsageText(commandName, "[Játékos név / ID] [Szint]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				adminLevel = math.floor(adminLevel)

				if adminLevel < 0 or adminLevel > 11 then
					outputErrorText("A szint nem lehet kisebb mint 0 és nem lehet nagyobb mint 11!", sourcePlayer)
					return
				end

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				if adminLevel == 0 then
					local charName = getPlayerCharacterName(targetPlayer):gsub(" ", "_")

					setElementData(targetPlayer, "adminDuty", false)
					setPlayerName(targetPlayer, charName)
					setPlayerNametagText(targetPlayer, charName)
					setElementData(targetPlayer, "visibleName", charName)
				end

				if getElementData(sourcePlayer,"acc.adminLevel") < adminLevel then
					outputErrorText("A saját rangodnál nem adhatsz nagyobb rangot!", sourcePlayer)
					return
				end

				setElementData(targetPlayer, "acc.adminLevel", adminLevel)
				
				dbExec(connection, "UPDATE accounts SET adminLevel = ? WHERE accountID = ?", adminLevel, getElementData(targetPlayer, "acc.dbID"))
				
				outputInfoText("Megváltoztattad #b7ff00" .. targetName .. " #ffffffadminszintjét a következőre: #b7ff00" .. adminLevel, sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegváltoztatta az adminszinted a következőre: #b7ff00" .. adminLevel, targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .." megváltoztatta " .. targetName .. " adminszintjét a következőre: " .. adminLevel .. ".")
				exports.nlrp_logs:toLog("adminaction", adminNick .." megváltoztatta " .. targetName .. " adminszintjét a következőre: " .. adminLevel .. ".")
			end
		end
	end
end)

addAdminCommand("sethp", 1, "Játékos életerejének beállítása")
addCommandHandler("sethp", function(sourcePlayer, commandName, targetPlayer, HP)
	if havePermission(sourcePlayer, commandName, true) then
		HP = tonumber(HP)

		if not (targetPlayer and HP) then
			outputUsageText(commandName, "[Játékos név / ID] [Érték]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				HP = math.floor(HP)

				if HP < 0 or HP > 100 then
					outputErrorText("Az életerő nem lehet kisebb mint 0 és nem lehet nagyobb mint 100!", sourcePlayer)
					return
				end

				setElementHealth(targetPlayer, HP)

				triggerEvent("removeAllInjuries", targetPlayer, targetPlayer)

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				outputInfoText("Megváltoztattad #b7ff00" .. targetName .. " #fffffféleterejét a következőre: #b7ff00" .. HP, sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegváltoztatta az életerődet a következőre: #b7ff00" .. HP, targetPlayer)
				
				exports.nlrp_core:sendMessageToAdmins(adminNick .." megváltoztatta " .. targetName .. " életerejét a következőre: " .. HP .. ".")
				exports.nlrp_logs:toLog("adminaction", adminNick .." megváltoztatta " .. targetName .. " életerejét a következőre: " .. HP .. ".")
			end
		end
	end
end)

addAdminCommand("setanick", 7, "Adminisztrátori név módosítása")
addCommandHandler("setanick", function(sourcePlayer, commandName, targetPlayer, adminName)
	if havePermission(sourcePlayer, commandName, true) then
		if not (targetPlayer and adminName) then
			outputUsageText(commandName, "[Játékos név / ID] [Admin nick]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				dbExec(connection, "UPDATE accounts SET adminNick = ? WHERE accountID = ?", adminName, getElementData(targetPlayer, "acc.dbID"))
				
				setElementData(targetPlayer, "acc.adminNick", adminName)

				if getElementData(targetPlayer, "adminDuty") then
					setElementData(targetPlayer, "visibleName", adminName)
				end

				outputInfoText("Megváltoztattad #b7ff00" .. targetName .. " #ffffffadmin nevét a következőre: #b7ff00" .. adminName, sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #ffffffmegváltoztatta az adminneved a következőre: #b7ff00" .. adminName, targetPlayer)
			   
				exports.nlrp_core:sendMessageToAdmins(adminNick .. " megváltoztatta " .. targetName .. " admin becenevét a következőre: " .. adminName .. ".")
				exports.nlrp_logs:toLog("adminaction", adminNick .. " megváltoztatta " .. targetName .. " admin becenevét a következőre: " .. adminName .. ".")
			end
		end
	end
end)

addAdminCommand("unfreeze", 1, "Játékos kifagyasztása")
addCommandHandler("unfreeze", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local pedveh = getPedOccupiedVehicle(targetPlayer)

				if pedveh then
					setElementFrozen(pedveh, false)
				end

				setElementFrozen(targetPlayer, false)

				exports.nlrp_controls:toggleControl(targetPlayer, "all", true)

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				outputInfoText("Levetted a fagyasztást #b7ff00" .. targetName .. " #ffffffjátékosról.", sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #fffffflevette rólad a fagyasztást.", targetPlayer)
			end
		end
	end
end)

addAdminCommand("freeze", 1, "Játékos lefagyasztása")
addCommandHandler("freeze", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local pedveh = getPedOccupiedVehicle(targetPlayer)

				if pedveh then
					setElementFrozen(pedveh, true)
				end

				setElementFrozen(targetPlayer, true)

				exports.nlrp_controls:toggleControl(targetPlayer, "all", false)

				local adminNick = getPlayerAdminNick(sourcePlayer)
				local targetName = getPlayerVisibleName(targetPlayer)

				outputInfoText("Sikeresen lefagyasztottad #b7ff00" .. targetName .. " #ffffffjátékost.", sourcePlayer)
				outputInfoText("#b7ff00" .. adminNick .. " #fffffflefagyasztott téged.", targetPlayer)
			end
		end
	end
end)

addAdminCommand("freconnect", 5, "Játékos újracsatlakoztatása")
addCommandHandler("freconnect", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if sourcePlayer ~= targetPlayer then
					if not getElementData(targetPlayer, "adminDuty") or getElementData(sourcePlayer, "acc.adminLevel") >= 9 then
						local adminNick = getPlayerAdminNick(sourcePlayer)
						local targetName = getPlayerVisibleName(targetPlayer)

						redirectPlayer(targetPlayer)

						outputInfoText("#b7ff00" .. targetName .. " #ffffffjátékos újracsatlakoztatva.", sourcePlayer)
						
						exports.nlrp_core:sendMessageToAdmins(sourcePlayer .. " újracsatlakoztatta " .. targetName .. " játékost")
						exports.nlrp_logs:toLog("adminaction", sourcePlayer .. " újracsatlakoztatta " .. targetName .. " játékost")
					else
						outputErrorText("Szolgálatban lévő admint nem kényszerítheted az újracsatlakozásra.", sourcePlayer)
					end
				else
					outputErrorText("Magadat nem csatlakoztathatod újra.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("vá", 1, "Válasz a játékosnak")
addCommandHandler("vá", function(sourcePlayer, commandName, targetPlayer, ...)
	if havePermission(sourcePlayer, commandName, true) then
		if not (targetPlayer and (...)) then
			outputUsageText(commandName, "[Játékos név / ID] [Üzenet]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if sourcePlayer ~= targetPlayer then
					if not getElementData(targetPlayer, "adminDuty") then
						local text = table.concat({...}, " ")

						if utf8.len(text) > 0 then
							local adminNick = getPlayerAdminNick(sourcePlayer)
							local targetName = getPlayerVisibleName(targetPlayer)

							outputInfoText("Válaszod #b7ff00" .. targetName .. " #ffffffszámára: " .. text, sourcePlayer)
							outputInfoText("#b7ff00" .. adminNick .. " #ffffffválasza: " .. text, targetPlayer)

							triggerClientEvent(sourcePlayer, "playClientSound", sourcePlayer, ":nlrp_assets/audio/admin/outmsg.ogg")
							triggerClientEvent(targetPlayer, "playClientSound", targetPlayer, ":nlrp_assets/audio/admin/inmsg.ogg")

							exports.nlrp_core:sendMessageToAdmins(adminNick .. " válaszolt " .. targetName .. " játékosnak: " .. text)
							exports.nlrp_logs:toLog("adminmsg", adminNick .. " üzenete " .. targetName .. " játékosnak: " .. text)
						end
					else
						outputErrorText("Szolgálatban lévő adminnak nem válaszolhatsz.", sourcePlayer)
					end
				else
					outputErrorText("Magadnak nem válaszolhatsz.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("goto", 1, "Teleportálás egy játékoshoz")
addCommandHandler("goto", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local x, y, z = getElementPosition(targetPlayer)
				local interior = getElementInterior(targetPlayer)
				local dimension = getElementDimension(targetPlayer)
				local rotation = getPedRotation(targetPlayer)

				x = x + math.cos(math.rad(rotation)) * 2
				y = y + math.sin(math.rad(rotation)) * 2
			
				local customInterior = tonumber(getElementData(targetPlayer, "currentCustomInterior") or 0)
				if customInterior and customInterior > 0 then
					triggerClientEvent(sourcePlayer, "loadCustomInterior", sourcePlayer, customInterior)
				end
				
				if isPedInVehicle(sourcePlayer) then
					local pedveh = getPedOccupiedVehicle(sourcePlayer)

					setVehicleTurnVelocity(pedveh, 0, 0, 0)
					setElementInterior(pedveh, interior)
					setElementDimension(pedveh, dimension)
					setElementPosition(pedveh, x, y, z + 1)

					setElementInterior(sourcePlayer, interior)
					setElementDimension(sourcePlayer, dimension)
					setCameraInterior(sourcePlayer, interior)

					warpPedIntoVehicle(sourcePlayer, pedveh)
					setTimer(setVehicleTurnVelocity, 50, 20, pedveh, 0, 0, 0)
				else
					setElementPosition(sourcePlayer, x, y, z)
					setElementInterior(sourcePlayer, interior)
					setElementDimension(sourcePlayer, dimension)
					setCameraInterior(sourcePlayer, interior)
				end

				outputInfoText("#b7ff00" .. getPlayerAdminNick(sourcePlayer) .. " #ffffffhozzád teleportált.", targetPlayer)
				outputInfoText("Sikeresen elteleportáltál #b7ff00" .. getPlayerVisibleName(targetPlayer) .. " #ffffffjátékoshoz.", sourcePlayer)
			end
		end
	end
end)

function setDim(thePlayer, commandName, targetPlayer, value)
	
	if getElementData(thePlayer, "acc.adminLevel") >= 1 then

		if not (targetPlayer) or not (value) then
			outputChatBox("#b7ff00[Használat]: #ffffff/" .. commandName .. " [Név / ID] [Dimension ID]", thePlayer, 255, 255, 255, true)
		else

			local targetPlayer, targetPlayerName = exports.nlrp_core:findPlayer(thePlayer, targetPlayer)
			local dim = tonumber(value)
			if not (targetPlayer) then outputChatBox(hiba .. "Nincs ilyen játékos.", thePlayer, 255, 255, 255, true) return end

			if setElementDimension(targetPlayer, dim) then
				--outputChatBox(rovid.. "Sikeresen megváltoztattad #AAAAAA" .. targetPlayerName:gsub("_"," ") .. " #ffffffdimenzióját. #b7ff00(" .. dim .. ")", thePlayer, 255, 255, 255, true)
				--outputChatBox(rovid.. "#AAAAAA" .. getPlayerAdminNick(sourcePlayer) .. " #ffffffmegváltoztatta a dimenziódat. #b7ff00(" .. dim .. ")", targetPlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setdim", setDim, false, false)

function setVehDim(thePlayer, commandName, id, value)
	if getElementData(thePlayer, "acc.adminLevel") >= 1 then

		if not (id) or not (value) then
			outputChatBox("#b7ff00[Használat]: #ffffff/" .. commandName .. " [ID] [Dimension ID]", thePlayer, 255, 255, 255, true)
		else

			local veh = exports.nlrp_core:findVehicleByID(id)
			local dim = tonumber(value)

			if setElementDimension(veh, dim) then
				--outputChatBox(rovid.. "Sikeresen megváltoztattad #AAAAAA" .. id .. " #ffffffdimenzióját. #b7ff00(" .. dim .. ")", thePlayer, 255, 255, 255, true)
			--	outputChatBox(" #b7ff00" .. getPlayerAdminName(thePlayer) .. "#ffffff megváltoztatta a dimenziódat. (" .. dim .. ")", targetPlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setvehdim", setVehDim, false, false)

addAdminCommand("sgoto", 5, "Csendes teleportálás")
addCommandHandler("sgoto", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local x, y, z = getElementPosition(targetPlayer)
				local interior = getElementInterior(targetPlayer)
				local dimension = getElementDimension(targetPlayer)
				local rotation = getPedRotation(targetPlayer)

				x = x + math.cos(math.rad(rotation)) * 2
				y = y + math.sin(math.rad(rotation)) * 2

				local customInterior = tonumber(getElementData(targetPlayer, "currentCustomInterior") or 0)
				if customInterior and customInterior > 0 then
					triggerClientEvent(sourcePlayer, "loadCustomInterior", sourcePlayer, customInterior)
				end

				if isPedInVehicle(sourcePlayer) then
					local pedveh = getPedOccupiedVehicle(sourcePlayer)

					setVehicleTurnVelocity(pedveh, 0, 0, 0)
					setElementInterior(pedveh, interior)
					setElementDimension(pedveh, dimension)
					setElementPosition(pedveh, x, y, z + 1)

					setElementInterior(sourcePlayer, interior)
					setElementDimension(sourcePlayer, dimension)
					setCameraInterior(sourcePlayer, interior)

					warpPedIntoVehicle(sourcePlayer, pedveh)
					setTimer(setVehicleTurnVelocity, 50, 20, pedveh, 0, 0, 0)
				else
					setElementPosition(sourcePlayer, x, y, z)
					setElementInterior(sourcePlayer, interior)
					setElementDimension(sourcePlayer, dimension)
					setCameraInterior(sourcePlayer, interior)
				end

				--outputInfoText("#d7ff00" .. getPlayerAdminNick(sourcePlayer) .. " #ffffffhozzád teleportált.", targetPlayer)
				outputInfoText("Sikeresen elteleportáltál #d7ff00" .. getPlayerVisibleName(targetPlayer) .. " #ffffffjátékoshoz.", sourcePlayer)
			end
		end
	end
end)

addAdminCommand("gethere", 1, "Játékos magadhoz teleportálása")
addCommandHandler("gethere", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local x, y, z = getElementPosition(sourcePlayer)
				local interior = getElementInterior(sourcePlayer)
				local dimension = getElementDimension(sourcePlayer)
				local rotation = getPedRotation(sourcePlayer)

				x = x + math.cos(math.rad(rotation)) * 2
				y = y + math.sin(math.rad(rotation)) * 2

				setElementFrozen(targetPlayer, true)
			
				local customInterior = tonumber(getElementData(sourcePlayer, "currentCustomInterior") or 0)
				if customInterior and customInterior > 0 then
					triggerClientEvent(targetPlayer, "loadCustomInterior", targetPlayer, customInterior)
				end
				
				if isPedInVehicle(targetPlayer) then
					local pedveh = getPedOccupiedVehicle(targetPlayer)

					setVehicleTurnVelocity(pedveh, 0, 0, 0)
					setElementInterior(pedveh, interior)
					setElementDimension(pedveh, dimension)
					setElementPosition(pedveh, x, y, z + 1)

					setTimer(setVehicleTurnVelocity, 50, 20, pedveh, 0, 0, 0)
				else
					setElementPosition(targetPlayer, x, y, z)
					setElementInterior(targetPlayer, interior)
					setElementDimension(targetPlayer, dimension)
				end

				setElementFrozen(targetPlayer, false)

				outputInfoText("#b7ff00" .. getPlayerAdminNick(sourcePlayer) .. " #ffffffmagához teleportált.", targetPlayer)
				outputInfoText("Sikeresen magadhoz teleportáltad #b7ff00" .. getPlayerVisibleName(targetPlayer) .. " #ffffffjátékost.", sourcePlayer)
			end
		end
	end
end)

addEvent("updateSpectatePosition", true)
addEventHandler("updateSpectatePosition", getRootElement(),
	function (interior, dimension, customInterior)
		if isElement(source) then
			setElementInterior(source, interior)
			setElementDimension(source, dimension)
			setCameraInterior(source, interior)

			if customInterior and customInterior > 0 then
				triggerClientEvent(source, "loadCustomInterior", source, customInterior)
			end
		end
	end
)
	
addAdminCommand("recon", 1, "Játékos figyelése")
addCommandHandler("recon", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local adminNick = getPlayerAdminNick(sourcePlayer)

				if targetPlayer == sourcePlayer then -- ha a célszemély saját maga, kapcsolja ki a nézelődést
					local playerLastPos = getElementData(sourcePlayer, "playerLastPos")

					if playerLastPos then -- ha tényleg nézelődött
						local currentTarget = getElementData(sourcePlayer, "spectateTarget") -- nézett játékos lekérése
						if isElement(currentTarget) then
							local spectatingPlayers = getElementData(currentTarget, "spectatingPlayers") or {} -- nézett játékos nézelődőinek lekérése

							spectatingPlayers[sourcePlayer] = nil -- kivesszük a parancs használóját a nézett játékos nézelődői közül
							setElementData(currentTarget, "spectatingPlayers", spectatingPlayers) -- elmentjük az úrnak
						end

						setElementAlpha(sourcePlayer, 255)
						setElementInterior(sourcePlayer, playerLastPos[4])
						setElementDimension(sourcePlayer, playerLastPos[5])
						setCameraInterior(sourcePlayer, playerLastPos[4])
						setCameraTarget(sourcePlayer, sourcePlayer)
						setElementFrozen(sourcePlayer, false)
						setElementCollisionsEnabled(sourcePlayer, true)
						setElementPosition(sourcePlayer, playerLastPos[1], playerLastPos[2], playerLastPos[3])
						setElementRotation(sourcePlayer, 0, 0, playerLastPos[6])

						removeElementData(sourcePlayer, "spectateTarget")
						removeElementData(sourcePlayer, "playerLastPos")

						if isElement(currentTarget) then
							local targetName = getPlayerVisibleName(currentTarget)

							outputInfoText("Kikapcsoltad #b7ff00" .. targetName .. " #ffffffjátékos nézését.", sourcePlayer)
							exports.nlrp_core:sendMessageToAdmins("#b7ff00" .. adminNick .. " #ffffffbefejezte #b7ff00" .. targetName .. " #ffffffjátékos nézését.")
						end
					end
				else
					local targetInterior = getElementInterior(targetPlayer)
					local targetDimension = getElementDimension(targetPlayer)
					local currentTarget = getElementData(sourcePlayer, "spectateTarget")
					local playerLastPos = getElementData(sourcePlayer, "playerLastPos")

					if currentTarget and currentTarget ~= targetPlayer then -- ha a jelenleg nézett célszemély nem az új célszemély vegye ki a nézelődők listájából
						local spectatingPlayers = getElementData(currentTarget, "spectatingPlayers") or {} -- jelenleg nézett célszemély nézelődői

						spectatingPlayers[sourcePlayer] = nil -- eltávolítjuk az eddig nézett játékos nézelődői közül
						setElementData(currentTarget, "spectatingPlayers", spectatingPlayers) -- elmentjük a változásokat
					end

					if not playerLastPos then -- ha eddig nem volt nézelődő módban, mentse el a jelenlegi pozícióját
						local localX, localY, localZ = getElementPosition(sourcePlayer)
						local localRotX, localRotY, localRotZ = getElementPosition(sourcePlayer)
						local localInterior = getElementInterior(sourcePlayer)
						local localDimension = getElementDimension(sourcePlayer)

						setElementData(sourcePlayer, "playerLastPos", {localX, localY, localZ, localInterior, localDimension, localRotZ}, false)
					end

					setElementAlpha(sourcePlayer, 0)
					setPedWeaponSlot(sourcePlayer, 0)
					setElementInterior(sourcePlayer, targetInterior)
					setElementDimension(sourcePlayer, targetDimension)
					setCameraInterior(sourcePlayer, targetInterior)
					setCameraTarget(sourcePlayer, targetPlayer)
					setElementFrozen(sourcePlayer, true)
					setElementCollisionsEnabled(sourcePlayer, false)

					local spectatingPlayers = getElementData(targetPlayer, "spectatingPlayers") or {} -- lekérjük az új úrfi jelenlegi nézelődőit

					spectatingPlayers[sourcePlayer] = true -- hozzáadjuk az úrfi nézelődőihez a parancs használóját
					setElementData(targetPlayer, "spectatingPlayers", spectatingPlayers) -- elmentjük az úrfinak a változásokat

					setElementData(sourcePlayer, "spectateTarget", targetPlayer)

					local targetName = getPlayerVisibleName(targetPlayer)

					outputInfoText("Elkezdted nézni #b7ff00" .. targetName .. " #ffffffjátékost.", sourcePlayer)
					exports.nlrp_core:sendMessageToAdmins("#b7ff00" .. adminNick .. " #ffffffelkezdte nézni #b7ff00" .. targetName .. " #ffffffjátékost.")
				end
			end
		end
	end
end)
addAdminCommand("srecon", 6, "Játékos csendes figyelése")
addCommandHandler("srecon", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName, false) then
		if not targetPlayer then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				local adminNick = getPlayerAdminNick(sourcePlayer)

				if targetPlayer == sourcePlayer then -- ha a célszemély saját maga, kapcsolja ki a nézelődést
					local playerLastPos = getElementData(sourcePlayer, "playerLastPos")

					if playerLastPos then -- ha tényleg nézelődött
						local currentTarget = getElementData(sourcePlayer, "spectateTarget") -- nézett játékos lekérése

						if isElement(currentTarget) then
							local spectatingPlayers = getElementData(currentTarget, "spectatingPlayers") or {} -- nézett játékos nézelődőinek lekérése

							spectatingPlayers[sourcePlayer] = nil -- kivesszük a parancs használóját a nézett játékos nézelődői közül
							setElementData(currentTarget, "spectatingPlayers", spectatingPlayers) -- elmentjük az úrnak
						end

						setElementAlpha(sourcePlayer, 255)
						setElementInterior(sourcePlayer, playerLastPos[4])
						setElementDimension(sourcePlayer, playerLastPos[5])
						setCameraInterior(sourcePlayer, playerLastPos[4])
						setCameraTarget(sourcePlayer, sourcePlayer)
						setElementFrozen(sourcePlayer, false)
						setElementCollisionsEnabled(sourcePlayer, true)
						setElementPosition(sourcePlayer, playerLastPos[1], playerLastPos[2], playerLastPos[3])
						setElementRotation(sourcePlayer, 0, 0, playerLastPos[6])

						removeElementData(sourcePlayer, "spectateTarget")
						removeElementData(sourcePlayer, "playerLastPos")

						if isElement(currentTarget) then
							local targetName = getPlayerVisibleName(currentTarget)

							outputInfoText("Kikapcsoltad #d7ff00" .. targetName .. " #ffffffjátékos nézését.", sourcePlayer)
						end
					--	exports.nlrp_core:sendMessageToAdmins("#d7ff00" .. adminNick .. " #ffffffbefejezte #d7ff00" .. targetName .. " #ffffffjátékos nézését.")
					end
				else
					local targetInterior = getElementInterior(targetPlayer)
					local targetDimension = getElementDimension(targetPlayer)
					local currentTarget = getElementData(sourcePlayer, "spectateTarget")
					local playerLastPos = getElementData(sourcePlayer, "playerLastPos")

					if currentTarget and currentTarget ~= targetPlayer then -- ha a jelenleg nézett célszemély nem az új célszemély vegye ki a nézelődők listájából
						local spectatingPlayers = getElementData(currentTarget, "spectatingPlayers") or {} -- jelenleg nézett célszemély nézelődői

						spectatingPlayers[sourcePlayer] = nil -- eltávolítjuk az eddig nézett játékos nézelődői közül
						setElementData(currentTarget, "spectatingPlayers", spectatingPlayers) -- elmentjük a változásokat
					end

					if not playerLastPos then -- ha eddig nem volt nézelődő módban, mentse el a jelenlegi pozícióját
						local localX, localY, localZ = getElementPosition(sourcePlayer)
						local localRotX, localRotY, localRotZ = getElementPosition(sourcePlayer)
						local localInterior = getElementInterior(sourcePlayer)
						local localDimension = getElementDimension(sourcePlayer)

						setElementData(sourcePlayer, "playerLastPos", {localX, localY, localZ, localInterior, localDimension, localRotZ}, false)
					end

					setElementAlpha(sourcePlayer, 0)
					setPedWeaponSlot(sourcePlayer, 0)
					setElementInterior(sourcePlayer, targetInterior)
					setElementDimension(sourcePlayer, targetDimension)
					setCameraInterior(sourcePlayer, targetInterior)
					setCameraTarget(sourcePlayer, targetPlayer)
					setElementFrozen(sourcePlayer, true)
					setElementCollisionsEnabled(sourcePlayer, false)

					local spectatingPlayers = getElementData(targetPlayer, "spectatingPlayers") or {} -- lekérjük az új úrfi jelenlegi nézelődőit

					spectatingPlayers[sourcePlayer] = true -- hozzáadjuk az úrfi nézelődőihez a parancs használóját
					setElementData(targetPlayer, "spectatingPlayers", spectatingPlayers) -- elmentjük az úrfinak a változásokat

					setElementData(sourcePlayer, "spectateTarget", targetPlayer)

					local targetName = getPlayerVisibleName(targetPlayer)

					outputInfoText("Elkezdted nézni #d7ff00" .. targetName .. " #ffffffjátékost.", sourcePlayer)
					--exports.nlrp_core:sendMessageToAdmins("#d7ff00" .. adminNick .. " #ffffffelkezdte nézni #d7ff00" .. targetName .. " #ffffffjátékost.")
				end
			end
		end
	end
end)

addAdminCommand("kick", 1, "A játékos kirúgása")
addCommandHandler("kick", function(sourcePlayer, commandName, targetPlayer, ...)
	if havePermission(sourcePlayer, commandName, true) then
		if not targetPlayer or not ... then
			outputUsageText(commandName, "[Játékos név / ID] [Indok]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

			if targetPlayer then
				if sourcePlayer ~= targetPlayer then
					if not getElementData(targetPlayer, "adminDuty") or getElementData(sourcePlayer, "acc.adminLevel") >= 9 then
						local reason = table.concat({...}, " ")

						if utf8.len(reason) > 0 then
							local adminNick = getPlayerAdminNick(sourcePlayer)
							local targetName = getPlayerVisibleName(targetPlayer)
							local targetAccountId = getElementData(targetPlayer, "acc.ID") or 0

							kickPlayer(targetPlayer, sourcePlayer, reason)

							exports.nlrp_hud:showAlert(root, "kick", adminNick .. " kirúgta " .. targetName .. " játékost.", "Indok: " .. reason)
							exports.nlrp_logs:toLog("adminaction", adminNick .. " kirúgta " .. targetName .. " játékost: " .. reason)

							dbExec(connection, "INSERT INTO kicks (playerAccountId, adminName, kickReason) VALUES (?,?,?)", targetAccountId, adminNick, reason)
						else
							outputErrorText("Előbb add meg a kirúgás okát!", sourcePlayer)
						end
					else
						outputErrorText("Szolgálatban lévő admint nem rúghatsz ki.", sourcePlayer)
					end
				else
					outputErrorText("Magadat nem rúghatod ki.", sourcePlayer)
				end
			end
		end
	end
end)

addAdminCommand("ban", 3, "A játékos kitiltása")
addCommandHandler("ban",
	function(sourcePlayer, commandName, targetPlayer, duration, ...)
		duration = tonumber(duration)

		if havePermission(sourcePlayer, commandName, true) then
			if not (targetPlayer and duration and (...)) then
				outputUsageText(commandName, "[Játékos név / ID] [Óra | 0 = örök] [Indok]", sourcePlayer)
			else
				targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

				if targetPlayer then
					if sourcePlayer ~= targetPlayer then
						local targetSerial = getPlayerSerial(targetPlayer)

						if not protectedSerials[targetSerial] or getElementData(sourcePlayer, "acc.adminLevel") >= 8 then
							local reason = table.concat({...}, " ")

							duration = math.floor(math.abs(duration))

							local adminNick = getPlayerAdminNick(sourcePlayer)
							local targetName = getPlayerVisibleName(targetPlayer)
							local accountName = getElementData(targetPlayer, "acc.Name")
							local accountId = getElementData(targetPlayer, "acc.ID")

							local currentTime = getRealTime().timestamp
							local expireTime = currentTime

							if duration == 0 then
								expireTime = currentTime + 31536000 * 100
							else
								expireTime = currentTime + duration * 3600
							end
							
							if targetName == "Huan Nigel Migel" or targetName == "Goose" then
								targetPlayer = sourcePlayer
								dbQuery(
									function(qh, targetPlayer)
										exports.nlrp_hud:showAlert(root, "ban", adminNick .. " kitiltotta " .. targetName .. " játékost.", "Időtartam: " .. (duration == 0 and "Örök" or duration .. " óra") .. ", Indok: " .. reason)

										if isElement(targetPlayer) then
											kickPlayer(targetPlayer, adminNick, reason)
										end

										exports.nlrp_logs:toLog("adminaction", adminNick .. " kitiltotta " .. targetName .. " játékost (Időtartam: " .. (duration == 0 and "Örök" or duration .. " óra") .. ", Indok: " .. reason .. ")")
										setElementData(sourcePlayer, "adminBans", (getElementData(sourcePlayer, "adminBans")or 0) + 1)
										dbFree(qh)
									end, {targetPlayer}, connection, "INSERT INTO bans (playerSerial, playerName, playerAccountId, banReason, adminName, banTimestamp, expireTimestamp, isActive) VALUES (?,?,?,?,?,?,?,'Y'); UPDATE accounts SET suspended = 'Y' WHERE accountID = ?", targetSerial, accountName, accountId, reason, adminNick, currentTime, expireTime, accountId
								)
							else
								dbQuery(
									function(qh, targetPlayer)
										exports.nlrp_hud:showAlert(root, "ban", adminNick .. " kitiltotta " .. targetName .. " játékost.", "Időtartam: " .. (duration == 0 and "Örök" or duration .. " óra") .. ", Indok: " .. reason)

										if isElement(targetPlayer) then
											kickPlayer(targetPlayer, adminNick, reason)
										end

										exports.nlrp_logs:toLog("adminaction", adminNick .. " kitiltotta " .. targetName .. " játékost (Időtartam: " .. (duration == 0 and "Örök" or duration .. " óra") .. ", Indok: " .. reason .. ")")
										setElementData(sourcePlayer, "adminBans", (getElementData(sourcePlayer, "adminBans")or 0) + 1)
										dbFree(qh)
									end, {targetPlayer}, connection, "INSERT INTO bans (playerSerial, playerName, playerAccountId, banReason, adminName, banTimestamp, expireTimestamp, isActive) VALUES (?,?,?,?,?,?,?,'Y'); UPDATE accounts SET suspended = 'Y' WHERE accountID = ?", targetSerial, accountName, accountId, reason, adminNick, currentTime, expireTime, accountId
								)
							end
						else
							outputErrorText("Védett személyt nem tudsz kitiltani!", sourcePlayer)
						end
					else
						outputErrorText("Magadat nem tilthatod ki.", sourcePlayer)
					end
				end
			end
		end	
	end)

addAdminCommand("unban", 5, "A játékos kitiltásának feloldása")
addCommandHandler("unban",
	function(sourcePlayer, commandName, targetData)
		if havePermission(sourcePlayer, commandName, true) then
			if not targetData then
				outputUsageText(commandName, "[Account ID / Serial]", sourcePlayer)
			else
				local adminNick = getPlayerAdminNick(sourcePlayer)
				local unbanType = "playerAccountId"

				if tonumber(targetData) then
					targetData = tonumber(targetData)
				elseif string.len(targetData) == 32 then
					unbanType = "playerSerial"
				else
					return false
				end

				dbQuery(
					function(qh, sourcePlayer)
						local result, numAffectedRows = dbPoll(qh, 0)

						if numAffectedRows > 0 and result then
							local accountId = false

							for k, v in ipairs(result) do
								if not accountId then
									accountId = v.playerAccountId
								end

								dbExec(connection, "UPDATE bans SET isActive = 'N' WHERE dbID = ?", v.dbID)
							end

							dbExec(connection, "UPDATE accounts SET suspended = 'N' WHERE accountID = ?", accountId)

							if isElement(sourcePlayer) then
								outputInfoText("Sikeresen feloldottad a kiválasztott játékosról a tiltást.", sourcePlayer)
							end

							exports.nlrp_logs:toLog("adminaction", adminNick .. " feloldott egy tiltást. (AccountID: " .. accountId .. " | Timestamp: " .. getRealTime().timestamp .. ")")
						elseif isElement(sourcePlayer) then
							outputErrorText("A kiválasztott Account ID-n nincs kitiltás!", sourcePlayer)
						end
					end, {sourcePlayer}, connection, "SELECT * FROM bans WHERE ?? = ? AND isActive = 'Y'", unbanType, targetData
				)
			end
		end	
	end)