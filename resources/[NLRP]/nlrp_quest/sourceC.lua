
local s = {guiGetScreenSize()}
local quest_ped = false

local talk = false
local tick = getTickCount()
local text_tick = getTickCount()

local cam = {}

local quest_started = false

local bH = 100
local questType = false
local ped_state = 1
local ped_text = "Csá haver! Jó, hogy látlak. Lenne egy kis munka a számodra."
local answer = {
	accept = "",
	decline = "",
}

local donePed = false

local lockpick = false
local lockpick_tick = getTickCount()

local marker = false

local blip = false

local new_questTimer = false

addEventHandler("onClientRender",root,
	function()
		if talk then
			local x,y,z = interpolateBetween(cam.start[1],cam.start[2],cam.start[3],cam.finish[1],cam.finish[2],cam.finish[3],getProgress(1200,tick),"Linear")
			local x2,y2,z2 = interpolateBetween(cam.start[4],cam.start[5],cam.start[6],cam.finish[4],cam.finish[5],cam.finish[6],getProgress(1200,tick),"Linear")
			setCameraMatrix(x,y,z,x2,y2,z2)

			local anim = interpolateBetween(0,0,0,1,0,0,getProgress(1200,tick),"Linear")

			dxDrawRectangle(0,s[2]-(bH*anim),s[1],bH,tocolor(0,0,0,255))
			if anim == 1 then
				local text_anim = interpolateBetween(0,0,0,1,0,0,getProgress(2000,text_tick),"Linear")
				local length = dxGetTextWidth(ped_text,1.4,"default-bold")
				dxDrawText(ped_text,20,s[2]-bH,20+(length*text_anim),s[2]-bH+bH,tocolor(222,222,222,222),1.4,"default-bold","left","center",true)
				
				if text_anim == 1 then
					if isCursorOnBox(s[1]-400-20,s[2]-bH+20,400,30) then
						dxDrawRectangle(s[1]-400-20,s[2]-bH+20,400,30,tocolor(200,200,200,40))
						dxDrawRectangle(s[1]-400-20,s[2]-bH+20,400,30,tocolor(99,245,66,120))
					end
					dxDrawBorder(s[1]-400-20,s[2]-bH+20,400,30,1.5,tocolor(200,200,200,50))
					dxDrawText(answer.accept,s[1]-20-400/2,s[2]-bH+20+30/2,nil,nil,tocolor(200,200,200,200),1.1,"default-bold","center","center")

					if isCursorOnBox(s[1]-400-20,s[2]-bH+55,400,30) then
						dxDrawRectangle(s[1]-400-20,s[2]-bH+55,400,30,tocolor(200,200,200,40))
						dxDrawRectangle(s[1]-400-20,s[2]-bH+55,400,30,tocolor(245,62,49,120))
					end
					dxDrawBorder(s[1]-400-20,s[2]-bH+55,400,30,1.5,tocolor(200,200,200,50))
					dxDrawText(answer.decline,s[1]-20-400/2,s[2]-bH+55+30/2,nil,nil,tocolor(200,200,200,200),1.1,"default-bold","center","center")
				end
			end
		end
		if lockpick then
			local timer = interpolateBetween(0,0,0,1,0,0,getProgress(lockpickTime*1000,lockpick_tick),"Linear")
			dxDrawRectangle(s[1]/2-350/2,s[2]-200,350,35,tocolor(0,0,0,200))
			dxDrawRectangle(s[1]/2-350/2+1,s[2]-200+1,348*timer,33,tocolor(170,170,170,200))
		end
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
			if getElementData(vehicle,"nlrp->healthBar") then
				local hp = getElementHealth(vehicle)/1000

				dxDrawRectangle(s[1]/2-350/2,s[2]-100,350,35,tocolor(0,0,0,200))
				dxDrawRectangle(s[1]/2-350/2+1,s[2]-100+1,348*hp,33,tocolor(170,170,170,200))
				dxDrawText("Jármű állapot: " .. math.ceil(hp*100) .. "%",s[1]/2,s[2]-100+35/2,nil,nil,tocolor(222,222,222,222),1.1,"default-bold","center","center")
			end
		end
	end
)

