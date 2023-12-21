
addEvent("nlrp_medicbagS:calculateMedicbag", true)
addEventHandler("nlrp_medicbagS:calculateMedicbag", root, function()

    local r = getPedRotation(source)
    local x, y, z = getElementPosition(source)
    x = x + ( ( math.cos ( math.rad ( r ) ) ) * 0.5 )
    y = y + ( ( math.sin ( math.rad ( r ) ) ) * 0.5 )

    local distance = getElementDistanceFromCentreOfMassToBaseOfModel(source) - 0.15

    triggerServerEvent("nlrp_medicbagS:dropMedicbag", source, source, {x, y, z - distance, r})
end)