radioURL = {
	{"http://risefm1.stereoplayer.hu:8080/risefm_hithouse_hq","RiseFM"},
	{"https://cast.magicstreams.gr:2200/ssl/psyndora?mp=","PsyTrance Radio"},
	{"http://stream001.radio.hu:8080/mr2.mp3.m3u","Petőfi Rádió"},
	{"http://www.radio88.hu/stream/radio88.pls","Rádió 88"},
	{"http://79.111.119.111:8002/riddimdubstep","Dubstep Radio"},
	{"http://fmradiom.hu/radiom.m3u","Rádió M"},
	{"http://stream.radio1.hu/mid.mp3","Rádió 1"},
	{"http://104.6.216.93:8000/Streetz","Rap Radio"},
	{"http://radio.yasenbit.net:8000/yasenbit128k","RU Rap Radio"},		{"https://turadio.accesopanel.com:7100/;stream.nsv","Latin Urban Hip Hop"},		{"https://electricfabric.stream.laut.fm/electricfabric","Electric Fabric"},
}

local s = {guiGetScreenSize()}
local box = {512,512}
local boxP = {s[1]/2 - box[1]/2,s[2]/2 - box[2]/2}
local colors = { tocolor(255,0,0),tocolor(0,255,0) }
local isStarted = false
local lastClick = 0
local radioOutside = {}
local isRadioShowed = false
local mouseCounting = false

drawArea = dxCreateRenderTarget(800,700)  

function isRadioShowing()
	return isRadioShowed
end

function getRadioURL()
	return radioURL
end



local trackFont = dxCreateFont("files/OpenSansB.ttf",11)
local nameFont = dxCreateFont("files/OpenSansB.ttf",15)
local font = dxCreateFont("files/OpenSansB.ttf",15)

bindKey("r","down",function()
	if isPedInVehicle(localPlayer) and getVehicleController (getPedOccupiedVehicle(localPlayer)) == localPlayer and not isPedDoingGangDriveby (localPlayer) or getPedOccupiedVehicleSeat(localPlayer) == 1 then
		if not isRadioShowed then
			isRadioShowed = true
		else
			isRadioShowed = false
		end
	end
end)

bindKey("F6","down",function()
	if isPedInVehicle(localPlayer) and getVehicleController (getPedOccupiedVehicle(localPlayer)) == localPlayer and not isPedDoingGangDriveby (localPlayer) or getPedOccupiedVehicleSeat(localPlayer) == 1 then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if getElementData(vehicle,"veh:window") == 0 then
			setElementData(vehicle,"veh:window",1)
			outputChatBox("lehúzta")
		elseif getElementData(vehicle,"veh:window") == 1 then
			setElementData(vehicle,"veh:window",0)
			outputChatBox("felhúzta")
		end
	end
end)

addEventHandler("onClientPlayerVehicleExit", getRootElement(), function (vehicle, seat)
	if source == localPlayer and isRadioShowed then
		isRadioShowed = false
	end
	if source == localPlayer then
		updateLoudness(vehicle)
	end
end)

addEventHandler("onClientPlayerVehicleEnter", getRootElement(), function (vehicle, seat)
	if source == localPlayer then
		updateLoudness(vehicle)
	end
end)

function updateLoudness(theVehicle)
	if (radioOutside[theVehicle]) then
		local windowState = getElementData(theVehicle, "veh:window") or 1
		local carVolume = getElementData(theVehicle, "vehicle:radio:volume")

		carVolume = carVolume / 100
		
		if (getPedOccupiedVehicle(getLocalPlayer()) == theVehicle) then
			setSoundMinDistance(radioOutside[theVehicle], 70)
			setSoundMaxDistance(radioOutside[theVehicle], 100)
			setSoundVolume(radioOutside[theVehicle], 1*carVolume)
		elseif (getVehicleType(theVehicle) == "Boat") then
			setSoundMinDistance(radioOutside[theVehicle], 25)
			setSoundMaxDistance(radioOutside[theVehicle], 60)
			setSoundVolume(radioOutside[theVehicle], 0.7*carVolume)
		else
			if getElementData(theVehicle, "veh:lockedTrunk") then
				setSoundMinDistance(radioOutside[theVehicle], 10)
				setSoundMaxDistance(radioOutside[theVehicle], 15)
				setSoundVolume(radioOutside[theVehicle], 0.7*carVolume)
			elseif windowState == 1 then
				setSoundMinDistance(radioOutside[theVehicle], 5)
				setSoundMaxDistance(radioOutside[theVehicle], 10)
				setSoundVolume(radioOutside[theVehicle], 0.5*carVolume)
			else
				setSoundMinDistance(radioOutside[theVehicle], 2)
				setSoundMaxDistance(radioOutside[theVehicle], 5)
				setSoundVolume(radioOutside[theVehicle], 0.2*carVolume)
			end
		end
	end
end

