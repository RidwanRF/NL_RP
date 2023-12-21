
local s = {guiGetScreenSize()}

local shop = false --// Vagy false vagy a típus id-je (Vagy 0 ha betöltés alatt van!)
local vehicle = false
local selected = 1
local companyLevel = false
local companyMoney = false

--setCameraTarget(localPlayer)
--setElementFrozen(localPlayer,false)

local renting = false
local rents = {1,3,5,10}

local size = {410,590}
local pos = {s[1]-size[1]-20,s[2]/2-size[2]/2}

local psize = {400,250}
local ppos = {s[1]/2-psize[1]/2,s[2]/2-psize[2]/2}

addEventHandler("onClientRender",root,
	function()
		if shop then
			if shop > 0 then
				local row = vehicleShops[shop].vehicles[selected]

				local rx,ry,rz = getElementRotation(vehicle)
				setElementRotation(vehicle,rx,ry,rz+0.25)

				dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(40,40,40,200))

				dxDrawRectangle(pos[1]+10,pos[2]+10,size[1]-20,100,tocolor(40,40,40,200))
				dxDrawRectangle(pos[1]+10,pos[2]+10,size[1]-20,50,tocolor(40,40,40,200))
				dxDrawText("Vállalkozói - Jármű kereskedés",pos[1]+size[1]/2,pos[2]+10+50/2,nil,nil,tocolor(183,255,0,222),1,fonts[14],"center","center",false,false,false,true)
				dxDrawText("Egyenleged: #b7ff00" .. format(companyMoney) .. " Ft",pos[1]+20,pos[2]+10+50+50/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"left","center",false,false,false,true)
			
				dxDrawRectangle(pos[1]+10,pos[2]+120,size[1]-20,200,tocolor(40,40,40,200))
				dxDrawRectangle(pos[1]+10,pos[2]+120,size[1]-20,40,tocolor(40,40,40,200))

				dxDrawText(row.name,pos[1]+size[1]/2,pos[2]+120+40/2,nil,nil,tocolor(222,222,222,222),1,fonts[15],"center","center",false,false,false,true)
				dxDrawImage(pos[1]+10+2.5,pos[2]+120+2.5,35,35,"images/arrow.png",180)
				dxDrawImage(pos[1]+size[1]-10-40,pos[2]+120+2.5,35,35,"images/arrow.png",0)

				dxDrawText("Szükséges szint: #b7ff00" .. row.minLevel,pos[1]+20,pos[2]+170,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","top",false,false,false,true)
				dxDrawText("Saját szinted: #b7ff00" .. companyLevel,pos[1]+20,pos[2]+205,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","top",false,false,false,true)
				dxDrawText("Típus: #b7ff00" .. row.type,pos[1]+20,pos[2]+240,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","top",false,false,false,true)
				dxDrawText("Tulajdonodban: #b7ff000db",pos[1]+20,pos[2]+275,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","top",false,false,false,true)
			
				if isCursorOnBox(pos[1]+size[1]-20-80,pos[2]+273,80,25) then
					dxDrawRectangle(pos[1]+size[1]-20-80,pos[2]+273,80,25,tocolor(241,0,0,225))
				else
					dxDrawRectangle(pos[1]+size[1]-20-80,pos[2]+273,80,25,tocolor(241,0,0,165))
				end
				dxDrawBorder(pos[1]+size[1]-20-80,pos[2]+273,80,25,1.5,tocolor(0,0,0,200))
				dxDrawText("Eladás",pos[1]+size[1]-20-80/2,pos[2]+273+25/2,nil,nil,tocolor(0,0,0,255),1,fonts[11],"center","center")
			
				dxDrawRectangle(pos[1]+10,pos[2]+330,size[1]-20,250,tocolor(40,40,40,200))
				dxDrawRectangle(pos[1]+10,pos[2]+330,size[1]-20,40,tocolor(40,40,40,200))

				dxDrawText("Jármű testreszabása",pos[1]+size[1]/2,pos[2]+330+40/2,nil,nil,tocolor(183,255,0,222),1,fonts[15],"center","center",false,false,false,true)
			
				for k,v in ipairs(vehicleShops[shop].avaibleColors) do
					dxDrawRectangle(pos[1]+30+(k-1)*59,pos[2]+380,54,54,tocolor(v[1],v[2],v[3],175))
					if isCursorOnBox(pos[1]+30+(k-1)*59,pos[2]+380,54,54) then
						dxDrawBorder(pos[1]+30+(k-1)*59,pos[2]+380,54,54,1.5,tocolor(v[1],v[2],v[3],225))
					end
				end

				dxDrawText("Ára#dedede: " .. format(row.price) .. " Ft",pos[1]+size[1]/2,pos[2]+450,nil,nil,tocolor(183,255,0,222),1,fonts[13],"center","top",false,false,false,true)
			
				if isCursorOnBox(pos[1]+60,pos[2]+size[2]-15-45-5-45,size[1]-120,45) then
					dxDrawRectangle(pos[1]+60,pos[2]+size[2]-15-45-5-45,size[1]-120,45,tocolor(183,255,0,225))
				else
					dxDrawRectangle(pos[1]+60,pos[2]+size[2]-15-45-5-45,size[1]-120,45,tocolor(183,255,0,175))
				end
				dxDrawText("Megvásárlás",pos[1]+size[1]/2,pos[2]+size[2]-15-45-5-45/2,nil,nil,tocolor(0,0,0,225),1,fonts[15],"center","center")

				if isCursorOnBox(pos[1]+60,pos[2]+size[2]-15-45,size[1]-120,45) then
					dxDrawRectangle(pos[1]+60,pos[2]+size[2]-15-45,size[1]-120,45,tocolor(223,139,6,225))
				else
					dxDrawRectangle(pos[1]+60,pos[2]+size[2]-15-45,size[1]-120,45,tocolor(223,139,6,175))
				end
				dxDrawText("Bérlés",pos[1]+size[1]/2,pos[2]+size[2]-15-45/2,nil,nil,tocolor(0,0,0,225),1,fonts[15],"center","center")
			
				if renting then
					dxDrawRectangle(ppos[1],ppos[2],psize[1],psize[2],tocolor(40,40,40,200))
					dxDrawRectangle(ppos[1],ppos[2],psize[1],50,tocolor(40,40,40,220))

					dxDrawText("Jármű bérlés",ppos[1]+psize[1]/2,ppos[2]+50/2,nil,nil,tocolor(183,255,0,222),1,fonts[13],"center","center")
					dxDrawText("X",ppos[1]+psize[1]-5,ppos[2]+1,nil,nil,tocolor(241,0,0,222),1,fonts[11],"right","top")

					for k,v in ipairs(rents) do
						dxDrawRectangle(ppos[1],ppos[2]+70+(k-1)*(35),psize[1],30,tocolor(40,40,40,200))
						if isCursorOnBox(ppos[1],ppos[2]+70+(k-1)*(35),psize[1],30) then
							dxDrawRectangle(ppos[1],ppos[2]+70+(k-1)*(35),psize[1],30,tocolor(200,200,200,10))
						end

						dxDrawText(v .. " fuvar - #dededexy #b7ff00Ft",ppos[1]+psize[1]/2,ppos[2]+70+(k-1)*(35)+30/2,nil,nil,tocolor(183,255,0,222),1,fonts[12],"center","center",false,false,false,true)
					end

					dxDrawRectangle(ppos[1],ppos[2]+psize[2]-35,psize[1],30,tocolor(40,40,40,200))

					dxDrawBorder(ppos[1]+psize[1]-40-5,ppos[2]+psize[2]-35+5,40,20,2,tocolor(183,255,0,200))
					dxDrawText("OK",ppos[1]+psize[1]-40-5+40/2,ppos[2]+psize[2]-35+30/2,nil,nil,tocolor(183,255,0,200),1,fonts[12],"center","center")
				end
			end
		end
	end
)

function openVehicleShop(id)
	local row = vehicleShops[id]
	if row then
		selected = 1
		shop = id
		setElementFrozen(localPlayer,true)
		setCameraMatrix(row.camera[1],row.camera[2],row.camera[3],row.pos[1],row.pos[2],row.pos[3])
		showChat(false)
		exports.nlrp_hud:toggleHUD(false)
		vehicle = createVehicle(row.vehicles[selected].id,row.pos[1],row.pos[2],row.pos[3])
		setVehicleColor(vehicle,255,255,255)
	end
end

addEventHandler("onClientKey",root,
	function(k,p)
		if not shop then return end
		if k == "mouse1" and p then
			if shop > 0 then
				if isCursorOnBox(pos[1]+10+2.5,pos[2]+120+2.5,35,35) then
					changeVehicle("left")
				elseif isCursorOnBox(pos[1]+size[1]-10-40,pos[2]+120+2.5,35,35) then
					changeVehicle("right")
				elseif isCursorOnBox(pos[1]+60,pos[2]+size[2]-15-45-5-45,size[1]-120,45) then --// Vásárlás
					if companyMoney >= vehicleShops[shop].vehicles[selected].price then
						if companyLevel >= vehicleShops[shop].vehicles[selected].minLevel then
							local r,g,b = getVehicleColor(vehicle,true)
							triggerServerEvent("tryToBuyVehicle",resourceRoot,localPlayer,shop,selected,r,g,b)
						else
							exports.nlrp_hud:showInfobox("error","Vállalkozásod szintje túl alacsony!")
						end
					else
						exports.nlrp_hud:showInfobox("error","Nincs elegendő pénze a vállalkozásodnak!")
					end
				elseif isCursorOnBox(pos[1]+60,pos[2]+size[2]-15-45,size[1]-120,45) then
					if not renting then
						renting = true
						dxCreateEdit("customRent","","Írd be az egyéni fuvarok számát..",ppos[1]+2,ppos[2]+psize[2]-35,psize[1]-55,30,12)
					end
				end

				for k,v in ipairs(vehicleShops[shop].avaibleColors) do
					if isCursorOnBox(pos[1]+30+(k-1)*59,pos[2]+380,54,54) then
						setVehicleColor(vehicle,v[1],v[2],v[3])
					end
				end
 			end
		end
		if k == "backspace" and p then
			if shop > 0 and not renting then
				setCameraTarget(localPlayer)
				setElementFrozen(localPlayer,false)
				showChat(true)
				exports.nlrp_hud:toggleHUD(true)
				if isElement(vehicle) then destroyElement(vehicle) end
				shop = false
			elseif shop > 0 and renting then
				if not dxGetActiveEdit() then
					renting = false
					dxDestroyEdit("customRent")
				end
			end
		elseif k == "arrow_r" and p and shop > 0 then
			changeVehicle("right")
		elseif k == "arrow_l" and p and shop > 0 then
			changeVehicle("left")
		end
	end
)

function changeVehicle(type)
	if renting then return end
	if type == "right" then
		if selected < #vehicleShops[shop].vehicles then
			selected = selected + 1
		end
	elseif type == "left" then
		if selected > 1 then
			selected = selected - 1
		end
	end
	setElementModel(vehicle,vehicleShops[shop].vehicles[selected].id)
end

addEvent("successVehicleBought",true)
addEventHandler("successVehicleBought",localPlayer,
	function()
		if shop > 0 then
			setCameraTarget(localPlayer)
			setElementFrozen(localPlayer,false)
			showChat(true)
			exports.nlrp_hud:toggleHUD(true)
			if isElement(vehicle) then destroyElement(vehicle) end
			shop = false
		end
	end
)











addEventHandler("onClientResourceStart",resourceRoot,
	function()
		--[[
		for _,row in ipairs(shopPeds) do
			local ped = createPed(row.skin,row.pos[1],row.pos[2],row.pos[3],row.rot)
			setElementInterior(ped,row.int)
			setElementDimension(ped,row.dim)
			setElementFrozen(ped,true)

			setElementData(ped,"nlrp->company->shopPed",true)

			setElementData(ped,"ped.name",row.name)
			setElementData(ped,"pedNameType","Járműkereskedés")
		end ]]--

		for _,row in ipairs(startJobPeds) do
			local ped = createPed(row.skin,row.pos[1],row.pos[2],row.pos[3],row.rot)
			setElementInterior(ped,row.int)
			setElementDimension(ped,row.dim)
			setElementFrozen(ped,true)

			setElementData(ped,"nlrp->company->jobPed",true)

			setElementData(ped,"ped.name",row.name)
			setElementData(ped,"pedNameType","Jármű lehívó")
		end
		local marker = createMarker(destroyVehicleMarker[1],destroyVehicleMarker[2],destroyVehicleMarker[3]-1,"cylinder",2.8,228,58,58,50)
		setElementData(marker,"vehicleDropdown",true)
	end
)

addEventHandler("onClientClick",root,
	function(button,state,x,y,wx,wy,wz,element)
		if getElementData(localPlayer,"loggedIn") then
			if button == "left" and state == "down" then
				if element then
					if getElementData(element,"nlrp->company->shopPed") then
						local p = Vector3(getElementPosition(element))
						local p2 = Vector3(getElementPosition(localPlayer))
						if getDistanceBetweenPoints3D(p,p2) <= maxPedClick then
							if not shop then
								shop = 0
								triggerServerEvent("getPlayerCompanyType",resourceRoot,localPlayer)
							end
						end
					end
				end
			end
		end
	end
)

addEvent("returnCompanyTypeForShop",true)
addEventHandler("returnCompanyTypeForShop",localPlayer,
	function(id,level,money)
		if id then
			openVehicleShop(id)
			companyLevel = level
			companyMoney = money
		else
			shop = false
		end
	end
)