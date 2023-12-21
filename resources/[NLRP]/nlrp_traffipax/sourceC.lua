col = engineLoadCOL( "files/fix.col" )
txd = engineLoadTXD( "files/fix.txd" )
dff = engineLoadDFF( "files/fix.dff" )

engineReplaceCOL( col, 753 )
engineImportTXD( txd, 753 )
engineReplaceModel( dff, 753 )-- replace the model at least

col = engineLoadCOL( "files/3leg.col" )
txd = engineLoadTXD( "files/3leg.txd" )
dff = engineLoadDFF( "files/3leg.dff" )

engineReplaceCOL( col, 7426 )
engineImportTXD( txd, 7426 )
engineReplaceModel( dff, 7426 )-- replace the model at least

col = engineLoadCOL( "files/veda.col" )
txd = engineLoadTXD( "files/veda.txd" )
dff = engineLoadDFF( "files/veda.dff" )

engineReplaceCOL( col, 7265 )
engineImportTXD( txd, 7265 )
engineReplaceModel( dff, 7265 )-- replace the model at least


local TrafiPos = {-- X, Y , Z ,Rot [1,2,3] ,Seblimits
	{2632.4484863281, -1142.1975097656, 53.576389312744,0, 0, 133+90,50},--4 sávostól Externalos autoker felé fent a dombon
	{2632.2866210938, -1163.0250244141, 53.261402130127,0, 0, 75+90,50},--4 sávostól Externalos autoker felé fent a dombon2
	{2045.9558105469, -1742.3405761719, 13.539077758789,0, 0, 230+90,40},--déli benzinkút (POS)
	{1613.4154052734, -1739.3972167969, 13.546875,0,0,250,40},--rendőrségtől balra (POS)
	--{1162.9130859375, -1389.0151367188, 13.676382064819,0,0,80,90},--kórháztól jobbra (POS)
	--{1090.2261962891, -1411.9454345703, 13.662985801697,0,0,-100,90},--kórház jobbra túloldal (POS)
	--{1306.1239013672, -1552.4890136719, 13.546875,0,0,350,100},--vh-nál 2x2 sávosnál (POS)
	{1831.3999023438, -1597.3576660156, 13.546875,0,0,180,50},--alhambra (POS)
	{1592.2755126953, -1585.5428466797, 13.546875,0,0,65,40},--rendőrségtől jobbra (POS)
	{2225.6877441406, -1835.3270263672, 13.552531242371,0,0,190,50},--kék sorházak(Ganton->Kékházak oldala) (POS)
	{377.15478515625, -1709.6251220703, 7.5561242103577,0,0,90,70},--Santa Maria Beach (POS)
	{-90.266494750977, -1427.2891845703, 12.521896362305,0,0,-25,90},--Santa Maria Beach (POS)
	{-99.943695068359, -1417.9799804688, 12.892049789429,0,0,-65,90},--Santa Maria Beach (POS)
	--{1962.3029785156, -1931.3592529297, 11.3828125,0,0,-180,50},--El Corona (POS)
	--{1940.2827148438, -1910.0213623047, 20.063995361328,0,0,45,500},--El Corona DíSZ(POS)
	--{1809.4779052734, -1697.9916992188, 28.581007003784,0,0,25,500},--Alhambra DíSZ(POS)
	--{2205.8615722656, -1124.0166015625, 23.506242752075,0,0,25,70},--Jefferson(POS)
	--{2234.4016113281, -1151.6008300781, 34.2421875,0,0,230,500},--Alhambra DíSZ(POS)
	--{2422.4775390625, -1732.2117919922, 11.090188980103,0,0,25,50},--Ganton(POS)
	--{2402.4790039063, -1709.5046386719, 18.641675949097,0,0,40,500},--Ganton DíSZ(POS)	
	--{1123.1356201172, -940.21978759766, 42.89009475708,0,0,75,70},--Temple(POS)
	--{1096.5441894531, -961.98114013672, 42.351272583008,0,0,-120,70},--Temple(POS)
	--{797.47521972656, -1322.6990966797, 10.982810974121,0,0,-120,70},--Market Station(POS)
	--809.16625976563, -1338.9560546875, 22.549976348877,0,0,-140,500},--Market Station Dísz(POS)
	--{625.20703125, -1586.416015625, 13.737939834595,0,0,120,70},--Rodeo-Tesco(POS)
	--{640.16912841797, -1586.3038330078, 13.737939834595,0,0,-45,70},--Roedo-Tesco(POS)
	--{653.84045410156, -1600.1931152344, 22.842807769775,0,0,-130,500},--Roedo-Tesco DíSZ(POS)
	--{1035.6091308594, -2067.4580078125, 11.126793861389,0,0,-130,110},--Verdant(POS)
	--{1051.0427246094, -2067.833984375, 11.126793861389,0,0,-130,110},--Verdant(POS)
	--{1040.5607910156, -2084.9565429688, 32.981101989746,0,0,-190,500},--Verdant DíSZ(POS)
	--{2284.328125, -2269.6962890625, 11.274998664856,0,0,-130,160},--Ocean Docks(POS)
	--{2295.9184570313, -2282.2133789063, 11.274998664856,0,0,-130,160},--Ocean Docks(POS)
	--{2321.8933105469, -2242.4375, 24.200691223145,0,0,-45,500},--Ocean Docks DíSZ(POS)
	--{2077.1599121094, 46.894100189209, 27.493835449219,0,0,-60,90},--Palomino(POS)
	--{-83.748222351074, -1116.8636474609, 4.578125,0,0,-40,90},--Flint Country(POS)
}
local VedaPos = {-- X, Y , Z ,Rot [1,2,3] ,Seblimits
	--{2892.423828125, -1590.9838867188, 11.046875,0, 0, 255,130},--4 sávos a gyárnál
	--{2885.2924804688, -1589.2777099609, 11.05464553833,0, 0, 70,130},--4 sávos a gyárnál
	{1306.3272705078, -1623.1745605469, 13.539079666138,0, 0, 270,70},--Középső
	{1303.6831054688, -1623.1096191406, 13.539079666138,0, 0, 90,70},--Középső
	{1162.7827148438, -1389.9599609375, 13.681171417236,0, 0, 180,70},--Korház
	{1164.6717529297, -1411.3416748047, 13.530388832092,0, 0, 0,70},--Korház
	{958.34283447266, -1788.6987304688, 14.286491394043,0, 0, 170,90},--Black Dragons
	{958.80975341797, -1785.5537109375, 14.286575317383,0, 0, 350,90},--Black Dragons
}

