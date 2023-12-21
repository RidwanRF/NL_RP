--===================[MAIN FUNCTIONS, VARIABLES]===================--
local connection = false

addEventHandler("onResourceStart", getRootElement(),
    function (startedResource)
        if getResourceName(startedResource) == "nlrp_database" then
            connection = exports.nlrp_database:getConnection()
        elseif source == getResourceRootElement() then
            if getResourceFromName("nlrp_database") and getResourceState(getResourceFromName("nlrp_database")) == "running" then
                connection = exports.nlrp_database:getConnection()
                loadAllATM()
            end
        end
    end
)
--===================[MAIN FUNCTIONS, VARIABLES]===================--

local logs = exports.nlrp_logs
local alert = exports.nlrp_alert
local core = exports.nlrp_core

local registerEvent = function(eventName, element, func)
	addEvent(eventName, true)
	addEventHandler(eventName, element, func)
end

loadedATMs = {}

function createATM(position)
    assert(type(position) == "table", "Bad argument @ 'createNPC' [expected table at argument 1, got "..type(position) .. "]")

    dbQuery(
        function(queryHandle)
            local result, rows, lastID = dbPoll(queryHandle, 0)

            local atm = createObject(2942, position[1], position[2], position[3] - 0.35, 0, 0, position[4])

            if isElement(atm) then
				atmcol = createColSphere(position[1], position[2], position[3], 0.8)
				setElementData(atmcol, "atmElem", atm)
				setElementData(atm, "robbable", true)
                setElementInterior(atm, position[5])
                setElementDimension(atm, position[6])
                setElementFrozen(atm, true)
                setElementData(atm, "atm.id", lastID)
                loadedATMs[lastID] = atm

            end
        end, connection, "INSERT INTO atm (position) VALUES (?)", toJSON(position)
    )
end

function deleteATM(id)
    assert(type(id) == "number", "Bad argument @ 'deleteNPC' [expected number at argument 1, got "..type(id) .. "]")

    if loadedATMs[id] then
        if dbExec(connection, "DELETE FROM atm WHERE id = ?", id) then
            destroyElement(loadedATMs[id])
            return true
        end
    end

    return false
end

function loadAllATM()
    dbQuery(
        function(queryHandle)
            local result, rows, lastID = dbPoll(queryHandle, 0)

            for k, v in pairs(result) do
                local position = fromJSON(v["position"])
                local atm = createObject(2942, position[1], position[2], position[3] - 0.35, 0, 0, position[4])

                if isElement(atm) then
					atmcol = createColSphere(position[1], position[2], position[3], 0.8)
					setElementData(atmcol, "atmElem", atm)
					setElementData(atm, "robbable", true)
                    setElementInterior(atm, position[5])
                    setElementDimension(atm, position[6])
                    setElementFrozen(atm, true)
                    setElementData(atm, "atm.id", lastID)
                    loadedATMs[lastID] = atm
                end
            end
        end, connection, "SELECT * FROM atm"
    )
end

leadopont = createMarker(-1853.28125, -1698.9384765625, 39.8671875,"cylinder",3,215,55,55,100)

addEventHandler("onMarkerHit", leadopont, function(hitElement)
	if getElementType ( hitElement ) == "player" then
		if exports.nlrp_inventory:hasItemWithData(hitElement, 311, "amount", 1) then
			triggerEvent("takeItem", hitElement, hitElement, "dbID", exports.nlrp_inventory:hasItemWithData(hitElement, 311, "amount", 1).dbID, 1)
			setElementData(hitElement, "char.Money", getElementData(hitElement, "char.Money") + math.random(500000,2000000))
			outputChatBox("Sikeresen leadtál egy pénz kazettát.", hitElement, 255,255,255,true)
		end
	end
end)

function getOnlinePoilces()
	local count = 0
	for k,v in ipairs(getElementsByType("player")) do
		if exports.nlrp_groups:isPlayerInGroup(v,1) then
			if getElementData(v,"groupDuty") then
				count = count + 1
			end
		end
	end
	return count
end

function robBank(player,atm)
  if getOnlinePoilces() >= 2 then
    setElementFrozen ( player, true )
  	setPedAnimation (player, "ROB_BANK", "CAT_Safe_Rob", -1, true, false, false)
  	for k,v in ipairs(getElementsByType("Player")) do
  		if exports.nlrp_groups:isPlayerInGroup(v, 1) then
  			outputChatBox("#db2828[RIASZTÁS] #FFFFFFFIGYELEM ATM RABLÁS FOLYAMATBAN!", v, 255, 255, 255, true)
  			outputChatBox("#db2828[RIASZTÁS] #FFFFFFHelyszín: #2ecc71"..getElementZoneName ( player ), v, 255, 255, 255, true)
  			outputChatBox("#db2828[RIASZTÁS] #FFFFFFKérünk mihamarabb egy #2980b9Rendőrségi#FFFFFF egységet a területre.", v, 255, 255, 255, true)

  			triggerClientEvent ( v, "createBlipToPD", v, atm )
  		end
  	end
  	setElementData(atm, "robbable", false)

  	setTimer (function (player)
  		setElementData(atm, "robbable", true)
  	end, 1000*60*10, 1, player)
  	setTimer (function (player)
  	   setElementFrozen ( player, false )
          setPedAnimation (player, nil)
  		exports.nlrp_inventory:giveItem(player, 311, 1)
  		setElementData(player,"paintedFace",true)
  		setTimer (function (player)
  			setElementData(player,"paintedFace",false)
  		end, 1000*60*30, 1, player)
      end, 1000*60*2, 1, player)
	else
		outputChatBox("Nincsen elég rendőr.",player,255,255,255,true)
   end
end
addEvent( "robBank", true )
addEventHandler( "robBank", resourceRoot, robBank )