function spawnSound(theVehicle)
	if getElementType( theVehicle ) == "vehicle" then
	
		local radioStation = getElementData(theVehicle, "vehicle:radio") or 0
	--	outputChatBox(radioStation)
		if radioStation ~= 0 then
			local thisRadio = radioURL[radioStation]
			if thisRadio then
				if radioOutside[theVehicle] then
					destroyElement(radioOutside[theVehicle])
					radioOutside[theVehicle] = nil
				end
				local x,y,z = getElementPosition(theVehicle)
				updateLoudness(vehicle)
				local carVolume = getElementData(theVehicle, "vehicle:radio:volume")
				radioOutside[theVehicle] = playSound3D(thisRadio[1], x,y,z)
				--setSoundVolume(radioOutside[theVehicle],carVolume)
				attachElements ( radioOutside[theVehicle], theVehicle, 0, 0, 0 )
			end
		end
	end
end

function delSound(player)
	if radioOutside[player] then
		if isElement(radioOutside[player]) then
			detachElements(radioOutside[player], player)
			destroyElement(radioOutside[player])
			
		end
		radioOutside[player] = nil
	end
end

addEventHandler("onClientRender",getRootElement(),function()
	if not isRadioShowed then return end
	dxDrawImage(boxP[1],boxP[2],box[1],box[2],"files/bg.png")
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		if getElementData(vehicle,"vehicle:radio") > 0 then
		local meta = getSoundMetaTags(radioOutside[vehicle])
		if meta then
			if meta["stream_title"] then
			--	dxSetRenderTarget ( drawArea, true ); 
				dxDrawText("Track: "..modifyString(meta["stream_title"]),boxP[1]+85,boxP[2]+55,box[1],box[2],tocolor(255,255,255,255),1,trackFont)
			--	dxSetRenderTarget() 
			--	dxDrawImage(boxP[1]+85,boxP[2]+55,20,20, drawArea )
			else
				dxDrawText("Track: - ",boxP[1]+85,boxP[2]+55,box[1],box[2],tocolor(255,255,255,255),1,trackFont)
			end
		end	
		--if isStarted then
		local bt = getSoundFFTData(radioOutside[vehicle],2048,257)
		if bt then
			for i=1,256 do
				bt[i] = math.sqrt(bt[i])*130 
				dxDrawRectangle(i-1+boxP[1]+150,s[1]/2-bt[i]/2-boxP[2]-275,1,bt[i])
			end
		end
		end	
		
		local radioStation = tonumber(getElementData(vehicle, "vehicle:radio")) or 0
		
		
		
		if getElementData(vehicle,"vehicle:radio") > 0 then
			dxDrawText(radioURL[radioStation][2],boxP[1]+130,boxP[2]+76,box[1],box[2],tocolor(255,255,255,255),1,nameFont)
			dxDrawRectangle(boxP[1]+45,boxP[2]+28,7,5,tocolor(0,255,0,255))
		elseif getElementData(vehicle,"vehicle:radio") == 0 then
			dxDrawText("Track: - ",boxP[1]+85,boxP[2]+55,box[1],box[2],tocolor(255,255,255,255),1,trackFont)
			dxDrawText("Rádió Jelenleg kikapcsolva",boxP[1]+130,boxP[2]+76,box[1],box[2],tocolor(255,255,255,255),1,nameFont)
			dxDrawRectangle(boxP[1]+45,boxP[2]+28,7,5,tocolor(255,0,0,255))
		end
		
		
		if isInSlot(boxP[1]+30,boxP[2]+20,35,25) then
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				if getElementData(vehicle,"vehicle:radio") == 0 then
					setElementData(vehicle,"vehicle:radio",1)
					spawnSound(vehicle)
				else
					setElementData(vehicle,"vehicle:radio",0)
					delSound(vehicle)
				end
			end
		end
		
		if isInSlot(boxP[1]+100,boxP[2]+220,25,25) then
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				updateLoudness(vehicle)
				local radioStation = tonumber(getElementData(vehicle, "vehicle:radio")) or 1
				if radioURL[radioStation - 1] then
					setElementData(vehicle, "vehicle:radio", radioStation - 1)
				elseif radioStation == 1 then
					setElementData(vehicle, "vehicle:radio", #radioURL)
				else
					setElementData(vehicle, "vehicle:radio", #radioURL)
				end
			end
			dxDrawImage(boxP[1]+100,boxP[2]+220,25,25,"files/tek.png",0,0,0,tocolor(255,255,255,255))
		else
			dxDrawImage(boxP[1]+100,boxP[2]+220,25,25,"files/tek.png",0,0,0,tocolor(255,255,255,150))
		end	
		
		if isInSlot(boxP[1]+130,boxP[2]+220,25,25) then
			dxDrawImage(boxP[1]+130,boxP[2]+220,25,25,"files/tek.png",180,0,0,tocolor(255,255,255,255))
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				updateLoudness(vehicle)
				local radioStation = tonumber(getElementData(vehicle, "vehicle:radio")) or 1
				if radioURL[radioStation + 1] then
					setElementData(vehicle, "vehicle:radio", radioStation + 1)
				else
					setElementData(vehicle, "vehicle:radio", 1)
				end
			end
		else
			dxDrawImage(boxP[1]+130,boxP[2]+220,25,25,"files/tek.png",180,0,0,tocolor(255,255,255,150))
		end
		
		
		
		dxDrawImage(boxP[1]+100,boxP[2]+105,3,107,"files/sliderBG.png",0,0,0,tocolor(255,255,255,150))
		dxDrawImage(boxP[1]+98,boxP[2]+190-getElementData(vehicle,"vehicle:radio:volume"),6,23,"files/sliderC.png",0,0,0,tocolor(255,255,255,255))
		if getElementData(vehicle,"vehicle:radio:volumeChange") then
			if getElementData(vehicle,"vehicle:radio:volume") > 0 then
				dxDrawText("Hangerő: "..getElementData(vehicle,"vehicle:radio:volume").."%",boxP[1]+200,boxP[2]+220,0,0,tocolor(255,255,255,255),1,nameFont)
			else
				dxDrawText("Hangerő: Némítva",boxP[1]+200,boxP[2]+220,0,0,tocolor(255,255,255,255),1,nameFont)
			end
		end
		
		local rtime = getRealTime()
		local hour = rtime.hour
		local minute = rtime.minute
		dxDrawText(hour..":"..minute,boxP[1]+416,boxP[2]+51,box[1],box[2],tocolor(255,255,255,255),1,font)
	end	
end)

bindKey("mouse_wheel_down", "down", 
	function() 
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if isRadioShowed and getElementData(vehicle,"vehicle:radio") > 0 then
		--	if mouseCounting then
				if isTimer(hangTimer) then 
					killTimer(hangTimer)
				end
				hangTimer = setTimer(function()
					setElementData(vehicle,"vehicle:radio:volumeChange",false)
				end,1000,1)
				if getElementData(vehicle,"vehicle:radio:volume") > 0 then
					setElementData(vehicle,"vehicle:radio:volumeChange",true)
					setElementData(vehicle,"vehicle:radio:volume",getElementData(vehicle,"vehicle:radio:volume")-1)
					updateLoudness(vehicle)
				end
		--	end
		end	
	end
)

bindKey("mouse_wheel_up", "down", 
	function() 
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if isRadioShowed and getElementData(vehicle,"vehicle:radio") > 0 then
		--	if mouseCounting then
			--outputChatBox(getElementData(vehicle,"vehicle:radio:volume"))
				if isTimer(hangTimer) then 
					killTimer(hangTimer)
				end
				hangTimer = setTimer(function()
					setElementData(vehicle,"vehicle:radio:volumeChange",false)
				
				end,1000,1)
				if getElementData(vehicle,"vehicle:radio:volume") < 100 then
					setElementData(vehicle,"vehicle:radio:volumeChange",true)
					setElementData(vehicle,"vehicle:radio:volume",getElementData(vehicle,"vehicle:radio:volume")+1)
					updateLoudness(vehicle)
				end
		--	end
		end	
	end
)

function stringInsert(value, insert, place)
    local isLen = string.len(value)
    if isLen > place then
        return string.sub(value, 1,place-1) .. tostring(insert) 
    else
        return value
    end
end

function split(s)
    local newString = s
    newString = stringInsert(newString, "...", 32)
    return newString
end

function modifyString(str)
    if str then
        return tostring(split(str))
    end
end

addEventHandler ( "onClientElementDataChange", getRootElement(),
	function ( dataName )
		if getElementType ( source ) == "vehicle" and dataName == "vehicle:radio" then
			local radioStation = tonumber(getElementData(source, "vehicle:radio")) or 0
			if radioStation ~= 0 then
				spawnSound(source)
				local radioVolume = tonumber(getElementData(source, "vehicle:radio:volume")) or 0
				setElementData(source,"vehicle:radio:volume",radioVolume)
				updateLoudness(source)
			else
				delSound(source)
				setElementData(source,"vehicle:radio",0)
			end
		end	
		if getElementType ( source ) == "vehicle" and dataName == "vehicle:radio:volume" then
			local radioVolume = tonumber(getElementData(source, "vehicle:radio:volume")) or 0
			setElementData(source,"vehicle:radio:volume",radioVolume)
			updateLoudness(source)
		end
	end
)


function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function()	
		local vehicles = getElementsByType("vehicle")
		for _, theVehicle in ipairs(vehicles) do
			setElementData(theVehicle,"vehicle:radio",0)
			setElementData(theVehicle,"vehicle:radio:volume",50)
			setElementData(theVehicle,"vehicle:radio:volumeChange",false)
		end
	end
)

addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
		spawnSound(source)
    end
)

addEventHandler( "onClientElementStreamOut", getRootElement( ),
    function ( )
		local newSoundElement = nil
        if getElementType( source ) == "vehicle" then
			delSound(source)
        end
    end
)


addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if getElementType(source) == "vehicle" then
		delSound(source)
		
	end
end)