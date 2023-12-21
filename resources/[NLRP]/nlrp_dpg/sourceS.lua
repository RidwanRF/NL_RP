local resources = {

	"nlrp_anticheat",
	"nlrp_database",
	"nlrp_core",
}

addEventHandler("onResourceStart", getResourceRootElement(),
	function()
		for i = 1, #resources do
			local resName = resources[i]
			local res = getResourceFromName(resName)
			local start = startResource ( res )
		--[[	if res then
				setTimer(
					function()
						local meta = xmlLoadFile(":" .. resName .. "/meta.xml")
						if meta then
							local dpg = xmlFindChild(meta, "download_priority_group", 0)
							local download_priority_group = 0 - i
							if dpg then
								xmlNodeSetValue(dpg, tostring(download_priority_group))
							else
								dpg = xmlCreateChild(meta, "download_priority_group")
								xmlNodeSetValue(dpg, tostring(download_priority_group))
							end
							print(resName .. " download_priority_group changed to -> " .. tostring(download_priority_group))
							xmlSaveFile(meta)
							xmlUnloadFile(meta)
						end
					end,
				1000, 1)
			end --]]
		end
	end)