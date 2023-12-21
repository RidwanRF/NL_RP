function addVehiclePaintJob(veh, model, id)
	if id or 0 > 0 then
		triggerClientEvent(root, "addVehiclePaintJob", source, veh, model, id)
	else
		triggerClientEvent(root, "destroyShaderCache", source, veh)
	end
end
addEvent("addVehiclePaintJob", true)
addEventHandler("addVehiclePaintJob", root, addVehiclePaintJob)