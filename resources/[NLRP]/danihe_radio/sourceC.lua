


local lastTick = getTickCount()
local s = {guiGetScreenSize()}

local radio_def_min_distance = 5
local radio_def_max_distance = 12

local fonts = {}
fonts["default_9"] = dxCreateFont(":nle_tuning/fonts/roboto.ttf",9)
fonts["default_10"] = dxCreateFont(":nle_tuning/fonts/roboto.ttf",10)
fonts["default_11"] = dxCreateFont(":nle_tuning/fonts/roboto.ttf",11)

fonts["default_bold_10"] = dxCreateFont(":nle_tuning/fonts/roboto_bold.ttf",10)
fonts["fontawsome_10"] = dxCreateFont(":nle_tuning/fonts/fontawesome.otf",10)
fonts["fontawsome_11"] = dxCreateFont(":nle_tuning/fonts/fontawesome.otf",11)

local size = {440,260}
local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
local radio_state = false
local max_channel = 7
local scroll = 0
local radio_browser = false
local browser_line_y = 20.83333333333333

local textures = {}

local vehicle_radio = {}

addEventHandler("onClientRender",root,
	function()
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if radio_state and vehicle then
			local channel = getElementData(vehicle,"danihe->radio->channel") or 1
			local volume = getElementData(vehicle,"danihe->radio->volume") or 100

			dxDrawCircleRectangle(pos[1],pos[2],size[1],size[2],tocolor(15,15,15,255),10)

			dxDrawCircleRectangle(pos[1]+10,pos[2]+10,size[1]-20,size[2]-40,tocolor(20,20,20,255),10)
			dxDrawCircleRectangle(pos[1]+10+4,pos[2]+10+4,size[1]-20-8,size[2]-40-8,tocolor(30,30,30,255),3)

			dxDrawRectangle(pos[1]+10+6,pos[2]+10+6,size[1]-20-12,size[2]-40-12,tocolor(5,5,5,255))

			-- Gomb
			if getElementData(vehicle,"danihe->radio->state") then
				dxDrawRectangle(pos[1]+10+4,pos[2]+size[2]-10-16,60,20,tocolor(25,25,25,255))
				dxDrawRectangle(pos[1]+10+4,pos[2]+size[2]-10-16,60,1,tocolor(10,10,10,255))
				dxDrawRectangle(pos[1]+10+4,pos[2]+size[2]-10-16+1,60,1,tocolor(15,15,15,255))
				dxDrawText("POWER",pos[1]+10+4+60/2,pos[2]+size[2]-10-16+20/2+1+1,nil,nil,tocolor(214,76,69,150),1,fonts["default_9"],"center","center",false,false,false,true)
			else
				dxDrawRectangle(pos[1]+10+4,pos[2]+size[2]-10-16,60,20,tocolor(25,25,25,255))
				dxDrawRectangle(pos[1]+10+4,pos[2]+size[2]-10-16+20-1,60,1,tocolor(30,30,30,255))
				dxDrawRectangle(pos[1]+10+4,pos[2]+size[2]-10-16+20-2,60,1,tocolor(35,35,35,255))
				dxDrawText("POWER",pos[1]+10+4+60/2,pos[2]+size[2]-10-16+20/2+1-1,nil,nil,tocolor(214,76,69,150),1,fonts["default_9"],"center","center",false,false,false,true)
			end

			if getElementData(vehicle,"danihe->radio->state") then
				dxDrawImage(pos[1]+10+6,pos[2]+10+6,size[1]-20-12,size[2]-40-12,textures["background"],0,0,0,tocolor(222,222,222,222))
				dxDrawRectangle(pos[1]+10+6,pos[2]+10+6,size[1]-20-12,size[2]-40-12,tocolor(5,5,5,30))

				dxDrawRectangle(pos[1]+10+6+40,pos[2]+10+6,size[1]-20-12-80,40,tocolor(25,25,25,250))

				dxDrawText("",pos[1]+size[1]/2-(dxGetTextWidth("Jelenglegi adó:",1,fonts["default_bold_10"],false))/2+5,pos[2]+10+6+3,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_10"],"right","top",false,false,false,true)
				dxDrawText("Jelenglegi adó:",pos[1]+size[1]/2+9,pos[2]+10+6+3,nil,nil,tocolor(222,222,222,222),1,fonts["default_bold_10"],"center","top",false,false,false,true)
				dxDrawText("#d6af42" .. channels[channel].name,pos[1]+size[1]/2,pos[2]+10+6+20,nil,nil,tocolor(222,222,222,222),1,fonts["default_10"],"center","top",false,false,false,true)
			
				if isCursorOnBox(pos[1]+10+6,pos[2]+10+6,40,40) then
					dxDrawRectangle(pos[1]+10+6,pos[2]+10+6,40,40,tocolor(30,30,30,250))
				else
					dxDrawRectangle(pos[1]+10+6,pos[2]+10+6,40,40,tocolor(25,25,25,250))
				end
				dxDrawText("",pos[1]+10+6+40/2,pos[2]+10+6+40/2,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_11"],"center","center",false,false,false,true)

				if isCursorOnBox(pos[1]+size[1]-10-6-40,pos[2]+10+6,40,40) then
					dxDrawRectangle(pos[1]+size[1]-10-6-40,pos[2]+10+6,40,40,tocolor(30,30,30,250))
				else
					dxDrawRectangle(pos[1]+size[1]-10-6-40,pos[2]+10+6,40,40,tocolor(25,25,25,250))
				end
				dxDrawText("",pos[1]+size[1]-10-6-40+40/2,pos[2]+10+6+40/2,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_11"],"center","center",false,false,false,true)
				
				if isElement(vehicle_radio[vehicle]) then
					local meta = getSoundMetaTags(vehicle_radio[vehicle])

					dxDrawRectangle(pos[1]+10+6,pos[2]+10+6+40,size[1]-20-12,18,tocolor(20,20,20,250))
					if meta then
						if meta["stream_title"] then
							dxDrawText("Zene:",pos[1]+35,pos[2]+10+6+40+18/2,nil,nil,tocolor(222,222,222,185),1,fonts["default_9"],"left","center",false,false,false,true)
							dxDrawText(meta["stream_title"],pos[1]+35+34,pos[2]+56,pos[1]+35+34+(size[1]-125),pos[2]+56+19,tocolor(116,179,71,185),1,fonts["default_10"],"left","center",true,false,true)
						else
							dxDrawText("Zene: #d64c45Ismeretlen",pos[1]+10+6+5+14,pos[2]+10+6+40+18/2,nil,nil,tocolor(222,222,222,185),1,fonts["default_9"],"left","center",false,false,false,true)
						end
					else
						dxDrawText("Zene: #d64c45Ismeretlen",pos[1]+10+6+5+14,pos[2]+10+6+40+18/2,nil,nil,tocolor(222,222,222,185),1,fonts["default_9"],"left","center",false,false,false,true)
					end

					if not radio_browser then
						local waveData = getSoundWaveData(vehicle_radio[vehicle],128)
						if waveData then
							for i=0,(128-1) do
				                if waveData[i] == waveData[i] then
				                	waveData[i] = math.abs(waveData[i])
				                	local line_size_y = -(waveData[i]*125)
				                	if line_size_y <= -125 then line_size_y = -125 end
				               		dxDrawRectangle(pos[1]+10+6+(i*3.1855),pos[2]+size[2]-36-25,3.1855,line_size_y,tocolor(200,200,200,200))
				            	end
				            end
						end
					end
				else
					dxDrawText("Zene: #d64c45Ismeretlen",pos[1]+10+6+5+14,pos[2]+10+6+40+18/2,nil,nil,tocolor(222,222,222,185),1,fonts["default_9"],"left","center",false,false,false,true)
				end
				dxDrawImage(pos[1]+10+6+2,pos[2]+10+6+40+2,14,14,textures["music"],0,0,0,tocolor(222,222,222,222))

				if isCursorOnBox(pos[1]+size[1]-10-6-36,pos[2]+10+6+40,36,18) then
					dxDrawRectangle(pos[1]+size[1]-10-6-36,pos[2]+10+6+40,36,18,tocolor(35,35,35,250))
				else
					dxDrawRectangle(pos[1]+size[1]-10-6-36,pos[2]+10+6+40,36,18,tocolor(30,30,30,250))
				end
				if radio_browser then
					dxDrawText("",pos[1]+size[1]-10-6-36+36/2,pos[2]+10+6+40+18/2,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_10"],"center","center",false,false,false,true)
				else
					dxDrawText("",pos[1]+size[1]-10-6-36+36/2,pos[2]+10+6+40+18/2,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_10"],"center","center",false,false,false,true)
				end

				if radio_browser then
					for i = 1,6 do
						if i%2 == 0 then
							dxDrawRectangle(pos[1]+10+6,pos[2]+10+6+40+18+(i-1)*browser_line_y,size[1]-20-12,browser_line_y,tocolor(50,50,50,170))
						else
							dxDrawRectangle(pos[1]+10+6,pos[2]+10+6+40+18+(i-1)*browser_line_y,size[1]-20-12,browser_line_y,tocolor(60,60,60,170))
						end
						if isCursorOnBox(pos[1]+10+6,pos[2]+10+6+40+18+(i-1)*browser_line_y,size[1]-20-12,browser_line_y) then
							dxDrawRectangle(pos[1]+10+6,pos[2]+10+6+40+18+(i-1)*browser_line_y,size[1]-20-12,browser_line_y,tocolor(255,255,255,10))
						end

						local channelID = channels[i+scroll]
						if i+scroll == channel then
							dxDrawRectangle(pos[1]+10+6,pos[2]+10+6+40+18+(i-1)*browser_line_y,size[1]-20-12,browser_line_y,tocolor(116,179,71,125))
						end
						if channelID then
							dxDrawImage(pos[1]+10+6+2.5,pos[2]+10+6+40+18+(i-1)*browser_line_y+2.5,browser_line_y-5,browser_line_y-5,textures["satelite"],0,0,0,tocolor(200,200,200,222))
							dxDrawText(channelID.name,pos[1]+10+6+25,pos[2]+10+6+40+18+(i-1)*browser_line_y+browser_line_y/2+1,nil,nil,tocolor(200,200,200,222),1,fonts["default_10"],"left","center",false,false,false,true)
						end
					end

					dxDrawRectangle(pos[1]+10+6+(size[1]-20-12)-10,pos[2]+10+6+40+18,10,6*browser_line_y,tocolor(50,50,50,250))
					--dxDrawScrollBar(pos[1]+10+6+(size[1]-20-12)-10,pos[2]+10+6+40+18,10,6,#channels,browser_line_y,scroll,tocolor(116,179,71,150))
				end

				-- Hangerő
				dxDrawRectangle(pos[1]+10+6,pos[2]+size[2]-36-25,size[1]-20-12,25,tocolor(20,20,20,250))
		
				dxDrawImage(pos[1]+size[1]-10-6-5-130-5-20,pos[2]+size[2]-36-25+2.5,20,20,textures["volume"],0,0,0,tocolor(200,200,200,200))
				dxDrawRectangle(pos[1]+size[1]-10-6-5-130,pos[2]+size[2]-36-25+5,130,15,tocolor(55,55,55,250))

				if volume > 1 then
					dxDrawRectangle(pos[1]+size[1]-10-6-5-130,pos[2]+size[2]-36-25+5,130/100*volume,15,tocolor(116,179,71,125))
				end

				if isCursorOnBox(pos[1]+size[1]-10-6-5-130-10,pos[2]+size[2]-36-25+5,130+20,15) then
					if getKeyState("mouse1") then
						local cx,cy = getCursorPosition()
						cx,cy = cx*s[1],cy*s[2]

						if cx >= pos[1]+size[1]-10-6-5-130 and cx <= pos[1]+size[1]-10-6-5 then
							local volume = (cx-(pos[1]+size[1]-10-6-5-130))*0.78	
							setElementData(vehicle,"danihe->radio->volume",volume)
						end
						if cx <= pos[1]+size[1]-10-6-5-130 then
							local volume = 0
							setElementData(vehicle,"danihe->radio->volume",volume)
						end
						if cx >= pos[1]+size[1]-10-6-5 then
							local volume = 100
							setElementData(vehicle,"danihe->radio->volume",volume)
						end
					end
				end

				dxDrawText(math.floor(volume) .. "%",pos[1]+size[1]-10-6-5-130+130/2,pos[2]+size[2]-36-25+25/2,nil,nil,tocolor(222,222,222,222),1,fonts["default_9"],"center","center",false,false,false,true)
			end
		end

		-- Rádió szinkronizáció
		for _,vehicle in ipairs(getElementsByType("vehicle")) do
			if isElementStreamedIn(vehicle) then
				setRadioChannel(0)
				if getElementData(vehicle,"danihe->radio->state") then
					if not vehicle_radio[vehicle] then
						start_vehicle_radio(vehicle)
					end

					local player_vehicle = getPedOccupiedVehicle(localPlayer)
					if player_vehicle then -- Ha járműben van a játékos
						if player_vehicle == vehicle then -- Ha azt a kocsit sync-eljük amiben ül
							setSoundVolume(vehicle_radio[vehicle],getElementData(vehicle,"danihe->radio->volume")/100)
							setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance*2)
						else
							if vehicleWindowsAreUp(player_vehicle) then
								setSoundVolume(vehicle_radio[vehicle],0)
								setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance)
							else
								if vehicleWindowsAreUp(vehicle) then
									setSoundVolume(vehicle_radio[vehicle],0)
									setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance)
								else
									setSoundVolume(vehicle_radio[vehicle],getElementData(vehicle,"danihe->radio->volume")/100)
									setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance)							
								end
							end
						end
					else -- Ha nincs járműben
						if vehicleWindowsAreUp(vehicle) then -- Ha fel van húzva az összes ablak
							setSoundVolume(vehicle_radio[vehicle],0.025)
							setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance)
						else -- Ha akár csak egy is le van engedve
							setSoundVolume(vehicle_radio[vehicle],getElementData(vehicle,"danihe->radio->volume")/100)
							setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance)
						end
					end
				else
					if vehicle_radio[vehicle] then
						destroyElement(vehicle_radio[vehicle])
						vehicle_radio[vehicle] = nil
					end
				end
			end
		end
	end
)

