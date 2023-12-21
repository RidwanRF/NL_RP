
local connection = exports.nlrp_database:getConnection()

addEventHandler("onResourceStart",resourceRoot,
	function()
		local Query = dbPoll(dbQuery(connection,"SELECT * FROM fuelpoints"),-1)
		if (Query) then
			for k, v in ipairs(Query) do
				loadFuelPoint(v["id"])
			end
		end	
	end
)

function loadFuelPoint(dbid)
	local Query = dbPoll(dbQuery(connection,"SELECT * FROM fuelpoints WHERE id=?",dbid),-1)
	if (Query) then
		for k,row in ipairs(Query) do
			local obj = createObject(3465,tonumber(row.x),tonumber(row.y),tonumber(row.z)+0.09,0,0,tonumber(row.rot)-90)
			setElementData(obj,"nlrp->fuelpoint",true)
			setElementData(obj,"nlrp->fuelpoint->id",dbid)
			setElementData(obj,"nlrp->fuelpoint->admin",row.admin)

			local col = createColSphere(tonumber(row.x),tonumber(row.y),tonumber(row.z),colRadius)
			setElementData(col,"nlrp->fuelcol->id",dbid)
			setElementData(col,"nlrp->fuelcol->inUse",false)
		end
	end
end

exports.nlrp_admin:addAdminCommand("nearbyfuel", 9, "Tankoló pontok mutatása")
addCommandHandler("nearbyfuel",
	function(player,cmd)
		if getElementData(player, "acc.adminLevel") >= 9 then
			triggerClientEvent(player,"toggleFuelShow",player)
		end
	end
)

exports.nlrp_admin:addAdminCommand("delfuel", 9, "Tankoló pont törlése")
addCommandHandler("delfuel",
	function(player,cmd,id)
		if getElementData(player, "acc.adminLevel") >= 9 then
			if id then
				local obj = findFuelByDBID(id)
				if obj then
					local name = getElementData(player,"acc.adminNick") or "Admin"
					local dbid = getElementData(obj,"nlrp->fuelpoint->id")
					outputChatBox(exports.nlrp_core:getServerTag("info") .. "Sikeresen töröltél egy fuel pontot! #b7ff00( ID:" .. dbid .. " )",player,255,255,255,true)
					exports.nlrp_core:sendMessageToAdmins("#b7ff00" .. name .. "#ffffff törölt egy fuel pontot! #b7ff00( ID:" .. dbid .." )",9)

					local query = dbExec(connection, "DELETE FROM fuelpoints WHERE id = ? LIMIT 1", dbid)

					destroyElement(obj)
					destroyElement(findFuelColByDBID(id))
				else
					outputChatBox(exports.nlrp_core:getServerTag("error") .. "Nem található fuel pont ezzel az ID-vel!",player,255,255,255,true)
				end
			else
				outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [ID]",player,255,255,255,true)
			end
		end
	end
)

function findFuelByDBID(id)
	local found = false
	if id then
		for k,obj in ipairs(getElementsByType("object")) do
			if getElementData(obj,"nlrp->fuelpoint") then
				if tonumber(getElementData(obj,"nlrp->fuelpoint->id")) == tonumber(id) then
					found = obj
				end
			end
		end
	end
	return found
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

exports.nlrp_admin:addAdminCommand("addfuel", 9, "Tankoló pont lértehozás")
addCommandHandler("addfuel",
	function(player,cmd)
		if getElementData(player, "acc.adminLevel") >= 9 then
			if getElementInterior(player) == 0 and getElementDimension(player) == 0 then
				local p = Vector3(getElementPosition(player))
				local _,_,rot = getElementRotation(player)

				local name = getElementData(player,"acc.adminNick") or "Admin"
				local query = dbQuery(connection, "INSERT INTO fuelpoints SET x=?,y=?,z=?,rot=?,admin=?",
					p.x,p.y,p.z,rot,name)
				local insertered, _, insertid = dbPoll(query, -1)
				if insertered then
					outputChatBox(exports.nlrp_core:getServerTag("info") .. "Sikeresen létrehoztál egy fuel pontot! #b7ff00( ID:" .. insertid .. " )",player,255,255,255,true)
					exports.nlrp_core:sendMessageToAdmins("#b7ff00" .. name .. "#ffffff létehozott egy fuel pontot! #b7ff00( ID:" .. insertid .." )",9)
					loadFuelPoint(insertid)
				else
					outputChatBox(exports.nlrp_core:getServerTag("error") .. "Nem sikerült lérehozni a fuel pontot.",player,255,255,255,true)
				end
			else
				outputChatBox(exports.nlrp_core:getServerTag("error") .. "Interiorban nem tehetsz le fuel pontot.",player,255,255,255,true)
			end
		end
	end
)

addEvent("changeFuelUse",true)
addEventHandler("changeFuelUse",resourceRoot,
	function(id,state)
		local col = findFuelColByDBID(id)
		if col then
			setElementData(col,"nlrp->fuelcol->inUse",state)
		end
	end
)

addEvent("fuelAnim",true)
addEventHandler("fuelAnim",resourceRoot,
	function(player,state,rot)
		if state then
			setElementRotation(player,0,0,rot)
			setPedAnimation(player,"SWORD","sword_IDLE")
		else
			setPedAnimation(player)
		end
	end
)

addEvent("payFueling",true)
addEventHandler("payFueling",resourceRoot,
	function(player,vehicle,fuel)
		local money = getElementData(player,"char.Money")
		setElementData(player,"char.Money",money-fuel*(fuelPrice))

		local oldFuel = getElementData(vehicle,"vehicle.fuel")
		setElementData(vehicle,"vehicle.fuel",oldFuel+fuel)
	end
)