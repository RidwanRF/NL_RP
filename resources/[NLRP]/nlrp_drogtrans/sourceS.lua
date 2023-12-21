local Hajo
local shipInterior
local shipKeret
local shipLepcsoKeret
local shipBoxes
local pos = {
	["startPos"] = {-3500.3544921875, 521.5, 6.96875},
	["endPos"] = {-2973.3544921875, 521.5, 7.4},
}
local drog = {}
local drogok = {
	{  -1629.5, -2236.2, 31.55},   --1. asztal
	{  -1629.5, -2236.6, 31.55},   --1. asztal
	{  -1629.5, -2237, 31.55},   --1. asztal
	{  -1629.5, -2237.4, 31.55},   --1. asztal
	{  -1629.5, -2237.8, 31.55},   --1. asztal
	{  -1629.5, -2238.2, 31.55},   --1. asztal
	{  -1629.5, -2238.6, 31.55},   --1. asztal
	{  -1629.5, -2239, 31.55},   --1. asztal
	
	{  -1629.5, -2240.2, 31.55},   --2. asztal
	{  -1629.5, -2240.6, 31.55},   --2. asztal
	{  -1629.5, -2241, 31.55},   --2. asztal
	{  -1629.5, -2241.4, 31.55},   --2. asztal
	{  -1629.5, -2241.8, 31.55},   --2. asztal
	{  -1629.5, -2242.2, 31.55},   --2. asztal
	{  -1629.5, -2242.6, 31.55},   --2. asztal
	{  -1629.5, -2243, 31.55},   --2. asztal
}




local lootok = {123,126}

local attachMents = {}

function createBoat()

