addEventHandler("onResourceStart",resourceRoot,function()
	local healPed = createPed(275, 1166.6022949219, -1369.8603515625, 13.841062545776)
    setElementInterior(healPed,0)
    setElementDimension(healPed,0)    
	setElementRotation(healPed,0,0,275)
	setElementData(healPed, "visibleName", "Ápolónő")
	setElementFrozen(healPed,true)    
	setElementData(healPed,"isHealPed",true)
	local healMarker = createMarker( 1166.6022949219, -1369.8603515625, 13.841062545776,"cylinder",1.5,124,197,118,0)
        setElementInterior(healMarker,0) 
        setElementDimension(healMarker,0)
	setElementData(healMarker,"isHealMarker",true)
	addEventHandler("onMarkerHit",healMarker,healMarkerHit) 
	addEventHandler("onMarkerLeave",healMarker,healMarkerLeave) 
end)

function healMarkerHit(hitElement,matchingDimension)
	triggerClientEvent(hitElement,"showHealPanel",hitElement)
end

function healMarkerLeave(hitElement,matchingDimension)
	triggerClientEvent(hitElement,"destHealPanel",hitElement)
end