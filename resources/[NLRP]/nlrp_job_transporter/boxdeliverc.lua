--getElementData(resourceRoot, "donePackages")
txd = engineLoadTXD ( "1640.txd" )
engineImportTXD ( txd, 1640 )
dff = engineLoadDFF ( "1640.dff", 1640 )
engineReplaceModel ( dff, 1640 )
col = engineLoadCOL ( "1640.col" )
engineReplaceCOL ( col, 1640 )
txd2 = engineLoadTXD ( "456.txd" )
engineImportTXD ( txd2, 456 )
dff2 = engineLoadDFF ( "456.dff", 456 )
engineReplaceModel ( dff2, 456 )

addPlayerBox = createColSphere ( 2764.5397949219, -2348.6459960938, 12.77187538147, 3 )

local jobPed = createPed ( 36, 2757.3464355469, -2331.2145996094, 14.78235244751, 180 )
local JOB_ID = 4

local maxPackages = 16
local serverCurrentPackages = 0
local moveable = false
local jobselecting = false
local currentveh = nil
local screenWidth,screenHeight = guiGetScreenSize()  -- Get screen resolution.
local jobBox = 0
local jobPrice = 0
local jobAllPack = 0
local moveBox = false

local jobName1,jobPacks1, jobEndX1, jobEndY1, jobEndZ1, jobPay1
local jobName2,jobPacks2, jobEndX2, jobEndY2, jobEndZ2, jobPay2
local jobName3,jobPacks3, jobEndX3, jobEndY3, jobEndZ3, jobPay3
local jobName4,jobPacks4, jobEndX4, jobEndY4, jobEndZ4, jobPay4
local jobName5,jobPacks5, jobEndX5, jobEndY5, jobEndZ5, jobPay5
local jobName6,jobPacks6, jobEndX6, jobEndY6, jobEndZ6, jobPay6
local jobName7,jobPacks7, jobEndX7, jobEndY7, jobEndZ7, jobPay7

local endMarker, endBlip, endTimer

local exitTimer, exitTimer2

function MarkerHit ( hitPlayer, matchingDimension )
	if source == endMarker then
		if hitPlayer == getLocalPlayer() and getPedOccupiedVehicle(getLocalPlayer()) then
			if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "veh:packages") == jobAllPack then
				outputChatBox("[Csomag szállító]#FFFFFF Kérjük várd meg amíg lepakolják az árút. ".. jobAllPack .." másodperc.",205,55,55,true)
				endTimer = setTimer(function()
					triggerServerEvent ( "removeAllPackages", resourceRoot,getPedOccupiedVehicle(getLocalPlayer()) )
					outputChatBox("[Csomag szállító]#FFFFFF Minden szállítmányt lepakoltak a fizetésed ".. jobPrice .."  Ft.",205,55,55,true)
					triggerServerEvent("addPlayerMoney",resourceRoot,getLocalPlayer(),jobPrice)
					outputChatBox("[Csomag szállító]#FFFFFF Menny add le a járművet vagy vegyél fel új rakományt!",205,55,55,true)
					setElementData(getLocalPlayer(), "Jobbing", 1)
					jobBox = 0
					jobPrice = 0
					jobAllPack = 0
					destroyElement(endMarker)
					destroyElement(endBlip)
				end, jobAllPack*1000, 1)
			else
				outputChatBox("[Csomag szállító]#FFFFFF Nem pakoltál fel minden csomagot, meny vissza és pakold fel az összeset!",205,55,55,true)
			end
		end
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

function markerLeave ( leavingPlayer, matchingDimension )
    if leavingPlayer == getLocalPlayer() then
    	if isTimer(endTimer) then
    		killTimer(endTimer)
    	end
    end
end
addEventHandler ( "onClientMarkerLeave", getRootElement(), markerLeave )

