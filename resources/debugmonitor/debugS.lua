addEventHandler("onDebugMessage", root, function(dbMsg, dbLevel, dbFile, dbLine)
	triggerClientEvent(root, "debug->Add", root, dbMsg or "", dbLevel or 0, dbFile or 0, dbLine or 0)
end)

addEventHandler("onPlayerCommand", root, function(commandName)
	if commandName == "debugscript" then
		if getElementData(source, "acc.adminLevel") >= 8 then
			triggerClientEvent(source, "debug->ChangeState", source)
		end
		cancelEvent()
	end
end)