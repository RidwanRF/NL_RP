--local connection = exports["mx_connection"]:getConnection()
local ObjectPos = {}

function onTrafiHit(thePlayer, Penz)
	setElementData(thePlayer,"char.Money",getElementData(thePlayer, "char.Money") - math.floor(tonumber(Penz)))
			local playerGroups = exports.nlrp_groups:getPlayerGroups(sourcePlayer)
				exports.nlrp_groups:setGroupMoney(tonumber(1),Penz)
				exports.nlrp_groups:setGroupMoney(tonumber(4),Penz)
end
addEvent("onTrafiHit", true)
addEventHandler("onTrafiHit", getRootElement(), onTrafiHit)

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

function syncSpeedCameras(x, y, z, rot,limit)
	
	local object = createObject(7426, x, y, z-1.65)
	
	setElementRotation(object, 0, 0, rot-90)
	object:setData("speedCamera", true)
	--object:setData("Object:Name", tostring("#87D37C"..limit.." #ffffffkm/h"))
end
addEvent("syncSpeedCameras", true)
addEventHandler("syncSpeedCameras", resourceRoot, syncSpeedCameras)


function createAmount (Player, element,amount, limit)
	outputChatBox("#b7ff00[NextLevel - Traffipax] #ffffffGyorsabban hajtottál a megengedett sebességnél: #FFFFFF( " .. limit .." )#ffffff \nBirság: #b7ff00Ft".. tonumber(amount), element,255, 255, 255, true)
end
addEvent("createAmount",true)
addEventHandler("createAmount",root,createAmount)

addCommandHandler("deltraffipax",function(p,c)
	if exports.nlrp_groups:isPlayerInGroup(p,1) then
			for k,v in ipairs(getElementsByType("object")) do
			if getElementData(v,"speedCamera") then
				x,y,z = getElementPosition(p)
				x1,y2,z2 = getElementPosition(v)
				if getDistanceBetweenPoints3D(x,y,z,x1,y2,z2) <= 1.5 then
					destroyElement(v)
				end
			end
		end
	end
end)