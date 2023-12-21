

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		for path,data in pairs(availableMods) do
			path = "files/" .. path
			if fileExists(path .. ".txd") then
				engineImportTXD( engineLoadTXD(path .. ".txd"),data[1])
			end
			if fileExists(path .. ".dff") then
				engineReplaceModel( engineLoadDFF(path .. ".dff",0),data[1])
			end
		end
	end
)