function vehicleWindowsAreUp(vehicle)
	return false
end

addEventHandler("onClientKey",root,
	function(k,p)
		if k == "r" and p then
			if not isChatBoxInputActive() and not getElementData(localPlayer,"danihe->input->active") then
				local vehicle = getPedOccupiedVehicle(localPlayer)
				local seat = getPedOccupiedVehicleSeat(localPlayer)
				if vehicle then
					if seat == 0 or seat == 1 then
						radio_state = not radio_state
					end
				end
			end
		end
		--- Jármű
		if radio_state then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			if radio_browser then
				if k == "mouse_wheel_down" then
					if scroll < #channels-6 then
						scroll = scroll + 1
						playSound(":reach_core/sounds/ui_click.ogg")
					end
				elseif k == "mouse_wheel_up" then
					if scroll > 0 then
						scroll = scroll - 1
						playSound(":reach_core/sounds/ui_click.ogg")
					end	
				end

				if k == "mouse1" and p then
					for i = 1,6 do
						if isCursorOnBox(pos[1]+10+6,pos[2]+10+6+40+18+(i-1)*browser_line_y,size[1]-20-12,browser_line_y) then
							if getElementData(vehicle,"danihe->radio->channel") ~= i+scroll then
								setElementData(vehicle,"danihe->radio->channel",i+scroll)
								playSound(":reach_core/sounds/ui_click.ogg")
							end
						end
					end
				end
			end
			if k == "mouse1" and p then
				if isCursorOnBox(pos[1]+size[1]-10-6-36,pos[2]+10+6+40,36,18) then
					radio_browser = not radio_browser
					playSound(":reach_core/sounds/ui_click.ogg")
				elseif isCursorOnBox(pos[1]+10+4,pos[2]+size[2]-10-16,60,20) then
					if isTimer(toggleTimer) then return end
					if getElementData(vehicle,"danihe->radio->state") then
						playSound("sounds/button.ogg")
						setElementData(vehicle,"danihe->radio->state",false)
						toggleTimer = setTimer( function() end,750,1)
						if vehicle_radio[vehicle] then
							destroyElement(vehicle_radio[vehicle])
							vehicle_radio[vehicle] = nil
						end
					else
						playSound("sounds/button.ogg")
						setElementData(vehicle,"danihe->radio->state",true)
						toggleTimer = setTimer( function() end,750,1)
						if not vehicle_radio[vehicle] then
							start_vehicle_radio(vehicle)
						end
					end 
				elseif isCursorOnBox(pos[1]+10+6,pos[2]+10+6,40,40) then
					local channel = getElementData(vehicle,"danihe->radio->channel")
					if channel > 1 then
						channel = channel - 1
					end
					setElementData(vehicle,"danihe->radio->channel",channel)
					playSound(":reach_core/sounds/ui_click.ogg")
				elseif isCursorOnBox(pos[1]+size[1]-10-6-40,pos[2]+10+6,40,40) then
					local channel = getElementData(vehicle,"danihe->radio->channel")
					if channel < #channels then
						channel = channel + 1
					end
					setElementData(vehicle,"danihe->radio->channel",channel)
					playSound(":reach_core/sounds/ui_click.ogg")
				end
			end
		end
	end
)

