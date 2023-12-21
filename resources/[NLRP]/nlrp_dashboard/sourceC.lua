
local lastTick = getTickCount()
local s = {guiGetScreenSize()}

local panel = false
local state = false

local fonts = {
	["roboto_bold_14"] = dxCreateFont("fonts/nextlevelfont.ttf",14),
	["roboto_bold_12"] = dxCreateFont("fonts/nextlevelfont.ttf",12),
	["roboto_11"] = dxCreateFont("fonts/nextlevelfont.ttf",10),

	["fontawsome_15"] = dxCreateFont("fonts/fontawsome.ttf",15),
}

local defSize = {1100,600}
local defPos = {s[1]/2-defSize[1]/2,s[2]/2-defSize[2]/2}

local size = {defSize[1],defSize[2]}
local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

local logo = {709/2.7,241/2.7}

local psize = {size[1]-logo[1]-12,size[2]-10}
local ppos = {pos[1]+logo[1]+7,pos[2]+5}

local selectedPanel = 1
--// Vagyon változók
local scroll = 0
local selected = 0
local maxLine = 6
local lineSize = 67

--// Prémium shop
local category = 0
local categorySelect = false
local maxCategoryLine = 8

local createdBlips = {}
createdBlips["vehicle"] = nil
createdBlips["interior"] = nil

local promtbox = false
local drawDistance = 0.28

local walkstyle = 1
local fight = 1

local crosshair = 1

local rowSize = 46

local panelTick = getTickCount()

local keyBinding = false
local keys = {
	["radio"] = "V",
	["voice"] = "Z",
}

function getBindedKeys(action)
	if keys[action] then
		return keys[action]
	else
		return false
	end
end

