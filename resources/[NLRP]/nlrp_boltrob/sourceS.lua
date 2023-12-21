local penztargepek = {
	{1514,1324.4479980469, -895.54052734375, 39.88,"Északi kisbolt",0,0,180},
	{1829,2310.7131347656, -5.9170624732971, 26.2,"Palomino Bank",0,0,180},
	{1829,2309.7131347656, -5.9170624732971, 26.2,"Palomino Bank",0,0,180},
	{1514,248.44813537598, -89.220680236816, 2,"Blueberry bolt",0,0,90},

}	
local penztargep = {}
local uSound = {}

function onLoadCreatePenztarGepek()
	for i=1,#penztargepek do
		penztargep[i] = createObject(penztargepek[i][1],penztargepek[i][2],penztargepek[i][3],penztargepek[i][4])
		setElementData(penztargep[i],"shop.rob.id",i)
		setElementData(penztargep[i],"shop.rob.name",penztargepek[i][5])
		setElementData(penztargep[i],"shop.rob.object",true)
		setElementData(penztargep[i],"shop.rob.rabolhato",0)
		setElementData(penztargep[i],"isRobbingPenztar",false)
		setElementInterior(penztargep[i],penztargepek[i][6])
		setElementDimension(penztargep[i],penztargepek[i][7])
		setObjectRotation(penztargep[i],0,0,penztargepek[i][8])
	end
end
onLoadCreatePenztarGepek()

setTimer(function()
	for k=1,#penztargepek do
		if getElementData(penztargep[k],"shop.rob.rabolhato") > 1 then
			setElementData(penztargep[k],"shop.rob.rabolhato",getElementData(penztargep[k],"shop.rob.rabolhato") - 1)
		else
			
		end
	end
end,60000,0)

addEvent("setPenztarData", true)
addEventHandler("setPenztarData", getRootElement(), function(clickedElement,data,value)
	setElementData(clickedElement,data,value)
end)

addEvent("AlarmToggle", true)
addEventHandler("AlarmToggle", getRootElement(), function(p,robID)
	triggerClientEvent("receiveSoundPos", root,penztargepek[robID][8],penztargepek[robID][9],penztargepek[robID][10],robID)
end)

addEvent("onFrakcioErtesitARablasrol", true)
addEventHandler("onFrakcioErtesitARablasrol", getRootElement(), function(p,id)	for k, v in ipairs(getElementsByType("player")) do		if exports.nlrp_groups:isPlayerInGroup(v, 1) then			outputChatBox("#F89406[Riasztás] #ffffffRablás folyamatban!", v,255,255,255,true)			outputChatBox("#F89406[Riasztás] #ffffffHelyszín: #db2828"..id, v,255,255,255,true)		end	end
end)

function setAnimTrue(j)
	setElementFrozen(j,true)
	setPedAnimation ( j, "ROB_BANK", "CAT_Safe_Rob", -1, true, false, false, false)
end
addEvent("setRobberAnim", true)
addEventHandler("setRobberAnim", getRootElement(), setAnimTrue)

function setAnimFalse(j)
local robbedMoney = -1
	setElementFrozen(j,false)
	setPedAnimation(j,nil,nil)

	setElementData(j,"char.Money",getElementData(j,"char.Money")+math.random(250000, 2000000))

end
addEvent("offRobberAnim", true)
addEventHandler("offRobberAnim", getRootElement(), setAnimFalse)