function moveRamp()
	if moveable then
		if getElementData(currentveh, "veh:ramp:state") == "moveing" then
			dxDrawImage ( screenWidth/2 - 30, 10, 60, 60, "files/progress.png", (getTickCount())  )
		elseif getElementData(currentveh, "veh:ramp:state") == "closed" then
			dxDrawRectangle(screenWidth/2 - 25, 10, 50, 50,tocolor(0,0,0,150))
			dxDrawImage ( screenWidth/2 - 25, 10, 50, 50, "files/left.png" )
		elseif getElementData(currentveh, "veh:ramp:state") == "openned" then
			dxDrawRectangle(screenWidth/2 - 55, 10, 50, 50,tocolor(0,0,0,150))
			dxDrawRectangle(screenWidth/2 + 5, 10, 50, 50,tocolor(0,0,0,150))
			dxDrawImage ( screenWidth/2 + 5, 10, 50, 50, "files/down.png" )
			dxDrawImage ( screenWidth/2 - 55, 10, 50, 50, "files/right.png" )
		elseif getElementData(currentveh, "veh:ramp:state") == "downed" then
			dxDrawRectangle(screenWidth/2 - 25, 10, 50, 50,tocolor(0,0,0,150))
			dxDrawImage ( screenWidth/2 - 25, 10, 50, 50, "files/up.png" )
		end
	end
	if jobselecting then
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 - 150, 600, 300, tocolor(0,0,0,150))
		dxDrawText("Válassz rakományt!",screenWidth/2 - 300, screenHeight/2 - 150,screenWidth/2 - 300 + 600, screenHeight/2 - 150 + 20, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 - 125, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName1.." - "..jobPacks1.." láda | Végállomás: "..getZoneName ( jobEndX1, jobEndY1, jobEndZ1).." | Fizetés: "..jobPay1.." Ft",screenWidth/2 - 300, screenHeight/2 - 125,screenWidth/2 - 300 + 600, screenHeight/2 - 125 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 - 95, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName2.." - "..jobPacks2.." láda | Végállomás: "..getZoneName ( jobEndX2, jobEndY2, jobEndZ2).." | Fizetés: "..jobPay2.." Ft",screenWidth/2 - 300, screenHeight/2 - 95,screenWidth/2 - 300 + 600, screenHeight/2 - 95 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 - 65, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName3.." - "..jobPacks3.." láda | Végállomás: "..getZoneName ( jobEndX3, jobEndY3, jobEndZ3).." | Fizetés: "..jobPay3.." Ft",screenWidth/2 - 300, screenHeight/2 - 65,screenWidth/2 - 300 + 600, screenHeight/2 - 65 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 - 35, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName4.." - "..jobPacks4.." láda | Végállomás: "..getZoneName ( jobEndX4, jobEndY4, jobEndZ4).." | Fizetés: "..jobPay4.." Ft",screenWidth/2 - 300, screenHeight/2 - 35,screenWidth/2 - 300 + 600, screenHeight/2 - 35 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 - 5, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName5.." - "..jobPacks5.." láda | Végállomás: "..getZoneName ( jobEndX5, jobEndY5, jobEndZ5).." | Fizetés: "..jobPay5.." Ft",screenWidth/2 - 300, screenHeight/2 - 5,screenWidth/2 - 300 + 600, screenHeight/2 - 5 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 + 25, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName6.." - "..jobPacks6.." láda | Végállomás: "..getZoneName ( jobEndX6, jobEndY6, jobEndZ6).." | Fizetés: "..jobPay6.." Ft",screenWidth/2 - 300, screenHeight/2 + 25,screenWidth/2 - 300 + 600, screenHeight/2 + 25 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 + 55, 600, 25, tocolor(0,0,0,150))
		dxDrawText("Rakomány: "..jobName7.." - "..jobPacks7.." láda | Végállomás: "..getZoneName ( jobEndX7, jobEndY7, jobEndZ7).." | Fizetés: "..jobPay7.." Ft",screenWidth/2 - 300, screenHeight/2 + 55,screenWidth/2 - 300 + 600, screenHeight/2 + 55 + 25, tocolor(255,255,255,255),1,"default","center","center")
		dxDrawRectangle(screenWidth/2 - 300, screenHeight/2 + 85, 600, 65, tocolor(205,55,55,150))
		dxDrawText("Bezárás",screenWidth/2 - 300, screenHeight/2 + 85,screenWidth/2 - 300 + 600, screenHeight/2 + 85 + 65, tocolor(255,255,255,255),1,"default","center","center")
	end
end
addEventHandler("onClientRender", getRootElement(), moveRamp)