local Trafipax = {}
local Vedapax = {}
local TrafipaxEffect = {}
local Distance = 12
local Elkapta = false
local ElkaptaTick = 0

function CreateTrafi ()
	for i,v in ipairs (TrafiPos) do
		Trafipax[i] = createObject(753,v[1],v[2],v[3]-1.04,v[4], v[5], v[6])
	end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(), CreateTrafi )
setElementData(localPlayer,"trafiBassza",false)
function TrafiSpeed()
	if isPedInVehicle(localPlayer) then
		local x, y, z = getElementPosition(getLocalPlayer())
		for i,v in ipairs (TrafiPos) do
			if getDistanceBetweenPoints3D(x, y, z, v[1], v[2], v[3]) <= Distance and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 416 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 427 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 490 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 523 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 528 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 596 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 597 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 598 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 599 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 601 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 407 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 418 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 481 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 509 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 510 then
				if (getVehicleSpeed() > tonumber(v[7]+getVehicleSpeed()/10) or not getElementData(localPlayer, "char:ov")) then
					if not getElementData(localPlayer,"trafiBassza") and not Elkapta then
						if getVehicleController(getPedOccupiedVehicle(localPlayer)) == getLocalPlayer() then
							setElementData(localPlayer,"trafiBassza",true)
							Elkapta = true
							ElkaptaTick = ElkaptaTick + 1
							
							if ElkaptaTick == 1 then	
								if --[[getElementData(localPlayer, "char:ov") or]] getVehicleSpeed() > tonumber(v[7]+getVehicleSpeed()/10) then 
									Birsag = calculateBirsag(getVehicleSpeed() - v[7])/100 * 7000
									Sebszam = getVehicleSpeed() - v[7]
									outputChatBox("#ffffff--------------------------------------------------------------------------------------------------------",0,0,255,true)
									outputChatBox("#b7ff00[Traffipax] #ffffffÁtlépted sebességhatárt! A megengedett sebesség: #F4B350"..v[7].."#ffffff km/h!",0,0,255,true)
									outputChatBox("#b7ff00[Traffipax] #ffffffA túllépés mértéke: #D24D57"..math.ceil(Sebszam).." km/h. #ffffffBirság: #b7ff00"..math.ceil(Birsag).." Ft",0,0,255,true)
									triggerServerEvent("onTrafiHit", localPlayer, localPlayer, Birsag)
									fadeCamera(false, 0.5,255,255,255)
									createEffect("camflash", v[1],v[2],v[3]+0.5)
									
									playSound("files/shutter.mp3")
									
									setTimer (function () 
										fadeCamera(true, 0.5)
									end,400,1)
								
							    --[[ elseif getElementData(localPlayer, "char:ov") and  getVehicleSpeed() > tonumber(v[7]+getVehicleSpeed()/10) and getVehicleType(getPedOccupiedVehicle(localPlayer)) ~= "Bike" then 
									Birsag = 10+calculateBirsag(getVehicleSpeed() - v[7])/100 * 50
									outputChatBox("#b7ff00[Traffipax] #ffffffNem volt bekötve a biztonsági öved, ezért büntetésben részesültél. Bírság: #dc143cFt".. Birsag,0,0,255,true)
									outputChatBox("#b7ff00[Traffipax] #ffffffRemélem legközelebb odafigyel a saját biztonsága érdekében .",0,0,255,true)
									triggerServerEvent("onTrafiHit", localPlayer, localPlayer, Birsag)
									fadeCamera(false, 0.5,255,255,255)
									createEffect("camflash", v[1],v[2],v[3]+0.5)
									
									playSound("files/shutter.mp3")
									
									setTimer (function () 
										fadeCamera(true, 0.5)
									end,400,1)
								end
								if not getElementData(localPlayer, "char:ov") and getVehicleType(getPedOccupiedVehicle(localPlayer)) ~= "Bike"  then 
									--Birsag = 10
									--outputChatBox("#b7ff00[Traffipax] #ffffffNem volt bekötve a biztonsági öved, ezért büntetésben részesültél. Bírság: #dc143cFt".. Birsag,0,0,255,true)
									--outputChatBox("#b7ff00[Traffipax] #ffffffRemélem legközelebb odafigyel a saját biztonsága érdekében.",0,0,255,true)
									--triggerServerEvent("onTrafiHit", localPlayer, localPlayer, Birsag)
									--fadeCamera(false, 0.5,255,255,255)
									--createEffect("camflash", v[1],v[2],v[3]+0.5)]]
									
									playSound("files/shutter.mp3")
									
									setTimer (function () 
										fadeCamera(true, 0.5)
									end,400,1)
								end
								end
							end
							aT = setTimer(function()
								Elkapta = false
								setElementData(localPlayer,"trafiBassza",false)
								ElkaptaTick = 0
								if isTimer(aT) then
									killTimer(aT)
								end
							end,1500,1)
						end
					end
				end
			end
		end
	end



