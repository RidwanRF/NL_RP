local connection = exports["nlrp_database"]:getConnection()







local hivasok = {}





function addPhone(playerSource)



	local phoneID = generatePhoneNumber()



	local checkID = dbPoll(dbQuery(connection, "SELECT * FROM phones"), -1)



	if (checkID) then



		for k, v in ipairs(checkID) do



			if (tonumber(v["number"]) == tonumber(phoneID)) then



				return addPhone(playerSource)



			end



		end



	end



	local insterT = dbQuery(connection, "INSERT INTO phones SET number = ?", phoneID)



	local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)



	if QueryEredmeny then



		exports.gear_item:giveItem(playerSource, 47, tonumber(phoneID), 1, 0)



	end



end







function generatePhoneNumber()



	return math.random(111111,999999)



end







function sendMessageToPD(playerSource, msg)

	if isTimer(callPdTimer) then

		outputChatBox("#F89406[Hívás] #ffffff Maximum 2 percenként értesítheted a rendőrséget!", playerSource,255,255,255,true)

		return

	end

	local pX, pY, pZ = getElementPosition(playerSource)



	local factionID = 1



	if not hivasok[factionID] then



		hivasok[factionID] = {}



	end



	outputChatBox("#F89406[Hívás] #ffffffSikeresen értesítetted a #2185d0Rendőrséget#ffffff.", playerSource,255,255,255,true)

	callPdTimer = setTimer( function() end,(60*1000)*2,1)



	hivasok[factionID][tonumber(#hivasok[factionID]) + 1] = {pX, pY, pZ, msg, true, playerSource}



	for k, v in ipairs(getElementsByType("player")) do



		if exports.nlrp_groups:isPlayerInGroup(v, factionID) then



			outputChatBox("#F89406[Riasztás] #ffffffHívás érkezett! Elfogadáshoz #22A7F0/accept pd " .. #hivasok[factionID], v,255,255,255,true)



		end



	end



end



addEvent("sendMessageToPD", true)



addEventHandler("sendMessageToPD", getRootElement(), sendMessageToPD)







function sendMessageToES(playerSource, msg)

	if isTimer(callEsTimer) then

		outputChatBox("#F89406[Hívás] #ffffff Maximum 2 percenként értesítheted a mentőket!", playerSource,255,255,255,true)

		return

	end



	local pX, pY, pZ = getElementPosition(playerSource)



	local factionID = 5



	if not hivasok[factionID] then



		hivasok[factionID] = {}



	end

	outputChatBox("#F89406[Hívás] #ffffffSikeresen értesítetted a #db2828Mentőket#ffffff.", playerSource,255,255,255,true)

	callEsTimer = setTimer( function() end,(60*1000)*2,1)



	hivasok[factionID][tonumber(#hivasok[factionID]) + 1] = {pX, pY, pZ, msg, true, playerSource}



	for k, v in ipairs(getElementsByType("player")) do



		if exports.nlrp_groups:isPlayerInGroup(v, factionID) then



			outputChatBox("#F89406[Riasztás] #ffffffHívás érkezett! Elfogadáshoz #22A7F0/accept omsz " .. #hivasok[factionID], v,255,255,255,true)



		end



	end



end



addEvent("sendMessageToES", true)



addEventHandler("sendMessageToES", getRootElement(), sendMessageToES)







function sendMessageToSERV(playerSource, msg)

	if isTimer(callSERVTimer) then

		outputChatBox("#F89406[Hívás] #ffffff Maximum 2 percenként értesítheted a szerelőket!", playerSource,255,255,255,true)

		return

	end



	local pX, pY, pZ = getElementPosition(playerSource)



	local factionID = 3



	if not hivasok[factionID] then



		hivasok[factionID] = {}



	end



	outputChatBox("#F89406[Hívás] #ffffffSikeresen értesítetted a #fbbd08Szerelőket#ffffff.", playerSource,255,255,255,true)

	callSERVTimer = setTimer( function() end,(60*1000)*2,1)



	hivasok[factionID][tonumber(#hivasok[factionID]) + 1] = {pX, pY, pZ, msg, true, playerSource}



	for k, v in ipairs(getElementsByType("player")) do



		if exports.nlrp_groups:isPlayerInGroup(v, factionID) then



			outputChatBox("#F89406[Riasztás] #ffffffHívás érkezett! Elfogadáshoz #22A7F0/accept fix " .. #hivasok[factionID], v,255,255,255,true)



		end



	end



end



addEvent("sendMessageToSERV", true)



addEventHandler("sendMessageToSERV", getRootElement(), sendMessageToSERV)







function chatToServer(playerSource, msg)



	if playerSource then







		local dimension = getElementDimension(playerSource)



		local interior = getElementInterior(playerSource)



		local shownto = 1



		local kieg = ""



		for key, nearbyPlayer in ipairs(getElementsByType( "player" )) do



			local dist = getElementDistance( playerSource, nearbyPlayer )







			if dist < 20 then



				local nearbyPlayerDimension = getElementDimension(nearbyPlayer)



				local nearbyPlayerInterior = getElementInterior(nearbyPlayer)







				if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then



					local logged = getElementData(nearbyPlayer, "loggedin")



					if not (isPedDead(nearbyPlayer)) and (logged) then



						local message2 = message



						local pveh = getPedOccupiedVehicle(playerSource)



						local jatekos = nearbyPlayer



						outputChatBox(getElementData(playerSource, "char:name") .. " mondja (Telefonba): #e7d9b0" .. msg.. "", jatekos, 255, 255, 255, true)







						shownto = shownto + 1



					end



				end



			end



		end



	end



end



addEvent("chatToServer", true)



addEventHandler("chatToServer", getRootElement(), chatToServer)







function sendMessageToTAXI(playerSource, msg)



	local pX, pY, pZ = getElementPosition(playerSource)



	local factionID = 3



	if not hivasok[factionID] then



		hivasok[factionID] = {}



	end



	hivasok[factionID][tonumber(#hivasok[factionID]) + 1] = {pX, pY, pZ, msg, true, playerSource}



	for k, v in ipairs(getElementsByType("player")) do



		if exports.nlrp_groups:isPlayerInGroup(v, factionID) then



			outputChatBox("#b7ff00[Riasztás] #ffffffHívás érkezett! Elfogadáshoz #22A7F0/accept " .. #hivasok[factionID], v,255,255,255,true)



		end



	end



end



addEvent("sendMessageToTAXI", true)



addEventHandler("sendMessageToTAXI", getRootElement(), sendMessageToTAXI)







function acceptCall(playerSource, cmd, fac, id)



	if (id) and (fac) then



		id = tonumber(id)

		if (fac == "pd") then

			factionID = 1

		elseif (fac == "omsz") then

			factionID = 5

		elseif (fac == "fix") then

			factionID = 3

		end



		if hivasok[factionID] then



			if hivasok[factionID][id] then



				if hivasok[factionID][id][5] then



					hivasok[factionID][id][5] = false



					triggerClientEvent(playerSource, "acceptCallInClient", playerSource, hivasok[factionID][id][1], hivasok[factionID][id][2], hivasok[factionID][id][3], playerSource)

					outputChatBox("#b7ff00 >> NextLevel:#ffffff Elfogadták a hívásod! Ne hagyd el a helyszínt!",hivasok[factionID][id][6],0,0,0,true)

					for k, v in ipairs(getElementsByType("player")) do



						if exports.nlrp_groups:isPlayerInGroup(v, factionID) then



							outputChatBox("#22A7F0" .. string.gsub(getPlayerName(playerSource), "_", " ") .. " #fffffffogadta a következő hívást: " .. id .. " ((Feladó: #22A7F0" .. string.gsub(getPlayerName(hivasok[factionID][id][6]), "_", " ") .. "#ffffff))",v,255,255,255,true)



						end



					end



				else



					outputChatBox("#D64541[Hiba] #ffffffEzt azt a hívást már fogadták!", playerSource,255,255,255,true)



				end



			else



				outputChatBox("#D64541[Hiba] #ffffffNincs ilyen hívás2!", playerSource,255,255,255,true)



			end



		else



			outputChatBox("#D64541[Hiba] #ffffffNincs ilyen hívás1!", playerSource,255,255,255,true)



		end



	else



		outputChatBox("#F89406[Help] #ffffff/" .. cmd .. " [pd/omsz/fix][HÍVÁSID]", playerSource,255,255,255,true)



	end



end



addCommandHandler("accept", acceptCall)







function getPhoneDataFromServer(playerSource, phoneID)



	if tonumber(phoneID) then



		local checkID = dbPoll(dbQuery(connection, "SELECT * FROM phones WHERE number = ?", tonumber(phoneID)), -1)



		if (checkID) then



			for k, v in ipairs(checkID) do



				setElementData(playerSource, "musicID", v["music"])



				triggerClientEvent(playerSource, "getPhoneDataToClient", playerSource, v["wallpaper"], v["music"], v["battery"])



			end



			--outputChatBox("Telefon adatai betöltve erre a telefonszámra: ".. phoneID)



		end



	end



end



addEvent("getPhoneDataFromServer", true)



addEventHandler("getPhoneDataFromServer", getRootElement(), getPhoneDataFromServer)











function getPhoneContactFromServer(playerSource, ownerPhone)



	local phoneContacts = {}



	phoneContacts = {}



	local QueryEredmeny = dbPoll ( dbQuery( connection, "SELECT * FROM contacts WHERE owner = ?", ownerPhone), -1 )



	if (QueryEredmeny) then



		for k, v in ipairs(QueryEredmeny) do

		--	outputChatBox(v["name"].." - "..v["number"])

			phoneContacts[#phoneContacts + 1] = {v["name"], tonumber(v["number"]), tonumber(v["id"])}

		end



		triggerClientEvent(playerSource, "getPhoneContactToClient", playerSource, phoneContacts)



	end



end



addEvent("getPhoneContactFromServer", true)

addEventHandler("getPhoneContactFromServer", getRootElement(), getPhoneContactFromServer)







function removeFromContactS(playerSource, row, id)



	if (dbExec(connection, "DELETE FROM contacts WHERE id = ?", id)) then



		triggerClientEvent(playerSource, "removeFromContactC", playerSource, row)



	end



end



addEvent("removeFromContactS", true)



addEventHandler("removeFromContactS", getRootElement(), removeFromContactS)







function editContactS(playerSource, number, name, ownerPhone, row, id)



	if (name) and (number) and (ownerPhone) then



		if dbExec(connection, "UPDATE contacts SET name = ?, number = ? WHERE id = ?",name, number, id) then



			triggerClientEvent(playerSource, "editContactC", playerSource, name, number, row, id)



		end



	end



end



addEvent("editContactS", true)



addEventHandler("editContactS", getRootElement(), editContactS)











function addContactMemberS(playerSource, number, name, ownerPhone)



	local query = dbQuery(connection, "INSERT INTO contacts SET name = ?, number = ?, owner = ?", name, number, ownerPhone)



	local QueryEredmeny,_,insertID = dbPoll(query, -1)



	if QueryEredmeny then



		triggerClientEvent(playerSource, "addContactMemberC", playerSource, name, number, insertID)

		getPhoneContactFromServer(playerSource, ownerPhone)



	end



end



addEvent("addContactMemberS", true)



addEventHandler("addContactMemberS", getRootElement(), addContactMemberS)







function getChatFromServer(playerSource, phoneID)



	local chatS = {}



	-- chatS = {}



	if (tonumber(phoneID)) then



		if (tonumber(phoneID) > 0) then



			--local checkID = dbPoll(dbQuery(connection, "SELECT * FROM chat WHERE owner = ?", tonumber(phoneID)), -1)



			--if (checkID) then



				--for k, v in ipairs(checkID) do



					--chatS[#chatS + 1] = {v["targetid"]}



				--end



			--end



		end



		triggerClientEvent(playerSource, "getChatToClient", playerSource, chatS)



	end



end



addEvent("getChatFromServer", true)



addEventHandler("getChatFromServer", getRootElement(), getChatFromServer)







function sendMessagesInServer(playerSource, fromID, toID, msg, when, date)



	if playerSource and fromID and toID and msg then



		if (checkNumber(toID)) then



			if insertChat(playerSource, fromID, toID) then -- lokál pléjer



				triggerClientEvent(playerSource, "insertClientChat", playerSource, toID)



			end



			if insertChat(playerSource, toID, fromID) then -- target pléjer



				local targetPlayer = checkOnline(toID)



				if targetPlayer then



					triggerClientEvent(targetPlayer, "insertClientChat", targetPlayer, fromID)



				end



			end



			insertMsg(fromID, toID, fromID, msg, date, when, toID) -- lokál pléjer



			insertMsg(fromID, toID, toID, msg, date, when, fromID) -- target pléjer



			triggerClientEvent(playerSource, "sendMessagesInClient", playerSource, fromID, toID, toID, msg, date, when, toID, fromID)



			local targetPlayer = checkOnline(toID)



			if (targetPlayer) then



				triggerClientEvent(targetPlayer, "sendMessagesInClient", targetPlayer, fromID, toID, fromID, msg, date, when, fromID, toID)



				exports.nlrp_chat:sendLocalDoAction(targetPlayer, " kapott egy SMS-t.")



				outputChatBox("#b7ff00[Telefon] #ffffffAz üzenetet sikeresen elküldtük!", playerSource,255,255,255,true)



			else



				outputChatBox("#d75959[Hiba]: #ffffffEz a szám jelenleg nem kapcsolható de az üzenetet továbítottuk!", playerSource,255,255,255,true)



			end



		else



			outputChatBox("#d75959[Hiba]: #ffffffNincs ilyen telefonszám!", playerSource,255,255,255,true)



		end



	end



end



addEvent("sendMessagesInServer", true)



addEventHandler("sendMessagesInServer", getRootElement(), sendMessagesInServer)







function editWallpaperInServer(playerSource, phoneID, wallPaperID)



	dbExec(connection, "UPDATE phones SET wallpaper = ? WHERE number = ?",wallPaperID, phoneID)



end



addEvent("editWallpaperInServer", true)



addEventHandler("editWallpaperInServer", getRootElement(), editWallpaperInServer)







function editRingInServer(playerSource, phoneID, musicID)



	if dbExec(connection, "UPDATE phones SET music = ? WHERE number = ?",musicID, phoneID) then



		--outputChatBox("Editelve a music erre: " .. musicID .. " ezen a telefonszámon: " .. phoneID)



	end



end



addEvent("editRingInServer", true)



addEventHandler("editRingInServer", getRootElement(), editRingInServer)







function checkOnline(phoneNumber)

    local checkID = dbPoll(dbQuery(connection, "SELECT * FROM phones"), -1)



    if (checkID) then



        for k, v in ipairs(checkID) do



            if (tonumber(v["number"]) == tonumber(phoneNumber)) then

                for k2, v2 in ipairs(getElementsByType("player")) do



                    if v2 and getElementData(v2, "acc.dbID") == v["owner"] then



                        return v2



                    end



                end



            end



        end



    end



	return false



end







function checkNumber(phoneNumber)



	local checkID = dbPoll(dbQuery(connection, "SELECT * FROM phones"), -1)



	if (checkID) then



		for k, v in ipairs(checkID) do



			if (tonumber(v["number"]) == tonumber(phoneNumber)) then



				return true



			end



		end



	end



	return false



end







function insertMsg(from, to, number, msg, date, when, fasz)



	local inster = dbExec(connection, "INSERT INTO messages SET msg = ?",toJSON({from, to, number, msg, date, when, fasz})) -- az sms küldőjének



	if insert then



		-- triggerClientEvent(play)



	end



end







function insertChat(playerSource, fromID, toID, phoneID)



	local checkID = dbPoll(dbQuery(connection, "SELECT * FROM chat"), -1)



	if (checkID) then



		for k, v in ipairs(checkID) do



			if (tonumber(v["owner"]) == tonumber(fromID)) then



				if (tonumber(toID) == tonumber(v["targetid"])) then



					return false



				end



			end



		end



		local insterT = dbQuery(connection, "INSERT INTO chat SET owner = ?, targetid = ?", fromID, toID)



		local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)



		if QueryEredmeny then



			return true



		end



	end



end







function callTargetInServer(playerSource, number, playerNumber)



	if number then



		targetPlayer = callMember(number)



		if getElementData(targetPlayer,"inCall") then

			outputChatBox("#d75959[Hiba]: #ffffffEz a szám már hívásban van!", playerSource,255,255,255,true)

			return

		end



		if targetPlayer ~= false and targetPlayer ~= "inCall" then



			triggerClientEvent(targetPlayer, "showMenu", targetPlayer, playerNumber, 6, playerSource, number)



			triggerClientEvent(playerSource, "showMenu", playerSource, number, 7, targetPlayer, playerNumber)



			triggerClientEvent(targetPlayer, "showSound", targetPlayer)



			exports.nlrp_chat:sendLocalDoAction(targetPlayer, " csörög a telefonja")



		elseif targetPlayer == "inCall" then



			outputChatBox("#d75959[Hiba]: #ffffffEz a szám már hívásban van!", playerSource,255,255,255,true)



		else



			outputChatBox("#d75959[Hiba]: #ffffffNem kapcsolható ez a szám!", playerSource,255,255,255,true)



		end



	end



end



addEvent("callTargetInServer", true)



addEventHandler("callTargetInServer", getRootElement(), callTargetInServer)







function sendCallMessages(playerSource, targetPlayerSource, msg, number)



	if (playerSource and targetPlayerSource and msg) then



		triggerClientEvent(playerSource, "insertMessages", playerSource, msg, 1, number)



		triggerClientEvent(targetPlayerSource, "insertMessages", targetPlayerSource, msg, 1, number)



	end



end



addEvent("sendCallMessages", true)



addEventHandler("sendCallMessages", getRootElement(), sendCallMessages)







function onClientCallAd(player, ad, ara, numberCall)



	local amout = math.ceil(ara)



	setElementData(player, "char:check", true)



	local money = getElementData(player,"char.Money")



	if(money<amout)then



		outputChatBox("#d75959[Hiba]: #ffffffNincs elég pénzed a hírdetéshez!", player, 255,0,0,true)



		return



	end



	setElementData(player,"char.Money",getElementData(player,"char.Money") - amout)



	for index , value in ipairs (getElementsByType("player")) do



		if (getElementData(value, "loggedin") and not getElementData(value, "char:check")) or player == value   then



			--outputChatBox ("#66ff66HIRDETÉS: #ffcc00" ..ad.. " ((" ..getPlayerName(player):gsub("_", " ") .. "))",value,0, 233, 58,true)

			outputChatBox ("#00fffcHírdetés: #C8C8C8" ..ad.. " ((" ..getPlayerName(player):gsub("_", " ") .. "))",root,0, 233, 58,true)



			outputChatBox ("#00fffcKapcsolat: #C8C8C8" .. numberCall,root,0, 233, 58,true)



		end



	end



end



addEvent("onClientCallForAdData", true )



addEventHandler("onClientCallForAdData", getRootElement(), onClientCallAd)



function onClientCallAd2(player, ad, ara, numberCall)



	local amout = math.ceil(ara)



	setElementData(player, "char:check", true)



	local money = getElementData(player,"char.Money")



	if(money<amout)then



		outputChatBox("#d75959[Hiba]: #ffffffNincs elég pénzed a hírdetéshez!", player, 255,0,0,true)



		return



	end



	setElementData(player,"char.Money",getElementData(player,"char.Money") - amout)



	for index , value in ipairs (getElementsByType("player")) do



		if (getElementData(value, "loggedin") and not getElementData(value, "char:check")) or player == value   then



			--outputChatBox ("#66ff66ILLEGÁL HIRDETÉS: #ffcc00" ..ad.. " ((" ..getPlayerName(player):gsub("_", " ") .. "))",value,0, 233, 58,true)

			outputChatBox ("#f54444DarkWeb: #C8C8C8" ..ad.. " ((" ..getPlayerName(player):gsub("_", " ") .. "))",root,0, 233, 58,true)



			outputChatBox ("#f54444Kapcsolat: #C8C8C8" .. numberCall,root,0, 233, 58,true)



		end



	end



end



addEvent("onClientCallForAdData2", true )



addEventHandler("onClientCallForAdData2", getRootElement(), onClientCallAd2)





addCommandHandler("toggleh",



	function(playerSource, cmd)



		if not ( getElementData(playerSource, "char:check")) then



			setElementData(playerSource, "char:check", true)



			outputChatBox("Letiltottad a hirdetéseket.", playerSource, 255, 255, 255, true)



		elseif (getElementData(playerSource, "char:check")) then



			setElementData(playerSource, "char:check", false)



			outputChatBox("Feloldottad a tiltást a hirdetéseket.",playerSource, 255, 255, 255, true)



		end



	end



)







function answerPhoneS(playerSource, targetPlayerSource, number)



	if tonumber(number) then



		if tonumber(number) == 1 then



			if playerSource then



				if targetPlayerSource then

					triggerClientEvent(playerSource, "answerPhone", playerSource, 1)



					triggerClientEvent(targetPlayerSource, "answerPhone", targetPlayerSource, 1)

										setElementData(playerSource, "callRoomNumber", nil)

										setElementData(targetPlayerSource, "callRoomNumber", nil)

										setElementData(playerSource, "isInPhoneCall", false)

										setElementData(targetPlayerSource, "isInPhoneCall", false)



				end



			end



		end



		if tonumber(number) == 2 then



			if playerSource then



				if targetPlayerSource then



					triggerClientEvent(playerSource, "answerPhone", playerSource, 2)



					triggerClientEvent(targetPlayerSource, "answerPhone", targetPlayerSource, 2)

					local roomNumber = math.random(1,9999999)

				--	outputChatBox(""..roomNumber)

					setElementData(playerSource, "callRoomNumber", roomNumber)

					setElementData(targetPlayerSource, "callRoomNumber", roomNumber)

					setElementData(playerSource, "isInPhoneCall", true)

					setElementData(targetPlayerSource, "isInPhoneCall", true)





					--setElementData(targetPlayerSource, "char:money", getElementData(targetPlayerSource, "char:money") - math.random(5, 10))



				end



			end



		end



	end



end



addEvent("answerPhoneS", true)



addEventHandler("answerPhoneS", getRootElement(), answerPhoneS)







function loadMessages(playerSource, phoneID)



	local messagesTable = {}



	messagesTable = {}



	--[[

	local QueryEredmeny = dbPoll ( dbQuery( connection, "SELECT * FROM messages"), -1 )



	if (QueryEredmeny) then



		for k, v in ipairs(QueryEredmeny) do



			tableData = fromJSON(v["msg"])



			if tonumber(tableData[3]) == tonumber(phoneID) then



				if not messagesTable[tonumber(tableData[7])] then



					messagesTable[tonumber(tableData[7])] = {}



				end



				messagesTable[tonumber(tableData[7])][#messagesTable[tonumber(tableData[7])] + 1] = {tableData[1], tableData[2], tableData[3], tableData[4], tableData[5], tableData[6]}



			end



		end



		--outputChatBox("Üzenetek betöltve erre a telefonszámra: ".. phoneID)



		triggerClientEvent(playerSource, "loadMessagesInClient", playerSource, messagesTable)



	end ]]--



end



addEvent("loadMessages", true)



addEventHandler("loadMessages", getRootElement(), loadMessages)





function callMember(number)

    local checkID = dbPoll(dbQuery(connection, "SELECT * FROM phones"), -1)



        if (checkID) then



            for k, v in ipairs(checkID) do



                if (tonumber(v["number"]) == tonumber(number)) then

                    for k2, v2 in ipairs(getElementsByType("player")) do



                        if v2 and getElementData(v2, "acc.dbID") == v["owner"] then

                            return v2

                        end



                    end



                end



            end



        end



    return false



end







function getElementDistance( a, b )



	if not isElement(a) or not isElement(b) or getElementDimension(a) ~= getElementDimension(b) then



		return math.huge



	else

	

		local x, y, z = getElementPosition( a )



		return getDistanceBetweenPoints3D( x, y, z, getElementPosition( b ) )



	end



end

