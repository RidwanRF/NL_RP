addEventHandler("onElementDataChange", root, function(theKey, oldValue, newValue)
    if getElementType(source) == "player" then
        if theKey == "vanishColt" then
            if newValue then
                giveWeapon(source, 22, 1, true)
            else
                takeWeapon(source, 22, 1)
            end
        end
    end
end)