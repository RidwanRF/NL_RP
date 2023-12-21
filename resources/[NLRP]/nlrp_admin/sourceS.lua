local acmds = {}

connection = false

logs = exports.nlrp_logs

protectedSerials = {
	----Tulajdonos----
	["F59221AFBD4E038B838E56957EE19A12"] = true, -- GreV
	----Fejlesztő----
    ["B512A7CE96CA1F1D7C3F0D8F107568B2"] = true, -- Azure
	----System Admin----
    ["1DE0D75535C78839A93B905F7968C79D"] = true, -- Patrik
	----Admin Controller----
   [""] = true,
	----Főadmin----
    ["802AF4EB4C4395528689018D211761A1"] = true, -- Kris
	----Egyéb Adminok----
  --  ["321321321"] = true, --
}

function addAdminCommand(command, level, description, forceResourceName)
	if not acmds[command] then
		local resourceName = forceResourceName or "nlrp_admin"

		if not forceResourceName and sourceResource then
			resourceName = getResourceName(sourceResource)
		end

		acmds[command] = {level, description, resourceName}
	end
end

addEvent("requestAdminCommands", true)
addEventHandler("requestAdminCommands", getRootElement(),
	function()
		if isElement(source) then
			triggerClientEvent(source, "receiveAdminCommands", source, acmds)
		end
	end)

addEventHandler("onResourceStop", getRootElement(),
	function(stoppedResource)
		if stoppedResource == getThisResource() then
			local array = {}
			local count = 0

			for k, v in pairs(acmds) do
				if v[3] ~= "nlrp_admin" then
					array[k] = v
					count = count + 1
				end
			end

			if count > 0 then
				setElementData(getResourceRootElement(getResourceFromName("nlrp_modstarter")), "adminCommandsCache", array, false)
			end
		else
			local resname = getResourceName(stoppedResource)

			for k, v in pairs(acmds) do
				if v[3] == resname then
					acmds[k] = nil
				end
			end
		end
	end)

function addPlusOneMinuteToAdmins()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"loggedIn") then
			if getElementData(v, "acc.adminJailTime") <= 0 then
				if getElementData(v, "adminDuty") then
					setElementData(v, "adminDutyTime", (getElementData(v, "adminDutyTime")or 0) + 1)
				end
				if getElementData(v, "char.Hunger") then
					if getElementData(v, "char.Hunger") > 0 then
						if not getElementData(v, "adminDuty") then
							setElementData(v, "char.Hunger", getElementData(v, "char.Hunger") - 0.4)
						end
					else
						setElementHealth ( v, 0 )
					end
				end
				if getElementData(v, "char.Thirst") then
					if getElementData(v, "char.Thirst") > 0 then
						if not getElementData(v, "adminDuty") then
							setElementData(v, "char.Thirst", getElementData(v, "char.Thirst") - 0.2)
						end
					else
						setElementHealth ( v, 0 )
					end
				end
			end
		end
	end
end

addEventHandler("onResourceStart", getResourceRootElement(),
	function(startedResource)
		connection = exports.nlrp_database:getConnection()
		setTimer ( addPlusOneMinuteToAdmins, 60000, 0 )
		local theRes = getResourceRootElement(getResourceFromName("nlrp_modstarter"))

		if theRes then
			local cache = getElementData(theRes, "adminCommandsCache")

			if cache then
				for k, v in pairs(cache) do
					if not acmds[k] then
						addAdminCommand(k, v[1], v[2], v[3])
					end
				end

				removeElementData(theRes, "adminCommandsCache")
			end
		end
	end)


addEventHandler("onResourceStart", getResourceRootElement(),
	function(startedResource)
		connection = exports.nlrp_database:getConnection()

		local theRes = getResourceRootElement(getResourceFromName("nlrp_modstarter"))

		if theRes then
			local cache = getElementData(theRes, "adminCommandsCache")

			if cache then
				for k, v in pairs(cache) do
					if not acmds[k] then
						addAdminCommand(k, v[1], v[2], v[3])
					end
				end

				removeElementData(theRes, "adminCommandsCache")
			end
		end
	end)



addEventHandler("onPlayerChangeNick", getRootElement(),
	function(oldNick, newNick, changedByUser)
		if changedByUser then
			cancelEvent()
		end
	end)

function outputUsageText(commandName, string, playerSource)
	if isElement(playerSource) then
		outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. commandName .. " " .. string, playerSource, 0, 0, 0, true)
	end
end

function outputErrorText(string, playerSource)
	if isElement(playerSource) then
		outputChatBox(exports.nlrp_core:getServerTag("error") .. string, playerSource, 0, 0, 0, true)

		exports.nlrp_core:playSoundForElement(playerSource, ":nlrp_assets/audio/admin/error.ogg")
	end
end

function outputInfoText(string, playerSource)
	if isElement(playerSource) then
		outputChatBox(exports.nlrp_core:getServerTag("info") .. string, playerSource, 0, 0, 0, true)
	end
end

function outputAdminText(string, playerSource)
	if isElement(playerSource) then
		outputChatBox(exports.nlrp_core:getServerTag("admin") .. string, playerSource, 0, 0, 0, true)
	end
end

function getPlayerAdminNick(playerSource)
	if isElement(playerSource) then
		return getElementData(playerSource, "acc.adminNick") or "Admin"
	end
end

function getPlayerCharacterName(playerSource)
	if isElement(playerSource) then
		return (getElementData(playerSource, "char.Name"):gsub("_", " "))
	end
