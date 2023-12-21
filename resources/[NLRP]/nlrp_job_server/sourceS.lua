local registerEvent = function(eventName, element, func)
	addEvent(eventName, true)
	addEventHandler(eventName, element, func)
end

registerEvent("nlrp_serverS:attachDish", root, function(objID)
    print(getPlayerName(source) .. " " .. objID)
    setPedAnimation(source, "carry", "putdwn", 1000, true, true, false, false)

    --setTimer(function()
        setPedAnimation(source, "carry", "crry_prtial", 0, true, true, false, true)
        triggerClientEvent(root, "nlrp_serverC:attachDish", source, objID)
    --end, 1050, 1)
end)

registerEvent("nlrp_serverS:dettachDish", root, function(objID)
    setPedAnimation(source)
    triggerClientEvent(root, "nlrp_serverC:dettachDish", source)
end)

registerEvent("nlrp_serverS:changeModel", root, function(modelID)
    --print(getPlayerName(source) .. modelID)
    --print(modelID)
    setElementModel(source, modelID)
    --print("asd3")
end)

