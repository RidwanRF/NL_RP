function clearAdminDatas ()
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v,"acc.adminLevel") > 0) then
			outputChatBox("#db2828[UCP] #FFFFFFLenullázták az adminisztrátori statisztikád.", v, 255,255,255,true)
		
		end
	end
end

function changePlayerName (playerID,newName)
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v,"acc.ID") == tonumber(playerID)) then
			outputChatBox("#db2828[UCP] #FFFFFFElfogadták a név változtatási kérelmedet.", v, 255,255,255,true)
			setPlayerName(v, newName)
			setPlayerNametagText(v, newName)
			setElementData(v, "visibleName", newName)
			setElementData(v, "char.Name", newName)
		end
	end
end