
local s = {guiGetScreenSize()}


addEventHandler("onClientRender",root,
	function()
		local col = isElementWithinAColShape(localPlayer)
		if col then
			if getElementData(col,"company.Col") then
				setCameraClip(true,false)
				if not getElementData(localPlayer,"inCarshop") then
					dxDrawText("No Collision Area",s[1]/2-1,10-1,nil,nil,tocolor(0,0,0,222),1,fonts[13],"center","top")
					dxDrawText("No Collision Area",s[1]/2+1,10-1,nil,nil,tocolor(0,0,0,222),1,fonts[13],"center","top")
					dxDrawText("No Collision Area",s[1]/2-1,10+1,nil,nil,tocolor(0,0,0,222),1,fonts[13],"center","top")
					dxDrawText("No Collision Area",s[1]/2+1,10+1,nil,nil,tocolor(0,0,0,222),1,fonts[13],"center","top")
					dxDrawText("No Collision Area",s[1]/2,10,nil,nil,tocolor(222,22,22,222),1,fonts[13],"center","top")
				end
				local vehicle = getPedOccupiedVehicle(localPlayer)
				if vehicle then
					for k,v in ipairs(getElementsByType("vehicle")) do
						if v ~= vehicle then
							if getElementAlpha(v) ~= 120 then
								setElementAlpha(v,120)
							end
						end
					end
				else	
					for k,v in ipairs(getElementsByType("vehicle")) do
						if getElementAlpha(v) ~= 255 then
							setElementAlpha(v,255)
						end
					end
				end
			else
				setCameraClip(true,true)
				for k,v in ipairs(getElementsByType("vehicle")) do
					if getElementAlpha(v) ~= 255 then
						setElementAlpha(v,255)
					end
				end
			end
		else
			for k,v in ipairs(getElementsByType("vehicle")) do
				if getElementAlpha(v) ~= 255 then
					setElementAlpha(v,255)
				end
			end
		end
	end
)

function toggleVehicleCollisions(vehicle,state)
	local elements = {}
	for k,v in ipairs(getElementsByType("vehicle")) do table.insert(elements,v) end
	for k,v in ipairs(getElementsByType("ped")) do table.insert(elements,v) end
	for k,v in ipairs(getElementsByType("player")) do table.insert(elements,v) end

	for _,element in ipairs(elements) do
		setElementCollidableWith(element,vehicle,state)
	end 
end
addEvent("toggleVehicleCollisions",true)
addEventHandler("toggleVehicleCollisions",localPlayer,toggleVehicleCollisions)


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