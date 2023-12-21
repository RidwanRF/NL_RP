local canRob = false
local atmElem

function createBlipToPD(atmElement)
	local x,y,z = getElementPosition(atmElement)
	local blip_ID = exports.nlrp_hud:addCustomBlip({x,y,z,"atm.png",14.5,true,tocolor(215,55,55)}) --ITT KELL ÁTÍRNI
	setTimer(function()
		exports.nlrp_hud:delCustomBlip(blip_ID)
	end, 1000*60*5,1)
end
addEvent( "createBlipToPD", true )
addEventHandler( "createBlipToPD", localPlayer, createBlipToPD )

function onClientColShapeHit( theElement, matchingDimension )
    atm = getElementData(source, "atmElem")
	if atm and theElement == getLocalPlayer() then
		atmElem = atm
		if getElementData(atmElem, "robbable") then
			canRob = true
		end
	end
end
addEventHandler("onClientColShapeHit", root, onClientColShapeHit)

function onClientColShapeLeave( theElement, matchingDimension )
    atm = getElementData(source, "atmElem")
	if atm and theElement == getLocalPlayer() then
		canRob = false
		atmElem = nil
	end
end
addEventHandler("onClientColShapeLeave", root, onClientColShapeLeave)

function feltor()
	if (canRob and atmElem) then
		if getElementData(atmElem, "robbable") then
			if exports.nlrp_inventory:hasItem(136) then
				triggerServerEvent ( "robBank", resourceRoot, getLocalPlayer(), atmElem)
				canRob = false
				atmElem = nil
			end
		else
			outputChatBox("Ez az ATM jelenleg nem rabolható.",255,255,255,true)
		end
	end
end
addCommandHandler("feltor",feltor)
