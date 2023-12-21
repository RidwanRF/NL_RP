local monitorSize = {guiGetScreenSize()}

local panelDraw = false

local font2 = dxCreateFont("files/myriadproregular.ttf",11) --<[ Font ]>--

local font3 = dxCreateFont("files/Roboto.ttf",11) --<[ Font ]>--

local font4 = dxCreateFont("files/Roboto.ttf",13) --<[ Font ]>--

local font = dxCreateFont("files/Roboto.ttf", 14)

local amount = 15000

local sx, sy = guiGetScreenSize()


     


local colshapeID



addEventHandler("onClientColShapeHit", getRootElement(),

function(player)

	if player ~= getLocalPlayer() then return end

	if (source) then

		local veh = getPedOccupiedVehicle(localPlayer)

		if (getElementData(source, "object->Colshape") or 0 > 0) and isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0  then

			panelDraw = true

			colshapeID = getElementData(source, "object->Colshape")

		--	setElementFrozen(getPedOccupiedVehicle(localPlayer), true)

			bindKey("enter", "down", triggerClientToServer)

			bindKey("backspace", "down", destroyborders)

			removeEventHandler("onClientClick", root, bordersClick)

			addEventHandler("onClientClick", root, bordersClick)

			setElementData(localPlayer, "borders", true)



		end

	end

end

)



function bordersClick(button, state, x, y)

	if button == "left" and state == "down" then

		if dobozbaVan(sx/2-350/2+5,sy/2+10, 340, 40, x, y) then

			triggerClientToServer()

		elseif dobozbaVan(sx/2-350/2+5,sy/2+55, 340, 40, x, y) then

			destroyborders()

		end

	end

end



addEventHandler("onClientColShapeLeave", getRootElement(),

function(player)

	if player ~= getLocalPlayer() then return end

	if (getElementData(source, "object->Colshape") or 0 > 0) and  isPedInVehicle(localPlayer) then

		panelDraw = false

		--setElementFrozen(getPedOccupiedVehicle(localPlayer), false)

		removeEventHandler("onClientClick", root, bordersClick)

		setTimer(function ()

			setElementData(localPlayer, "borders", false)

		end, 200, 1 )

	end

end

)



function triggerClientToServer()

	if getElementData(localPlayer, "char.Money") >= amount then

		triggerServerEvent("moveObject", resourceRoot, localPlayer, colshapeID, amount)

	end

	panelDraw = false

	unbindKey("enter", "down", triggerClientToServer)

	unbindKey("backspace", "down", destroyborders)

--	setElementFrozen(getPedOccupiedVehicle(localPlayer), false)

	removeEventHandler("onClientClick", root, bordersClick)

		setTimer(function ()

			setElementData(localPlayer, "borders", false)

		end, 200, 1 )

end

function destroyborders()

	panelDraw = false

	colshapeID = 0

	--setElementFrozen(getPedOccupiedVehicle(localPlayer), false)

	removeEventHandler("onClientClick", root, bordersClick)

	unbindKey("enter", "down", triggerClientToServer)

	unbindKey("backspace", "down", destroyborders)

		setTimer(function ()

			setElementData(localPlayer, "borders", false)

		end, 200, 1 )

end



addEventHandler("onClientRender", root, function ()

	if panelDraw and isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then

		dxDrawRectangle(sx/2-350/2,sy/2-100, 350, 200, tocolor(0,0,0,180))

		dxDrawRectangle(sx/2-350/2,sy/2-100, 350, 25, tocolor(0,0,0,180))

		dxDrawText("#B7FF00 NLRP - Határ #ffffff", sx/2-350/2+10,sy/2-100, 0, sy/2-100+25, tocolor(255,255,255,255), 0.8, font, "left", "center", false, false, false, true)

		dxDrawText("#ffffffSzeretnél átlépni a határon?\n #ffffffA határátlépés díja: #B7FF0015.000 Ft",sx/2-350/2,sy/2-50, sx/2-350/2+350, 0, tocolor(255,255,255,255), 0.8, font, "center", "top", false, false, false, true)



		if isInSlot(sx/2-350/2+5,sy/2+10, 340, 40) then

    	dxDrawRectangle(sx/2-350/2+5,sy/2+10, 340, 40, tocolor(124, 197, 118, 255))

    else

    	dxDrawRectangle(sx/2-350/2+5,sy/2+10, 340, 40, tocolor(124, 197, 118, 200))

    end



  	dxDrawText("Igen", sx/2-350/2+5,sy/2+10, sx/2-350/2+5+340,sy/2+10+40, tocolor(0,0,0,230), 0.8, font, "center", "center", false, false, false, true)



  	if isInSlot(sx/2-350/2+5,sy/2+55, 340, 40) then

    	dxDrawRectangle(sx/2-350/2+5,sy/2+55, 340, 40, tocolor(217, 83, 79, 255))

    else

    	dxDrawRectangle(sx/2-350/2+5,sy/2+55, 340, 40, tocolor(217, 83, 79, 200))

    end



    dxDrawText("Nem", sx/2-350/2+5,sy/2+55,sx/2-350/2+5+340,sy/2+55+40, tocolor(0,0,0,230), 0.8, font, "center", "center", false, false, false, true)

	end

end)



function dobozbaVan(dX, dY, dSZ, dM, eX, eY)

	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then

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

		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then

			return true

		else

			return false

		end

	end

end

