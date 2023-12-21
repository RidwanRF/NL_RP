local theKey = "x2Yy#v,&[2yegYu[m"

addEvent("requestDecodeKey", true)
addEventHandler("requestDecodeKey", getRootElement(),
	function (player)
		if isElement(source) and player then
			if client == source and source == player then
				triggerClientEvent(source, "decodeAndLoadModels", source, theKey)
			end
		end
	end
)

exports.sarp_admin:addAdminCommand("vehiclecompiler", 9, "Modell(ek) lekódolása")
addCommandHandler("vehiclecompiler",
	function (player, cmd, ...)
		if getElementData(player, "acc.adminLevel") >= 9 then
			local names = {...}

			if string.len(#names) > 0 then
				for k, v in pairs(names) do
					local data = ""

					if fileExists("server_files/" .. v .. ".txd") then
						local file = fileOpen("server_files/" .. v .. ".txd", true)
						local size = fileGetSize(file)
						local bytes = fileRead(file, size)
						fileClose(file)

						data = data .. "isTxd" .. teaEncode(base64Encode(bytes), theKey) .. ";"
					end

					if fileExists("server_files/" .. v .. ".dff") then
						local file = fileOpen("server_files/" .. v .. ".dff", true)
						local size = fileGetSize(file)
						local bytes = fileRead(file, size)
						fileClose(file)

						data = data .. "isDff" .. teaEncode(base64Encode(bytes), theKey) .. ";"
					end

					if fileExists("files/" .. v .. ".heal") then
						fileDelete("files/" .. v .. ".heal")
					end

					local file = fileCreate("files/" .. v .. ".heal")
					fileWrite(file, data)
					fileClose(file)

					outputDebugString("[encode]: 'files/" .. v .. ".heal' created.")
				end
			else
				outputChatBox("#ff4646>> Használat: #ffffff/" .. cmd .. " [modell nevek, szóközzel elválasztva ha egyszerre többet akarsz]", 255, 255, 255, true)
			end
		end
	end
)