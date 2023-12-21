if fileExists("sourceC.lua") then
	fileDelete("sourceC.lua")
end

local showedPanel = false
local screen = {guiGetScreenSize()}
local kepMeret = {300,430}
local kepPos = {screen[1]/2-kepMeret[1]/2,screen[2]/2-kepMeret[2]/2 + 120}
local clickedElementS = nil
-- Fontok
local robTimer = {}
local isRobbing = false
local font = dxCreateFont("fajlok/Roboto.ttf", 13)

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

function ObjectClick( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if clickedElement and getElementType(clickedElement) == "object" and state=="down" and getElementData(clickedElement,"shop.rob.object") then
		local pX,pY,pZ = getElementPosition(getLocalPlayer())
		if getDistanceBetweenPoints3D(pX,pY,pZ,worldX,worldY,worldZ)<=10 then
			if (not showedPanel and not isRobbing and not getElementData(clickedElement,"isRobbingPenztar")) then
				showedPanel = true
				clickedElementS = clickedElement
			end
		end
	end
end
addEventHandler ("onClientClick",getRootElement(),ObjectClick)

addEventHandler("onClientRender",getRootElement(),function()
	if showedPanel then
local sx, sy = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(sx/2, sy/2)
dxDrawRectangle(sx/2-250,sy/2-70,500,180,tocolor(0,0,0,100))
dxDrawRectangle(sx/2-250,sy/2-100,500,30,tocolor(0,0,0,150))
dxDrawText("#b7ff00NextLevel #FFFFFF - Rablás ",sx/2-240,sy/2+310,sx/2-400,sy/2-475,tocolor(255,255,255,255),1,font,"left","center",false,false,false,true)

--dxDrawImage(sx/2-55,sy/2-200,100,100,"fajlok/logo.png")


            -- RECTANGLE -- 
		--dxDrawRectangle(kepPos[1]+5,kepPos[2]+50,kepMeret[1]-10,30,tocolor(0,0,0,200))
		dxDrawText("#ffffffBoltrablás elérhető: "..IfElse(getElementData(clickedElementS,"shop.rob.rabolhato") == 0,"#acd373Igen","#ca5454".. getElementData(clickedElementS,"shop.rob.rabolhato").."p múlva"),kepPos[1]+8,kepPos[2]+55,kepMeret[1]-10,30,tocolor(255,255,255,255),1,font,"left","top",false,false,true,true)
		dxDrawRectangle(kepPos[1]+5,kepPos[2]+100,kepMeret[1]-10,30,tocolor(0,0,0,200))
		dxDrawText("#FFFFFFRablás megkezdése",kepPos[1]+25,kepPos[2]+105,kepMeret[1]-10,30,tocolor(255,255,255,255),1,font,"left","top",false,false,true,true)
		dxDrawRectangle(kepPos[1]+5,kepPos[2]+150,kepMeret[1]-10,30,tocolor(0,0,0,200))
		dxDrawText("#FFFFFFBezárás",kepPos[1]+30,kepPos[2]+155,kepMeret[1]-10,30,tocolor(255,255,255,255),1,font,"left","top",false,false,true,true)
		
		-- SLOTOK --
		if isInSlot(kepPos[1]+5,kepPos[2]+50,kepMeret[1]-10,30) then
		elseif isInSlot(kepPos[1]+5,kepPos[2]+100,kepMeret[1]-10,30) then
			dxDrawRectangle(kepPos[1]+5,kepPos[2]+100,kepMeret[1]-10,30,tocolor(172,211,115,180))
		elseif isInSlot(kepPos[1]+5,kepPos[2]+150,kepMeret[1]-10,30) then
			dxDrawRectangle(kepPos[1]+5,kepPos[2]+150,kepMeret[1]-10,30,tocolor(202,84,84,180))
		end
		
	end
end)

function menuClick(gomb,stat,x,y)
	if not showedPanel then return end
	if gomb == "left" and stat == "down" then	
		if (dobozbaVan(kepPos[1]+5,kepPos[2]+100,kepMeret[1]-10,30,x,y,0)) then
			if getElementData(clickedElementS,"shop.rob.rabolhato") > 1 then outputChatBox("#b7ff00[NextLevel] #fffffNem rabolható a bank!",player,177,9,45,true) return end
			
			local p = Vector3(getElementPosition(clickedElementS))
			local p2 = Vector3(getElementPosition(localPlayer))
			if getDistanceBetweenPoints3D(p,p2) >= 10 then
				outputChatBox(exports.nlrp_core:getServerTag("error") .. "Ilyen messziről nem kezdheted el a rablást!",0,0,0,true)
				return
			end

			if getOnlinePoilces() < 4 then
				outputChatBox(exports.nlrp_core:getServerTag("error") .. "Nincs elég rendőr szolgálatban a rabláshoz!",0,0,0,true)
				return
			end

			triggerServerEvent("AlarmToggle",localPlayer,localPlayer,getElementData(clickedElementS,"shop.rob.id"))
			setElementData(localPlayer,"isRobbingShop",true)
			triggerServerEvent("onFrakcioErtesitARablasrol",localPlayer,localPlayer,getElementData(clickedElementS,"shop.rob.name"))
			setElementData(clickedElementS,"isRobbingPenztar",true)
			triggerServerEvent("setRobberAnim",localPlayer,localPlayer)
			showedPanel = false
			isRobbing = true
			robTimer[getLocalPlayer()] = setTimer(function()
				if isTimer(robTimer[getLocalPlayer()]) then
					killTimer(robTimer[getLocalPlayer()])
				end
				isRobbing = false
				setElementData(localPlayer,"isRobbingShop",false)
				setElementData(clickedElementS,"isRobbingPenztar",false)
				triggerServerEvent("offRobberAnim",localPlayer,localPlayer)
				triggerServerEvent("setPenztarData",localPlayer,clickedElementS,"shop.rob.rabolhato",300)
			--	setElementData(localPlayer,"char:money",getElementData(localPlayer,"char:money")+math.random(15000, 580000))
			end,20*15000,1)
		elseif (dobozbaVan(kepPos[1]+5,kepPos[2]+150,kepMeret[1]-10,30,x,y,0)) then
			showedPanel = false
		end
	end
end
addEventHandler("onClientClick", getRootElement(), menuClick)

function getOnlinePoliceDepartmentPlayers()
	local onlineRendorok = 5
	for k,v in ipairs (getElementsByType("player")) do
		if getElementData(v,"isPlayerInGroup") == 1 then
			onlineRendorok = onlineRendorok + 1
		end
	end
	return tonumber(onlineRendorok)
end

function wastedMessage ( killer, weapon, bodypart )
	if getElementData(localPlayer,"isRobbingShop") then
		if isTimer(robTimer[getLocalPlayer()]) then
			killTimer(robTimer[getLocalPlayer()])
		end
		isRobbing = false
		triggerServerEvent("offRobberAnim",localPlayer,localPlayer)
		triggerServerEvent("setPenztarData",localPlayer,clickedElementS,"shop.rob.rabolhato",300)
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), wastedMessage )

