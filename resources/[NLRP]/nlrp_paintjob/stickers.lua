 addCommandHandler('apaintjob',
 function(player, cmd, id)
		 local vehicle = getPedOccupiedVehicle(player)
		
		 if (vehicle) then
				 setElementData(vehicle, 'tuning.paintjob', tonumber(id), true)
		 else
				 outputChatbox("Nem vagy járműben!")
		 end
 end)
-- )addCommandHandler('col',
        -- function(player, cmd, id)
                -- local vehicle = getPedOccupiedVehicle(player)
                
                -- if (vehicle) then
                        -- setVehicleColor(vehicle,255,255,255)
                -- else
                        -- outputChatbox("Nem vagy járműben!")
                -- end
        -- end
-- )

addEventHandler("onElementDataChange", root, function(dataName,regiData)
    if dataName == "tuning.paintjob" and getElementType(source) == "vehicle" then
		local ujData = tonumber(getElementData(source,"tuning.paintjob") or 0)
	   
	    if ujData == 0 then
			triggerClientEvent(source, "changeSticker", source, source, 0)
		else
		--	outputChatBox("OK1")
			triggerClientEvent(source, "changeSticker", source, source, ujData)		
		end
    end
end)