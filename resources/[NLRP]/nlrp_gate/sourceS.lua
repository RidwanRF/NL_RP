
local dbConnection = exports.nlrp_database:getConnection()

local loadedGates = {}

addEventHandler("onResourceStart", getResourceRootElement(), function()
	loadGates()
end)

function loadGates()
	local query = dbQuery(dbConnection, "SELECT * FROM gates")
	if query then
		local result, rows = dbPoll(query, -1 )
		if result then
			outputDebugString(rows .. " kapu betöltve")
			for k, v in ipairs(result) do
				local closePosition = fromJSON(v["closeposition"])
				local openPosition = fromJSON(v["openposition"])
				loadedGates[v["dbID"]] = createObject(v["object"], closePosition[1], closePosition[2], closePosition[3], closePosition[4], closePosition[5], closePosition[6])
				setElementData(loadedGates[v["dbID"]], "gate.id", v["dbID"])
				setElementData(loadedGates[v["dbID"]], "gate.movetime", tonumber(v["movetime"]))
				setElementData(loadedGates[v["dbID"]], "gate.open", false)
				setElementData(loadedGates[v["dbID"]], "gate.code", v["code"])
				setElementData(loadedGates[v["dbID"]], "gate.mode", v["mode"])
				setElementData(loadedGates[v["dbID"]], "gate.groupID", v["groupID"])
				setElementData(loadedGates[v["dbID"]], "gate.openposition", openPosition)
				setElementData(loadedGates[v["dbID"]], "gate.closeposition", closePosition)
				setElementInterior(loadedGates[v["dbID"]], v["interior"])
				setElementDimension(loadedGates[v["dbID"]], v["dimension"])
			end
			
		end
	end
end

function createGate(objID, openPosition, closePosition, moveTime, intdim, mode, code)
	if objID and openPosition and closePosition and moveTime and intdim then
		if mode == "group" then
			dbExecution = dbQuery(dbConnection, "INSERT INTO gates (mode, groupID, object, openposition, closeposition, movetime, interior, dimension) VALUES (?,?,?,?,?,?,?,?)", mode, code, objID, toJSON(openPosition), toJSON(closePosition), moveTime, intdim[1], intdim[2] )
		else
			dbExecution = dbQuery(dbConnection, "INSERT INTO gates (mode, code, object, openposition, closeposition, movetime, interior, dimension) VALUES (?,?,?,?,?,?,?,?)", mode, code, objID, toJSON(openPosition), toJSON(closePosition), moveTime, intdim[1], intdim[2] )
		end
		if dbExecution then
			local result, rows, lastid = dbPoll(dbExecution, -1)
			if lastid then
				loadedGates[lastid] = createObject(objID, closePosition[1], closePosition[2], closePosition[3], closePosition[4], closePosition[5], closePosition[6])
				setElementData(loadedGates[lastid], "gate.id", lastid)
				setElementData(loadedGates[lastid], "gate.movetime", tonumber(moveTime))
				setElementData(loadedGates[lastid], "gate.open", false)
				if mode == "group" then
					setElementData(loadedGates[lastid], "gate.groupID", code)
					setElementData(loadedGates[lastid], "gate.code", 0)
				else
					setElementData(loadedGates[lastid], "gate.groupID", 0)
					setElementData(loadedGates[lastid], "gate.code", code)
				end
				setElementData(loadedGates[lastid], "gate.mode", mode)
				setElementData(loadedGates[lastid], "gate.openposition", openPosition)
				setElementData(loadedGates[lastid], "gate.closeposition", closePosition)
				setElementInterior(loadedGates[lastid], intdim[1])
				setElementDimension(loadedGates[lastid], intdim[2])
				outputChatBox("#b7ff00GATE : #ffffff" .. lastid .. " #b7ff00azonosítójú kapu létrehozva!", source, 0, 0, 0, true)
			end
		end
	end
end
addEvent("createGate", true)
addEventHandler("createGate", root, createGate)

function deleteGate(gateID)
	if gateID then
		local dbExecution = dbExec(dbConnection, "DELETE FROM gates WHERE dbID = ?", gateID)
		if dbExecution then
			if destroyElement(loadedGates[gateID]) then
				outputChatBox("#b7ff00GATE : #ffffff" .. gateID .. " #b7ff00azonosítójú kapu törölve!", source, 0, 0, 0, true)
			end
		end
	end
end
addEvent("deleteGate", true)
addEventHandler("deleteGate", root, deleteGate)

function setGateState(gateID, player)
	if gateID then
		if getElementData(loadedGates[gateID], "gate.open") then
			local gCP = getElementData(loadedGates[gateID], "gate.closeposition")
			local gOP = getElementData(loadedGates[gateID], "gate.openposition")
			
			local rotDiff = calculateDifferenceBetweenAngles(gOP[6], gCP[6])
			
			if moveObject(loadedGates[gateID], getElementData(loadedGates[gateID], "gate.movetime") * 1000, gCP[1], gCP[2], gCP[3], gCP[4], gCP[5], rotDiff ) then
				setElementData(loadedGates[gateID], "gate.open", false)
				outputChatBox("#b7ff00GATE : #ffffffKapu bezárva", player, 0, 0, 0, true)
			end
		else
			local gCP = getElementData(loadedGates[gateID], "gate.closeposition")
			local gOP = getElementData(loadedGates[gateID], "gate.openposition")
		
			local rotDiff = -calculateDifferenceBetweenAngles(gOP[6], gCP[6])
		
			if moveObject(loadedGates[gateID], getElementData(loadedGates[gateID], "gate.movetime") * 1000, gOP[1], gOP[2], gOP[3], gOP[4], gOP[5], rotDiff ) then
				setElementData(loadedGates[gateID], "gate.open", true)
				outputChatBox("#b7ff00GATE : #ffffffKapu kinyitva", player, 0, 0, 0, true)
			end
		end
	end
end

function useGate(thePlayer, asd, password)
	local posX, posY, posZ = getElementPosition(thePlayer)
	
	for k, object in ipairs(getElementsByType("object", getResourceRootElement())) do
		local gateID = getElementData(object, "gate.id")
		if gateID then
			local gX, gY, gZ = getElementPosition(object)
			local distance = getDistanceBetweenPoints3D(posX, posY, posZ, gX, gY, gZ)
			
			if (distance<=8) then
				if (getElementData(object, "gate.mode") == "group") then
					if (exports.nlrp_groups:isPlayerInGroup(thePlayer, getElementData(object, "gate.groupID"))) then
						setGateState(gateID, thePlayer)
					end
				elseif (getElementData(object, "gate.mode") == "code") then
					if tostring(getElementData(object, "gate.code")) == tostring(password)  then
						setGateState(gateID, thePlayer)
					end
				end
			end
		end
	end
end
addCommandHandler("gate", useGate)

function calculateDifferenceBetweenAngles(firstAngle, secondAngle) 
    difference = secondAngle - firstAngle; 
    while (difference < -180) do 
        difference = difference + 360 
    end 
    while (difference > 180) do 
        difference = difference - 360 
    end 
    return difference 
end 













