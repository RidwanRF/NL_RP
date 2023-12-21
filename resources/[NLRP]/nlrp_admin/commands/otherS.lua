local places = {
	["ls"] = {1484.7469482422, -1740.1397705078, 13.546875, 180},
	["deli"] = {1933.1015625, -1744.0854492188, 13.546875, 180},
	["eszaki"] = {1005.5318603516, -951.64923095703, 42.192859649658, 0},
	["alsohatar"] = {85.606513977051, -1519.0068359375, 4.8448534011841, 180},
	["felsohatar"] = {-54.145683288574, -1386.3479003906, 11.854888916016, 309},
	["ur"] = {572.81579589844, -1432.7233886719, 70336.34375, 0},
	["nav"] = {-2274.19921875, -197.67405700684, 35.3203125, 0},
	["autoker"] = {1953.7609863281, -2101.2587890625, 13.546875, 270},
	["sf"] = {-2016.0750732422, -77.725944519043, 35.3203125, 0},
}

addAdminCommand("gotoplace", 1, "Elteleportálás az adott helyre")
addCommandHandler("gotoplace", function(sourcePlayer, commandName, place)
    if havePermission(sourcePlayer, commandName, true) then
        if not place then
            outputUsageText(commandName, "[Hely]", sourcePlayer)
            outputInfoText("Elérhető helyek:", sourcePlayer)

			local availablePlaces = {}

			for k, v in pairs(places) do
				table.insert(availablePlaces, k)
			end

			outputInfoText(table.concat(availablePlaces, ", "), sourcePlayer)
        else

        	if places[place] then
        		local data = places[place]

        		setElementPosition(sourcePlayer, data[1], data[2], data[3])
				setElementDimension(sourcePlayer, 0)
				setElementInterior(sourcePlayer, 0)

				outputInfoText("Elteleportáltál a következő helyre: #32b3ef" .. place, sourcePlayer)
        	else
        		outputErrorText("A kiválasztott hely nem létezik.", sourcePlayer)
        	end
        end
    end
end)

addAdminCommand("asay", 1, "Admin felhívás a játékosok felé")
addCommandHandler("asay", function(sourcePlayer, commandName, ...)
    if havePermission(sourcePlayer, commandName, true) then
        if not (...) then
            outputUsageText(commandName, "[Üzenet]", sourcePlayer)
        else
            local text = table.concat({...}, " ")

            local adminNick = getPlayerAdminNick(sourcePlayer)
            local adminlevel = getElementData(sourcePlayer, "acc.adminLevel") or 0
			local adminrank = exports.nlrp_core:getPlayerAdminTitle(sourcePlayer)
			local rankcolor = exports.nlrp_core:getAdminLevelColor(adminlevel)

			outputInfoText(rankcolor .. adminrank .. " " .. adminNick .. " #fffffffelhívása: ".. rankcolor .. text, root)
			exports.nlrp_hud:showAlert(root, "info", getPlayerAdminNick(sourcePlayer) .. "#FFFFFF Felhívás : ".. text)
			exports.nlrp_logs:toLog("adminaction", adminNick .. " admin felhívása: " .. text)
        end
    end
end)

addAdminCommand("vanish", 1, "Láthatatlanná/Láthatóvá válás")
addCommandHandler("vanish", function(sourcePlayer, commandName)
    if havePermission(sourcePlayer, commandName, true) then
        local invisible = getElementData(sourcePlayer, "invisible")

        if invisible then
            setElementAlpha(sourcePlayer, 255)

            outputInfoText("Látható lettél.", sourcePlayer)

            triggerClientEvent(sourcePlayer, "playClientSound", sourcePlayer, ":nlrp_assets/audio/admin/restore.ogg")
        else
            setElementAlpha(sourcePlayer, 0)

            outputInfoText("Láthatatlan lettél.", sourcePlayer)

            triggerClientEvent(sourcePlayer, "playClientSound", sourcePlayer, ":nlrp_assets/audio/admin/minimize.ogg")
        end

        setElementData(sourcePlayer, "invisible", not invisible)
    end
end)

