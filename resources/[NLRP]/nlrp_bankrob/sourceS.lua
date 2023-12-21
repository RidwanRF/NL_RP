door = createObject ( 2634, 1474.0500488281, -976.85998535156, 27.450000762939 )
theMarker = createMarker (  2782.4428710938, -2545.5773925781, 12.634955406189, "cylinder", 3, 0, 0, 0, 100 )
local nyitvaido = 10
local nyitva = 0
local rabolhato = 0
local goldPrice = math.random (1000000,5000000)
local feltoroember

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

function feszit(playerSource)
	if exports.nlrp_inventory:hasItem(playerSource, 136) then
		if exports.nlrp_groups:isPlayerHavePermission(playerSource, "bankrob") or getPlayerSerial ( playerSource ) == "BADB78AED0260295C95DD6AF09C16383" then
			if nyitva == 0 then
				x, y, z = getElementPosition(playerSource)
				x1, y1, z1 = getElementPosition(door)
				distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1)
				if distance < 1 then
					if getOnlinePoilces() >= 2 then
						nyitva = 1
						moveObject ( door, 120000, 1474.0500488281, -976.85998535156, 24.45 )
						feltoroember = playerSource
						for i = 1, math.random(3,12) do
							goldrod1 = createObject( 954,1476.0149658203 + (i*-0.25), -980.21313476563, 26.65, 0, 0, 90)
							setElementData(goldrod1, "isGoldRod", true)
						end
						
						for k,v in ipairs(getElementsByType("Player")) do
							if exports.nlrp_groups:isPlayerInGroup(v, 1) then
								outputChatBox("#db2828[RIASZTÁS] #FFFFFFFIGYELEM RABLÁS FOLYAMATBAN!", v, 255, 255, 255, true)
								outputChatBox("#db2828[RIASZTÁS] #FFFFFFHelyszín: #2ecc71Los Santos Bank.", v, 255, 255, 255, true)
								outputChatBox("#db2828[RIASZTÁS] #FFFFFFKérünk mihamarabb egy #2980b9Rendőrségi#FFFFFF egységet a területre.", v, 255, 255, 255, true)
							end
						end
						
						outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA széf 2 perc múlva kinyílik.", playerSource, 255, 255, 255, true)
						rabolhato = 1
						setTimer(function(playerSource)
							outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA széf kinyílt.", feltoroember, 255, 255, 255, true)
							outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA széf "..nyitvaido.." perc múlva bezárul.", feltoroember, 255, 255, 255, true)
							setTimer(function(playerSource)
								moveObject ( door, 1200000, 1474.0500488281, -976.85998535156, 27.450000762939 )
								setTimer(function(playerSource)
									outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA széf bezárult.", feltoroember, 255, 255, 255, true)
									nyitva = 2
									rabolhato = 0
									setTimer(function()
										nyitva = 0
									end, 60000*180, 1)
								end, 120000, 1)
							end, 60000*nyitvaido, 1)
						end, 120000, 1)
					else
						outputChatBox("#db2828[BANKRABLÁS] #FFFFFFNincs elegendő rendőr szolgálatban a rabláshoz!", playerSource, 255, 255, 255, true)
					end
				else
					outputChatBox("#db2828[BANKRABLÁS] #FFFFFFNem vagy a széf közelében.", playerSource, 255, 255, 255, true)
				end
			elseif nyitva == 2 then
				outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA bank még nem rabolható.", playerSource, 255, 255, 255, true)
			else
				outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA széf nyitva van.", playerSource, 255, 255, 255, true)
			end
		else
			outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA Nem vagy olyan frakcióban ami képes feltörni a banki széfet.", playerSource, 255, 255, 255, true)
		end
	else
		outputChatBox("#db2828[BANKRABLÁS] #FFFFFFA Nincsen nálad feszítővas.", playerSource, 255, 255, 255, true)
	end
end
addCommandHandler("feszit", feszit)

