local connection = exports["nlrp_database"]:getConnection()

addEventHandler("onResourceStart", resourceRoot,
    function()
		local result = dbQuery(connection,"SELECT * FROM hunting")
		local handler = dbPoll(result, -1)
		if (handler) then
			for i, row in ipairs(handler) do
				loadOneAnimal(row["id"])
			end
		end
	end
)

function loadOneAnimal(id)
	local Query = dbPoll(dbQuery(connection, "SELECT * FROM hunting WHERE id = ? ", id), -1 )
	if (Query) then
		for i, row in ipairs(Query) do
			local x,y,z = row["x"],row["y"],row["z"]
			local skin = row["skin"]
			local rot = row["rot"]
			local name = row["name"]
			local maxHealth = row["health"]
			local ped = createPed(skin,x,y,z, rot)
			setPedWalkingStyle(ped,118)
			setElementData(ped, "hunter:id",row["id"])
	    setElementData(ped,"name",""..name.."")
			setElementData(ped,"nameEnabled",true)
			setElementData(ped,"visibleName", name)
			setElementData(ped, "hunter:animal", true)
			setElementData(ped, "hunter:canRob", false)
			setElementData(ped, "hunter:health", maxHealth)
			setElementData(ped, "hunter:maxHealth", maxHealth)
			setElementData(ped, "hunter:autoAttack", true)
			setElementData(ped, "hunter:attack", false)
			setElementData(ped, "hunter:target", nil)
			setElementData(ped, "hunter:defPos", {x,y,z})
			setElementData(ped, "hunter:use", false)
			setElementData(ped, "hunter:clicks", 0)
		end
	end
end

addEvent("hunter:startAttack", true)
addEventHandler("hunter:startAttack", root,
    function(e1, ped)
	    setElementData(ped, "hunter:attack", true)
		setElementData(ped, "hunter:target", e1)
	end
)

addEvent("hunter:stopAttack", true)
addEventHandler("hunter:stopAttack", root,
    function(e1, ped)
	    --outputChatBox("asd3")
	    setElementData(ped, "hunter:attack", false)
		setElementData(ped, "hunter:target", nil)
	end
)

addEvent("hunter:destroyAnimal", true)
addEventHandler("hunter:destroyAnimal", root,
    function(ped)
	    setElementFrozen(ped, true)
        local op = {getElementPosition(ped)}
		setElementPosition(ped, op[1], op[2], op[3]-50)
		setTimer(
		    function()
			    local p = getElementData(ped, "hunter:defPos")
				setElementFrozen(ped, false)
				setElementData(ped, "hunter:health", getElementData(ped, "hunter:maxHealth"))
				setElementData(ped, "hunter:use", false)
				setElementData(ped, "hunter:clicks", 0)
				setElementPosition(ped, p[1], p[2], p[3])
			end, 5 * 60 * 10000, 1
		)
	end
)

addEventHandler("onElementDataChange", root,
   function(dName, oldValue)
       if getElementType(source) == "ped" and getElementData(source, "hunter:animal") then
	       if dName == "hunter:health" then
		       local newValue = getElementData(source, dName)
			   if newValue <= 0 then
			      setElementFrozen(source, true)
				  setPedAnimation(source,"ped", "FLOOR_hit",-1,false,false,false)
			   end
		   end
	   end
   end
)

addEvent("server:giveItem", true)
addEventHandler("server:giveItem", root,
    function(ped, b)
	    exports["nlrp_inventory"]:giveItem(ped, b, 1,1,0)
	end
)

addEvent("serverHunterAnim",true)
addEventHandler("serverHunterAnim",getRootElement(),function(playerSource,num)
	if num == 1 then
		setPedAnimation(playerSource, "bomber", "bom_plant", -1, true, false, false, false)
	elseif num == 2 then
		setPedAnimation(playerSource,nil,nil)
	end
end)

addEvent("giveVadaszMoney",true)
addEventHandler("giveVadaszMoney",getRootElement(),function(playerSource)
		local itemData = exports["nlrp_inventory"]:getElementItems(playerSource,playerSource,0)
		local row = 4
		local column = 9
		local bagValue = 0
		local bagCount = 0
		local goldCount = 0
		local money = 2500
		for i = 1, row * column do
			if (itemData[playerSource]["bag"][i]) then
				if itemData[playerSource]["bag"][i]["id"] == 138 then
					goldCount = goldCount+1
					money = money+0
					exports["nlrp_inventory"]:deleteItem(playerSource,playerSource,itemData[playerSource]["bag"][i])
				end
				if itemData[playerSource]["bag"][i]["id"] == 139 then
					goldCount = goldCount+1
					money = money+0
					exports["nlrp_inventory"]:deleteItem(playerSource,playerSource,itemData[playerSource]["bag"][i])
				end
				if itemData[playerSource]["bag"][i]["id"] == 140 then
					goldCount = goldCount+1
					money = money +500
					exports["nlrp_inventory"]:deleteItem(playerSource,playerSource,itemData[playerSource]["bag"][i])
				end
				if itemData[playerSource]["bag"][i]["id"] == 141 then
					goldCount = goldCount+1
					money = money +500
					exports["nlrp_inventory"]:deleteItem(playerSource,playerSource,itemData[playerSource]["bag"][i])
				end
				if itemData[playerSource]["bag"][i]["id"] == 142 then
					goldCount = goldCount+1
					money = money +750
					exports["nlrp_inventory"]:deleteItem(playerSource,playerSource,itemData[playerSource]["bag"][i])
				end
				if itemData[playerSource]["bag"][i]["id"] == 143 then
					goldCount = goldCount+1
					money = money +750
					exports["nlrp_inventory"]:deleteItem(playerSource,playerSource,itemData[playerSource]["bag"][i])
				end
			end
		end
		if goldCount > 0 then
			outputChatBox("#7cc576[NextLevel]#ffffff Sikeresen leadtál #7cc576"..goldCount.."#ffffff darab bőrt / húst, ezért a jutalmad #7cc576"..money*goldCount.."#ffffff $.",playerSource,255,153,51,true)
			setElementData(playerSource,"money",getElementData(playerSource,"money")+money*goldCount)
		end
end)