function onClientColShapeHit( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
    	if source == addPlayerBox then
    		if getElementData(getLocalPlayer(), "Jobbing") and getElementData(getLocalPlayer(), "Jobbing") > 0 and not moveBox and jobBox > 0 then
    			moveBox = true
    			jobBox = jobBox - 1
				triggerServerEvent ( "addPackageToPlayer", resourceRoot,getLocalPlayer() )
			else
				outputChatBox("[Csomag szállító]#FFFFFF Már minden csomagot bepakoltál vagy nem kezdted el még a munkát.",205,55,55,true)
    		end
    	else
	        if getElementData(source, "col:addToVeh") and getElementData(source, "col:veh") and moveBox and getElementData(getLocalPlayer(), "Jobbing") and getElementData(getLocalPlayer(), "Jobbing") > 0 then
    			if getElementData(getLocalPlayer(), "acc.dbID") == getElementData(getElementData(source, "col:veh"), "veh:owner") then
					triggerServerEvent ( "addPackageToVeh", resourceRoot, getElementData(source, "col:veh"),getLocalPlayer() )
	    			moveBox = false
	    			if jobBox > 0 then
						outputChatBox("[Csomag szállító]#FFFFFF Bepakoltál egy csomagot. Még "..jobBox.."db ot kell bepakolnod.",205,55,55,true)
					else
						outputChatBox("[Csomag szállító]#FFFFFF Bepakoltad az összes csomagot. Mostmár csak el kell szállítanod a rakományt.",205,55,55,true)
						outputChatBox("[Csomag szállító]#FFFFFF Az szállítási helyet megjelöltük egy doboz ikonnal a minimapen.",205,55,55,true)
					end
				else
					outputChatBox("[Csomag szállító]#FFFFFF Ez nem a te járműved.",205,55,55,true)
				end
	        elseif getElementData(source, "col:veh") then
	        	setElementData(getLocalPlayer(), "veh:moveable", true)
	        	setElementData(getLocalPlayer(),"veh:vehMove",getElementData(source, "col:veh"))
	        	moveable = true
	        	currentveh = getElementData(source, "col:veh")
	        end
	    end
    end
end
addEventHandler("onClientColShapeHit",getRootElement(),onClientColShapeHit)

function onClientColShapeLeave( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
        if getElementData(source, "col:veh") and not getElementData(source, "col:addToVeh") then
        	setElementData(getLocalPlayer(), "veh:moveable", false)
        	setElementData(getLocalPlayer(),"veh:vehMove",nil)
        	moveable = false
        	currentveh = nil
        end
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),onClientColShapeLeave)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "vehicle" and dataName == "veh:ramp:posX" then
		local x, y, z = getVehicleComponentPosition(source, "boot_dummy") --get the position of the component
        setVehicleComponentPosition(source, "boot_dummy", getElementData(source,"veh:ramp:posX"), y, z) -- increases by 1 unit
	elseif getElementType ( source ) == "vehicle" and dataName == "veh:ramp:posY" then
		local x, y, z = getVehicleComponentPosition(source, "boot_dummy") --get the position of the component
        setVehicleComponentPosition(source, "boot_dummy", x, getElementData(source,"veh:ramp:posY"), z) -- increases by 1 unit
	elseif getElementType ( source ) == "vehicle" and dataName == "veh:ramp:posZ" then
		local x, y, z = getVehicleComponentPosition(source, "boot_dummy") --get the position of the component
        setVehicleComponentPosition(source, "boot_dummy", x, y, getElementData(source,"veh:ramp:posZ")) -- increases by 1 unit
	elseif getElementType ( source ) == "vehicle" and dataName == "veh:ramp:posZ" then
		local x, y, z = getVehicleComponentPosition(source, "boot_dummy") --get the position of the component
        setVehicleComponentPosition(source, "boot_dummy", x, y, getElementData(source,"veh:ramp:posZ")) -- increases by 1 unit
	elseif getElementType ( source ) == "vehicle" and dataName == "veh:ramp:rotX" then
		local rx, ry, rz = getVehicleComponentRotation(source, "boot_dummy")
        setVehicleComponentRotation(source, "boot_dummy", getElementData(source,"veh:ramp:rotX") * -1, 180, 180) -- increases by 10 unit
	end
end )

