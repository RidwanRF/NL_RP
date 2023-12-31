function tunrad(playerSource, chan)
  setElementData(playerSource, "currentRadioChanTune", chan)
end
addEvent( "tunrad", true )
addEventHandler( "tunrad", resourceRoot, tunrad ) -- Bound to this resource only, saves on CPU usage.

addEvent("setPedFightingStyle", true)
addEventHandler("setPedFightingStyle", getRootElement(),
	function (fightStyle)
		if isElement(source) then
			setPedFightingStyle(source, fightStyle)
			setElementData(source, "fightStyle", fightStyle)
		end
	end
)

addEvent("setPedWalkingStyle", true)
addEventHandler("setPedWalkingStyle", getRootElement(),
	function (walkStyle)
		if isElement(source) then
			setPedWalkingStyle(source, walkStyle)
		end
	end
)

addEvent("kickPlayerCuzScreenSize", true)
addEventHandler("kickPlayerCuzScreenSize", getRootElement(),
	function ()
		kickPlayer(source, "Nem megfelelő képernyőfelbontás! (Minimum 1024x768)")
	end
)
