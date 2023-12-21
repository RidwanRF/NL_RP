
function registerEvent(event, element, xfunction)
    addEvent(event, true)
    addEventHandler(event, element, xfunction)
end

registerEvent("nlrp_medicC:playerHeal", root, function(targetPlayer)
    if targetPlayer then
        if not isPedDead(targetPlayer) then
            exports.nlrp_minigames:startMinigame("buttons", "healSuccess", "healFailed", 0.15, 0.2, 115, 40)
        else
            outputChatBox(exports.nlrp_core:getServerTag("info") .. "A páciens halott.", 0, 0, 0, true)
        end
    end
end)

registerEvent("healSuccess", root, function(player)
    triggerServerEvent("nlrp_medicS:healPlayer", player, player)
    --triggerServerEvent("nlrp_medicS", player)
end)

registerEvent("healFailed", root, function(player)
    exports.nlrp_hud:showAlert("error", "Sikertelen ellátás!", "Nem sikerült az ellátást szakszerűen végrehajtanod")
    --triggerServerEvent("nlrp_medicS", player)
end)