function onClientClick ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if ( clickedElement ) == jobPed and getElementData(localPlayer, "char.Job") == JOB_ID then
	    if button == "left" and state == "down" then
			if getElementData(getLocalPlayer(),"Jobbing") == 1 or getElementData(getLocalPlayer(),"Jobbing") == 2 then

                    serverCurrentPackages = tonumber(getElementData(root, "donePackages"))
                    if serverCurrentPackages > 0 then
						if serverCurrentPackages > 16 then
							serverCurrentPackages = 16
						end
                        jobselecting = not jobselecting
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName1,jobPacks1, jobEndX1, jobEndY1, jobEndZ1, jobPay1 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName2,jobPacks2, jobEndX2, jobEndY2, jobEndZ2, jobPay2 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName3,jobPacks3, jobEndX3, jobEndY3, jobEndZ3, jobPay3 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName4,jobPacks4, jobEndX4, jobEndY4, jobEndZ4, jobPay4 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName5,jobPacks5, jobEndX5, jobEndY5, jobEndZ5, jobPay5 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName6,jobPacks6, jobEndX6, jobEndY6, jobEndZ6, jobPay6 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                        local RName = math.random(1,1)
                        local RPacks = math.random(1,serverCurrentPackages)
                        local RPos = math.random(1,#packageEndPosTable)
                        local price = math.floor(RPacks * packagesTable[RName][2] + getDistanceBetweenPoints2D ( 2182.58618, -2253.28271, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2] ) * 1.5)
                        jobName7,jobPacks7, jobEndX7, jobEndY7, jobEndZ7, jobPay7 = packagesTable[RName][1], RPacks, packageEndPosTable[RPos][1], packageEndPosTable[RPos][2], packageEndPosTable[RPos][3], price
                    else
                        outputChatBox("[Csomag szállító]#FFFFFF Jelenleg nincsen egy csomag sem amit eltudnal szallitani.",205,55,55,true)
                    end
		    else
				outputChatBox("[Csomag szállító]#FFFFFF Először vegyél fel egy munkakocsit.",205,55,55,true)
		    end
		end
	elseif button == "left" and state == "down" then
		if jobselecting then
			if absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 + 85 and absoluteY < screenHeight/2 + 85 + 65 then
    			jobselecting = not jobselecting
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 - 125 and absoluteY < screenHeight/2 - 125 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks1
    			jobPrice = jobPay1
    			jobAllPack = jobPacks1
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX1, jobEndY1, jobEndZ1 , "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX1, jobEndY1, jobEndZ1, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 - 95 and absoluteY < screenHeight/2 - 95 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks2
    			jobPrice = jobPay2
    			jobAllPack = jobPacks2
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX2, jobEndY2, jobEndZ2 , "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX2, jobEndY2, jobEndZ2, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 - 65 and absoluteY < screenHeight/2 - 65 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks3
    			jobPrice = jobPay3
    			jobAllPack = jobPacks3
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX3, jobEndY3, jobEndZ3 , "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX3, jobEndY3, jobEndZ3, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 - 35 and absoluteY < screenHeight/2 - 35 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks4
    			jobPrice = jobPay4
    			jobAllPack = jobPacks4
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX4, jobEndY4, jobEndZ4 , "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX4, jobEndY4, jobEndZ4, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 - 5 and absoluteY < screenHeight/2 - 5 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks5
    			jobPrice = jobPay5
    			jobAllPack = jobPacks5
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX5, jobEndY5, jobEndZ5, "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX5, jobEndY5, jobEndZ5, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 + 25 and absoluteY < screenHeight/2 + 25 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks6
    			jobPrice = jobPay6
    			jobAllPack = jobPacks6
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX6, jobEndY6, jobEndZ6, "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX6, jobEndY6, jobEndZ6, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			elseif absoluteX > screenWidth/2 - 300 and absoluteX < screenWidth/2 - 300 + 600 and absoluteY > screenHeight/2 + 55 and absoluteY < screenHeight/2 + 55 + 25 then
    			jobselecting = not jobselecting
    			jobBox = jobPacks7
    			jobPrice = jobPay7
    			jobAllPack = jobPacks7
				setElementData(getLocalPlayer(), "Jobbing", 2)
				endMarker = createMarker ( jobEndX7, jobEndY7, jobEndZ7, "checkpoint", 4.0, 205, 55, 55, 50 )
				endBlip = createBlip ( jobEndX7, jobEndY7, jobEndZ7, 56)
				setElementData(endBlip,"blipIcon","package")
				setElementData(endBlip,"blipTooltipText","Szállítási Cél")
				setElementData(endBlip,"blipColor",tocolor(255,255,255,255))
			end
            if jobAllPack > 0 then
                triggerServerEvent ( "minusPackages", resourceRoot, getLocalPlayer(), jobAllPack )
            end
		else
			
				if currentveh and getElementData(currentveh, "veh:ramp:state") == "closed" then
					if absoluteX > screenWidth/2 - 25 and absoluteX < screenWidth/2 - 25 + 50 and absoluteY > 10 and absoluteY < 60 then
						triggerServerEvent ( "onOpenRamp", resourceRoot, getLocalPlayer() )
					end
				elseif currentveh and getElementData(currentveh, "veh:ramp:state") == "openned" then
					if absoluteX > screenWidth/2 - 55 and absoluteX < screenWidth/2 - 55 + 50 and absoluteY > 10 and absoluteY < 60 then
						triggerServerEvent ( "onCloseRamp", resourceRoot, getLocalPlayer() )
					elseif absoluteX > screenWidth/2 + 5 and absoluteX < screenWidth/2 + 5 + 50 and absoluteY > 10 and absoluteY < 60 then
						triggerServerEvent ( "onDownRamp", resourceRoot, getLocalPlayer() )
					end
				elseif currentveh and getElementData(currentveh, "veh:ramp:state") == "downed" then
					if absoluteX > screenWidth/2 - 25 and absoluteX < screenWidth/2 - 25 + 50 and absoluteY > 10 and absoluteY < 60 then
						triggerServerEvent ( "onUpRamp", resourceRoot, getLocalPlayer() )
					end
				end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), onClientClick )