function dobozbaVan(dX, dY, dSz, dM, gX, gY ,gM)
	if(gX >= dX and gX+gM <= dX+dSz and gY >= dY and gY <= dY+dM) then
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
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY,0)) then
			return true
		else
			return false
		end
	end	
end

function IfElse(condition, trueReturn, falseReturn)
    if (condition) then return trueReturn
    else return falseReturn end
end

function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x,y,w+1,1,color) -- Fent
	dxDrawRectangle(x,y+1,1,h,color) -- Bal Oldal
	dxDrawRectangle(x+1,y+h,w,1,color) -- Lent Oldal
	dxDrawRectangle(x+w,y+1,1,h,color) -- Jobb Oldal
end

local uSound = {}
local SoundTimer = {}

addEvent("receiveSoundPos",true)
addEventHandler("receiveSoundPos",getRootElement(),function(x,y,z,id)
	uSound[id] = playSound3D("fajlok/alarm.mp3", x,y,z, true) 
	setSoundMaxDistance( uSound[id], 100 )
	setSoundVolume( uSound[id], 1 )
	SoundTimer[id] = setTimer(function()
		if isTimer(SoundTimer[id]) then
			killTimer(SoundTimer[id])
		end
		stopSound(uSound[id])
		uSound[id] = nil
	end,180000,1)
	setElementData(id,"shop.rob.sound",true)
end)