addEventHandler ( "onClientRender", getRootElement(), TrafiSpeed2 )function CreateTrafi ()
	for i,v in ipairs (VedaPos) do
		Vedapax[i] = createObject(7265,v[1],v[2],v[3]-1.04,v[4], v[5], v[6])
	end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(), CreateTrafi )
setElementData(localPlayer,"trafiBassza",false)
function TrafiSpeed2()
	if isPedInVehicle(localPlayer) then
		local x, y, z = getElementPosition(getLocalPlayer())
		for i,v in ipairs (VedaPos) do
			if getDistanceBetweenPoints3D(x, y, z, v[1], v[2], v[3]) <= Distance and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 416 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 427 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 490 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 523 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 528 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 596 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 597 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 598 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 599 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 601 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 407 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 418 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 481 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 509 and getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 510 then
				if (getVehicleSpeed() > tonumber(v[7]+getVehicleSpeed()/10) or not getElementData(localPlayer, "char:ov")) then
					if not getElementData(localPlayer,"trafiBassza") and not Elkapta then
						if getVehicleController(getPedOccupiedVehicle(localPlayer)) == getLocalPlayer() then
							setElementData(localPlayer,"trafiBassza",true)
							Elkapta = true
							ElkaptaTick = ElkaptaTick + 1
							
							if ElkaptaTick == 1 then	
								if --[[getElementData(localPlayer, "char:ov") or]] getVehicleSpeed() > tonumber(v[7]+getVehicleSpeed()/10) then 
									Birsag = calculateBirsag(getVehicleSpeed() - v[7])/100 * 7000
									Sebszam = getVehicleSpeed() - v[7]
									outputChatBox("#ffffff--------------------------------------------------------------------------------------------------------",0,0,255,true)
									outputChatBox("#b7ff00[Traffipax] #ffffffÁtlépted sebességhatárt! A megengedett sebesség: #F4B350"..v[7].."#ffffff km/h!",0,0,255,true)
									outputChatBox("#b7ff00[Traffipax] #ffffffA túllépés mértéke: #D24D57"..math.ceil(Sebszam).." km/h. #ffffffBirság: #b7ff00"..math.ceil(Birsag).." Ft",0,0,255,true)
									triggerServerEvent("onTrafiHit", localPlayer, localPlayer, Birsag)
									fadeCamera(false, 0.5,255,255,255)
									createEffect("camflash", v[1],v[2],v[3]+0.5)
									
									playSound("files/shutter.mp3")
									
									setTimer (function () 
										fadeCamera(true,0.5)
									end,400,1)
								--[[elseif getElementData(localPlayer, "char:ov") and  getVehicleSpeed() > tonumber(v[7]+getVehicleSpeed()/10) and getVehicleType(getPedOccupiedVehicle(localPlayer)) ~= "Bike" then 
									Birsag = 10+calculateBirsag(getVehicleSpeed() - v[7])/100 * 50
									outputChatBox("#b7ff00[Traffipax] #ffffffNem volt bekötve a biztonsági öved, ezért büntetésben részesültél. Bírság: #dc143cFt".. Birsag,0,0,255,true)
								--	outputChatBox("#b7ff00[Traffipax] #ffffffRemélem legközelebb odafigyel a saját biztonsága érdekében .",0,0,255,true)
									triggerServerEvent("onTrafiHit", localPlayer, localPlayer, Birsag)
									fadeCamera(false, 0.5,255,255,255)
									createEffect("camflash", v[1],v[2],v[3]+0.5)
									
									playSound("files/shutter.mp3")
									
									setTimer (function () 
										fadeCamera(true, 0.5)
									end,400,1)
								end]]
								--[[if not getElementData(localPlayer, "char:ov") and getVehicleType(getPedOccupiedVehicle(localPlayer)) ~= "Bike"  then 
									Birsag = 10
									outputChatBox("#b7ff00[Traffipax] #ffffffNem volt bekötve a biztonsági öved, ezért büntetésben részesültél. Bírság: #dc143cFt".. Birsag,0,0,255,true)
									--outputChatBox("#b7ff00[Traffipax] #ffffffRemélem legközelebb odafigyel a saját biztonsága érdekében.",0,0,255,true)
									triggerServerEvent("onTrafiHit", localPlayer, localPlayer, Birsag)
									fadeCamera(false, 0.5,255,255,255)
									createEffect("camflash", v[1],v[2],v[3]+0.5)
									
									playSound("files/shutter.mp3")
									
									setTimer (function () 
										fadeCamera(true, 0.5)
									end,400,1)
								end]]
								end
							end
							aT = setTimer(function()
								Elkapta = false
								setElementData(localPlayer,"trafiBassza",false)
								ElkaptaTick = 0
								if isTimer(aT) then
									killTimer(aT)
								end
							end,1500,1)
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), TrafiSpeed2 )

