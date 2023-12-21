local abKapcsolat = exports.nlrp_database:getConnection()

function isMDCAllowedPD(thePlayer)
	if exports.nlrp_groups:isPlayerHavePermission(thePlayer, "MDCPD") then
	return true
	end
end

function isMDCAllowedNAV(thePlayer)
	if exports.nlrp_groups:isPlayerHavePermission(thePlayer, "MDCNAV") then
	return true
	end
end

function mdcLoginServer(username, password)
	local source = client
	dbQuery(
		function (queryHandler)
			local result, numAffectedRows, errorMsg = dbPoll(queryHandler, 0)
			if numAffectedRows > 0 then
				for _, row in ipairs(result) do
 					frakcio = row["frakcio"]
 				end
 				triggerClientEvent(source, "loginMdcClient", source, frakcio)
			else
				--exports.sas_hud:addNotification(source,"Hibás felhasználónév/jelszó.","error")
			end
		end,
		abKapcsolat,
		"SELECT * FROM mdcaccounts WHERE username = ? AND password = ?", username, password
	)
end
addEvent("mdcLoginServer", true)
addEventHandler("mdcLoginServer", getRootElement(), mdcLoginServer)

addEvent("acceptPlayerLogin", true)
addEventHandler("acceptPlayerLogin", getRootElement(), function(player)
	triggerClientEvent(player, "loginMdcClient", player)
end)

function createMdcAccount(thePlayer, command, username, password)
	if (isMDCAllowedPD(thePlayer)) then
		faction = "PD"
		if faction then
		if not (username) or not (password) then
			outputChatBox("#7cc576[NLRP]: #FFFFFF/" .. command .. " [Felhasználónév] [Jelszó]", thePlayer, 255, 0, 0, true)
		else
			local query = dbExec(abKapcsolat, "INSERT INTO mdcaccounts SET username = ?, password = ?, frakcio = ?",username,password,faction)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffHozzáadva!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC] #ffffffMySQL Hiba [#001-es kód]", thePlayer, 255, 0, 0, true)
			end

			end
		end
	end
	if (isMDCAllowedNAV(thePlayer)) then
		    faction = "NAV"
			if faction then
		if not (username) or not (password) then
			outputChatBox("#7cc576[NLRP - Használat]: #ffffff/" .. command .. " [Felhasználónév] [Jelszó]", thePlayer, 255, 0, 0, true)
		else
			local query = dbExec(abKapcsolat, "INSERT INTO mdcaccounts SET username = ?, password = ?, frakcio = ?",username,password,faction)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffHozzáadva!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC] #ffffffMySQL Hiba [#001-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end
--[[	if exports.exg_dashboard:isPlayerInFaction(thePlayer, 10) then
		faction = "SW"
	if faction then
		if not (username) or not (password) then
			outputChatBox("#7cc576[NLRP - Használat]: #ffffff/" .. command .. " [Felhasználónév] [Jelszó]", thePlayer, 255, 0, 0, true)
		else
		local query = dbExec(abKapcsolat, "INSERT INTO mdcaccounts SET username = ?, password = ?, frakcio = ?",username,password,faction)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffHozzáadva!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC] #ffffffMySQL Hiba [#001-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end
	if exports.exg_dashboard:isPlayerInFaction(thePlayer, 12) then
		faction = "FBI"
	if faction then
		if not (username) or not (password) then
			outputChatBox("#7cc576[NLRP - Használat]: #ffffff/" .. command .. " [Felhasználónév] [Jelszó]", thePlayer, 255, 0, 0, true)
		else
		local query = dbExec(abKapcsolat, "INSERT INTO mdcaccounts SET username = ?, password = ?, frakcio = ?",username,password,faction)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffHozzáadva!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC] #ffffffMySQL Hiba [#001-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end]]
end
addCommandHandler("createmdcaccount", createMdcAccount)