addCommandHandler("addanimal",
	function(playerSource,cmd,typ)
		if getElementData(playerSource, "acc.adminLevel") == 9 then
			if typ then
				typ = tonumber(typ)
				local x,y,z = getElementPosition(playerSource)
				local rot = getPedRotation(playerSource)
				if typ == 1 then
					local Query = dbQuery(connection, "INSERT INTO hunting SET x = ? , y = ? , z = ?, rot = ? , skin = ?, name = ?, health = ?",x,y,z,rot,312,"Medve",320)
					local beszurasQueryEredmeny, _, beszurid = dbPoll ( Query, -1 )
					if beszurasQueryEredmeny then
						loadOneAnimal(beszurid)
						outputChatBox("[NextLevel]:#ffffff Sikeresen leraktál egy medvét. #e5a00c("..beszurid..")",playerSource,183,255,0,true)
					end
				elseif typ == 2 then
					local Query = dbQuery(connection, "INSERT INTO hunting SET x = ? , y = ? , z = ?, rot = ? , skin = ?, name = ?, health = ?",x,y,z,rot,309,"Szarvas",265)
					local beszurasQueryEredmeny, _, beszurid = dbPoll ( Query, -1 )
					if beszurasQueryEredmeny then
						loadOneAnimal(beszurid)
						outputChatBox("[NextLevel]:#ffffff Sikeresen leraktál egy szarvast. #e5a00c("..beszurid..")",playerSource,183,255,0,true)
					end
				elseif typ == 3 then
					local Query = dbQuery(connection, "INSERT INTO hunting SET x = ? , y = ? , z = ?, rot = ? , skin = ?, name = ?, health = ?",x,y,z,rot,310,"Vaddisznó",220)
					local beszurasQueryEredmeny, _, beszurid = dbPoll ( Query, -1 )
					if beszurasQueryEredmeny then
						loadOneAnimal(beszurid)
						outputChatBox("[NextLevel]:#ffffff Sikeresen leraktál egy vaddisznót. #e5a00c("..beszurid..")",playerSource,183,255,0,true)
					end
				elseif typ == 4 then
					local Query = dbQuery(connection, "INSERT INTO hunting SET x = ? , y = ? , z = ?, rot = ? , skin = ?, name = ?, health = ?",x,y,z,rot,304,"Csirke",120)
					local beszurasQueryEredmeny, _, beszurid = dbPoll ( Query, -1 )
					if beszurasQueryEredmeny then
						loadOneAnimal(beszurid)
						outputChatBox("[NextLevel]:#ffffff Sikeresen leraktál egy csirkét. #e5a00c("..beszurid..")",playerSource,183,255,0,true)
					end
				else
					outputChatBox("[NextLevel]:#ffffff Helytelen érték.",playerSource,183,255,0,true)
				end
			else
				outputChatBox("Használat:#ffffff /"..cmd.." [tipus]",playerSource,183,255,0,true)
				outputChatBox("[Tipusok]:#ffffff 1 = Medve, 2 = Szarvas, 3 = Vaddisznó, 4 = Csirke(nemjó)",playerSource,183,255,0,true)
			end

		end
	end)

addCommandHandler("delanimal",function(playerSource)

  if getElementData(playerSource, "acc.adminLevel") == 9 then
		local x, y, _ = getElementPosition(playerSource)
		local shape = createColCircle(x,y,3)
		local aCount = 0
		for _,v in ipairs(getElementsWithinColShape(shape,"ped")) do
			if getElementData(v, "hunter:animal") == true then
				local theID = getElementData(v, "hunter:id")
				aCount = aCount + 1
				destroyElement(v)
				dbPoll(dbQuery(connection, "DELETE FROM hunting WHERE id = '?'", theID), -1 )
				outputChatBox("[NextLevel]:#ffffff Sikeresen töröltél egy állatot. #e5a00c("..theID..")",playerSource,183,255,0,true)
				return
			end
		end
		if(aCount == 0) then
			outputChatBox("[NextLevel]:#ffffff Nincs a közeledbe állat.", playerSource,61, 122, 188, true)
		end
  end
end)