end

function getPlayerVisibleName(playerSource)
	if isElement(playerSource) then
		return (getElementData(playerSource, "visibleName"):gsub("_", " "))
	end
end

function havePermission(playerSource, command, forceDuty, helperLevel)
	if isElement(playerSource) then
		if getElementData(playerSource, "acc.adminLevel") >= 9 then
			return true
		end

		if helperLevel and getElementData(playerSource, "acc.helperLevel") >= helperLevel then
			if forceDuty and helperLevel == 2 and not getElementData(playerSource, "helperDuty") then
				outputErrorText("Csak adminsegéd szolgálatban használhatod az adminsegéd parancsokat! (/asduty)", playerSource)
				return false
			end

			return true
		end

		if getElementData(playerSource, "acc.adminLevel") >= acmds[command][1] and getElementData(playerSource, "acc.adminLevel") ~= 0 then
			if forceDuty then
				if not getElementData(playerSource, "adminDuty") then
					outputErrorText("Csak adminszolgálatban használhatod az admin parancsokat!", playerSource)

					return false
				else
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

local dutyTime = {}

addEventHandler("onResourceStop", getRootElement(),
	function(res)
		exports.nlrp_core:sendMessageToAdmins("Resource sikeresen leállítva. #d75959(" .. getResourceName(res) .. ")", 8)

		if res == getThisResource() then
			for k, v in pairs(dutyTime) do
				if isElement(k) then
				--	dbExec(connection, "UPDATE accounts SET adminDutyTime = adminDutyTime + ? WHERE accountID = ?", getTickCount() - v, getElementData(k, "acc.dbID"))
				end
			end
		end
	end)

addEventHandler("onResourceStart", getRootElement(),
	function(res)
		exports.nlrp_core:sendMessageToAdmins("Resource sikeresen elindítva. #32b3ef(" .. getResourceName(res) .. ")", 8)
	end)

addEventHandler("onElementDataChange", getRootElement(),
	function(data, oldval, newval)
		if data == "adminDuty" then
			if getElementData(source, "adminDuty") then
				dutyTime[source] = getTickCount()
			elseif dutyTime[source] then
			--	dbExec(connection, "UPDATE accounts SET adminDutyTime = adminDutyTime + ? WHERE accountID = ?", getTickCount() - dutyTime[source], getElementData(source, "acc.dbID"))
				dutyTime[source] = nil
			end
		end
	end)

addEventHandler("onPlayerQuit", getRootElement(),
	function()
		if dutyTime[source] then
		--	dbExec(connection, "UPDATE accounts SET adminDutyTime = adminDutyTime + ? WHERE accountID = ?", getTickCount() - dutyTime[source], getElementData(source, "acc.dbID"))
			dutyTime[source] = nil
		end
	end)


local aclCommands = {
	--["parancs"] = AdminRang
 	["stop"] = 9,["start"] = 9,["restart"] = 9,["debugscript"] = 9,
}

addEventHandler("onPlayerCommand",root,
	function(cmd)
		if aclCommands[cmd] then
			if getElementData(source,"acc.adminLevel") then
				if getElementData(source,"acc.adminLevel") < aclCommands[cmd] then
					cancelEvent()
				end
			else
				cancelEvent()
			end
		end
	end
)

function player_Wasted ( ammo, attacker, weapon, bodypart )

	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute

	if minutes < 10 then
		minutes = "0" .. minutes
	end
	if hours < 10 then
		hours = "0" .. hours
	end

	local killog

	if (attacker) then
		if (getElementType(attacker) == "player") then
			if getWeaponNameFromID(weapon) == "Explosion" then
				allapot = "Felrobbantotta"
			else
				allapot = "Fegyver: " .. getWeaponNameFromID(weapon)
			end
			killog = "[" .. hours .. ":" .. minutes .. "] ".. getPlayerName(attacker):gsub("_"," ")   .. " megölte " .. getPlayerName(source):gsub("_"," ") .. " játékost. (" .. allapot .. ")"
			if (bodypart) == 9 then
				killog = killog .. " (Fejbelövés)"
			elseif (bodypart) == 4 then
				killog = killog .. " (Seggbelőtték)"
			end
		elseif (getElementType(attacker) == "vehicle") then
			if getWeaponNameFromID(weapon) == "Rammed" then
				allapot = "Elütötte"
			elseif getWeaponNameFromID(weapon) == "Ranover" then
				allapot = "Ráállt DB"
			end
			killog = "[" .. hours .. ":" .. minutes .. "] " .. getPlayerName(getVehicleController(attacker)):gsub("_"," ") .. " elütötte " .. getPlayerName(source):gsub("_"," ") .. " játékost. (Járművel: " .. allapot .. ")"
		elseif (getElementType(attacker) == "ped") then
			allapot = "( PET )"
			killog = "[" .. hours .. ":" .. minutes .. "] ".. (getElementData(attacker, "ped:name") or "Ismeretlen") .. " "..allapot .. " megölte " .. getPlayerName(source):gsub("_"," ") .. " játékost."
		end
	else
		killog = "[" .. hours .. ":" .. minutes .. "] " .. getPlayerName(source):gsub("_", " ") .. " meghalt."
	end

	for k, v in ipairs(getElementsByType("player")) do
		if tonumber(getElementData(v, "acc.adminLevel") or 0) >= 1 and getElementData(v, "loggedIn") then
			outputChatBox("**KILLOG** ".. killog, v, 255, 105, 105, true)
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )
