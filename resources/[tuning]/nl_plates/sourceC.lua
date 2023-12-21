local lastTick = getTickCount()
local s = {guiGetScreenSize()}

local plates = {}
local fonts = {}
fonts["licenseplate_40"] = dxCreateFont("fonts/font.ttf",40)

local RAW_SHADER = [[
    texture platetex;
    technique TexReplace {
        pass P0 {
            Texture[0] = platetex;
        }
    }
]]

--[[
local plateDistance = 23
addEventHandler("onClientRender",root,
    function()
    	--if not getElementData(localPlayer,"reach->settings->showInterface") then return end
        if getElementData(localPlayer,"settings_plates") == 1 then
            for k,v in ipairs(getElementsByType("vehicle")) do
                local x,y,z = getElementPosition(v)
                local px,py,pz = getElementPosition(localPlayer)
                if getDistanceBetweenPoints3D(x,y,z,px,py,pz) < plateDistance then
                    if isElementStreamedIn(v) then
                        local sx,sy = getScreenFromWorldPosition(x,y,z+1.6,0.06,false) 
                        if sx and sy then
                            if isLineOfSightClear(px,py,pz,x,y,z,true,false,true,false,true,true,false) then
                                if v ~= getPedOccupiedVehicle(localPlayer) then
                                	local size = {120,60}

                                	local plateStyle = getElementData(v,"reach->vehicles->plateStyle") or 1

                                    local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
                                    local scale = 0.9-(distance/plateDistance)*0.5
                                    local alphaScale = 255-(distance/plateDistance)*1
                                    local plateText = getElementData(v,"reach->vehicles->plate") or "REACHMTA"
                                    core:dxDrawBorder(sx-(size[1]*scale)/2,sy-(size[2]*scale)/2,size[1]*scale,size[2]*scale,1.5,tocolor(40,40,40,255*alphaScale))
                                    dxDrawImage(sx-(size[1]*scale)/2,sy-(size[2]*scale)/2,size[1]*scale,size[2]*scale,"textures/" .. plateStyle .. ".png",0,0,0,tocolor(222,222,222,255*alphaScale))
                                    dxDrawText(plateText,sx,sy+(16*scale)/2,nil,nil,tocolor(designs[plateStyle].text[1],designs[plateStyle].text[2],designs[plateStyle].text[3],255*alphaScale),1*scale,fonts["licenseplate_16"],"center","center",false,false,false,true)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
) ]]--

function addCustomPlate(vehicle)
	if isElement(vehicle) then
		if isElementStreamedIn(vehicle) then
			if not plates[vehicle] then
				plates[vehicle] = {}

				local plateStyle = getElementData(vehicle,"danihe->vehicles->plateStyle") or 1
				plates[vehicle].background_texture = dxCreateTexture("textures/" .. plateStyle .. ".png")

				plates[vehicle].render_target = dxCreateRenderTarget(350,60,true)

				local plate_text = getElementData(vehicle,"danihe->vehicles->plate") or "DANIHE"
				dxSetRenderTarget(plates[vehicle].render_target)
					dxDrawRectangle(0,0,350,60,tocolor(designs[plateStyle].background[1],designs[plateStyle].background[2],designs[plateStyle].background[3],255))
					dxDrawText(plate_text,350/2,70/2,nil,nil,tocolor(designs[plateStyle].text[1],designs[plateStyle].text[2],designs[plateStyle].text[3],255),1,fonts["licenseplate_40"],"center","center",false,false,false,true)
				dxSetRenderTarget()

				if plates[vehicle].background_texture then
					plates[vehicle].shader_bg = dxCreateShader(RAW_SHADER)
					dxSetShaderValue(plates[vehicle].shader_bg,"platetex",plates[vehicle].background_texture)
					engineApplyShaderToWorldTexture(plates[vehicle].shader_bg, "plateback*",vehicle)
				end

				if plates[vehicle].render_target then
					plates[vehicle].shader = dxCreateShader(RAW_SHADER)
					dxSetShaderValue(plates[vehicle].shader,"platetex",plates[vehicle].render_target)
					engineApplyShaderToWorldTexture(plates[vehicle].shader,"custom_car_plate",vehicle)
				end
			end
		end
	end
end

addEventHandler("onClientRender",root,
	function()
		if getElementData(localPlayer,"loggedIn") then
			for k,vehicle in pairs(plates) do
				if not vehicle.render_target then
					removeCustomPlate(k)
					addCustomPlate(k)
				end
			end
		end
	end
)

addEventHandler("onClientElementDataChange",root,
	function(data)
		if getElementType(source) == "vehicle" and isElementStreamedIn(source) then
			if data == "danihe->vehicles->plate" or data == "danihe->vehicles->plateStyle" then
				removeCustomPlate(source)
				addCustomPlate(source)
			end
		end
	end
)

function removeCustomPlate(vehicle)
	if isElement(vehicle) then
		if plates[vehicle] then
			destroyElement(plates[vehicle].shader)

			plates[vehicle] = nil
		end
	end
end

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		for _,vehicle in ipairs(getElementsByType("vehicle")) do
			if isElementStreamedIn(vehicle) then
				addCustomPlate(vehicle)
			end
		end
	end
)

addEventHandler("onClientElementStreamIn",root,
	function()
		if getElementType(source) == "vehicle" then
			addCustomPlate(source)
		end
	end
)

addEventHandler("onClientElementStreamOut",root,
	function()
		if getElementType(source) == "vehicle" then
			removeCustomPlate(source)
		end
	end
)

addEventHandler("onClientElementDestroy",root,
	function()
		if getElementType(source) == "vehicle" then
			removeCustomPlate(source)
		end
	end
)

addEventHandler("onClientRestore",root,
	function()
		for _,vehicle in ipairs(getElementsByType("vehicle")) do
			if isElementStreamedIn(vehicle) then
				removeCustomPlate(source)
				addCustomPlate(vehicle)
			end
		end
	end
)