addAdminCommand("asduty", -2, "Adminsegéd szolgálat be -és kikapcsolása")
addCommandHandler("asduty", function(sourcePlayer, commandName)
	if havePermission(sourcePlayer, commandName, false, 2) then
		local currentState = getElementData(sourcePlayer, "helperDuty")

		if not currentState then
			setElementData(sourcePlayer, "helperDuty", true)

			outputInfoText("Adminsegéd szolgálatba léptél.", sourcePlayer)
		else
			setElementData(sourcePlayer, "helperDuty", false)

			outputInfoText("Kiléptél az adminsegéd szolgálatból.", sourcePlayer)
		end
	end
end)

addAdminCommand("aduty", 1, "Adminsegéd szolgálat be -és kikapcsolása")
addCommandHandler("aduty", function(sourcePlayer, commandName)
	if havePermission(sourcePlayer, commandName) then
		local currentState = getElementData(sourcePlayer, "adminDuty")

		if not currentState then
			setElementData(sourcePlayer, "adminDuty", true)
			setElementData(sourcePlayer, "visibleName", getPlayerAdminNick(sourcePlayer))
			setElementData(sourcePlayer, "invulnerable", true)
			if (getElementData(sourcePlayer,"acc.adminLevel") < 6) then
				setElementData(sourcePlayer,"adutyBackTimer", true)
				setTimer(function()
					setElementData(sourcePlayer,"adutyBackTimer", false)
				end,1000*60*5,1)
			end
			exports.nlrp_hud:showAlert(root, "aduty", getPlayerAdminNick(sourcePlayer) .. " adminszolgálatba lépett.")
		else
			if getElementData(sourcePlayer, "adutyBackTimer") == false then
				setElementData(sourcePlayer, "adminDuty", false)
				setElementData(sourcePlayer, "visibleName", getPlayerCharacterName(sourcePlayer))
				setElementData(sourcePlayer, "invulnerable", false)

				exports.nlrp_hud:showAlert(root, "aduty", getPlayerAdminNick(sourcePlayer) .. " kilépett az adminszolgálatból.")
			else
				outputChatBox("#db2828[ADMIN]#FFFFFF Sajnáljuk 5 percig minimum dutyban kell lenned.",sourcePlayer,255,255,255,true)
			end
		end
	end
end)

addAdminCommand("adutyba", 7, "Admin adminbabarakása")
addCommandHandler("adutyba", function(sourcePlayer, commandName, targetPlayer)
	if havePermission(sourcePlayer, commandName) then
		if not (targetPlayer ) then
			outputUsageText(commandName, "[Játékos név / ID]", sourcePlayer)
		else
			targetPlayer = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)
			local currentState = getElementData(targetPlayer, "adminDuty")
			if not currentState then
				if (getElementData(targetPlayer,"acc.adminLevel") > 0) then
					outputChatBox("#db2828[ADMIN]#FFFFFF "..getPlayerAdminNick(sourcePlayer).." adminszolgálatba rakott téged. 30 másodperced van befejezni az IC tevékenységedet.",targetPlayer,255,255,255,true)
					setTimer(function()
						setElementData(targetPlayer, "adminDuty", true)
						setElementData(targetPlayer, "visibleName", getPlayerAdminNick(targetPlayer))
						setElementData(targetPlayer, "invulnerable", true)
						if (getElementData(targetPlayer,"acc.adminLevel") < 7) then
							setElementData(targetPlayer,"adutyBackTimer", true)
							setTimer(function()
								setElementData(targetPlayer,"adutyBackTimer", false)
							end,1000*60*5,1)
						end
						
						outputChatBox("#db2828[ADMIN]#FFFFFF "..getPlayerAdminNick(sourcePlayer).." adminszolgálatba rakott téged.",targetPlayer,255,255,255,true)
				
						exports.nlrp_hud:showAlert(root, "aduty", getPlayerAdminNick(targetPlayer) .. " adminszolgálatba lépett.")
					end,30000,1)
				end
			else
				outputChatBox("#db2828[ADMIN]#FFFFFF Jelenleg adminszolgálatban van a kiválaszott admin.",sourcePlayer,255,255,255,true)
			end
		end
	end
