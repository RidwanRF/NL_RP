local font = dxCreateFont('widgets/speedo2/myfont.ttf', 50, false, 'proof') or 'default-bold' -- fallback to default

function renderSpeedo()
	if getPedOccupiedVehicle ( getLocalPlayer() ) then
		--dxDrawRectangle( x - 310, y - 100, 300, 90, tocolor(0,0,0,100))
		if getElementData(getLocalPlayer(), "hud.speedo.x") then
			x = getElementData(getLocalPlayer(), "hud.speedo.x")
		end
		if getElementData(getLocalPlayer(), "hud.speedo.y") then
			y = getElementData(getLocalPlayer(), "hud.speedo.y")
		end
		local kilometersToChangeOil = 100
		if getElementData(getPedOccupiedVehicle ( getLocalPlayer() ), "lastOilChange") then
			local OilLevel = ((515000-tonumber(getElementData(getPedOccupiedVehicle ( getLocalPlayer() ), "lastOilChange")))/515000)*100
			progBar(x,y + 55,260,10,(tonumber(getElementData(getPedOccupiedVehicle ( getLocalPlayer() ), "vehicle.fuel"))/getTheFuelTankSizeOfVehicle(getElementModel(getPedOccupiedVehicle ( getLocalPlayer() ))))*100,tocolor(241, 196, 15, 100),tocolor(211, 84, 0, 100), 4)
			progBar(x,y + 70,130,10,OilLevel,tocolor(52, 152, 219, 100),tocolor(52, 73, 94, 100), 2)
			kilometersToChangeOil = 500 - math.floor((math.floor(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "lastOilChange")) or 0) / 1000)
		end
		
		local speed = ""..getElementSpeed(getPedOccupiedVehicle ( getLocalPlayer() ), "kmh")
		dxDrawText(speed,x - 1, y + 10, x + 204, y + 67, tocolor(0,0,0,255), 1, font, "right", "bottom")
		dxDrawText(speed,x + 1, y + 10, x + 206, y + 67, tocolor(0,0,0,255), 1, font, "right", "bottom")
		dxDrawText(speed,x, y + 9, x + 205, y + 66, tocolor(0,0,0,255), 1, font, "right", "bottom")
		dxDrawText(speed,x, y + 11, x + 205, y + 68, tocolor(0,0,0,255), 1, font, "right", "bottom")
		dxDrawText(speed,x, y + 10, x + 205, y + 67, tocolor(255,255,255,255), 1, font, "right", "bottom")
		
		dxDrawText("KM",x + 209, y - 90, x + 289, y + 55, tocolor(0,0,0,255), 0.5, font, "left", "bottom")
		dxDrawText("KM",x + 211, y - 90, x + 291, y + 55, tocolor(0,0,0,255), 0.5, font, "left", "bottom")
		dxDrawText("KM",x + 210, y - 91, x + 290, y + 54, tocolor(0,0,0,255), 0.5, font, "left", "bottom")
		dxDrawText("KM",x + 210, y - 89, x + 290, y + 56, tocolor(0,0,0,255), 0.5, font, "left", "bottom")
		dxDrawText("KM",x + 210, y - 90, x + 290, y + 55, tocolor(183,255,0,255), 0.5, font, "left", "bottom")
		
		local currText = "OLAJ: "..kilometersToChangeOil.."KM"
		local currColor = tocolor ( 255, 255, 255, 255 )
		if getElementHealth(getPedOccupiedVehicle(getLocalPlayer())) < 500 then
			currText = "SZERVÍZ!"
			currColor = tocolor ( 192, 57, 43, 255 )
		elseif kilometersToChangeOil and kilometersToChangeOil <= 30 then
			currText = "OLAJCSERE!"
			currColor = tocolor ( 192, 57, 43, 255 )
		elseif tonumber(getElementData(getPedOccupiedVehicle ( getLocalPlayer() ), "vehicle.fuel")) < 10 then
			currText = "TANKOLJ!"
			currColor = tocolor ( 192, 57, 43, 255 )
		end
		dxDrawText(currText,x + 129, y + 70, x + 301, y + 85, tocolor(0,0,0,255), 1, "default-bold", "center", "center")
		dxDrawText(currText,x + 131, y + 70, x + 299, y + 85, tocolor(0,0,0,255), 1, "default-bold", "center", "center")
		dxDrawText(currText,x + 130, y + 71, x + 300, y + 84, tocolor(0,0,0,255), 1, "default-bold", "center", "center")
		dxDrawText(currText,x + 130, y + 69, x + 300, y + 86, tocolor(0,0,0,255), 1, "default-bold", "center", "center")
		dxDrawText(currText,x + 130, y + 70, x + 300, y + 85, currColor, 1, "default-bold", "center", "center")
		--outputChatBox(""..OilLevel)
	end
end
addEventHandler("onClientRender", getRootElement(), renderSpeedo)

function progBar(x,y,sx,sy,percent,color,colorBG, sequence)
	for k = 0,(sequence-1) do
		--dxDrawRectangle(x+(k*sx/sequence)+(k*6)-2,y-2,sx/sequence+4,sy+4,tocolor(0,0,0,255))
		dxDrawRectangle(x+(k*sx/sequence)+(k*6)-2,y-2,sx/sequence+4,2,tocolor(0,0,0,255))
		dxDrawRectangle(x+(k*sx/sequence)+(k*6)-2,y+sy,sx/sequence+4,2,tocolor(0,0,0,255))
		dxDrawRectangle(x+(k*sx/sequence)+(k*6)-2,y-2,2,sy+4,tocolor(0,0,0,255))
		dxDrawRectangle(x+(k*sx/sequence)+(k*6)+sx/sequence,y-2,2,sy+4,tocolor(0,0,0,255))
		dxDrawRectangle(x+(k*sx/sequence)+(k*6),y,sx/sequence,sy,colorBG)
		percentCalculator = (((100/sequence)*(k+1))-(100/sequence))
		percentCalculator2 = (percentCalculator+(100/sequence))
		if percent >= percentCalculator and percentCalculator2 >= percent then
			--outputChatBox(((((percent-((k+1)*(100/sequence)))*sequence)*-1)/100).."%")
			dxDrawRectangle(x+(k*sx/sequence)+(k*6),y,(sx/sequence)*(1-((((percent-((k+1)*(100/sequence)))*sequence)*-1)/100)),sy,color)
		elseif percent >= percentCalculator then
			dxDrawRectangle(x+(k*sx/sequence)+(k*6),y,(sx/sequence),sy,color)
		end
	end
end

function getElementSpeed(element,unit)
    if (unit == nil) then unit = 0 end
    if (isElement(element)) then
        local x,y,z = getElementVelocity(element)
        if (unit=="mph" or unit==1 or unit =='1') then
            return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100)
        else
            return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100 * 1.609344)
        end
    else
        return false
    end
end