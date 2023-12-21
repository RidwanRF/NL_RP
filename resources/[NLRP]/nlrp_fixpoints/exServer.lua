

addEvent("points->FixVehicle", true)
addEventHandler("points->FixVehicle", root,
	function(player,vehicle,price)
		fixVehicle(vehicle)
		setElementData(player,"char.Money",getElementData(player,"char.Money")-price)

		exports.nlrp_groups:setGroupMoney(3,price)
	end
)


local markers = {
	{1723.3383789063, -1778.4544677734, 13.501170158386},
	--{1789.5438232422, -1748.8385009766, 13.556562423706},
	--{1803.3308105469, -1748.896484375, 13.556562423706},
}

function checkFixPoints()
	deleteFixpoints()

	local factionMembers = 0
	for k,v in ipairs(getElementsByType("player")) do
		if exports.nlrp_groups:isPlayerInGroup(v,3) then
			if getElementData(v,"groupDuty") then
				factionMembers = factionMembers + 1
			end
		end
	end
	if factionMembers == 0 then
		createFixpoints()
	end
end

function createFixpoints()
	for k,v in ipairs(markers) do
		local marker = createMarker(v[1],v[2],v[3],"cylinder",2,215,255,0,0)
		setElementData(marker,"points->FixMarker",true)
	end
end

function deleteFixpoints()
	for k,v in ipairs(getElementsByType("marker")) do
		if getElementData(v,"points->FixMarker") then
			destroyElement(v)
		end
	end
end

addEventHandler("onResourceStart",resourceRoot,
	function()
		checkFixPoints()
	end
)