function playerPressedKey(button, press)
    if (press) then
        if moveBox then
            if "w" == button or "a" == button or "s" == button or "d" == button or "m" == button or "tab" == button or "i" == button then
            else
                cancelEvent()
            end
        end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)

local texture = dxCreateTexture("files/marker.png")
local renderTarget1 = dxCreateRenderTarget(1024, 1024, true)
addEventHandler("onClientRender", getRootElement(),
	function ()
		dxSetRenderTarget(renderTarget1, true)
			dxDrawImage(250, 250, 274, 274, texture, getTickCount() / 50, 0, 0, tocolor(205, 55, 55, 200), false)
		dxSetRenderTarget()
		dxDrawMaterialLine3D(2800.1101074219 - 1.2,-2406.9482421875 - 3.75,13.636850357056 - 0.95, 2800.1101074219 - 1.2,2406.9482421875 + 6.25,13.636850357056 - 0.95, renderTarget1, 10, tocolor(255, 255, 255, 255), 2040, -1432, 16.168 + 500000000)
		local x, y, z = getElementPosition(localPlayer)
		local distance = getDistanceBetweenPoints3D(x, y, z, 2764.5397949219, -2348.6459960938, 12.77187538147)

		if distance < 20 then
			local dx, dy = getScreenFromWorldPosition(2764.5397949219, -2348.6459960938, 12.77187538147 + 2, 10)
				local scale = 512 / distance

			if scale > 32 then
				scale = 32
			end

		if not dx and not dy then return end
			dxDrawImage(dx - scale / 2, dy - scale / 2, scale, scale, "files/package.png", 0, 0, 0, tocolor(255, 255, 255, 200))
		end
	end)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
				if isTimer(exitTimer) then
					killTimer(exitTimer)
				end
				if isTimer(exitTimer2) then
					killTimer(exitTimer2)
				end
        end
    end
)

setElementData(getLocalPlayer(), "Jobbing", 0)

addEventHandler("onClientVehicleExit", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
			if getElementData(source, "veh:owner") then
				outputChatBox("[Csomag szállító]#FFFFFF 5 perced van hogy vissza szállj a járművedbe különben törtlődik.",205,55,55,true)
				exitTimer = setTimer(function()
						triggerServerEvent ( "destroyJobVeh", resourceRoot, getLocalPlayer() )
						setElementData(getLocalPlayer(), "Jobbing", 0)
						jobBox = 0
						jobPrice = 0
						jobAllPack = 0
						if isElement(endMarker) then destroyElement(endMarker) end
						if isElement(endBlip) then destroyElement(endBlip) end
						outputChatBox("[Csomag szállító]#FFFFFF Járműved törölve.",205,55,55,true)
				end,5*(60*1000), 1)
				exitTimer2 = setTimer(function()
					outputChatBox("[Csomag szállító]#FFFFFF 1 perced van hogy vissza szállj a járművedbe különben törtlődik.",205,55,55,true)
				end,240000, 1)
			end
        end
    end
)