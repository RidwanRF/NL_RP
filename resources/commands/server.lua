addCommandHandler("servercmds", function(thePlayer, cmd, resource)
	local resource = getResourceFromName(resource)
	if not resource then
		outputChatBox("Nem található ilyen névvel resource!", thePlayer, 255, 255, 255)
		return
	end

	local commands = getCommandHandlers(resource)

	if #commands == 0 then
		outputChatBox("Nincs egy szerver oldali parancs se a resource-ben!", thePlayer, 255, 255, 255)
		return
	end

	outputChatBox("Szerver oldali parancsok a resource-ben: ", thePlayer, 255, 255, 255)

	for _, command in pairs(commands) do
		outputChatBox(command, thePlayer, 0, 170, 255)
	end
end)