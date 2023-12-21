spawnMarker = createMarker(2795.2641601563, -2430.2436523438, 13.640400886536,"checkpoint", 3, 205, 55, 55, 50)
createBlip(2782.7341308594, -2411.1748046875, 13.649580001831,9)
local JOB_ID = 4
function MarkerHit( hitElement, matchingDimension )
    if getElementType(hitElement) == "player" and getElementData(hitElement, "char.Job") == JOB_ID then
        if not getElementData(hitElement, "Jobbing") or getElementData(hitElement, "Jobbing") == 0 then
            cv (hitElement)
            setElementData(hitElement, "Jobbing", 1)
        end
    elseif getElementType(hitElement) == "vehicle" and getElementData(getVehicleOccupant ( hitElement ), "char.Job") == JOB_ID and getElementData(getVehicleOccupant ( hitElement ), "Jobbing") == 1 then
        setElementData(getVehicleOccupant ( hitElement ), "Jobbing", 0)
        destroyJobVeh (getVehicleOccupant ( hitElement ))
    end
end
addEventHandler( "onMarkerHit", spawnMarker, MarkerHit ) -- attach onMarkerHit event to MarkerHit function

function cv (source)
        local rand = math.random(1,#jobSpawnPoses)
        local x,y,z = jobSpawnPoses[rand].pos[1],jobSpawnPoses[rand].pos[2],jobSpawnPoses[rand].pos[3]
        vehicle = createVehicle ( 456, x,y,z)
        setElementRotation(vehicle,jobSpawnPoses[rand].rot[1],jobSpawnPoses[rand].rot[2],jobSpawnPoses[rand].rot[3])
        ramp = createObject ( 1640, 0, 0, 0)
        package1 = createObject ( 1271, 0, 0, 0)
        package2 = createObject ( 1271, 0, 0, 0)
        package3 = createObject ( 1271, 0, 0, 0)
        package4 = createObject ( 1271, 0, 0, 0)
        package5 = createObject ( 1271, 0, 0, 0)
        package6 = createObject ( 1271, 0, 0, 0)
        package7 = createObject ( 1271, 0, 0, 0)
        package8 = createObject ( 1271, 0, 0, 0)
        package9 = createObject ( 1271, 0, 0, 0)
        package10 = createObject ( 1271, 0, 0, 0)
        package11 = createObject ( 1271, 0, 0, 0)
        package12 = createObject ( 1271, 0, 0, 0)
        package13 = createObject ( 1271, 0, 0, 0)
        package14 = createObject ( 1271, 0, 0, 0)
        package15 = createObject ( 1271, 0, 0, 0)
        package16 = createObject ( 1271, 0, 0, 0)
        setElementAlpha ( package1, 0 )
        setElementAlpha ( package2, 0 )
        setElementAlpha ( package3, 0 )
        setElementAlpha ( package4, 0 )
        setElementAlpha ( package5, 0 )
        setElementAlpha ( package6, 0 )
        setElementAlpha ( package7, 0 )
        setElementAlpha ( package8, 0 )
        setElementAlpha ( package9, 0 )
        setElementAlpha ( package10, 0 )
        setElementAlpha ( package11, 0 )
        setElementAlpha ( package12, 0 )
        setElementAlpha ( package13, 0 )
        setElementAlpha ( package14, 0 )
        setElementAlpha ( package15, 0 )
        setElementAlpha ( package16, 0 )
        rampCol = createColSphere ( 0, 0, 0, 3 )
        addToVehicle = createColSphere ( 0, 0, 0, 1 )

        attachElements ( package1, vehicle, 0.5,-0.5, 0.4,0,0,0)
        attachElements ( package2, vehicle, 0.5,-0.5, 1.1,0,0,0)
        attachElements ( package3, vehicle, -0.5,-0.5, 0.4,0,0,0)
        attachElements ( package4, vehicle, -0.5,-0.5, 1.1,0,0,0)
        attachElements ( package5, vehicle, 0.5,-1.3, 0.4,0,0,0)
        attachElements ( package6, vehicle, 0.5,-1.3, 1.1,0,0,0)
        attachElements ( package7, vehicle, -0.5,-1.3, 0.4,0,0,0)
        attachElements ( package8, vehicle, -0.5,-1.3, 1.1,0,0,0)
        attachElements ( package9, vehicle, 0.5,-2.1, 0.4,0,0,0)
        attachElements ( package10, vehicle, 0.5,-2.1, 1.1,0,0,0)
        attachElements ( package11, vehicle, -0.5,-2.1, 0.4,0,0,0)
        attachElements ( package12, vehicle, -0.5,-2.1, 1.1,0,0,0)
        attachElements ( package13, vehicle, 0.5,-2.9, 0.4,0,0,0)
        attachElements ( package14, vehicle, 0.5,-2.9, 1.1,0,0,0)
        attachElements ( package15, vehicle, -0.5,-2.9, 0.4,0,0,0)
        attachElements ( package16, vehicle, -0.5,-2.9, 1.1,0,0,0)

        attachElements ( ramp, vehicle, 0,-5.27, 0.05,0,0,180)
        attachElements ( rampCol, vehicle, 0,-5.1, 0.05,0,0,0)
        attachElements ( addToVehicle, vehicle, 0,-4.2, 1,0,0,0)

		setElementAlpha ( ramp, 0 )
        setElementData(vehicle, "veh:ramp",ramp)
        setElementData(vehicle, "veh:rampcol",rampCol)
        setElementData(rampCol, "col:veh",vehicle)
        setElementData(addToVehicle, "col:veh",vehicle)
        setElementData(addToVehicle, "col:addToVeh",true)
        setElementData(vehicle, "veh:ramp:state","closed")
        setElementData(vehicle, "veh:packages",0)
        setElementData(vehicle, "veh:package:1",package1)
        setElementData(vehicle, "veh:package:2",package2)
        setElementData(vehicle, "veh:package:3",package3)
        setElementData(vehicle, "veh:package:4",package4)
        setElementData(vehicle, "veh:package:5",package5)
        setElementData(vehicle, "veh:package:6",package6)
        setElementData(vehicle, "veh:package:7",package7)
        setElementData(vehicle, "veh:package:8",package8)
        setElementData(vehicle, "veh:package:9",package9)
        setElementData(vehicle, "veh:package:10",package10)
        setElementData(vehicle, "veh:package:11",package11)
        setElementData(vehicle, "veh:package:12",package12)
        setElementData(vehicle, "veh:package:13",package13)
        setElementData(vehicle, "veh:package:14",package14)
        setElementData(vehicle, "veh:package:15",package15)
        setElementData(vehicle, "veh:package:16",package16)
        setElementData(vehicle, "veh:owner",getElementData(source,"acc.dbID"))
        setElementData(source, "job:veh",vehicle)
        warpPedIntoVehicle ( source, vehicle )
end
--addCommandHandler("cv",cv)

function destroyJobVeh (element)
	if isElement(element) then
	    for x = 1,16 do
	        if getElementData(getElementData(element,"job:veh"),"veh:package:"..x) then
	            destroyElement(getElementData(getElementData(element,"job:veh"),"veh:package:"..x))
	        end
	    end
	    if getElementData(getElementData(element,"job:veh"),"veh:ramp") then
	        destroyElement(getElementData(getElementData(element,"job:veh"),"veh:ramp"))
	    end
	    if getElementData(getElementData(element,"job:veh"),"veh:rampcol") then
	        destroyElement(getElementData(getElementData(element,"job:veh"),"veh:rampcol"))
	    end
	    if getElementData(element,"job:veh") then
	        destroyElement(getElementData(element,"job:veh"))
	    end
	   end
end
addEvent( "destroyJobVeh", true )
addEventHandler( "destroyJobVeh", resourceRoot, destroyJobVeh )

function quitPlayer ( quitType )
    destroyJobVeh (source)
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

function kickveh (element)
    removePedFromVehicle ( element )
end
addEvent( "kickveh", true )
addEventHandler( "kickveh", resourceRoot, kickveh )

function removeAllPackages(element)
    setElementData(element, "veh:packages",0)
    setElementAlpha (getElementData(element, "veh:package:1"), 0 )
    setElementAlpha (getElementData(element, "veh:package:2"), 0 )
    setElementAlpha (getElementData(element, "veh:package:3"), 0 )
    setElementAlpha (getElementData(element, "veh:package:4"), 0 )
    setElementAlpha (getElementData(element, "veh:package:5"), 0 )
    setElementAlpha (getElementData(element, "veh:package:6"), 0 )
    setElementAlpha (getElementData(element, "veh:package:7"), 0 )
    setElementAlpha (getElementData(element, "veh:package:8"), 0 )
    setElementAlpha (getElementData(element, "veh:package:9"), 0 )
    setElementAlpha (getElementData(element, "veh:package:10"), 0 )
    setElementAlpha (getElementData(element, "veh:package:11"), 0 )
    setElementAlpha (getElementData(element, "veh:package:12"), 0 )
    setElementAlpha (getElementData(element, "veh:package:13"), 0 )
    setElementAlpha (getElementData(element, "veh:package:14"), 0 )
    setElementAlpha (getElementData(element, "veh:package:15"), 0 )
    setElementAlpha (getElementData(element, "veh:package:16"), 0 )
end
addEvent( "removeAllPackages", true )
addEventHandler( "removeAllPackages", resourceRoot, removeAllPackages )

function addPlayerMoney(element, money)
    local default_money = getElementData(element,"char.Money")
    setElementData(element,"char.Money",default_money+tonumber(money))
end
addEvent( "addPlayerMoney", true )
addEventHandler( "addPlayerMoney", resourceRoot, addPlayerMoney )

function addPackageToVeh(element,player)
    setPedAnimation(player,nil,nil) -- NEM JÓ VALAMIÉRT
    exports.nlrp_boneattach:detachElementFromBone(getElementData(player, "job:pack"))
    destroyElement(getElementData(player, "job:pack"))
    setElementAlpha ( getElementData(element, "veh:package:".. getElementData(element, "veh:packages") + 1), 255 )
    setElementData(element, "veh:packages", getElementData(element, "veh:packages") + 1)
end
addEvent( "addPackageToVeh", true )
addEventHandler( "addPackageToVeh", resourceRoot, addPackageToVeh )

function addPackageToPlayer(element)
    pack = createObject ( 1271, 0, 0, 0)
    exports.nlrp_boneattach:attachElementToBone(pack,element,12,0.2,0.3,0.2,0,0,0)
    setPedAnimation(element, "CARRY", "crry_prtial", 0, true, false, true, true)
    setElementData(element, "job:pack", pack)
end
addEvent( "addPackageToPlayer", true )
addEventHandler( "addPackageToPlayer", resourceRoot, addPackageToPlayer )

function close(source)
   if getElementData(source,"veh:moveable") then
        local theVehicle = getElementData(source,"veh:vehMove")
        if getElementData(theVehicle,"veh:ramp:state") == "openned" then
            local rx1 = 270
            local last = 1
            setTimer ( function()
                    rx1 = rx1 - 1
                    setElementAttachedOffsets (getElementData(theVehicle,"veh:ramp"),0,-5.27, 0.05,rx1,180,0)
                    setElementData(theVehicle, "veh:ramp:posX",0)
                    setElementData(theVehicle, "veh:ramp:posY",-5.27)
                    setElementData(theVehicle, "veh:ramp:posZ",0.05)
                    setElementData(theVehicle, "veh:ramp:rotX",rx1)
                    setElementData(theVehicle, "veh:ramp:rotY",180)
                    setElementData(theVehicle, "veh:ramp:rotZ",0)
                    setElementData(theVehicle, "veh:ramp:state","moveing")
                    if last == 89 then
                     	setElementData(theVehicle, "veh:ramp:state","closed")
                    else
                     	setElementData(theVehicle, "veh:ramp:state","moveing")
                     	last = last + 1
                    end
            end, 100, 90 )
        end
   end
end
addEvent( "onCloseRamp", true )
addEventHandler( "onCloseRamp", resourceRoot, close )

function open(source)
   if getElementData(source,"veh:moveable") then
        local theVehicle = getElementData(source,"veh:vehMove")
        if getElementData(theVehicle,"veh:ramp:state") == "closed" then
                local rx1 = 180
                local last = 1
                setTimer ( function()
                        rx1 = rx1 + 1
                        setElementAttachedOffsets (getElementData(theVehicle,"veh:ramp"),0,-5.27, 0.05,rx1,180,0)
                        setElementData(theVehicle, "veh:ramp:posX",0)
                        setElementData(theVehicle, "veh:ramp:posY",-5.27)
                        setElementData(theVehicle, "veh:ramp:posZ",0.05)
                        setElementData(theVehicle, "veh:ramp:rotX",rx1)
                        setElementData(theVehicle, "veh:ramp:rotY",180)
                        setElementData(theVehicle, "veh:ramp:rotZ",0)
                        setElementData(theVehicle, "veh:ramp:state","moveing")
                        if last == 89 then
                        	setElementData(theVehicle, "veh:ramp:state","openned")
                        else
                        	setElementData(theVehicle, "veh:ramp:state","moveing")
                        	last = last + 1
                        end
                end, 100, 90 )
        end
   end
end
addEvent( "onOpenRamp", true )
addEventHandler( "onOpenRamp", resourceRoot, open )

function down(source)
   if getElementData(source,"veh:moveable") then
        local theVehicle = getElementData(source,"veh:vehMove")
        if getElementData(theVehicle,"veh:ramp:state") == "openned" then
                local z = 0.05
                local last = 1
                setTimer ( function()
                        z = z + 0.01
                        setElementAttachedOffsets (getElementData(theVehicle,"veh:ramp"),0,-5.27, z*-1,-90,180,0)
                        setElementData(theVehicle, "veh:ramp:posX",0)
                        setElementData(theVehicle, "veh:ramp:posY",-5.27)
                        setElementData(theVehicle, "veh:ramp:posZ",z*-1)
                        setElementData(theVehicle, "veh:ramp:rotX",-90)
                        setElementData(theVehicle, "veh:ramp:rotY",180)
                        setElementData(theVehicle, "veh:ramp:rotZ",0)
                        setElementData(theVehicle, "veh:ramp:state","moveing")
                        if last == 99 then
                        	setElementData(theVehicle, "veh:ramp:state","downed")
                        else
                        	setElementData(theVehicle, "veh:ramp:state","moveing")
                        	last = last + 1
                        end
                end, 100, 100 )
        end
   end
end
addEvent( "onDownRamp", true )
addEventHandler( "onDownRamp", resourceRoot, down )

function up(source)
   if getElementData(source,"veh:moveable") then
        local theVehicle = getElementData(source,"veh:vehMove")
        if getElementData(theVehicle,"veh:ramp:state") == "downed" then
                local z = 1
                local last = 1
                setTimer ( function()
                        z = z - 0.01
                        setElementAttachedOffsets (getElementData(theVehicle,"veh:ramp"),0,-5.27, z*-1,-90,180,0)
                        setElementData(theVehicle, "veh:ramp:posX",0)
                        setElementData(theVehicle, "veh:ramp:posY",-5.27)
                        setElementData(theVehicle, "veh:ramp:posZ",z*-1)
                        setElementData(theVehicle, "veh:ramp:rotX",-90)
                        setElementData(theVehicle, "veh:ramp:rotY",180)
                        setElementData(theVehicle, "veh:ramp:rotZ",0)
                        setElementData(theVehicle, "veh:ramp:state","moveing")
                        if last == 99 then
                        	setElementData(theVehicle, "veh:ramp:state","openned")
                        else
                        	setElementData(theVehicle, "veh:ramp:state","moveing")
                        	last = last + 1
                        end
                end, 100, 100 )
        end
   end
end
addEvent( "onUpRamp", true )
addEventHandler( "onUpRamp", resourceRoot, up )


function minusPackages(source, data)
    if getElementData(root, "donePackages") - tonumber(data) > 0 then
        setElementData(root, "donePackages", getElementData(root, "donePackages") - tonumber(data))
    else
        setElementData(root, "donePackages", 0)
    end
end
addEvent( "minusPackages", true )
addEventHandler( "minusPackages", resourceRoot, minusPackages )
