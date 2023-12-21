local screenSize = {guiGetScreenSize()}
screenSize.x, screenSize.y = screenSize[1], screenSize[2]

local bgColor = tocolor(30, 30, 30)
local slotColor = tocolor(40, 40, 40, 200)

local hoverColor = tocolor(215, 255, 0, 180)
local cancelColor = tocolor(243, 85, 85, 180)

local fasz = dxCreateTexture("files/fasz.png","dxt5");

function isCursorHover(startX, startY, sizeX, sizeY)
	if isCursorShowing() then
		local cursorPosition = {getCursorPosition()}
		cursorPosition.x, cursorPosition.y = cursorPosition[1] * screenSize.x, cursorPosition[2] * screenSize.y

		if cursorPosition.x >= startX and cursorPosition.x <= startX + sizeX and cursorPosition.y >= startY and cursorPosition.y <= startY + sizeY then
			return true
		else
			return false
		end
	else
		return false
	end
end

local roboto = dxCreateFont("files/Roboto.ttf", 9)

local panelStates = false

addEventHandler("onClientMarkerHit", root, function(player)
	if player == localPlayer and getElementData(source, "points->FixMarker") then
		vehicle = getPedOccupiedVehicle(localPlayer)

		if vehicle and getPedOccupiedVehicleSeat(localPlayer) == 0 then
			if getElementHealth(vehicle) >= 990 then
				outputChatBox("#d7ff00[Javító] #ffffffA járműved nem sérült.", 0, 0, 0, true)
			else
				panelStates = true
				fixMoney = math.floor((exports.nle_carshop:getVehicleShopPirce(getElementModel(vehicle)) / getElementHealth(vehicle) * 5))
			end
		end
	end
end)

addEventHandler("onClientMarkerLeave", root, function(player)
	if player == localPlayer and getElementData(source, "points->FixMarker") then
		if panelStates then
			panelStates = false
		end
	end
end)


local rootTick = getTickCount();

addEventHandler("onClientRender", root, function()
	local anim = interpolateBetween(0,0,0,0.5,0,0,(getTickCount()-rootTick)/2000,"CosineCurve");
	for k,v in ipairs(getElementsByType("marker")) do
		if getElementData(v,"points->FixMarker") then 
			local x,y,z = getElementPosition(v)
			z = z + 0.5 + anim
			local size = 1
			dxDrawMaterialLine3D(x,y,z-size/2,x,y,z+size/2,fasz,size)
		end
	end

	if panelStates then
		dxDrawRectangle(screenSize.x/2 - 200, screenSize.y/2 - 50, 400, 100, bgColor)
		dxDrawRectangle(screenSize.x/2 - 200, screenSize.y/2 + 50, 400, 2, hoverColor)

		dxDrawText("Szeretnéd megjavítani a járművedet?\nJavítás ára #d7ff00Ft" .. format(fixMoney), screenSize.x/2 - 200, screenSize.y/2 - 45, screenSize.x/2 + 200, 0, tocolor(255, 255, 255), 1, roboto, "center", "top", false, false, false, true)
	
		dxDrawRectangle(screenSize.x/2 - 170, screenSize.y/2, 150, 30, slotColor)
		dxDrawText("Javítás", screenSize.x/2 - 170, screenSize.y/2, screenSize.x/2 - 20, screenSize.y/2 + 30, tocolor(255, 255, 255), 1, roboto, "center", "center")
	
		if isCursorHover(screenSize.x/2 - 170, screenSize.y/2, 150, 30) then
			dxDrawRectangle(screenSize.x/2 - 170, screenSize.y/2, 150, 30, hoverColor)
			dxDrawText("Javítás", screenSize.x/2 - 170, screenSize.y/2, screenSize.x/2 - 20, screenSize.y/2 + 30, tocolor(0, 0, 0), 1, roboto, "center", "center")
		end

		dxDrawRectangle(screenSize.x/2 + 20, screenSize.y/2, 150, 30, slotColor)
		dxDrawText("Kilépés", screenSize.x/2 + 20, screenSize.y/2, screenSize.x/2 + 170, screenSize.y/2 + 30, tocolor(255, 255, 255), 1, roboto, "center", "center")
	
		if isCursorHover(screenSize.x/2 + 20, screenSize.y/2, 150, 30) then
			dxDrawRectangle(screenSize.x/2 + 20, screenSize.y/2, 150, 30, cancelColor)
			dxDrawText("Kilépés", screenSize.x/2 + 20, screenSize.y/2, screenSize.x/2 + 170, screenSize.y/2 + 30, tocolor(0, 0, 0), 1, roboto, "center", "center")
		end
	elseif repairState then
		if getTickCount() >= startTick then
			local delayTime = getTickCount() - startTick
			if delayTime < 48000 then
				progTime = delayTime / 48000
				panelX = interpolateBetween(0, 0, 0, 400, 0, 0, progTime, "Linear")

				dxDrawRectangle(screenSize.x/2 - 400/2 - 2, screenSize.y/2 - 20, 404, 40, bgColor)
				dxDrawRectangle(screenSize.x/2 - 400/2, screenSize.y/2 - 18, 400, 36, slotColor)
				dxDrawRectangle(screenSize.x/2 - 400/2, screenSize.y/2 - 18, panelX, 36, hoverColor)

				dxDrawText("Szerelés folyamatban...", 0, 0, screenSize.x, screenSize.y, tocolor(0, 0, 0), 1, roboto, "center", "center")
			else
				repairState = false
				stopSound(sound)

				--// Itt kliens oldalon volt a pénz állítás ismét ._.
				--setElementData(localPlayer, "char.Money", getElementData(localPlayer, "char.Money") - fixMoney)
				outputChatBox("#d7ff00[Javító] #ffffffSikeresen megjavíttattad a járműved #d7ff00Ft".. format(fixMoney) .."#ffffff-ért.", 0, 0, 0, true)

				triggerServerEvent("points->FixVehicle",resourceRoot,localPlayer,vehicle,fixMoney)

				toggleAllControls(true)
			end
		end
	end
end)

addEventHandler("onClientClick", root, function(key, state)
	if key == "left" and state == "down" and panelStates then
		if isCursorHover(screenSize.x/2 - 170, screenSize.y/2, 150, 30) then
			if getElementData(localPlayer, "char.Money") >= fixMoney then
				panelStates = false

				repairState = true
				startTick = getTickCount()

				sound = playSound("files/repair.mp3", true)

				toggleAllControls(false)
			else
				outputChatBox("#d7ff00[Javító] #ffffffNincs elég pénzed a jármű javításához. #d7ff00(Ft"..fixMoney..")", 0, 0, 0, true)
			end
		elseif isCursorHover(screenSize.x/2 + 20, screenSize.y/2, 150, 30) then
			panelStates = false
		end
	end
end)

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 