function start_vehicle_radio(vehicle)
	if isElement(vehicle) and isElementStreamedIn(vehicle) then
		if getElementData(vehicle,"danihe->radio->state") then
			local channelID = getElementData(vehicle,"danihe->radio->channel")
			local x,y,z = getElementPosition(vehicle)
			vehicle_radio[vehicle] = playSound3D(channels[channelID].stream,x,y,z)
			attachElements(vehicle_radio[vehicle],vehicle)
			setSoundVolume(vehicle_radio[vehicle],getElementData(vehicle,"danihe->radio->volume")/100)
			setSoundMinDistance(vehicle_radio[vehicle],radio_def_min_distance)
			setSoundMaxDistance(vehicle_radio[vehicle],radio_def_max_distance)
		end
	end
end

addEventHandler("onClientVehicleExit",root,
	function(vehicle,seat)
		if source == localPlayer then
			radio_state = false
			radio_browser = false
			srcoll = 0
		end
	end
)

addEventHandler("onClientElementDataChange",root,
	function(data,old,new)
		if getElementType(source) == "vehicle" and isElementStreamedIn(source) then
			if data == "danihe->radio->channel" then
				if new ~= old then
					if vehicle_radio[source] then
						destroyElement(vehicle_radio[source])
						vehicle_radio[source] = nil
					end
					start_vehicle_radio(source)
				end
			elseif data == "danihe->radio->volume" then
				if new ~= old then
					if vehicle_radio[source] then
						setSoundVolume(vehicle_radio[source],new/100)
					end
				end	
			end
		end
	end
)

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		for k,v in ipairs(getElementsByType("vehicle")) do
			if isElementStreamedIn(v) then
				if not vehicle_radio[v] then
					start_vehicle_radio(v)
				end
			end
		end

		textures["volume"] = dxCreateTexture("images/volume.dds")
		textures["background"] = dxCreateTexture("images/background.dds")
		textures["music"] = dxCreateTexture("images/music.dds")
		textures["satelite"] = dxCreateTexture("images/satelite.dds")
	end
)

