function government(thePlayer, commandName, ...)
	local faction = false
	
	local mess = "felhívás"
	if exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 1) then
		faction = "Országos Rendőr-főkapitányság"
		color = "#446CB3"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 5) then
		faction = "Országos Mentőszolgálat"
		color = "#F89406"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 28) then
		faction = "Nemzeti Adó- és Vámhivatal"
		color = "#D35400"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 2) then
		faction = "Terror Elhárítási Központ"
		color = "#446CB3"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 19) then
		faction = "Nemzeti Nyomozó Iroda"
		color = "#446CB3"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 3) then
		faction = "Autómentők"
		color = "#00ced1"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 9) then
		faction = "Carter's Autókereskedés"
		color = "#00ced1"
		mess = "közlemény"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 12) then
		faction = "Next Events"
		color = "#b7ff00"
	elseif exports["nlrp_groups"]:isPlayerInGroup(thePlayer, 4) then
		faction = "Önkormányzat"
		color = "#ffcc00"
		mess = "közlemény"
	end
	
	if (faction) then
		if not (...) then
			outputChatBox("#00aeefHasználat:#ffffff /" .. commandName .. " [Üzenet]", thePlayer, 255, 255, 255, true)
		else
			
			local msg = table.concat({...}," ")
			if (msg) then
				outputChatBox(" ", root, 255, 255, 255, true)
				outputChatBox(color .. "[" .. faction .. " " .. mess .. "]:#ffffff " .. msg, root, 255, 255, 255, true)
				exports.nlrp_core:sendMessageToAdmins("#00aeef" .. getPlayerName(thePlayer) .. "#ffffff használta a #0094ff/" .. commandName .. "#ffffff parancsot.")
				triggerClientEvent(root, "playGovSound", root)
			end
		end
	end
end
addCommandHandler("gov", government, false, false)