--		exports["gear_chat"]:sendMessageToGroup(8, "#ca5454[Freedom Gaming - Fegyverszállítás] #ffffffA #4aabd01 perc #ffffffmúlva megérkezik #4aabd0Nyugat San Fierroba!")
--		exports["gear_chat"]:sendMessageToGroup(9, "#ca5454[Freedom Gaming - Fegyverszállítás] #ffffffA #4aabd01 perc #ffffffmúlva megérkezik #4aabd0Nyugat San Fierroba!")

		Hajo = createObject(10230, pos["startPos"][1],pos["startPos"][2],pos["startPos"][3])
		setElementRotation(Hajo, 0, 0, 180)

		shipInterior = createObject(10140, pos["startPos"][1]-14.7188, pos["startPos"][2]+1.05, 7.125)
		setElementRotation(shipInterior, 0, 0, 180)

		shipKeret = createObject(10229, pos["startPos"][1]+0.250, pos["startPos"][2]+1.4, pos["startPos"][3]-1.14844)
		setElementRotation(shipKeret, 0, 0, 180)

		shipLepcsoKeret = createObject(10226, pos["startPos"][1]-44.3906, pos["startPos"][2]-0.7656, pos["startPos"][3]-0.75781)
		setElementRotation(shipLepcsoKeret, 0, 0, 180)

		shipBoxes = createObject(10231,pos["startPos"][1]+0.9,pos["startPos"][2]+1.495,pos["startPos"][3]+1)
		setElementRotation(shipBoxes, 0, 0, 180)
		
		moveObject ( Hajo, 1000*60, pos["endPos"][1],pos["endPos"][2],pos["endPos"][3] )
		moveObject ( shipInterior, 1000*60, pos["endPos"][1]-14.7188,pos["endPos"][2]+1.05,7.125)
		moveObject ( shipKeret, 1000*60, pos["endPos"][1]+0.250,pos["endPos"][2]+1.4,pos["endPos"][3]-1.14844)
		moveObject ( shipLepcsoKeret, 1000*60, pos["endPos"][1]-44.3906,pos["endPos"][2]-0.7656,pos["endPos"][3]-0.75781)
		moveObject ( shipBoxes, 1000*60, pos["endPos"][1]+0.9,pos["endPos"][2]+1.495,pos["endPos"][3]+1)

		
		setTimer(function()
			triggerClientEvent(getRootElement(), "playHorn", getRootElement())
		--exports["gear_chat"]:exports.exg_dashboard:isPlayerInFaction(2), "#ca5454[Freedom Gaming - Fegyverszállítás] #ffffffA hajó megérkezett #4aabd0Nyugat San Fierroba#ffffff, és #4aabd030 percig #fffffffog ott maradni.")
		--exports["gear_chat"]:exports.exg_dashboard:isPlayerInFaction(2), "#ca5454[Freedom Gaming - Fegyverszállítás] #ffffffA hajó megérkezett #4aabd0Nyugat San Fierroba#ffffff, és #4aabd030 percig #fffffffog ott maradni.")
			--createMarkers()
			for k,v in pairs(drogok) do
				drog[k] = createObject(1580,v[1],v[2],v[3]-0.2)
				setElementData(drog[k],"object.isDrogZsak",true)
				setElementData(drog[k],"object.drogLoot", tonumber(lootok[math.random(#lootok)]))
				setElementData(drog[k],"object.drogID", k)
			end
			--generateLoots()
		end,10*60,1)
end

function destroyDrogCrate(crateID)
	destroyElement(drog[crateID])
	drog[crateID] = nil
end
addEvent("destroyDrogCrate", true)
addEventHandler("destroyDrogCrate", getRootElement(), destroyDrogCrate)

local leadoMarker = createMarker( 5059.2939453125, -1873.4622802734, 4.5078125, "arrow", 2, 183,255,0, 50) --5059.2939453125, -1873.4622802734, 4.5078125 sziget
	  setElementDimension(leadoMarker, 0, true)

function leadDrog(hitElement)

	local count = exports.nlrp_inventory:countItemsByItemID(hitElement, 123)
	
	if exports.nlrp_inventory:hasItem(hitElement, 123,1) then
	
		exports.nlrp_inventory:removeItemByData(hitElement, 123, 1) 
		
	for i=1,count do
		exports.nlrp_inventory:addItem(hitElement, 125, 1) 
	end
	
		else exports.nlrp_inventory:hasItem(hitElement, 123,1) 
		
	--	outputChatBox ("#d7a360Gear Weapon#FFFFFF - Nincs nálad fegyveres láda!", thePlayer, 255, 255, 255, true)
	end
	
	local count = exports.nlrp_inventory:countItemsByItemID(hitElement, 124)
	
	if exports.nlrp_inventory:hasItem(hitElement, 124,1) then
	
		exports.nlrp_inventory:removeItemByData(hitElement, 124, 1) 
		
	for i=1,count do
		exports.nlrp_inventory:addItem(hitElement, 126, 1) 
	end
	
		else exports.nlrp_inventory:hasItem(hitElement, math.random (123,124), 1) 
		
	--	outputChatBox ("#d7a360Gear Weapon#FFFFFF - Nincs nálad fegyveres láda!", thePlayer, 255, 255, 255, true)
	end
end
addEventHandler("onMarkerHit", leadoMarker, leadDrog)


function createDrogInInv(player)
	exports.nlrp_inventory:addItem(player, math.random (123,124), 1)
end
addEvent("createDrogInInv", true)
addEventHandler("createDrogInInv", getRootElement(), createDrogInInv)

function startTimer2()
	for k,v in ipairs(getElementsByType("player")) do
		if exports.nlrp_groups:isPlayerHavePermission(v, "DrogTrans") then
			--if getElementData(thePlayer, "acc.adminLevel") >= 9 then
			outputChatBox("[NextLevel Drog] 30 perc múlva drogtrans",v,183,255,0,true)
		end
	end
	setTimer(function()
	--if getElementData(thePlayer, "acc.adminLevel") >= 9 then
		if not isElement(Hajo) then
			createBoat()
			exports["nlrp_groups"]:isPlayerInGroup(1)
			setTimer(function()
				for k,v in pairs(dobozok) do
					if isElement(doboz[k]) then
						destroyElement(doboz[k])
						destroyElement(Hajo)
					end
				end
			end, 1000*60*30, 1)
		end
	--end
	end, 1000*60*30, 1)
end	--1000*60*60*24*3 
setTimer(startTimer2, 1000, 1)
setTimer(startTimer2, 1000*60*60*24*3, 0)

exports.nlrp_admin:addAdminCommand("drógos", 9, "Drogok létrehozása")
	function createdrog(thePlayer, commandName)
		if getElementData(thePlayer, "acc.adminLevel") >= 9 then
		if not isElement(Hajo) then
		
			if not (targetPlayer) then
				outputChatBox("#b7ff00[NextLevel]:#ffffff Sikeresen létrehoztad a drogszállítmányt!", thePlayer, 255, 255, 255, true)
				createBoat()
				
			else
				exports["nlrp_groups"]:isPlayerInGroup(2)
				setTimer(function()
					for k,v in pairs(drogok) do
						if isElement(drog[k]) then
							destroyElement(drog[k])
						end
					end
				end, 100*60*30, 1)
			end
		end
	end
end
addCommandHandler("drógos",createdrog)
