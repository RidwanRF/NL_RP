availablePaintJobs = {
	[497] = {
			{'*remap', 'textures/heli1.png'},				
			{'*remap', 'textures/heli2.png'},				
			{'*remap', 'textures/heli3.png'},				
			{'*remap', 'textures/heli4.png'},				
			{'*remap', 'textures/heli5.png'},				
			{'*remap', 'textures/heli6.png'},				
			{'*remap', 'textures/heli7.png'},				
	},
	
};

local shaders = {}
local elementShaders = {}
local textureCache = {}
local textureCount = {}
local textureSize = 768

function applyShader(texture, img, distance, element)
	if element then
		destroyShaderCache(element)
	end
	local this = #shaders + 1
	shaders[this] = {}
	shaders[this][1] = dxCreateShader("texturechanger.fx",0,distance,layered)
	if not textureCount[img] then
		textureCount[img] = 0
	end
	if textureCount[img] == 0 then
		textureCache[img] = dxCreateTexture(img)
	end
	textureCount[img] = textureCount[img] + 1
	shaders[this][2] = textureCache[img]
	shaders[this][3] = texture
	if element then
		if not elementShaders[element] then
			elementShaders[element] = {shaders[this], img}
		end
	end
	if shaders[this][1] and shaders[this][2] then
		dxSetShaderValue(shaders[this][1], "TEXTURE", shaders[this][2])
		engineApplyShaderToWorldTexture(shaders[this][1], texture, element)
	end
end

function destroyShaderCache(element)
	if elementShaders[element] then
		destroyElement(elementShaders[element][1][1])
		local old_img = elementShaders[element][2]
		textureCount[old_img] = textureCount[old_img] - 1
		if textureCount[old_img] == 0 then
			destroyElement(elementShaders[element][1][2])
		end
		elementShaders[element] = nil
	end
end
addEvent("destroyShaderCache", true)
addEventHandler("destroyShaderCache", root, destroyShaderCache)


addEventHandler("onClientResourceStart", resourceRoot, function()
	for k,v in ipairs(getElementsByType("vehicle", root, true)) do
		local pj = tonumber(getElementData(v, "tuning.paintjob")) or 0
		if pj > 0 then
			addVehiclePaintJob(v, getElementModel(v), pj)
		end
	end
end)

function getVehiclePaintJobs(model)
	if availablePaintJobs[model] then
		return #availablePaintJobs[model]
	else
		return 0
	end
end

function addVehiclePaintJob(veh, model, id)
	local pj = availablePaintJobs[model]
	if pj then
		local pj = pj[id]
		if pj then
			applyShader(pj[1], pj[2], 100, veh)
		end
	end
end
addEvent("addVehiclePaintJob", true)
addEventHandler("addVehiclePaintJob", root, addVehiclePaintJob)

addEventHandler("onClientElementDestroy", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		destroyShaderCache(source)
	end
end)

addEventHandler("onClientElementStreamIn", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		local pj = tonumber(getElementData(source, "tuning.paintjob")) or 0
		if pj > 0 then
			addVehiclePaintJob(source, getElementModel(source), pj)
		end
	end
end)

addEventHandler("onClientElementStreamOut", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		destroyShaderCache(source)
	end
end)

addCommandHandler("pj", function(cmd,id)
	if getElementData(localPlayer, "acc.adminLevel") > 7 then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then
			local id = tonumber(id) or 0
			local model = getElementModel(veh)
			if availablePaintJobs[model] and availablePaintJobs[model][id] then
				setElementData(veh, "tuning.paintjob", id)
				triggerServerEvent("addVehiclePaintJob", localPlayer, veh, model, id, true)
			end
		end
	end
end)

addEventHandler("onClientElementDataChange",root,
	function(data,old,new)
		if getElementType(source) == "vehicle" then
			if new then
				triggerServerEvent("addVehiclePaintJob", localPlayer, source, getElementModel(source), new, true)
			end
		end
	end
)