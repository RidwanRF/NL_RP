kuka1 = createColSphere(1996.8781738281, -1606.1839599609, 13.539, 1)
setElementDimension(kuka1, 0)
setElementInterior(kuka1, 0)

kuka2 = createColSphere(171.24893188477, 1172.6807861328, 14.7578125, 5)
setElementDimension(kuka2, 0)
setElementInterior(kuka2, 0)

kuka3 = createColSphere(1749.1875, -1765.55078125, 13.536721229553, 5)
setElementDimension(kuka3, 0)
setElementInterior(kuka3, 0)

kuka4 = createColSphere(1794.2177734375, -1784.712890625, 13.534149169922, 5)
setElementDimension(kuka4, 0)
setElementInterior(kuka4, 0)

kuka5 = createColSphere(1883.7060546875, -1874.8671875, 13.51043510437, 5)
setElementDimension(kuka5, 0)
setElementInterior(kuka5, 0)


function kukaBuvarkodas(thePlayer, commandName)
    if getElementData(thePlayer, "kukabuvar") == 1 then
    else
        if isElementWithinColShape(thePlayer, kuka1) or isElementWithinColShape(thePlayer, kuka2) or isElementWithinColShape(thePlayer, kuka3) or isElementWithinColShape(thePlayer, kuka4) or isElementWithinColShape(thePlayer, kuka5) then
            setElementFrozen ( thePlayer, true )
            setPedAnimation (thePlayer, "ROB_BANK", "CAT_Safe_Rob", false, true, false, false)
			setPedAnimation (thePlayer, "ROB_BANK", "CAT_Safe_Rob", -1, true, false, false)
			exports.nlrp_chat:sendLocalMeAction(thePlayer, "elkezd turkálni a szemetek között.")
            setTimer(trashTimer, 10000, 1, thePlayer, commandName)
            setElementData(thePlayer, "kukabuvar", 1)
        end
    end
end
addCommandHandler("turkal", kukaBuvarkodas, false, false)

function trashTimer(thePlayer, commandName)
    removeElementData(thePlayer, "kukabuvar")
    exports.nlrp_admin:unfreeze(thePlayer)
    setElementFrozen ( thePlayer, false )
    if isElementWithinColShape(thePlayer, kuka1) or isElementWithinColShape(thePlayer, kuka2) or isElementWithinColShape(thePlayer, kuka3) or isElementWithinColShape(thePlayer, kuka4) or isElementWithinColShape(thePlayer, kuka5) then
        local gotItem = math.random(1,50)
        local givedItem = 0
        if gotItem == 1 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Rádiót.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 2 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Dobókockát.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 3 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Gyógyszert.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 4 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Kötelet.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 5 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Szendvicset.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 6 then
            outputChatBox("#b7ff00[NextLevel: #ffffffTaláltál egy Sí maszkot.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 7 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy HiFi-t.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 8 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Flakon Vizet.", thePlayer, 200,200,200, true) 
            givedItem = 53
        elseif gotItem == 9 then
            outputChatBox("#b7ff00[NextLevel]: #ffffffTaláltál egy Ásót.", thePlayer, 200,200,200, true) 
            givedItem = 53
        else
            outputChatBox("#b7ff00[NextLevel]: #ffffffNem találtál semmit.", thePlayer, 200,200,200, true)
        end
        if givedItem == 0 then
        else
			exports.nlrp_inventory:giveItem(thePlayer, givedItem, 1, 1)
        end
    else
        outputChatBox("#cb1919[NextLevel]: #ffffffNem vagy szeméttelepen!", thePlayer, 200,200,200, true)
    end
end