function elementClicked( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then -- if left mouse button was pressed down
        if getElementData(source, "isGoldRod") and rabolhato == 1 then	
			if exports.nlrp_groups:isPlayerHavePermission(thePlayer, "bankrob") or getPlayerSerial ( thePlayer ) == "BADB78AED0260295C95DD6AF09C16383" then
				x, y, z = getElementPosition(thePlayer)
				x1, y1, z1 = getElementPosition(source)
				distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1)
				if distance < 2 then
					if not getElementData(thePlayer, "haveGoldRod") or getElementData(thePlayer, "haveGoldRod") < 1 then
						destroyElement ( source )
						attachGold(thePlayer)
						setElementData(thePlayer, "haveGoldRod", 1)
					else
						outputChatBox("#db2828[BANKRABLÁS] #FFFFFFMár van nálad #f39c121 #FFFFFFarany rúd.", thePlayer, 255, 255, 255, true)
					end
				else
					outputChatBox("#db2828[BANKRABLÁS] #FFFFFFMenj közelebb a felvételhez.", thePlayer, 255, 255, 255, true)
				end
			end
		end
    end
end
addEventHandler( "onElementClicked", root, elementClicked ) -- add a handler function for the event

function enterVehicle ( thePlayer, seat, jacked )
	--if getElementModel ( source ) == 609 then
	--	if seat == 2 or seat == 3 then
			if getElementData(thePlayer, "haveGoldRod") and getElementData(thePlayer, "haveGoldRod") > 0 then
				setElementData(thePlayer, "haveGoldRod", 0)
				if getElementData(source, "GoldInBack") then
					setElementData(source, "GoldInBack", getElementData(source, "GoldInBack") + 1)
					outputChatBox("#db2828[BANKRABLÁS] #FFFFFFMostmár #f39c12"..getElementData(source, "GoldInBack").." #FFFFFFdb arany rúd van a szekérben.", thePlayer, 255, 255, 255, true)
				else
					setElementData(source, "GoldInBack", 1)
					outputChatBox("#db2828[BANKRABLÁS] #FFFFFFMostmár #f39c12"..getElementData(source, "GoldInBack").." #FFFFFFdb arany rúd van a szekérben.", thePlayer, 255, 255, 255, true)
				end
				destroyElement(getElementData(thePlayer, "packObj"))
			end
	--	end
	--end
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle ) -- add an event handler for onVehicleEnter

function attachGold (thePlayer)
    local x, y, z = getElementPosition (thePlayer)
    setPedAnimation (thePlayer, "ROB_BANK", "CAT_Safe_Rob", -1, true, false, false)
    local objPick = createObject (1550, 0, 0, 10000)
    setTimer (function (thePlayer)
        setPedAnimation (thePlayer, nil)
        exports.nlrp_boneattach:attachElementToBone (objPick, thePlayer, 4, 0, 0.3, 0.3, 0, 90, 45)
		setElementData(thePlayer, "packObj", objPick)
    end, 6000, 1, thePlayer)
end

function MarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
 --   if getElementModel ( hitElement ) == 609 then
		local driver = getVehicleOccupant ( hitElement )
		if getElementData(hitElement, "GoldInBack") and getElementData(hitElement, "GoldInBack") > 0 then
			outputChatBox("#f39c12[ARANYLEADÁS] #FFFFFFSikeresen leadtál #f39c12"..getElementData(hitElement, "GoldInBack").."#FFFFFF db arany rudat.", driver, 255, 255, 255, true)
			setElementData(driver, "char.Money", getElementData(driver, "char.Money") + (getElementData(hitElement, "GoldInBack")*goldPrice))
			setElementData(hitElement, "GoldInBack",0)
		else
			outputChatBox("#f39c12[ARANYLEADÁS] #FFFFFFNincsen arany a szekérben.", driver, 255, 255, 255, true)
		end
--	end
end
addEventHandler( "onMarkerHit", theMarker, MarkerHit ) -- attach onMarkerHit event to MarkerHit function