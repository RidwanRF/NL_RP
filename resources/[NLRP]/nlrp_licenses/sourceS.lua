local registerEvent = function(eventName, element, func)
	addEvent(eventName, true)
	addEventHandler(eventName, element, func)
end

registerEvent("nlrp_licensesS:giveDocument", root, function(docID, data, money)
    if docID and data then
        if docID == 112 then
            if exports.nlrp_core:takeMoney(source,  money) then
                exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
            else
                exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
            end
        elseif docID == 372 then
                if exports.nlrp_core:takeMoney(source,  money) then
                    exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
                else
                    exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
                end
            elseif docID == 373 then
                if exports.nlrp_core:takeMoney(source,  money) then
                    exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
                else
                    exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
                end
            elseif docID == 374 then
                if exports.nlrp_core:takeMoney(source,  money) then
                    exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
                else
                    exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
                end
           elseif docID == 375 then
                if exports.nlrp_core:takeMoney(source,  money) then
                    exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
                else
                    exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
                end
                elseif docID == 376 then
                    if exports.nlrp_inventory:hasItem(source,377) then
                if exports.nlrp_core:takeMoney(source, money) then
                            exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
                     else
                        exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
                     end
                     else
                        outputChatBox("Nincs műszaki adatlapod")
                     
                
                end
        elseif docID == 111 then
            local itemData = exports.nlrp_inventory:hasItemWithData(source, 113, "data2", "vezetés-gyakorlat")
            if itemData and (itemData.data1 or itemData.data1 == 1) and itemData.data2 == "vezetés-gyakorlat" and tonumber(itemData.data3) == getElementData(source, "char.ID") then
                if exports.nlrp_core:takeMoney(source,  money) then
                    --exports.nlrp_inventory:removeItemByData(source, 113, "data1", true)
                    exports.nlrp_inventory:removeItemByData(source, 113, "data2", "vezetés-gyakorlat")
                    exports.nlrp_inventory:removeItemByData(source, 113, "data2", "vezetés-elmélet")
                    exports.nlrp_inventory:giveItem(source, docID, 1, toJSON(data), nil, nil)
                else
                    exports["nlrp_alert"]:showAlert(source, "error", "Nincs elég pénzed")
                end
            else
                exports["nlrp_alert"]:showAlert(source, "error", "Névre szóló vizsga záradék nélkül nem", "válthatod ki a jogosítványodat")
            end
        end
    end
end)