end)

addAdminCommand("createnpc", 7, "NPC lerakása")
addCommandHandler("createnpc", function(sourcePlayer, commandName, skin, pedtype, subtype, ...)
    if havePermission(sourcePlayer, commandName, true) then
    	skin = tonumber(skin)
    	pedtype = tonumber(pedtype)
    	subtype = tonumber(subtype)
		print(sourcePlayer, commandName, skin, pedtype, subtype, ...)
    	if not (skin and pedtype and subtype and (...) and pedtype ) then
    		outputUsageText(commandName, "[Skin ID] [Típus] [Altípus] [Név]", sourcePlayer)

    		for k, v in pairs(exports.nlrp_npcs:getNPCTypes()) do
				outputInfoText(k .. ": " .. v, sourcePlayer)
			end
    	else
    		skin = math.floor(skin)
    		pedtype = math.floor(pedtype)
    		subtype = math.floor(subtype)

    		local name = table.concat({...}, " ")

    		local x, y, z = getElementPosition(sourcePlayer)
			local rx, ry, rz = getElementRotation(sourcePlayer)
			local interior = getElementInterior(sourcePlayer)
			local dimension = getElementDimension(sourcePlayer)

			if exports.nlrp_npcs:createNPC({x, y, z, rz, interior, dimension}, skin, name, pedtype, subtype) then
				outputInfoText("Sikeresen leraktál egy #32b3ef" .. exports.nlrp_npcs:getNPCTypeName(pedtype) .. " #fffffftípusú NPC-t.", sourcePlayer)
			end
    	end
    end
end)

addAdminCommand("deletenpc", 6, "NPC törlése")
addCommandHandler("deletenpc", function(sourcePlayer, commandName, id)
    if havePermission(sourcePlayer, commandName, true) then
    	id = tonumber(id)

        if not id then
            outputUsageText(commandName, "[NPC ID]", sourcePlayer)
        else
        	id = math.floor(id)

            if exports.nlrp_npcs:deleteNPC(id) then
				outputInfoText("Sikeresen kitörölted a(z) #32b3ef# " .. id .. " #ffffffazonosítóval rendelkező NPC-t.", sourcePlayer)
			else
				outputErrorText("Nem sikerült kitörölni az NPC-t!", sourcePlayer)
			end
        end
    end
end)

addAdminCommand("createatm", 6, "ATM létrehozása")
addCommandHandler("createatm", function(sourcePlayer, commandName)
    if havePermission(sourcePlayer, commandName, true) then
        local x, y, z = getElementPosition(sourcePlayer)
		local rx, ry, rz = getElementRotation(sourcePlayer)
		local interior = getElementInterior(sourcePlayer)
		local dimension = getElementDimension(sourcePlayer)

		if exports.nlrp_bank:createATM({x, y, z, rz, interior, dimension}) then
			outputInfoText("Sikeresen leraktál egy ATM-et.", sourcePlayer)
		end
    end
end)

addAdminCommand("deleteatm", 6, "ATM törlése")
addCommandHandler("deleteatm", function(sourcePlayer, commandName, id)
    if havePermission(sourcePlayer, commandName, true) then
    	id = tonumber(id)

        if not id then
            outputUsageText(commandName, "[ATM ID]", sourcePlayer)
        else
            if exports.nlrp_bank:deleteATM(id) then
				outputInfoText("Sikeresen kitörölted a(z) #32b3ef #" .. id .. " #ffffffazonosítóval rendelkező ATM-et.", sourcePlayer)
			else
				outputErrorText("Nem sikerült kitörölni az ATM-et!", sourcePlayer)
			end
        end
    end
end)