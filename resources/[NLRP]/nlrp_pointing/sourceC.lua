local shaders = {}
local texture = dxCreateTexture("inv.png") 

function invisibleWeapon(player)
    if isElement(player) then
        if not shaders[player] then
            shaders[player] = dxCreateShader("changer.fx", 0, 100, false, "ped")
        end

        if shaders[player] then
            dxSetShaderValue(shaders[player], "TEXTURE", texture)

            for k, v in pairs(engineGetModelTextureNames("346")) do
                engineApplyShaderToWorldTexture(shaders[player], v, player)
            end
        end
    end
end

function visibleWeapon(player)
    if isElement(player) then
        if shaders[player] then
            for k, v in pairs(engineGetModelTextureNames("346")) do
                engineRemoveShaderFromWorldTexture(shaders[player], v, player)
            end

            destroyElement(shaders[player])
            shaders[player] = nil
        end
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    for k, v in pairs(getElementsByType("player", root, true)) do
        local vanishColt = getElementData(v, "vanishColt")

        if vanishColt then
            visibleWeapon(v)
        end
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if getElementType(source) == "player" then
        local vanishColt = getElementData(source, "vanishColt")

        if vanishColt then
            visibleWeapon(source)
        end
    end
end)

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "player" then
        local vanishColt = getElementData(source, "vanishColt")

        if vanishColt then
            invisibleWeapon(source)
        end
    end
end)

addEventHandler("onClientElementDataChange", root, function (dataName, oldValue, newValue)
    if dataName == "vanishColt" then
        if newValue then
            invisibleWeapon(source)
        else
            visibleWeapon(source)
        end

        if source == localPlayer then
            if isTimer(timer) then killTimer(timer) end
            if not newValue then
                timer = setTimer( function()
                    toggleControl("fire", not newValue)
                    toggleControl("reload", not newValue)
                    toggleControl("next_weapon", not newValue)
                    toggleControl("previous_weapon", not newValue)

                    showPlayerHudComponent("crosshair", not newValue)
                end,500,1)
            else
                toggleControl("fire", not newValue)
                toggleControl("reload", not newValue)
                toggleControl("next_weapon", not newValue)
                toggleControl("previous_weapon", not newValue)

                showPlayerHudComponent("crosshair", not newValue)
            end
        end
    end
end)

addCommandHandler("aim", function()
    setElementData(localPlayer, "vanishColt", not getElementData(localPlayer, "vanishColt"))
end)

addEventHandler("onClientKey",root,
    function(k,p)
        if k == "tab" then
            if getElementData(localPlayer,"vanishColt") and (getKeyState("mouse1") or getKeyState("mouse2")) then
                cancelEvent()
            end
        end
    end
)