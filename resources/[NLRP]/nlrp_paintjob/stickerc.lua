local paintJob = {
	[562] = {
			{'*remapelegybody*', 'elegy1body256'},
			{'*remapelegybody*', 'elegy2body256'},
			{'*remapelegybody*', 'elegy3body256'},
			{'*remapelegybody*', 'elegy4body256'},
			{'*remapelegybody*', 'elegy5body256'},
	},
	[560] = {
			{'*remapelegybody128*', 'sultan1body256'},
			{'*remapelegybody128*', 'sultan2body256'},
			{'*remapelegybody128*', 'sultan3body256'},
			{'*remapelegybody128*', 'sultan4body256'},			
	},	
	[565] = {
			{'*remap_civic*', 'flash1body'},
			{'*remap_civic*', 'flash2body'},
			{'*remap_civic*', 'flash3body'},		
	},	
	[535] = {
			{'*@hite*', 'slamvan1'},
			{'*@hite*', 'slamvan2'},
			{'*@hite*', 'slamvan3'},		
			{'*@hite*', 'slamvan4'},		
	},	
	[598] = {
			{'*remap*', 'remap1rs6'},		
			{'*remap*', 'remap2rs6'},		
	},	
	[596] = {
			{'*remap_body*', 'e63pd1'},		
			{'*remap_body*', 'e63pd2'},		
	},	
	[558] = {
			{'*remapelegybody128*', 'uranus1'},
			{'*remapelegybody128*', 'uranus2'},
			{'*remapelegybody128*', 'uranus3'},		
			{'*remapelegybody128*', 'uranus4'},		
	},	
	[559] = {
			{'*remap_supra92*', 'jester1'},
			{'*remap_supra92*', 'jester2'},
			{'*remap_supra92*', 'jester3'},		
			{'*remap_supra92*', 'jester4'},		
	},	
	[561] = {
			{'*remap_volvo97*', 'stratum1'},
			{'*remap_volvo97*', 'stratum2'},
			{'*remap_volvo97*', 'stratum3'},		
			{'*remap_volvo97*', 'stratum4'},		
	},	
	[541] = {
			{'*remap_camaro70*', 'bullet1'},
			{'*remap_camaro70*', 'bullet2'},
			{'*remap_camaro70*', 'bullet3'},		
			{'*remap_camaro70*', 'bullet4'},		
	},	
	[451] = {
			{'*remap458ttbody*', 'turismo1'},
			{'*remap458ttbody*', 'turismo2'},
			{'*remap458ttbody*', 'turismo3'},		
			{'*remap458ttbody*', 'turismo4'},		
	},	
	[415] = {
			{'*remap_corvette*', 'cheetah1'},
			{'*remap_corvette*', 'cheetah2'},
			{'*remap_corvette*', 'cheetah3'},		
			{'*remap_corvette*', 'cheetah4'},		
	},
};


--setElementData(getPedOccupiedVehicle(localPlayer),"veh:uzemanyag",100)
--setElementData(getPedOccupiedVehicle(localPlayer),"veh:akkumulator",100)
local vehicleShader = {}
local vehicleTexture = {}
local vehicleElement = {}
local vehicleCurrentElementDataPaintjob = {}

function countPaintjobsInVeh(vehID)
	if paintJob[vehID] then
		return #paintJob[vehID]
	else
		return false
	end
end

function startSnowShader()
	if getVersion ().sortable < "1.1.0" then
		--outputChatBox( "Nem kompatibilis a shader." )
		return
	end

	for k,v in ipairs(getElementsByType("vehicle")) do
		vehicleCurrentElementDataPaintjob[v] = tonumber(getElementData(v,"tuning.paintjob") or 0)
		if vehicleCurrentElementDataPaintjob[v] > 0 then
			vehicleShader[v] = dxCreateShader ( "replace.fx" )
			vehicleTexture[v] = dxCreateTexture ( "paintjobs/"..paintJob[tonumber(getElementModel(v))][vehicleCurrentElementDataPaintjob[v]][2]..".png" )
			vehicleElement[v] = v
			
			dxSetShaderValue ( vehicleShader[v], "gPaintjobTexture", vehicleTexture[v] )
			engineApplyShaderToWorldTexture ( vehicleShader[v], tostring(paintJob[tonumber(getElementModel(v))][vehicleCurrentElementDataPaintjob[v]][1]),vehicleElement[v] )
		end
	end

end
addEventHandler( "onClientResourceStart", getResourceRootElement(),startSnowShader)

function changeSticker(vehicle, ujData)
	if ujData == 0 then
		engineRemoveShaderFromWorldTexture(vehicleShader[vehicle], paintJob[getElementModel(vehicle)][1][1], vehicle); 
	else
		for k,v in ipairs(getElementsByType("vehicle")) do
			if v == vehicle then
				vehicleCurrentElementDataPaintjob[v] = tonumber(getElementData(v,"tuning.paintjob") or 0)
				if vehicleCurrentElementDataPaintjob[v] > 0 then
					vehicleShader[v] = dxCreateShader ( "replace.fx" )
					vehicleTexture[v] = dxCreateTexture ( "paintjobs/"..paintJob[tonumber(getElementModel(v))][vehicleCurrentElementDataPaintjob[v]][2]..".png" )
					vehicleElement[v] = v
					
					dxSetShaderValue ( vehicleShader[v], "gPaintjobTexture", vehicleTexture[v] )
					engineApplyShaderToWorldTexture ( vehicleShader[v], tostring(paintJob[tonumber(getElementModel(v))][vehicleCurrentElementDataPaintjob[v]][1]),vehicleElement[v] )
				end
			end
		end	
	end
end
addEvent("changeSticker", true)
addEventHandler("changeSticker", getRootElement(), changeSticker)

addEventHandler("onClientElementDataChange", getRootElement(), function(dataName,regiData)
    if dataName == "tuning.paintjob" and getElementType(source) == "vehicle" then
       local ujData = tonumber(getElementData(source,"tuning.paintjob") or 0)
	   
	    if ujData == 0 then
			engineRemoveShaderFromWorldTexture(vehicleShader[source], paintJob[getElementModel(source)][regiData][1], source); 
		else
			vehicleShader[source] = dxCreateShader ( "replace.fx" )
			vehicleTexture[source] = dxCreateTexture ( "paintjobs/"..paintJob[tonumber(getElementModel(source))][ujData][2]..".png" )
			vehicleElement[source] = source
			
			dxSetShaderValue ( vehicleShader[source], "gPaintjobTexture", vehicleTexture[source] )
			engineApplyShaderToWorldTexture ( vehicleShader[source], tostring(paintJob[tonumber(getElementModel(source))][ujData][1]),vehicleElement[source] )
		end
    end
end)
