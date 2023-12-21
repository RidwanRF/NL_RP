-- robbanó kocsi fix
setTimer(function()
	for k,v in ipairs(getElementsByType("vehicle", root, true)) do
		if getElementHealth(v) < 250 and not isVehicleDamageProof(v) then
			setElementHealth(v, 250)
			setVehicleDamageProof(v, true)
		end
	end
end, 5000, 0)

-- robbanó object fix
local disabledObjects = {[1676] = true}
addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "object" and disabledObjects[getElementModel(source)] then
		setObjectBreakable(source, false)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for k, v in ipairs(getElementsByType("object", root, true)) do
		if disabledObjects[getElementModel(v)] then
			setObjectBreakable(v, false)
		end
	end
end)

-- amin állsz azt kiírja
addCommandHandler("thisobj", function()
	local x,y,z = getElementPosition(localPlayer)
	local hit,x,y,z,elementHit,nx,ny,nz,material,lighting,piece,buildingId,wX,wY,wZ,rX,rY,rZ = processLineOfSight(x,y,z,x,y,z-10,true,true,true,true,true,true,false,true,localPlayer,true)
	if hit then
		if buildingId then
			outputChatBox(buildingId.." -> "..engineGetModelNameFromID(buildingId))
			local tempObj = createObject(buildingId, wX, wY, wZ, rX, rY, rZ)
			outputChatBox("Radius: "..getElementRadius(tempObj))
			destroyElement(tempObj)
			outputChatBox("Position: "..wX..", "..wY..", "..wZ)
			outputChatBox("Rotation: "..rX..", "..rY..", "..rZ)
		end
	else
		outputChatBox("Hiba")
	end
end)