addEventHandler("onClientElementStreamIn",root,
	function()
		if getElementType(source) == "vehicle" then
			if not vehicle_radio[source] then
				start_vehicle_radio(source)
			end
		end
	end
)

addEventHandler("onClientElementStreamOut",root,
	function()
		if getElementType(source) == "vehicle" then
			if vehicle_radio[source] then
				destroyElement(vehicle_radio[source])
				vehicle_radio[source] = nil
			end
		end
	end
)

addEventHandler("onClientElementDestroy",root,
	function()
		if getElementType(source) == "vehicle" then
			if vehicle_radio[source] then
				destroyElement(vehicle_radio[source])
				vehicle_radio[source] = nil
			end
		end
	end
)






function dxDrawCircleRectangle(x, y, rx, ry, color, radius, postGUI)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color, postGUI)
        dxDrawRectangle(x, y - radius, rx, radius, color, postGUI)
        dxDrawRectangle(x, y + ry, rx, radius, color, postGUI)
        dxDrawRectangle(x - radius, y, radius, ry, color, postGUI)
        dxDrawRectangle(x + rx, y, radius, ry, color, postGUI)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7, 1, postGUI)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7, 1, postGUI)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, postGUI)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7, 1, postGUI)
    end
end

function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end


function getProgress(addtick, lastTick) 
    local now = getTickCount() 
    local elapsedTime = now - lastTick 
    local duration = lastTick+addtick - lastTick 
    local progress = elapsedTime / duration 
    return progress 
end 

function isCursorOnBox(x, y, width, height)
	if isCursorShowing() then
		local sx, sy = guiGetScreenSize ( )
		local cx, cy = getCursorPosition ( )
		local cx, cy = ( cx * sx ), ( cy * sy )
	  	if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
   			return true
	  	else
  	   		return false
		end
	else
		return false
	end	
end

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end

function roundNumber(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end