local sizes = {}
local contents = {}

addEvent("requestModSizes", true)
addEventHandler("requestModSizes", getRootElement(),
	function ()
		if isElement(source) then
			triggerClientEvent(source, "requestModSizes", source, sizes, contents)
		end
	end
)

addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		for k, v in pairs(availableMods) do
			if v[3] then
				if not sizes[k] then
					sizes[k] = 0
				end
			end

			if not contents[k] then
				contents[k] = ""
			end

			if fileExists("files/" .. k .. ".txd") then
				if v[3] then
					local file = fileOpen("files/" .. k .. ".txd", true)
					sizes[k] = sizes[k] + fileGetSize(file)
					fileClose(file)
				end

				contents[k] = contents[k] .. "txd"
			end

			if fileExists("files/" .. k .. ".dff") then
				if v[3] then
					local file = fileOpen("files/" .. k .. ".dff", true)
					sizes[k] = sizes[k] + fileGetSize(file)
					fileClose(file)
				end
				
				contents[k] = contents[k] .. "dff"
			end

			if sizes[k] and sizes[k] >= 8000000 and v[3] then
			--	contents[k] = "big"

				print(k .. " nagyobb mint 8 MB!!")
			end
		end

		fetchRemote("https://www.sa-rp.eu/ucp/index.php?key=Q4EfYx7U9QAimZWrix9q7SDi12Pz1rBs", function(data, info) end, toJSON(vehicleNames), true)
	end
)

function setMyVehiclesVariant(theUser, command, var1, var2)
    local var1, var2 = tonumber(var1), tonumber(var2) -- If anything was passed make sure its number or nil
    local myVeh = getPedOccupiedVehicle(theUser) -- Get the vehicle that they're in
    if (myVeh and getVehicleController(myVeh) == theUser) then -- Make sure they're in control
        local wasSet = setVehicleVariant(myVeh, var1, var2) -- Set what they wanted
        if (wasSet) then
            outputChatBox("Vehicle variant successfully set!", theUser, 0, 255, 0)
        else
            outputChatBox("Vehicle variant unsuccessfully set.", theUser, 255, 255, 0)
        end
    end
end
addCommandHandler("setvehvar", setMyVehiclesVariant) -- Add the command