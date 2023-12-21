
local font = dxCreateFont(":nlrp_dashboard/fonts/nextlevelfont.ttf",10)

local showFuels = false
local fueling = false
local tick = getTickCount()
local fuelingTick = getTickCount()
local sound = false

addEventHandler("onClientRender",root,
	function()
		local colShape = isElementWithinAColShape(localPlayer)
		if colShape then
			local id = getElementData(colShape,"nlrp->fuelcol->id")
			if id then
				local col = findFuelColByDBID(id)
				if col then
					local x,y,z = getElementPosition(colShape)
					local sx,sy = getScreenFromWorldPosition(x,y,z)
					if sx and sy then
						local text = "Nincs a közeledben megtankolható jármű!"
						local vehicle = getNearestVehicle(localPlayer,colRadius*1.5)
						if vehicle then
							text = "Tankoláshoz nyomd meg az [E] billentyűt!"
						end
						if fueling then
							text = "Tankolás befejezéséhez nyomd meg az [E] billentyűt!\nVégösszeg: #b7ff00" .. format(fueling*fuelPrice) .. "Ft"
						end
						dxDrawText(text,sx,sy+20,nil,nil,tocolor(255,255,255,255),1,font,"center","center",false,false,false,true)

						if vehicle then
							if getKeyState("e") and not isChatBoxInputActive() then
								if tick+1000 < getTickCount() then
									if fueling then
										exports.nlrp_chat:sendLocalMeAction(localPlayer,"befejezi a tankolást.")
										tick = getTickCount()
										triggerServerEvent("fuelAnim",resourceRoot,localPlayer,false)
										if isElement(sound) then 
											stopSound(sound)
											sound = false
										end
										triggerServerEvent("changeFuelUse",resourceRoot,id,false)
										triggerServerEvent("payFueling",resourceRoot,localPlayer,vehicle,fueling)
										fueling = false
									else
										local fuel = getElementData(vehicle,"vehicle.fuel")
										local maxFuel = exports.nlrp_hud:getTheFuelTankSizeOfVehicle(getElementModel(vehicle))
										if fuel < maxFuel then
											if not getElementData(col,"nlrp->fuelcol->inUse") then
												if getElementData(localPlayer,"char.Money") >= fuelPrice then
													if not getVehicleEngineState(vehicle) then
														fueling = 0
														exports.nlrp_chat:sendLocalMeAction(localPlayer,"elkezdi megtankolni a járművét.")
														tick = getTickCount()
														local px,py,_ = getElementPosition(localPlayer)
														rotation = findRotation(x,y,px,py)
														triggerServerEvent("fuelAnim",resourceRoot,localPlayer,true,rotation)
														if not isElement(sound) then sound = playSound("sounds/fill.mp3",true) end
														triggerServerEvent("changeFuelUse",resourceRoot,id,true)

														fuelingTick = getTickCount()
													else
														exports.nlrp_hud:showInfobox("error","Járó motorral nem tankolhatsz!")
														tick = getTickCount()
													end
												else
													exports.nlrp_hud:showInfobox("error","Nincs elegendő pénzed a tankolás megkezdéséhez!")
													tick = getTickCount()
												end
											else
												exports.nlrp_hud:showInfobox("error","A kútoszlop már használatban van!")
												tick = getTickCount()
											end
										else
											exports.nlrp_hud:showInfobox("error","A jármű tankja tele.")
											tick = getTickCount()
										end
									end
								end
							end
						end
						if fueling then
							if fuelingTick+1000 < getTickCount() then
								local newPrice = (fueling+1)*fuelPrice
								if getElementData(localPlayer,"char.Money") >= newPrice then
									local fuel = getElementData(vehicle,"vehicle.fuel")
									local maxFuel = exports.nlrp_hud:getTheFuelTankSizeOfVehicle(getElementModel(vehicle))
									if fuel+fueling >= maxFuel then
										triggerServerEvent("payFueling",resourceRoot,localPlayer,vehicle,fueling)
										fueling = false
										exports.nlrp_chat:sendLocalMeAction(localPlayer,"befejezi a tankolást.")
										tick = getTickCount()
										triggerServerEvent("fuelAnim",resourceRoot,localPlayer,false)
										if isElement(sound) then 
											stopSound(sound)
											sound = false
										end
										triggerServerEvent("changeFuelUse",resourceRoot,id,false)

										exports.nlrp_hud:showInfobox("info","A jármű tankja megtelt.")
									else
										if not getVehicleEngineState(vehicle) then
											fueling = fueling + 1
											fuelingTick = getTickCount()
										else
											triggerServerEvent("payFueling",resourceRoot,localPlayer,vehicle,fueling)
											fueling = false
											exports.nlrp_chat:sendLocalMeAction(localPlayer,"befejezi a tankolást.")
											tick = getTickCount()
											triggerServerEvent("fuelAnim",resourceRoot,localPlayer,false)
											if isElement(sound) then 
												stopSound(sound)
												sound = false
											end
											triggerServerEvent("changeFuelUse",resourceRoot,id,false)

											exports.nlrp_hud:showInfobox("info","Járó motorral nem tankolhatsz!")
										end
									end
								else
									triggerServerEvent("payFueling",resourceRoot,localPlayer,vehicle,fueling)
									fueling = false
									exports.nlrp_chat:sendLocalMeAction(localPlayer,"befejezi a tankolást.")
									tick = getTickCount()
									triggerServerEvent("fuelAnim",resourceRoot,localPlayer,false)
									if isElement(sound) then 
										stopSound(sound)
										sound = false
									end
									triggerServerEvent("changeFuelUse",resourceRoot,id,false)
								end
							end
						end
					end
				end
			end
		end
		--// Nearby fuel parancs
		if showFuels then
			for k,obj in ipairs(getElementsByType("object")) do
				if isElementStreamedIn(obj) then
					if getElementData(obj,"nlrp->fuelpoint") then
						local x,y,z = getElementPosition(obj)
						local x2,y2,z2 = getElementPosition(localPlayer)
						local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
						if distance < 20 then
							local sx,sy = getScreenFromWorldPosition(x,y,z)
							if sx and sy then
								local id = getElementData(obj,"nlrp->fuelpoint->id") or 0
								local admin = getElementData(obj,"nlrp->fuelpoint->admin") or "Ismeretlen"
								dxDrawText("ID: #" .. id,sx,sy,nil,nil,tocolor(255,255,255,255),1,font,"center","center",false,false,false,false)
								dxDrawText("Lerakta: #b7ff00" .. admin,sx,sy+20,nil,nil,tocolor(255,255,255,255),1,font,"center","center",false,false,false,true)
							end
						end
					end
				end
			end
		end
	end
)

addEvent("toggleFuelShow",true)
addEventHandler("toggleFuelShow",localPlayer,
	function()
		showFuels = not showFuels
	end
)

function getNearestVehicle(player,distance)
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local vint,vdim = getElementInterior(v),getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

function isElementWithinAColShape(element)
    local element = element or localPlayer
    if element or isElement(element)then
    	for _,colshape in ipairs(getElementsByType("colshape"))do
			if isElementWithinColShape(element,colshape) then
	    		return colshape
	 		end
    	end
    end
    return false
end

function findFuelColByDBID(id)
	local found = false
	if id then
		for k,obj in ipairs(getElementsByType("colshape")) do
			if getElementData(obj,"nlrp->fuelcol->id") then
				if tonumber(getElementData(obj,"nlrp->fuelcol->id")) == tonumber(id) then
					found = obj
				end
			end
		end
	end
	return found
end