function calculateBirsag(a)
	if math.ceil(a) > 100 then
		return math.ceil(a*35/2)
	else
		return math.ceil(a*12/2)
	end
end

function getVehicleSpeed()
	local vehicle = getPedOccupiedVehicle(localPlayer)
    if isPedInVehicle(localPlayer) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161		
	end
    return 0
end

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
local speedCamObject
local Kepernyom = {guiGetScreenSize()}
local limits = 0
local SQLTabla = true


function setSpeedCam(commandName, Limit)
	if not isPedInVehicle(localPlayer) and getElementHealth(localPlayer) > 0 and not speedCamObject then
		if exports.nlrp_groups:isPlayerHavePermission(localPlayer, "traffipax") then
			if not Limit then
				outputChatBox("#b7ff00[NextLevel - Használat]#ffffff: /" .. commandName .. " [Speedlimits]", 255, 194, 14, true)
			else
				speedCamObject = createObject(7426, 0, 0, 0)
				setElementCollisionsEnabled(speedCamObject, false)
				
				outputChatBox("#b7ff00[NextLevel - Info] #ffffffSikeresen lérehoztad a taraffipax-ot az #EB9532'E' #ffffffgomb lenyomásálval tudod letenni a #EB9532'Backspace' #ffffffgomb lenyomásával pedig törölni tudod az traffipaxot.",255,255,255,true)
				
				addEventHandler("onClientRender", getRootElement(), setSpeedCamRender)
				attachElementToElement(speedCamObject,localPlayer,0.2,0.7,0.55,90,0,0)
				setElementRotation(speedCamObject, 90, 90, 0)
				toggleControl("sprint", false)
				toggleControl("jump", false)		
				limits = Limit
				setElementAlpha(speedCamObject, 155)
			end
		end
	end