addEventHandler("onClientClick",root,
	function(button,state,x,y,wx,wy,wz,element)
		if button == "left" and state == "down" then
			if talk then
				if text_tick+2000 > getTickCount() then return end --// Ezt kell kihúzni ha pörgetni akarjátok a párbeszédet
				if isCursorOnBox(s[1]-400-20,s[2]-bH+20,400,30) then --// Elfogadás
					if ped_state == 1 then
						setPedAnimation(quest_ped,"ped","factalk",2000,true,false,false,false)
						ped_state = 2

						text_tick = getTickCount()
						ped_text = "Lenne egy kocsi amit meg kéne fújnod.."
						answer.accept = "Érdekes, milyen kocsi és hol?"
						answer.decline = "Nem szeretnék ilyesmibe belefolyni."
						if questType == "item" then
							ped_text = "Van pár cuccom amit el kéne vinned, kapsz kocsit is csak szállítsd le."
							answer.accept = "Rendben, add a kulcsokat."
							answer.decline = "Ez elég rosszul hangzik, inkább kihagyom.."
						end
					elseif ped_state == 2 then
						if questType == "car" then
							local rP = math.random(1,#vehicle_poses)
							local veh_id = vehicle_ids[math.random(1,#vehicle_ids)]
							local rC = math.random(1,#vehicle_colors)
							local r,g,b = vehicle_colors[rC].rgb[1],vehicle_colors[rC].rgb[2],vehicle_colors[rC].rgb[3]
							triggerServerEvent("spawnTheVehicle",resourceRoot,
								localPlayer,
								veh_id, --// Id
								vehicle_poses[rP][1],vehicle_poses[rP][2],vehicle_poses[rP][3],vehicle_poses[rP][4], --// poz,rot
								r,g,b
							)

							text_tick = getTickCount()
							setPedAnimation(quest_ped,"ped","factalk",2000,true,false,false,false)
							ped_state = 3
							ped_text = "Egy " .. vehicle_colors[rC].name .. " " .. exports.nlrp_vehs:getVehicleNameFromModel(veh_id) .. " kocsiról lenne szó '" .. getZoneName(vehicle_poses[rP][1],vehicle_poses[rP][2],vehicle_poses[rP][3]) .. "' környékén." 
							answer.accept = "Elfogadom, de adj kucslkészletet."
							answer.decline = "Elég rosszul hangzik, ezt inkább kihagyom."
						elseif questType == "item" then
							talk = false
							setCameraTarget(localPlayer)
							exports.nlrp_hud:toggleHUD(true)
							showChat(true)

							triggerServerEvent("spawnItemVehicle",resourceRoot,localPlayer)

							if isElement(donePed) then destroyElement(donePed) end
							if isElement(marker) then destroyElement(marker) end
							local p = math.random(1,#ped_poses)
							donePed = createPed(99,ped_poses[p][1],ped_poses[p][2],ped_poses[p][3])
							setElementData(donePed,"ped.name","John Beam")
							setElementData(donePed,"pedNameType","Felvásárló")

							blip = createBlip(ped_poses[p][1],ped_poses[p][2],ped_poses[p][3],14)
							setElementData(blip,"blipIcon","felvasarlo")
							setElementData(blip,"blipTooltipText","Felvásárló")
							setElementData(blip,"blipColor",tocolor(255,255,255,255))

							quest_started = true

							marker = createMarker(dropDownMarker[1],dropDownMarker[2],dropDownMarker[3]-1,"cylinder",2,200,200,200,50)

							new_questTimer = setTimer( function() end,newQuestTime*(60*1000),1)

							exports.nlrp_hud:showInfobox("info","Kövesd " .. ped_data.name .. " utasításait. És teljesítsd a feladatot! (" .. jobCancelTime .. " Perced van!)")
							jobTimer = setTimer( function()
								if isElement(marker) then destroyElement(marker) end
								exports.nlrp_hud:showInfobox("error","Lejárt az időd a munka elvégzésére!")
								triggerServerEvent("destroyItemVehicle",resourceRoot,localPlayer)
								quest_started = false
							end,jobCancelTime*(60*1000),1)
						end
					elseif ped_state == 3 then
						if questType == "car" then
							talk = false
							setCameraTarget(localPlayer)
							exports.nlrp_hud:toggleHUD(true)
							showChat(true)

							if isElement(marker) then destroyElement(marker) end
							marker = createMarker(dropDownPos[1],dropDownPos[2],dropDownPos[3]-1,"cylinder",2,200,200,200,50)

							blip = createBlip(dropDownPos[1],dropDownPos[2],dropDownPos[3],14)
							setElementData(blip,"blipIcon","target")
							setElementData(blip,"blipTooltipText","Jármű leadása")
							setElementData(blip,"blipColor",tocolor(255,255,255,255))

							new_questTimer = setTimer( function() end,newQuestTime*(60*1000),1)

							triggerServerEvent("giveKeyToVehicle",resourceRoot,localPlayer)
							exports.nlrp_hud:showInfobox("info","Kövesd " .. ped_data.name .. " utasításait. És teljesítsd a feladatot! (" .. jobCancelTime .. " Perced van!)")
							jobTimer = setTimer( function()
								if isElement(marker) then destroyElement(marker) end
								if isElement(blip) then destroyElement(blip) end
								exports.nlrp_hud:showInfobox("error","Lejárt az időd a munka elvégzésére!")
								triggerServerEvent("destroyVehicle",resourceRoot,localPlayer)
								quest_started = false
							end,jobCancelTime*(60*1000),1)
						elseif questType == "item" then

						end
					end
				elseif isCursorOnBox(s[1]-400-20,s[2]-bH+55,400,30) then --// Elutasít
					talk = false
					setCameraTarget(localPlayer)
					exports.nlrp_hud:toggleHUD(true)
					showChat(true)
					if ped_state == 3 then
						triggerServerEvent("destroyVehicle",resourceRoot,localPlayer)
					end
				end
			end
			if isElement(quest_ped) and isElement(element) then
				if quest_ped == element then
					local p1 = Vector3(getElementPosition(localPlayer))
					local p2 = Vector3(getElementPosition(element))
					if getDistanceBetweenPoints3D(p1,p2) < 2 then
						if quest_started then
							exports.nlrp_hud:showInfobox("error","Már van egy elvállalt küldetésed!")
							return
						end
						if isTimer(new_questTimer) then
							exports.nlrp_hud:showInfobox("error",ped_data.name .. " jelenleg elfoglalt. Keresd fel később!")
							return
						end
						if not talk then
							talk = true
							tick = getTickCount()
							text_tick = getTickCount()+1200

							local x,y,z,x2,y2,z2 = getCameraMatrix()
							local camRot = ped_data.rot
							if ped_data.rot == 90 then camRot = 270 end
							if ped_data.rot == 270 then camRot = 90 end
							local fX,fY = getPointFromDistanceRotation(p2.x,p2.y,1,camRot)
							cam = {
								start = {x,y,z,x2,y2,z2},
								finish = {fX,fY,p2.z+0.81,p2.x,p2.y,p2.z+0.6},
							}
							exports.nlrp_hud:toggleHUD(false)
							showChat(false)
							textID = 1

							ped_text = "Csá haver! Jó, hogy látlak. Lenne egy kis munka a számodra."
							answer.accept = "Jól hangzik, hallgatlak."
							answer.decline = "Bocs haver, de most nem érek rá."
							ped_state = 1

							questType = "item"
							if math.random(1,2) == 2 then
								questType = "car"
							end

							setTimer( function()
								setPedAnimation(quest_ped,"ped","factalk",2000,true,false,false,false)
							end,1200,1)
						end
					end
				end
			end
			if isElement(donePed) and isElement(element) then
				if element == donePed then
					if quest_started then
						local p1 = Vector3(getElementPosition(localPlayer))
						local p2 = Vector3(getElementPosition(element))
						if getDistanceBetweenPoints3D(p1,p2) < 2 then
							if not talk then
								if isTimer(spamTimer) then return end
								sellJobItems()
								spamTimer = setTimer( function() end,3000,1)
							end
						end
					end
				end
			end
		end
	end
)

function sellJobItems()
	local sellItems = {}
	local price = 0
	local globalItemID = false
	for slot,data in pairs(exports.nlrp_inventory:returnAllItems(localPlayer)) do
		if isJobItem(data.itemId) then
			table.insert(sellItems,{
				item_dbID = data.dbID,
				item_slot = slot,
			})
			globalItemID = data.itemId
			price = price + getItemPrice(data.itemId)
		end
	end
	if globalItemID then
		outputChatBox("#b7ff00[NextLevel] #ffffffSikeresen átadtál #b7ff00" .. #sellItems .. "#ffffff darab #b7ff00'" .. exports.nlrp_inventory:getItemName(globalItemID) .. "'#ffffff tárgyat. Összes kereseted: #b7ff00" .. format(price) .. "Ft",0,0,0,true)

		triggerServerEvent("giveMoneyForItems",resourceRoot,localPlayer,price)

		for k,v in ipairs(sellItems) do
			exports.nlrp_inventory:removeItemBySlot(v.item_slot,v.item_dbID)
		end
	else
		exports.nlrp_hud:showInfobox("error","Nincs nálad átadható tárgy!")
	end
end

addEventHandler("onClientMarkerHit",root,
	function(player,dim)
		if isElement(marker) then
			if source == marker then
				if player == localPlayer and dim then
					local vehicle = getPedOccupiedVehicle(localPlayer)
					if vehicle then
						if questType == "car" then
							triggerServerEvent("tryToFinsihQuest",resourceRoot,localPlayer)
						elseif questType == "item" then
							triggerServerEvent("tryToFinsihItemQuest",resourceRoot,localPlayer)
						end
					end
				end
			end
		end
	end
)

addEvent("finishedQuest",true)
addEventHandler("finishedQuest",localPlayer,
	function()
		quest_started = false
		if isElement(marker) then destroyElement(marker) end
		if isElement(donePed) then destroyElement(donePed) end
		if blip then destroyElement(blip) end
		blip = false

		if isTimer(jobTimer) then killTimer(jobTimer) end
	end
)

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		quest_ped = createPed(ped_data.skin,ped_data.pos[1],ped_data.pos[2],ped_data.pos[3],ped_data.rot)
		setElementData(quest_ped,"ped.name",ped_data.name)
		setElementData(quest_ped,"pedNameType",ped_data.tag)
		setElementFrozen(quest_ped,true)
	end
)

addEventHandler("onClientPedDamage",root,
	function()
		if quest_ped then
			if isElement(quest_ped) and quest_ped == source then
				cancelEvent()
			end
		end
	end
)

addEvent("startLockpicking",true)
addEventHandler("startLockpicking",localPlayer,
	function()
		toggleAllControls(false)
		lockpick = true
		lockpick_tick = getTickCount()
		exports.nlrp_inventory:removeLockPick()

		setTimer( function()
			exports.nlrp_hud:showInfobox("info","Sikeresen feltörted a járművet!")
			toggleAllControls(true)
			lockpick = false
		end,lockpickTime*1000,1)
	end
)



function getProgress(addtick, lastTick) 
    local now = getTickCount() 
    local elapsedTime = now - lastTick 
    local duration = lastTick+addtick - lastTick 
    local progress = elapsedTime / duration 
    return progress 
end
function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end
function isCursorOnBox(x, y, width, height)
	if isCursorShowing() then
   		local sx, sy = guiGetScreenSize ( )
   		local cx, cy = getCursorPosition ( )
   		local cx, cy = ( cx * sx ), ( cy * sy )
  	  	if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
      		return true
  	  	else
     	    return false
   		end
   	else
   		return false
   	end	
end