function drawDashboard()
	if panel then
		if state == "open" then
			alpha = interpolateBetween(0,0,0,1,0,0,getProgress(1000,lastTick),"InOutQuad")
			anim = interpolateBetween(0,0,0,1,0,0,getProgress(1000,lastTick),"OutBounce")
		elseif state == "close" then
			alpha = interpolateBetween(1,0,0,0,0,0,getProgress(500,lastTick),"InOutQuad")
			anim = interpolateBetween(1,0,0,0,0,0,getProgress(500,lastTick),"InBack")
			if alpha == 0 then
				panel = false
				state = false
				removeEventHandler("onClientRender",root,drawDashboard)
				removeBlur("dashboard")
				showChat(true)
				exports.nlrp_hud:toggleHUD(true)
			end
		end

		size = {defSize[1]*anim,defSize[2]*anim}
		pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

		dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(41,41,41,200*alpha))
		dxDrawBorder(pos[1],pos[2],size[1],size[2],2,tocolor(20,20,20,200*alpha))

		dxDrawRectangle(pos[1]+logo[1],pos[2],1.5,size[2],tocolor(20,20,20,200*alpha))

		if anim == 1 then
			dxDrawImage(pos[1],pos[2],logo[1],logo[2],"images/logo.png",0,0,0,tocolor(255,255,255,200*alpha))

			for k,row in ipairs(panels) do
				if isCursorOnBox(pos[1]+5,pos[2]+logo[2]+5+(k-1)*(rowSize+1),logo[1]-10,rowSize) then
					dxDrawRectangle(pos[1]+5,pos[2]+logo[2]+5+(k-1)*(rowSize+1),logo[1]-10,rowSize,tocolor(51,51,51,250*alpha))
				else
					dxDrawRectangle(pos[1]+5,pos[2]+logo[2]+5+(k-1)*(rowSize+1),logo[1]-10,rowSize,tocolor(41,41,41,250*alpha))
				end
				if panel == row.id then
					dxDrawBorder(pos[1]+5,pos[2]+logo[2]+5+(k-1)*(rowSize+1),logo[1]-10,rowSize,2,tocolor(183,255,0,200*alpha),true)
				else
					dxDrawBorder(pos[1]+5,pos[2]+logo[2]+5+(k-1)*(rowSize+1),logo[1]-10,rowSize,1,tocolor(20,20,20,200*alpha))
				end 
				dxDrawText(row.text,pos[1]+logo[1]/2,pos[2]+logo[2]+5+(k-1)*(rowSize+1)+rowSize/2,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_bold_14"],"center","center",false,false,false,true)
			end

			local alpha = interpolateBetween(0,0,0,1,0,0,getProgress(500,panelTick),"InOutQuad")
			if panel == 1 then

				dxDrawRectangle(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,tocolor(46,46,46,250*alpha))
				dxDrawBorder(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,1,tocolor(20,20,20,200*alpha))

				local jobText = "Nincs"
				if getElementData(localPlayer,"char.Job") > 0 then
					jobText = exports.nlrp_jobs:getJobInfo(getElementData(localPlayer,"char.Job"))[1]
				end
				local factionText = "Nem vagy frakcióban"
				local playerGroups = exports.nlrp_groups:getPlayerGroups(localPlayer)
				local pFactions = {}

				for groupID,groupData in pairs(playerGroups) do
					table.insert(pFactions,{
						factionID = groupID,
						data = groupData,
					})
				end
				if #pFactions == 1 then
					local rankID,rankName = exports.nlrp_groups:getPlayerRank(localPlayer,pFactions[1].factionID)
					factionText = exports.nlrp_groups:getGroupPrefix(pFactions[1].factionID) .. " (" .. rankName .. ")"
				elseif #pFactions > 1 then
					factionText = "Jelenleg " .. #pFactions .. " frakció tagja vagy."
				end

				local datas = {
					{icon="images/icons/1.png",text="Karakter neve:",text2=getElementData(localPlayer,"char.Name"):gsub("_"," "),size=45},
					{icon="images/icons/2.png",text="Készpénzed:",text2=format(getElementData(localPlayer,"char.Money")) .. " Ft",size=55},
					{icon="images/icons/3.png",text="Banki egyenleg:",text2=format(getElementData(localPlayer,"char.bankMoney")) .. " Ft",size=55},
					{icon="images/icons/4.png",text="NL Coin:",text2=format(getElementData(localPlayer,"char.PP")),size=65},
					{icon="images/icons/5.png",text="Járműveid száma:",text2=#getPlayerVehicles() .. " db",size=55},
					{icon="images/icons/6.png",text="Ingatlanjaid száma:",text2=#getPlayerInteriors() .. " db",size=55},
					{icon="images/icons/7.png",text="Munkahely:",text2=jobText,size=55},
					{icon="images/icons/8.png",text="Idő a fizetésig:",text2=60-getElementData(localPlayer,"char.playTimeForPayday") .. " perc",size=55},
					{icon="images/icons/9.png",text="Skin ID:",text2="#" .. getElementModel(localPlayer),size=55},
					{icon="images/icons/10.png",text="Frakció:",text2=factionText,size=55},
				}

				draw_column = 0
				draw_row = 0
				for i = 1,#datas do
					local row = datas[i]
					dxDrawImage(ppos[1]+40+30+(draw_row*(psize[1]/2-50)),ppos[2]+55+30+(draw_column*90),row.size,row.size,row.icon,0,0,0,tocolor(255,255,255,222*alpha))
					dxDrawText(row.text,ppos[1]+40+30+(draw_row*(psize[1]/2-50))+70,ppos[2]+55+30+(draw_column*90)+row.size/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"left","bottom",false,false,false,true)
					dxDrawText(row.text2,ppos[1]+40+30+(draw_row*(psize[1]/2-50))+70,ppos[2]+55+30+(draw_column*90)+row.size/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"left","top",false,false,false,true)

					draw_column = draw_column + 1
					if draw_column == 5 then
						draw_column = 0
						draw_row = draw_row + 1
					end
				end
			elseif panel == 2 then
				dxDrawRectangle(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,tocolor(46,46,46,250*alpha))
				dxDrawBorder(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,1,tocolor(20,20,20,200*alpha))

				if isCursorOnBox(ppos[1]+40+(psize[1]-80)/2,ppos[2]+55,(psize[1]-80)/2,60) then
					dxDrawRectangle(ppos[1]+40+(psize[1]-80)/2,ppos[2]+55,(psize[1]-80)/2,60,tocolor(52,52,52,250*alpha))
				end
				dxDrawText("Ingatlanok",ppos[1]+40+(psize[1]-80)/2+((psize[1]-80)/2)/2,ppos[2]+55+60/2,nil,nil,tocolor(255,255,255,222*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)
				if isCursorOnBox(ppos[1]+40,ppos[2]+55,(psize[1]-80)/2,60) then
					dxDrawRectangle(ppos[1]+40,ppos[2]+55,(psize[1]-80)/2,60,tocolor(52,52,52,250*alpha))
				end
				dxDrawText("Járművek",ppos[1]+40+((psize[1]-80)/2)/2,ppos[2]+55+60/2,nil,nil,tocolor(255,255,255,222*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)

				if selectedPanel == 2 then
					dxDrawBorder(ppos[1]+40+(psize[1]-80)/2,ppos[2]+55,(psize[1]-80)/2,60,2,tocolor(183,255,0,200*alpha),true)
				elseif selectedPanel == 1 then
					dxDrawBorder(ppos[1]+40,ppos[2]+55,(psize[1]-80)/2,60,2,tocolor(183,255,0,200*alpha),true)
				end

				dxDrawRectangle(ppos[1]+psize[1]/2-0.5,ppos[2]+55,1,60,tocolor(20,20,20,200*alpha))
				dxDrawRectangle(ppos[1]+40,ppos[2]+55+60,psize[1]-80,1,tocolor(20,20,20,200*alpha))

				if selectedPanel == 1 then --// Járművek
					local vehicles = getPlayerVehicles()
					for i = 1,maxLine do
						local vehicle = vehicles[i+scroll]
						local boxsize = {psize[1]/2-60,lineSize}
						local boxpos = {ppos[1]+40+5,ppos[2]+55+65+(i-1)*(boxsize[2]+1)}
						if vehicle then
							dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(57,57,57,250*alpha))
							if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
								dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(200,200,200,4*alpha))
							end

							dxDrawText(exports.nlrp_vehs:getVehicleName(vehicle),boxpos[1]+boxsize[1]/2,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"center","center",false,false,false,true)
						else
							dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(52,52,52,250*alpha))
						end
						if selected == i+scroll then
							dxDrawBorder(boxpos[1],boxpos[2],boxsize[1],boxsize[2],2,tocolor(183,255,0,200*alpha),true)
						end
					end
					if #vehicles == 0 then
						dxDrawText("Nincs egyetlen járműved sem..",ppos[1]+40+5+(psize[1]/2-60)/2,ppos[2]+55+65+lineSize/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center")
					end
					if selected ~= 0 then
						local vehicle = vehicles[selected]
						if vehicle then
							dxDrawText("ID: #" .. format(getElementData(vehicle,"vehicle.dbID")),ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+120,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"left","top",false,false,false,true)
							dxDrawText("Felszereltség:",ppos[1]+40+(psize[1]/2-80)+35+155,ppos[2]+145,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","top",false,false,false,true)

							local tunings = exports.nle_tuning:getPerformanceTunesForDashboard()

							for k,v in ipairs(tunings) do
								dxDrawText(v.name .. ": " .. getTuningName(getElementData(vehicle,v.elementdata) or 0),ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+170+(k-1)*16.25,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"left","top",false,false,false,true)
							end

							local color = tocolor(183,255,0,170*alpha)
							local text = "Jármű pozíció megjelőlése"
							if createdBlips["vehicle"] then
								if createdBlips["vehicle"].vehicle_dbid == getElementData(vehicle,"vehicle.dbID") then
									color = tocolor(169,50,38,170*alpha)
									text = "Jelölés törlése"
								end
							end

							dxDrawBorder(ppos[1]+45,ppos[2]+psize[2]-50,psize[1]/2-60,45,1,tocolor(20,20,20,250*alpha))
							if isCursorOnBox(ppos[1]+45,ppos[2]+psize[2]-50,psize[1]/2-60,45) then
								dxDrawRectangle(ppos[1]+45,ppos[2]+psize[2]-50,psize[1]/2-60,45,color)
							else
								dxDrawRectangle(ppos[1]+45,ppos[2]+psize[2]-50,psize[1]/2-60,45,tocolor(52,52,52,250*alpha))
							end
							dxDrawText(text,ppos[1]+45+(psize[1]/2-60)/2,ppos[2]+psize[2]-50+45/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"center","center",false,false,false,true)
						else
							selected = 0
							scroll = 0
						end
					end
				elseif selectedPanel == 2 then
					local interiors = getPlayerInteriors()
					for i = 1,maxLine do
						local interior = interiors[i+scroll]
						local boxsize = {psize[1]/2-60,lineSize}
						local boxpos = {ppos[1]+40+5,ppos[2]+55+65+(i-1)*(boxsize[2]+1)}
						if interior then
							dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(57,57,57,250*alpha))
							if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
								dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(200,200,200,4*alpha))
							end

							dxDrawText(interior.data.name,boxpos[1]+boxsize[1]/2,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"center","center",false,false,false,true)
						else
							dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(52,52,52,250*alpha))
						end
						if selected == i+scroll then
							dxDrawBorder(boxpos[1],boxpos[2],boxsize[1],boxsize[2],2,tocolor(183,255,0,200*alpha),true)
						end
					end
					if #interiors == 0 then
						dxDrawText("Nincs egyetlen ingatlanod sem..",ppos[1]+40+5+(psize[1]/2-60)/2,ppos[2]+55+65+lineSize/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center")
					end
					if selected ~= 0 then
						local interior = interiors[selected]
						if interior then
							dxDrawText("ID: #" .. format(interior.interiorId),ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+120,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"left","top",false,false,false,true)
							
							local x,y,z = getElementPosition(interior.data.enterMarker)
							dxDrawText("Pozíció: " .. getZoneName(x,y,z),ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+170,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"left","top",false,false,false,true)
						else
							selected = 0
							scroll = 0
						end

						local color = tocolor(183,255,0,170*alpha)
						local text = "Ingatlan pozíció megjelőlése"
						if createdBlips["interior"] then
							if createdBlips["interior"].interior_dbid == interior.interiorId then
								color = tocolor(169,50,38,170*alpha)
								text = "Jelölés törlése"
							end
						end

						dxDrawBorder(ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+psize[2]-108,368,45,1,tocolor(20,20,20,250*alpha))
						if isCursorOnBox(ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+psize[2]-108,368,45) then
							dxDrawRectangle(ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+psize[2]-108,368,45,color)
						else
							dxDrawRectangle(ppos[1]+40+(psize[1]/2-80)+35,ppos[2]+psize[2]-108,368,45,tocolor(52,52,52,250*alpha))
						end
						dxDrawText(text,ppos[1]+40+(psize[1]/2-80)+35+368/2,ppos[2]+psize[2]-108+45/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"center","center",false,false,false,true)
					end
				end
			elseif panel == 3 then
				dxDrawRectangle(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,tocolor(46,46,46,250*alpha))
				dxDrawBorder(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,1.5,tocolor(20,20,20,200*alpha))

				for i = 1,3 do
					if isCursorOnBox(ppos[1]+40+(i-1)*((psize[1]-80)/3),ppos[2]+55,(psize[1]-80)/3,60) then
						dxDrawRectangle(ppos[1]+40+(i-1)*((psize[1]-80)/3),ppos[2]+55,(psize[1]-80)/3,60,tocolor(51,51,51,250*alpha))
					else
						dxDrawRectangle(ppos[1]+40+(i-1)*((psize[1]-80)/3),ppos[2]+55,(psize[1]-80)/3,60,tocolor(46,46,46,250*alpha))
					end
					dxDrawRectangle(ppos[1]+40+((psize[1]-80)/3)+(i-1)*((psize[1]-80)/3)-0.75,ppos[2]+55,1.5,60,tocolor(20,20,20,250*alpha))
					dxDrawText(donate_panels[i],ppos[1]+40+(i-1)*((psize[1]-80)/3)+((psize[1]-80)/3)/2,pos[2]+55+70/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_14"],"center","center",false,false,false,true)
					if selectedPanel == i then
						dxDrawBorder(ppos[1]+40+(i-1)*((psize[1]-80)/3),ppos[2]+55,(psize[1]-80)/3,60,2,tocolor(183,255,0,200*alpha),true)
					end
				end
				dxDrawRectangle(ppos[1]+40,ppos[2]+55+60,psize[1]-80,1.5,tocolor(20,20,20,250*alpha))

				if selectedPanel == 1 then
					for i = 1,#donate_packs do
						if isCursorOnBox(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(82),300,81) then
							dxDrawRectangle(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(82),300,81,tocolor(65,65,65,250*alpha))
							local imgSize = {498/1.15,459/1.15}
							dxDrawImage(ppos[1]+40+5+300+5,ppos[2]+55+60+12,imgSize[1],imgSize[2],donate_packs[i].image,0,0,0,tocolor(255,255,255,200*alpha))
						else
							dxDrawRectangle(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(82),300,81,tocolor(55,55,55,250*alpha))
						end
						dxDrawText(donate_packs[i].name,ppos[1]+40+5+300/2,ppos[2]+55+60+5+(i-1)*(82)+81/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)
					end
				elseif selectedPanel == 2 then
					local imgSize = {996/1.36,489/1.36}
					dxDrawImage(ppos[1]+40+5,ppos[2]+55+60+5+25,imgSize[1],imgSize[2],"images/donate/paypal.png",0,0,0,tocolor(255,255,255,200*alpha))
				elseif selectedPanel == 3 then
					local imgSize = {996/1.36,489/1.36}
					dxDrawImage(ppos[1]+40+5,ppos[2]+55+60+5+25,imgSize[1],imgSize[2],"images/donate/sms.png",0,0,0,tocolor(255,255,255,200*alpha))
				end
			elseif panel == 4 then
				dxDrawRectangle(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,tocolor(46,46,46,250*alpha))
				dxDrawBorder(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,1.5,tocolor(20,20,20,200*alpha))

				dxDrawRectangle(ppos[1]+40,ppos[2]+55+60,psize[1]-80,1,tocolor(20,20,20,250*alpha))
				dxDrawText(shopCategorys[category].name,ppos[1]+psize[1]/2,ppos[2]+55+60/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)
			
				if category > 0 then
					local row = shopCategorys[category]
					if row then
						draw_column = 0
						draw_row = 0
						for i = 1,12 do
							local boxsize = {(psize[1]-100)/2,60}
							local boxpos = {ppos[1]+40+5+((psize[1]-100)/2+10)*draw_column,ppos[2]+55+60+5+(70*draw_row)}

							if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
								dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(56,56,56,250*alpha))
							else
								dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(51,51,51,250*alpha))
							end
							if selected == i+scroll then
								dxDrawBorder(boxpos[1],boxpos[2],boxsize[1],boxsize[2],2,tocolor(183,255,0,200*alpha))
							end
							local item = row.items[i+scroll]
							if item then
								local name,desc,weight = exports.nlrp_inventory:getItemInfoForShop(item.id)
								dxDrawImage(boxpos[1]+5,boxpos[2]+5,boxsize[2]-10,boxsize[2]-10,":nlrp_inventory/files/items/" .. item.id .. ".png")
								dxDrawText(item.count .. "x " .. name,boxpos[1]+boxsize[2]+5,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_bold_12"],"left","bottom",false,false,false,true)
								dxDrawText("#FFD700" .. format(item.price) .. " #b7ff00NL Coin",boxpos[1]+boxsize[2]+5,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_bold_12"],"left","top",false,false,false,true)
							end
							draw_column = draw_column + 1
							if draw_column == 2 then
								draw_column = 0
								draw_row = draw_row + 1
							end
						end
					end
					if selected ~= 0 then
						if isCursorOnBox(ppos[1]+psize[1]-40-275,ppos[2]+psize[2]-50,275,40) then
							dxDrawRectangle(ppos[1]+psize[1]-40-275,ppos[2]+psize[2]-50,275,40,tocolor(183,255,0,200*alpha))
						else
							dxDrawRectangle(ppos[1]+psize[1]-40-275,ppos[2]+psize[2]-50,275,40,tocolor(183,255,0,165*alpha))
						end
						dxDrawText("Vásárlás",ppos[1]+psize[1]-40-275/2,ppos[2]+psize[2]-50+40/2,nil,nil,tocolor(0,0,0,200*alpha),1,fonts["roboto_bold_12"],"center","center")
					end
				end
				dxDrawImage(ppos[1]+40,ppos[2]+psize[2]-60,65,65,"images/icons/4.png",0,0,0,tocolor(255,255,255,255*alpha))
				dxDrawText("#FFD700" .. format(getElementData(localPlayer,"char.PP")) .. " #b7ff00NL Coin",ppos[1]+40+62,ppos[2]+psize[2]-61/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"left","center",false,false,false,true)

				if categorySelect then
					dxDrawText("",ppos[1]+psize[1]-40-60/2,ppos[2]+55+60/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center")
					for i,v in ipairs(shopCategorys) do
						if isCursorOnBox(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(51),psize[1]-90,50) then
							dxDrawRectangle(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(51),psize[1]-90,50,tocolor(71,71,71,250*alpha))
						else
							dxDrawRectangle(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(51),psize[1]-90,50,tocolor(61,61,61,250*alpha))
						end
						dxDrawText(v.name,ppos[1]+psize[1]/2,ppos[2]+55+60+5+(i-1)*(51)+50/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center")
					end
				else
					dxDrawText("",ppos[1]+psize[1]-40-60/2,ppos[2]+55+60/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center")
				end
			elseif panel == 5 then
				dxDrawRectangle(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,tocolor(46,46,46,250*alpha))
				dxDrawBorder(ppos[1]+40,ppos[2]+55,psize[1]-80,psize[2]-110,1.5,tocolor(20,20,20,200*alpha))

				dxDrawRectangle(ppos[1]+40+5,ppos[2]+55+psize[2]-110-40-5,psize[1]-90,40,tocolor(61,61,61,250*alpha))
				if isCursorOnBox(ppos[1]+40+5,ppos[2]+55+psize[2]-110-40-5,psize[1]-90,40) then
					if getKeyState("mouse1") then
						local cx,cy = getCursorPosition()
						cx,cy = cx*s[1],cy*s[2]

						local boxwidth = psize[1]-90
						drawDistance = (cx-(ppos[1]+40+5))/boxwidth
						setFarClipDistance(math.floor(300+(2700*drawDistance)))
					end
				end

				local boxColor = tocolor(169,50,38,200*alpha)
				if drawDistance >= 0.33 and drawDistance < 0.66 then boxColor = tocolor(255,215,0,200*alpha) end
				if drawDistance >= 0.66 then boxColor = tocolor(183,255,0,200*alpha) end

				dxDrawRectangle(ppos[1]+40+5,ppos[2]+55+psize[2]-110-40-5,(psize[1]-90)*drawDistance,40,boxColor)
				dxDrawText("Látótávolság: " .. format(math.floor(300+(2700*drawDistance))) .. " yard",ppos[1]+psize[1]/2,ppos[2]+55+psize[2]-110-40-5+40/2,nil,nil,tocolor(0,0,0,222*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)
			
				dxDrawBorder(ppos[1]+45,ppos[2]+60,365,40,1,tocolor(20,20,20,250*alpha))
				dxDrawText("Séta stílus",ppos[1]+45+365/2,ppos[2]+60+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"center","bottom",false,false,false,true)
				dxDrawText(walkstyles[walkstyle].text,ppos[1]+45+365/2,ppos[2]+60+37/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","top",false,false,false,true)
				
				dxDrawText("",ppos[1]+45+40/2,ppos[2]+60+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center",false,false,false,true)
				dxDrawText("",ppos[1]+45+365-40/2,ppos[2]+60+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center",false,false,false,true)

				dxDrawBorder(ppos[1]+45+370,ppos[2]+60,365,40,1,tocolor(20,20,20,250*alpha))
				dxDrawText("Harc stílus",ppos[1]+45+370+365/2,ppos[2]+60+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_11"],"center","bottom",false,false,false,true)
				dxDrawText(fights[fight].text,ppos[1]+45+370+365/2,ppos[2]+60+37/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","top",false,false,false,true)
				
				dxDrawText("",ppos[1]+45+370+40/2,ppos[2]+60+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center",false,false,false,true)
				dxDrawText("",ppos[1]+45+370+365-40/2,ppos[2]+60+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center",false,false,false,true)

				dxDrawBorder(ppos[1]+45,ppos[2]+110,365,40,1,tocolor(20,20,20,250*alpha))
				dxDrawText("Rádió billentyű",ppos[1]+45+10,ppos[2]+110+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"left","center",false,false,false,true)
				dxDrawText(keys["radio"],ppos[1]+45+280,ppos[2]+110+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"left","center",false,false,false,true)
						
				dxDrawBorder(ppos[1]+45,ppos[2]+160,365,40,1,tocolor(20,20,20,250*alpha))
				dxDrawText("Hud szerkesztés",ppos[1]+45+365/2,ppos[2]+160+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)
			
				dxDrawBorder(ppos[1]+45+370,ppos[2]+160,365,40,1,tocolor(20,20,20,250*alpha))
				dxDrawText("Modpanel",ppos[1]+45+370+365/2,ppos[2]+160+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["roboto_bold_12"],"center","center",false,false,false,true)
			
				dxDrawBorder(ppos[1]+45+370,ppos[2]+110,365,40,1,tocolor(20,20,20,250*alpha))
				dxDrawImage(ppos[1]+45+370+365/2-35/2,ppos[2]+110+2.5,35,35,"images/crosshairs/" .. crosshair .. ".png",0,0,0,tocolor(255,255,255,255*alpha))

				dxDrawText("",ppos[1]+45+370+40/2,ppos[2]+110+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center",false,false,false,true)
				dxDrawText("",ppos[1]+45+370+365-40/2,ppos[2]+110+40/2,nil,nil,tocolor(255,255,255,200*alpha),1,fonts["fontawsome_15"],"center","center",false,false,false,true)
			end
		end
	end
	if promtbox then
		dxDrawRectangle(0,0,s[1],s[2],tocolor(0,0,0,175))
		local bsize = {480,135}
		local bpos = {s[1]/2-bsize[1]/2,s[2]/2-bsize[2]/2}
		local item = shopCategorys[category].items[selected]
		local name,_,_ = exports.nlrp_inventory:getItemInfoForShop(item.id)
		local price = item.price

		dxDrawRectangle(bpos[1],bpos[2],bsize[1],bsize[2],tocolor(41,41,41,250))
		dxDrawBorder(bpos[1],bpos[2],bsize[1],bsize[2],1.5,tocolor(20,20,20,250))
		dxDrawText("Biztos megszeretnéd vásárolni a kiválasztott tárgyat?",bpos[1]+bsize[1]/2,bpos[2]+5,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_11"],"center","top",false,false,false,true)
		dxDrawText(name,bpos[1]+bsize[1]/2,bpos[2]+35,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_bold_12"],"center","top",false,false,false,true)
		dxDrawText("#FFD700" .. format(price) .. " #b7ff00NL Coin",bpos[1]+bsize[1]/2,bpos[2]+55,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_bold_12"],"center","top",false,false,false,true)
	
		if isCursorOnBox(bpos[1]+5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40) then
			dxDrawRectangle(bpos[1]+5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40,tocolor(183,255,0,200*alpha))
		else
			dxDrawRectangle(bpos[1]+5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40,tocolor(183,255,0,165*alpha))
		end
		dxDrawText("Igen",bpos[1]+5+(bsize[1]/2-10)/2,bpos[2]+bsize[2]-40-5+40/2,nil,nil,tocolor(0,0,0,200*alpha),1,fonts["roboto_bold_12"],"center","center")

		if isCursorOnBox(bpos[1]+bsize[1]-(bsize[1]/2-10)-5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40) then
			dxDrawRectangle(bpos[1]+bsize[1]-(bsize[1]/2-10)-5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40,tocolor(169,50,38,200*alpha))
		else
			dxDrawRectangle(bpos[1]+bsize[1]-(bsize[1]/2-10)-5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40,tocolor(169,50,38,165*alpha))
		end
		dxDrawText("Nem",bpos[1]+bsize[1]-(bsize[1]/2-10)-5+(bsize[1]/2-10)/2,bpos[2]+bsize[2]-40-5+40/2,nil,nil,tocolor(0,0,0,200*alpha),1,fonts["roboto_bold_12"],"center","center")
	end
	if keyBinding then
		dxDrawRectangle(0,0,s[1],s[2],tocolor(0,0,0,175))
		dxDrawText("Nyomj meg egy tetszőleges billentyűt..",s[1]/2,s[2]/2,nil,nil,tocolor(255,255,255,200),1,fonts["roboto_bold_14"],"center","center",false,false,false,true)
	end
end

addEventHandler("onClientKey",root,
	function(k,p)
		if keyBinding and p then
			if bindableKeys[keyBinding][string.upper(k)] and not keys["radio"] ~= string.upper(k) and not keys["voice"] ~= string.upper(k) then
				exports.nlrp_hud:showInfobox("info","Sikeresen beállítottad a kiválasztott billentyűt!")
				keys[keyBinding] = string.upper(k)
				keyBinding = false
			else
				exports.nlrp_hud:showInfobox("error","Ezt a billentyűt nem használhatod erre a funkcióra!")
			end
			return
		end
		if panel and state == "open" and (lastTick+500 < getTickCount()) and promtbox then
			local bsize = {480,135}
			local bpos = {s[1]/2-bsize[1]/2,s[2]/2-bsize[2]/2}
			if isCursorOnBox(bpos[1]+5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40) then
				promtbox = false
				playSound("sounds/katt.wav")
				local item = shopCategorys[category].items[selected]
				local name,_,_ = exports.nlrp_inventory:getItemInfoForShop(item.id)
				local price = item.price
				local count = item.count
				if getElementData(localPlayer,"char.PP") >= price then
					triggerServerEvent("buyItemFromShop",resourceRoot,localPlayer,item.id,count,price)
				else
					exports.nlrp_hud:showInfobox("error","Nincs elegendő NL Coin-od a vásárláshoz!")
				end
			elseif isCursorOnBox(bpos[1]+bsize[1]-(bsize[1]/2-10)-5,bpos[2]+bsize[2]-40-5,bsize[1]/2-10,40) then
				promtbox = false
				playSound("sounds/katt.wav")
			end
		end
		if panel and state == "open" and (lastTick+500 < getTickCount()) and not promtbox then
			if panel == 4 and category > 0 then
				if k == "mouse_wheel_down" and p then
					if scroll < #shopCategorys[category].items-12 then
						scroll = scroll + 2
					end
				elseif k == "mouse_wheel_up" and p then
					if scroll > 0 then
						scroll = scroll - 2
					end
				end
			end
			if k == "mouse1" and p then
				if panel == 5 then
					if isCursorOnBox(ppos[1]+45,ppos[2]+110,365,40) then
						keyBinding = "radio"
						playSound("sounds/katt.wav")
					end	

					if isCursorOnBox(ppos[1]+45,ppos[2]+160,365,40) then
						promtbox = false
						panel = false
						state = false
						removeEventHandler("onClientRender",root,drawDashboard)
						removeBlur("dashboard")
						showChat(true)
						exports.nlrp_hud:toggleHUD(true)
						executeCommandHandler("edithud")
						playSound("sounds/katt.wav")
					elseif isCursorOnBox(ppos[1]+45+370,ppos[2]+160,365,40) then
						promtbox = false
						panel = false
						state = false
						removeEventHandler("onClientRender",root,drawDashboard)
						removeBlur("dashboard")
						showChat(true)
						exports.nlrp_hud:toggleHUD(true)
						executeCommandHandler("mods")
						playSound("sounds/katt.wav")
					end

					if isCursorOnBox(ppos[1]+45+365-40,ppos[2]+60,40,40) then
						if walkstyle < #walkstyles then
							walkstyle = walkstyle + 1
							playSound("sounds/katt.wav")
							triggerServerEvent("setWalkstyle",resourceRoot,localPlayer,walkstyles[walkstyle].data)
						end
					elseif isCursorOnBox(ppos[1]+45,ppos[2]+60,40,40) then
						if walkstyle > 1 then
							walkstyle = walkstyle - 1
							playSound("sounds/katt.wav")
							triggerServerEvent("setWalkstyle",resourceRoot,localPlayer,walkstyles[walkstyle].data)
						end
					end

					if isCursorOnBox(ppos[1]+45+370+365-40,ppos[2]+60,40,40) then
						if fight < #fights then
							fight = fight + 1
							playSound("sounds/katt.wav")
							triggerServerEvent("setFightstyle",resourceRoot,localPlayer,fights[fight].data)
						end
					elseif isCursorOnBox(ppos[1]+45+370,ppos[2]+60,40,40) then
						if fight > 1 then
							fight = fight - 1
							playSound("sounds/katt.wav")
							triggerServerEvent("setFightstyle",resourceRoot,localPlayer,fights[fight].data)
						end
					end

					if isCursorOnBox(ppos[1]+45+370+365-40,ppos[2]+110,40,40) then
						if crosshair < #crosshairs then
							crosshair = crosshair + 1
							playSound("sounds/katt.wav")
						end
					elseif isCursorOnBox(ppos[1]+370+45,ppos[2]+110,40,40) then
						if crosshair > 1 then
							crosshair = crosshair - 1
							playSound("sounds/katt.wav")
						end
					end
				elseif panel == 4 then
					if isCursorOnBox(ppos[1]+40,ppos[2]+55,psize[1]-80,60) then
						categorySelect = not categorySelect
						playSound("sounds/katt.wav")
					end
					if category ~= 0 then
						local row = shopCategorys[category]
						if row then
							if selected ~= 0 then
								local item = row.items[selected]
								if item then
									if isCursorOnBox(ppos[1]+psize[1]-40-275,ppos[2]+psize[2]-50,275,40) then
										promtbox = not promtbox
										playSound("sounds/katt.wav")
									end
								end
							end

							draw_column = 0
							draw_row = 0
							for i = 1,12 do
								local boxsize = {(psize[1]-100)/2,60}
								local boxpos = {ppos[1]+40+5+((psize[1]-100)/2+10)*draw_column,ppos[2]+55+60+5+(70*draw_row)}

								if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
									local item = row.items[i+scroll]
									if item then
										if selected ~= i+scroll then
											if not categorySelect then
												selected = i+scroll
												playSound("sounds/katt.wav")
											end
										end
									end
								end
								draw_column = draw_column + 1
								if draw_column == 2 then
									draw_column = 0
									draw_row = draw_row + 1
								end
							end
						end
					end
					if categorySelect then
						for i,v in ipairs(shopCategorys) do
							if isCursorOnBox(ppos[1]+40+5,ppos[2]+55+60+5+(i-1)*(51),psize[1]-90,50) then
								category = i
								categorySelect = false
								selected = 0
								scroll = 0
								playSound("sounds/katt.wav")
							end
						end
					end
				elseif panel == 3 then
					for i = 1,3 do
						if isCursorOnBox(ppos[1]+40+(i-1)*((psize[1]-80)/3),ppos[2]+55,(psize[1]-80)/3,60) then
							if selectedPanel ~= i then
								selectedPanel = i
								playSound("sounds/katt.wav")
							end
						end
					end
				elseif panel == 2 then
					if selectedPanel == 1 then
						local vehicles = getPlayerVehicles()
						for i = 1,maxLine do
							local vehicle = vehicles[i+scroll]
							local boxsize = {psize[1]/2-60,lineSize}
							local boxpos = {ppos[1]+40+5,ppos[2]+55+65+(i-1)*(boxsize[2]+1)}
							if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
								if vehicle then
									if selected ~= i+scroll then
										selected = i+scroll
										playSound("sounds/katt.wav")
									end
								end
							end
						end
						if selected ~= 0 then
							local vehicle = vehicles[selected]
							if vehicle then
								if isCursorOnBox(ppos[1]+45,ppos[2]+psize[2]-50,psize[1]/2-60,45) then
									if not createdBlips["vehicle"] then
										if getElementInterior(vehicle) == 0 and getElementDimension(vehicle) == 0 then
											createdBlips["vehicle"] = {}
											local x,y,z = getElementPosition(vehicle)
											createdBlips["vehicle"].blip_id = exports.nlrp_hud:addCustomBlip({x,y,z,"car.png",14.5,true})
											createdBlips["vehicle"].vehicle_dbid = getElementData(vehicle,"vehicle.dbID")
											createdBlips["vehicle"].marker = createMarker(x,y,z,"checkpoint",3.5,183,255,0,100)
											exports.nlrp_hud:showInfobox("info", "A kiválasztott járműved meg lett jelölve a térképen!")
										else
											exports.nlrp_hud:showInfobox("error", "A kiválasztott jármű egy interiorban van! (ID: #" .. getElementDimension(vehicle) .. ")")
										end
									else
										if createdBlips["vehicle"].vehicle_dbid == getElementData(vehicle,"vehicle.dbID") then
											exports.nlrp_hud:delCustomBlip(createdBlips["vehicle"].blip_id)
											destroyElement(createdBlips["vehicle"].marker)
											exports.nlrp_hud:showInfobox("info", "Jelölés törölve!")
											createdBlips["vehicle"] = nil
										else
											exports.nlrp_hud:showInfobox("error", "Már megvan jelölve egy járműved!")
										end 
									end
								end
							end
						end
					elseif selectedPanel == 2 then
						local interiors = getPlayerInteriors()
						for i = 1,maxLine do
							local interior = interiors[i+scroll]
							local boxsize = {psize[1]/2-60,lineSize}
							local boxpos = {ppos[1]+40+5,ppos[2]+55+65+(i-1)*(boxsize[2]+1)}
							if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
								if interior then
									if selected ~= i+scroll then
										selected = i+scroll
										playSound("sounds/katt.wav")
									end
								end
							end
						end
						if selected ~= 0 then
							local interior = interiors[selected]
							if interior then
								if isCursorOnBox(ppos[1]+45,ppos[2]+psize[2]-50,psize[1]/2-60,45) then
									if not createdBlips["interior"] then
										createdBlips["interior"] = {}
										local x,y,z = getElementPosition(interior.data.enterMarker)
										createdBlips["interior"].blip_id = exports.nlrp_hud:addCustomBlip({x,y,z,"home.png",14.5,true})
										createdBlips["interior"].interior_dbid = interior.interiorId
										createdBlips["interior"].marker = createMarker(x,y,z,"checkpoint",3.5,183,255,0,100)
										exports.nlrp_hud:showInfobox("info", "A kiválasztott ingatlan meg lett jelölve a térképen!")
									else
										if createdBlips["interior"].interior_dbid == interior.interiorId then
											exports.nlrp_hud:delCustomBlip(createdBlips["interior"].blip_id)
											destroyElement(createdBlips["interior"].marker)
											exports.nlrp_hud:showInfobox("info", "Jelölés törölve!")
											createdBlips["interior"] = nil
										else
											exports.nlrp_hud:showInfobox("error", "Már megvan jelölve egy ingatlanod!")
										end 
									end
								end
							end
						end
					end
					if isCursorOnBox(ppos[1]+40,ppos[2]+55,(psize[1]-80)/2,60) then
						if selectedPanel ~= 1 then
							selectedPanel = 1
							playSound("sounds/katt.wav")
							selected = 0
							scroll = 0
						end
					elseif isCursorOnBox(ppos[1]+40+(psize[1]-80)/2,ppos[2]+55,(psize[1]-80)/2,60) then
						if selectedPanel ~= 2 then
							selectedPanel = 2
							playSound("sounds/katt.wav")
							selected = 0
							scroll = 0
						end
					end
				end
				for k,row in ipairs(panels) do
					if isCursorOnBox(pos[1]+5,pos[2]+logo[2]+5+(k-1)*(rowSize+1),logo[1]-10,rowSize) then
						if panel ~= row.id then
							panel = row.id
							panelTick = getTickCount()
							playSound("sounds/katt.wav")
							selectedPanel = 1
							category = 0
							categorySelect = false
						end
					end
				end
			end
			if panel == 2 then
				if k == "mouse_wheel_down" and p then
					if selectedPanel == 1 then
						local vehicles = getPlayerVehicles()
						if scroll < #vehicles-maxLine then
							scroll = scroll + 1
						end
					elseif selectedPanel == 2 then
						local interiors = getPlayerInteriors()
						if scroll < #interiors-maxLine then
							scroll = scroll + 1
						end
					end
				elseif k == "mouse_wheel_up" and p then
					if scroll > 0 then
						scroll = scroll - 1
					end
				end
			end
		end
		if k == "home" and p then
			cancelEvent()
			if getElementData(localPlayer,"loggedIn") then
				if not panel then
					panel = 1
					category = 0
					state = "open"
					lastTick = getTickCount()
					addEventHandler("onClientRender",root,drawDashboard)
					createBlur("dashboard",10)
					showChat(false)
					exports.nlrp_hud:toggleHUD(false)
					playSound("sounds/open.wav")
					selectedPanel = 1
					scroll = 0
					selected = 0
					categorySelect = false
					promtbox = false
					panelTick = getTickCount()
				else
					if state ~= "close" and (lastTick+500 < getTickCount()) then
						playSound("sounds/close.wav")
						state = "close"
						lastTick = getTickCount()
						promtbox = false
					end
				end
			end
		end
	end
)

function loadSavedSettings()
	--// Beállítások betöltése
	if fileExists("settings.xml") then
		local file = xmlLoadFile("settings.xml")
		if file then
			if xmlFindChild(file,"walkstyle",0) then
				walkstyle = tonumber(xmlNodeGetValue(xmlFindChild(file,"walkstyle",0)))
				triggerServerEvent("setWalkstyle",resourceRoot,localPlayer,walkstyles[walkstyle].data)
			end

			if xmlFindChild(file,"fightstyle",0) then
				fight = tonumber(xmlNodeGetValue(xmlFindChild(file,"fightstyle",0)))
				triggerServerEvent("setFightstyle",resourceRoot,localPlayer,fights[fight].data)
			end

			if xmlFindChild(file,"radioKey",0) then
				keys["radio"] = xmlNodeGetValue( xmlFindChild(file,"radioKey",0))
			end

			if xmlFindChild(file,"crosshair",0) then
				crosshair = tonumber(xmlNodeGetValue(xmlFindChild(file,"crosshair",0)))
			end
			if xmlFindChild(file,"drawdistance",0) then
				drawDistance = tonumber(xmlNodeGetValue( xmlFindChild(file,"drawdistance",0)))
				setFarClipDistance(300+(2700*drawDistance))
			end
		end
	end
end

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		loadSavedSettings()
	end
)

addEventHandler("onClientElementDataChange",root,
	function(data,o,n)
		if source == localPlayer then
			if data == "loggedIn" then
				if n then
					setTimer( function()
						loadSavedSettings()
					end,2000,1)
				end
			end
		end
	end
)


addEventHandler("onClientResourceStop",resourceRoot,
	function()
		--// Beállítások mentése
		if fileExists("settings.xml") then
			fileDelete("settings.xml")
		end

		local file = xmlCreateFile("settings.xml","Dashboard")
		xmlNodeSetValue( xmlCreateChild(file,"walkstyle"),walkstyle)
		xmlNodeSetValue( xmlCreateChild(file,"fightstyle"),fight)
		xmlNodeSetValue( xmlCreateChild(file,"radioKey"),keys["radio"])
		xmlNodeSetValue( xmlCreateChild(file,"crosshair"),crosshair)
		xmlNodeSetValue( xmlCreateChild(file,"drawdistance"),drawDistance)

		xmlSaveFile(file)
		xmlUnloadFile(file)
	end
)


addEventHandler("onClientMarkerHit",root,
	function(element,dimensions)
		if element == localPlayer and dimensions then
			if createdBlips["vehicle"] then
				if source == createdBlips["vehicle"].marker then
					exports.nlrp_hud:delCustomBlip(createdBlips["vehicle"].blip_id)
					destroyElement(createdBlips["vehicle"].marker)
					exports.nlrp_hud:showInfobox("info", "Jelölés törölve!")
					createdBlips["vehicle"] = nil
				end
			end
			if createdBlips["interior"] then
				if source == createdBlips["interior"].marker then
					exports.nlrp_hud:delCustomBlip(createdBlips["interior"].blip_id)
					destroyElement(createdBlips["interior"].marker)
					exports.nlrp_hud:showInfobox("info", "Jelölés törölve!")
					createdBlips["interior"] = nil
				end
			end
		end
	end
)

function getPlayerVehicles()
	local prop = {}
	for k,v in ipairs(getElementsByType("vehicle")) do
		local accID = getElementData(localPlayer,"char.ID")
		local ownerID = getElementData(v,"vehicle.owner")
		if ownerID and getElementData(v,"vehicle.dbID") then
			if accID == ownerID then
				table.insert(prop,v)
			end
		end
	end
	return prop
end

function getPlayerInteriors()
	local prop = exports.nlrp_interiors:requestInteriors(localPlayer)
	return prop
end






--// Progress számolás interpolate genyóhoz
function getProgress(addtick, lastTick) 
    local now = getTickCount() 
    local elapsedTime = now - lastTick 
    local duration = lastTick+addtick - lastTick 
    local progress = elapsedTime / duration 
    return progress 
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

function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end

local blurShaders = {}
local myScreenSource = dxCreateScreenSource(s[1], s[2])

function createBlur(name, strenght)
	if strenght > 10 then strenght = 10 end
	blurShaders[#blurShaders + 1] = {s_name = name, shader = dxCreateShader("shaders/blur.fx"), strenght_s = strenght}
end

function removeBlur(name)
	for k, v in ipairs(blurShaders) do
		if v.s_name == name then
			table.remove(blurShaders, k)
			return
		end
	end
end

addEventHandler("onClientRender", getRootElement(),
function()
	for k, v in ipairs(blurShaders) do
		if v.shader then
			dxUpdateScreenSource(myScreenSource)
			
			dxSetShaderValue(v.shader, "ScreenSource", myScreenSource);
			dxSetShaderValue(v.shader, "BlurStrength", v.strenght_s);
			dxSetShaderValue(v.shader, "UVSize", s[1], s[2]);

			dxDrawImage(0, 0, s[1], s[2], v.shader)
		end
	end
end)


setPlayerHudComponentVisible("crosshair",false)
addEventHandler("onClientRender",root,
	function()
		if getElementData(localPlayer,"loggedIn") then
			if getControlState("aim_weapon") and not getPedAnimation(localPlayer) then
				if getPedTargetStart(localPlayer) then
					local tx,ty,tz = getPedTargetEnd(localPlayer)
					if tx and ty and tz then
		             	local x,y = getScreenFromWorldPosition(tx,ty,tz)
		             	if x and y then
		             		if getPedWeapon(localPlayer) > 0 then
		             			local size = 65
		             			if getPedWeapon(localPlayer) ~= 34 then
									if not getElementData(localPlayer,"vanishColt") then
		             					dxDrawImage(x-size/2,y-size/2,size,size,"images/crosshairs/" .. crosshair .. ".png")
									end
		             			end
		             		end
		             	end
		            end
				end
			end
		end
	end
)