end
addCommandHandler("traffipax", setSpeedCam, false, false)

function setSpeedCamRender()
	local playerX, playerY, playerZ = getElementPosition(localPlayer)
	local rotX, rotY, rotZ = getElementRotation(localPlayer)
	local angle = math.rad(rotZ + 45)

	local cornerX, cornerY = playerX, playerY
	local pointX, pointY = playerX + 0.75, playerY + 0.75

	local rotatedX = math.cos(angle) * (pointX - cornerX) - math.sin(angle) * (pointY- cornerY) + cornerX
	local rotatedY = math.sin(angle) * (pointX - cornerX) + math.cos(angle) * (pointY - cornerY) + cornerY
	
	local z = getGroundPosition(rotatedX, rotatedY, playerZ) + 0.5
	if getKeyState("e") then
		removeEventHandler("onClientRender", getRootElement(), setSpeedCamRender)
		destroyElement(speedCamObject)
		toggleControl("sprint", true)
		toggleControl("jump", true)
		speedCamObject = nil
		addEventHandler("onClientRender", getRootElement(), SpeedCamText)


		triggerServerEvent("syncSpeedCameras", resourceRoot, rotatedX, rotatedY, z + 1.15, rotZ,limits)
	elseif getKeyState("backspace") then
		removeEventHandler("onClientRender", getRootElement(), setSpeedCamRender)
		toggleControl("enter_exit", true)
		toggleControl("sprint", true)
		toggleControl("jump", true)
		destroyElement(speedCamObject)
		--destroyElement(speedCamObject)
		speedCamObject = nil
	end
end

