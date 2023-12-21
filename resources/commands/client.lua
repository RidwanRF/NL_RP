addCommandHandler("clientcmds", function(cmd, resource)
	local resource = getResourceFromName(resource)
	if not resource then
		outputChatBox("Nem található ilyen névvel resource!", 255, 255, 255)
		return
	end

	local commands = getCommandHandlers(resource)

	if #commands == 0 then
		outputChatBox("Nincs egy kliens oldali parancs se a resource-ben!", 255, 255, 255)
		return
	end

	outputChatBox("Kliens oldali parancsok a resource-ben: ", 255, 255, 255)

	for _, command in pairs(commands) do
		outputChatBox(command, 0, 170, 255)
	end
end)