function deleteMdcAccount(thePlayer, command, username)
	if (isMDCAllowedPD(thePlayer)) then
		faction = "PD"

	    if faction then
	    if not (username) then
			outputChatBox("#7cc576[NLRP - MDC]: #ffffff/" .. command .. " [Felhasználónév]", thePlayer, 255, 0, 0, true)
		else
			local query = dbExec(abKapcsolat, "DELETE FROM mdcaccounts WHERE username=?",username)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffKitörölve!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffMySQL Hiba [#002-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end
		--[[if exports.exg_dashboard:isPlayerInFaction(thePlayer, 9) then
		    faction = "SD"
			if faction then
	    if not (username) then
			outputChatBox("#7cc576[NLRP - MDC]: #ffffff/" .. command .. " [Felhasználónév]", thePlayer, 255, 0, 0, true)
		else
			local query = dbExec(abKapcsolat, "DELETE FROM mdcaccounts WHERE username=?",username)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffKitörölve!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffMySQL Hiba [#002-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end
	if exports.exg_dashboard:isPlayerInFaction(thePlayer, 10) then
		faction = "SW"
	if faction then
	    if not (username) then
			outputChatBox("#7cc576[NLRP - MDC]: #ffffff/" .. command .. " [Felhasználónév]", thePlayer, 255, 0, 0, true)
		else
			local query = dbExec(abKapcsolat, "DELETE FROM mdcaccounts WHERE username=?",username)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffKitörölve!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffMySQL Hiba [#002-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end
	if exports.exg_dashboard:isPlayerInFaction(thePlayer, 12) then
		faction = "FBI"
	if faction then
	    if not (username) then
			outputChatBox("#7cc576[NLRP - MDC]: #ffffff/" .. command .. " [Felhasználónév]", thePlayer, 255, 0, 0, true)
		else
			local query = dbExec(abKapcsolat, "DELETE FROM mdcaccounts WHERE username=?",username)
			if query then
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffKitörölve!", thePlayer, 255, 0, 0, true)
			else
				outputChatBox("#7cc576[NLRP - MDC]: #ffffffMySQL Hiba [#002-es kód]", thePlayer, 255, 0, 0, true)
			    end
			end
		end
	end]]
end
addCommandHandler("deletemdcaccount", deleteMdcAccount)

--================================================--




--================================================--

function sendMessageToPolice(text, number)		for k, v in ipairs(getElementsByType("player")) do		if exports.nlrp_groups:isPlayerInGroup(v, 1) or exports.nlrp_groups:isPlayerInGroup(v, 16) then			outputChatBox("#7cc576" .. text .. "", v,255,255,255,true)		end	end
end
addEvent("sendMessageToPolice", true)
addEventHandler("sendMessageToPolice", getRootElement(), sendMessageToPolice)

function sendMessageToPoliceG(text, number)		for k, v in ipairs(getElementsByType("player")) do		if exports.nlrp_groups:isPlayerInGroup(v, 1) or exports.nlrp_groups:isPlayerInGroup(v, 16) then			outputChatBox("#7cc576" .. text .. "", v,255,255,255,true)		end	end
end
addEvent("sendMessageToPoliceG", true)
addEventHandler("sendMessageToPoliceG", getRootElement(), sendMessageToPoliceG)

function createBackupBlipServer(vehicle)
		for k, v in ipairs(getElementsByType("player")) do
			local count = getElementData(v, "groupCount")
			if count then
				for i=0, count-1 do
		--	local group = getElementData(v, "group_" .. i .. "")
		--		if group == 1 or group == 2 then
					triggerClientEvent(root, "createBackupBlipClient", root, vehicle)
			--					end
					end
				end
		end
end
addEvent("createBackupBlipServer", true)
addEventHandler("createBackupBlipServer", getRootElement(), createBackupBlipServer)

function destroyBlipServer(vehicle)
		for k, v in ipairs(getElementsByType("player")) do
			local count = getElementData(v, "groupCount")
			if count then
				for i=0, count-1 do
			local group = getElementData(v, "group_" .. i .. "")
				if group == 1 or group == 2 then
					triggerClientEvent(root, "destroyBlipClient", root, vehicle)
								end
						end
				end
		end
end
addEvent("destroyBlipServer", true)
addEventHandler("destroyBlipServer", getRootElement(), destroyBlipServer)

function createDutyBlipServer(vehicle)
		for k, v in ipairs(getElementsByType("player")) do
			local count = getElementData(v, "groupCount")
			if count then
				for i=0, count-1 do
			local group = getElementData(v, "group_" .. i .. "")
				if group == 2 or group == 16 then
					triggerClientEvent(root, "createDutyBlipClient", root, vehicle)
								end
						end
				end
		end
end
addEvent("createDutyBlipServer", true)
addEventHandler("createDutyBlipServer", getRootElement(), createDutyBlipServer)

function addTicket(charactername, price, jail, reason)
	 local insertSQL = dbExec(abKapcsolat, "INSERT INTO mdctickets SET targetname = ?, price = ?, jailtime =?, reason =?",charactername, price, jail, reason)
end
addEvent("addTicket", true)
addEventHandler("addTicket", getRootElement(), addTicket)

function deleteFromTickets(id)
	 local insertSQL = dbExec(abKapcsolat, "DELETE FROM mdctickets WHERE id=?",id)
end
addEvent("deleteFromTickets", true)
addEventHandler("deleteFromTickets", getRootElement(), deleteFromTickets)

function addWantedPerson(charactername, reason, description)
	 local insertSQL = dbExec(abKapcsolat, "INSERT INTO mdcwantedpersons SET charactername = ?, reason = ?, leiras = ?",charactername, reason, description)
end
addEvent("addWantedPerson", true)
addEventHandler("addWantedPerson", getRootElement(), addWantedPerson)

function deleteFromWantedPersons(id)
	 local insertSQL = dbExec(abKapcsolat, "DELETE FROM mdcwantedpersons WHERE id=?",id)
end
addEvent("deleteFromWantedPersons", true)
addEventHandler("deleteFromWantedPersons", getRootElement(), deleteFromWantedPersons)

function addWantedCar(modelname,numberplate,reason)
	 local insertSQL = dbExec(abKapcsolat, "INSERT INTO mdcwantedcars SET modelname = ?, numberplate = ?, reason = ?",modelname,numberplate,reason)
	 triggerEvent("getKorozottKocsik", root)
end
addEvent("addWantedCar", true)
addEventHandler("addWantedCar", getRootElement(), addWantedCar)

function deleteFromWantedCars(id)
	 local insertSQL = dbExec(abKapcsolat, "DELETE FROM mdcwantedcars WHERE id=?",id)
	 triggerEvent("getKorozottKocsik", root)
end
addEvent("deleteFromWantedCars", true)
addEventHandler("deleteFromWantedCars", getRootElement(), deleteFromWantedCars)

function getTicketsServer(playerSource)
	local tickets = {}
	tickets = {}
	local QueryEredmeny = dbPoll ( dbQuery( abKapcsolat, "SELECT * FROM mdctickets"), -1 )
	if (QueryEredmeny) then
		for k, v in ipairs(QueryEredmeny) do
			tickets[#tickets + 1] = {v["targetname"], v["price"], v["jailtime"], v["reason"], v["id"]}
		end
		triggerClientEvent(root, "getTicketsClient", root, tickets)
	end
end
addEvent("getTicketsServer", true)
addEventHandler("getTicketsServer", getRootElement(), getTicketsServer)

function getWantedCarsServer(playerSource)
	local wantedcars = {}
	wantedcars = {}
	local QueryEredmeny = dbPoll ( dbQuery( abKapcsolat, "SELECT * FROM mdcwantedcars"), -1 )
	if (QueryEredmeny) then
		for k, v in ipairs(QueryEredmeny) do
			wantedcars[#wantedcars + 1] = {v["modelname"], v["numberplate"], v["reason"], v["id"]}
		end
		triggerClientEvent(root, "getWantedCarsClient", root, wantedcars)
	end
end
addEvent("getWantedCarsServer", true)
addEventHandler("getWantedCarsServer", getRootElement(), getWantedCarsServer)

function getWantedPersonsServer(playerSource)
	local wantedpersons = {}
	wantedpersons = {}
	local QueryEredmeny = dbPoll ( dbQuery( abKapcsolat, "SELECT * FROM mdcwantedpersons"), -1 )
	if (QueryEredmeny) then
		for k, v in ipairs(QueryEredmeny) do
			wantedpersons[#wantedpersons + 1] = {v["charactername"], v["reason"], v["id"], v["leiras"]}
		end
		triggerClientEvent(root, "getWantedPersonsClient", root, wantedpersons)
	end
end
addEvent("getWantedPersonsServer", true)
addEventHandler("getWantedPersonsServer", getRootElement(), getWantedPersonsServer)

--[[Szirénapanel]]--
 
--[[CCTV]]--