function reMap(x, in_min, in_max, out_min, out_max)
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function getElementSpeed(element, unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="km/h" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		return false
	end
end

function SpeedCameraCreate ()
	dxDrawImage(Kepernyom[1] / 2 - 25, Kepernyom[2] / 2 - 25, 50, 50, "files/speedcam-pointer.png")
	
	local speedCamera = getElementData(localPlayer, "usingSpeedCamera")

	local x, y, z = getElementPosition(speedCamera)
	local rotX, rotY, rotZ = getElementRotation(speedCamera)

	local cursorX, cursorY = getCursorPosition()

	targetX = reMap(cursorX, 0, 1, 80, -80)
	targetZ = reMap(cursorY, 0, 1, z + 10, z - 10)

	local angle = math.rad(rotZ + 45)

	local cornerX, cornerY = x, y
	local pointX, pointY = cornerX + 10, cornerY + 10

	local rotatedX = math.cos(angle + math.rad(targetX)) * (pointX - cornerX) - math.sin(angle + math.rad(targetX)) * (pointY - cornerY) + cornerX
	local rotatedY = math.sin(angle + math.rad(targetX)) * (pointX - cornerX) + math.cos(angle + math.rad(targetX)) * (pointY - cornerY) + cornerY

	local cornerX2, cornerY2 = x, y
	local pointX2, pointY2 = cornerX2 + 0.3, cornerY2 + 0.3

	local rotatedX2 = math.cos(angle) * (pointX2 - cornerX2) - math.sin(angle) * (pointY2 - cornerY2) + cornerX2
	local rotatedY2 = math.sin(angle) * (pointX2 - cornerX2) + math.cos(angle) * (pointY2 - cornerY2) + cornerY2
	
	setCameraMatrix(rotatedX2, rotatedY2, z+1.5, rotatedX, rotatedY, targetZ)
	
	local vehicles = getElementsByType("vehicle", getRootElement(), true)
	local vehicle

	for k, v in ipairs(vehicles) do
		for i=1, 20 do
			local angle = math.rad(rotZ + 45)

			local cornerX, cornerY = x, y
			local pointX, pointY = cornerX + i, cornerY + i

			local worldX = math.cos(angle + math.rad(targetX)) * (pointX - cornerX) - math.sin(angle + math.rad(targetX)) * (pointY - cornerY) + cornerX
			local worldY = math.sin(angle + math.rad(targetX)) * (pointX - cornerX) + math.cos(angle + math.rad(targetX)) * (pointY - cornerY) + cornerY
			local worldZ = targetZ

			local vehX, vehY, vehZ = getElementPosition(v)

			local distance = getDistanceBetweenPoints3D(worldX, worldY, worldZ, vehX, vehY, vehZ)

			local lineClear = isLineOfSightClear(rotatedX2, rotatedY2, z + 0.7, worldX, worldY, worldZ, true, false)

	
			if distance < 5.4 * reMap(distance, 1, 500, 1, 30) and lineClear then
				vehicle = v
				break
			end
		end
	end
	dxDrawRectangle(0, 0, Kepernyom[1], 30, tocolor(0, 0, 0, 225))
	dxDrawRectangle(0, 30, 200, Kepernyom[2] - 30, tocolor(0, 0, 0, 225))


	local memory = getElementData(speedCamera, "memory")

	if not memory then
		memory = {}
	end

	if vehicle then 
		local speed = math.floor(getElementSpeed(vehicle) * 10) / 10
		local plate = getVehiclePlateText(vehicle)

		local speedRecord = getElementData(speedCamera, "speed" .. plate)

		if not speedRecord then 
			speedRecord = 0
		end

		if speedRecord < speed then
			speedRecord = speed
			setElementData(speedCamera, "speed" .. plate, speedRecord)
		end

		if limits + 5 < speed and getElementModel(vehicle) ~= 416 and getElementModel(vehicle) ~= 427 and getElementModel(vehicle) ~= 490 and getElementModel(vehicle) ~= 523 and getElementModel(vehicle) ~= 528 and getElementModel(vehicle) ~= 596 and getElementModel(vehicle) ~= 597 and getElementModel(vehicle) ~= 598 and getElementModel(vehicle) ~= 599 and getElementModel(vehicle) ~= 601 and getElementModel(vehicle) ~= 407 and getElementModel(vehicle) ~= 418 and getElementModel(vehicle) ~= 481 and getElementModel(vehicle) ~= 509 and getElementModel(vehicle) ~= 510 then
			local found

			for k, v in ipairs(memory) do
				if v[1] == plate then
					found = true
					memory[k] = {plate, speedRecord}
					break
				end
			end

			if not found then
				table.insert(memory, {plate, speedRecord})
			end
			--playSound("files/shutter.mp3")
			setElementData(speedCamera, "memory", memory)
			fadeCamera(false, 0.5,255,255,255)								
			setTimer (function () 
				fadeCamera(true, 0.5)
			end,400,1)
			if not (getElementData(vehicle, "Traffipax")) then 
				local occupants = getVehicleOccupants(vehicle) or {} 
				for seat, occupant in pairs(occupants) do 
					if (occupant and getElementType(occupant) == "player") then
						if seat == 0 then 
							if getElementData(player, "char:ov") then 
								triggerServerEvent("createAmount", localPlayer, localPlayer, occupant, tonumber(calculateTraffipaxBirsag(speed)), limits)
							else
								triggerServerEvent("createAmount", localPlayer, localPlayer, occupant, tonumber(calculateTraffipaxBirsag(speed)) + 10, limits)
							end
							player = occupant
						end
					end
				end
				if getElementData(player, "char:ov") then 
					setElementData(player, "char.Money", getElementData(player,"char.Money") - math.floor(tonumber(calculateTraffipaxBirsag(speed))))
				else
					setElementData(player, "char.Money", getElementData(player,"char.Money") - math.floor(tonumber(calculateTraffipaxBirsag(speed))) - 10)
				end
				setElementData(vehicle, "Traffipax", true)
				setTimer (function () 
					setElementData(vehicle, "Traffipax", false)
				end,4000,1)
			end
		end
		dxDrawText("[#87D37C" .. plate .. "#ffffff] #87D37C" ..math.floor( speed ).."#ffffffKM/h " .. "MAX: #87D37C" .. math.floor(speedRecord * 10) / 10 .. "#ffffffKM/h Limit: #87D37C" .. limits .. "#ffffff KM/h", 0, 10, Kepernyom[1], 10, tocolor(255, 255, 255, 255), 1, "sans", "center", "center",false,false,false,true)
	else
		dxDrawText("[Nincs Jel]", 0, 10, Kepernyom[1], 10, tocolor(210, 77, 87, 200), 1, "sans", "center", "center")
	end

	local memoryString = "Memory:\n\n"

	for k, v in ipairs(memory) do
		dxDrawText("[" ..v[1] .. "] " ..math.floor(v[2]) .. "#87D37CKM/h \n", 25, 25+k*(11), 300, Kepernyom[2] - 100, tocolor(255, 255, 255, 200), 0.75, "sans","left", "top",false,false,false,true)
	end

	
	if getKeyState("backspace") then
		
		localPlayer:setData("togInterface",false)		
		setElementData(speedCamera, "inUse", false)
		setElementData(localPlayer, "usingSpeedCamera", false)
		removeEventHandler("onClientRender", getRootElement(), SpeedCameraCreate)

		setCameraTarget(localPlayer)
		showCursor(false)

		setCursorAlpha(255)

		showChat(true)
	end
end
setCursorAlpha(255)
fadeCamera(true, 0.5)

function calculateTraffipaxBirsag(a)
	if math.ceil(a) > 100 then
		return math.ceil(a*2)
	else
		return math.ceil(a*1)
	end
end

function getElementDataPlayerByAccountID(owner,elementDataName)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"acc:id") == owner then
			return getElementData(v,elementDataName)
		end
	end
end

function speedCameraClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if button == "right" and state == "up" and clickedElement and getElementData(clickedElement, "speedCamera") and not isPedInVehicle(localPlayer) then
		if getElementData(clickedElement, "inUse") then
			outputChatBox("#D24D57[NextLevel - Hiba] #ffffffValaki már használja!",255,255,255,true)
			return
		end
		setElementData(clickedElement, "inUse", true)
		setElementData(localPlayer, "usingSpeedCamera", clickedElement)
		addEventHandler("onClientRender", getRootElement(), SpeedCameraCreate)
		localPlayer:setData("togInterface",true)

		showCursor(true)

		setCursorAlpha(0)

		showChat(false)
	end
end
addEventHandler("onClientClick", getRootElement(), speedCameraClick)