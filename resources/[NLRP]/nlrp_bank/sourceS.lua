local connection = false



local tax = 0.05 -- X% adó minden be/kifizetéskor (1 = 100%) (0.5 = 50%) (0.05 = 5%)



addEventHandler("onResourceStart", getRootElement(),
    function (startedResource)
        if getResourceName(startedResource) == "nlrp_database" then
            connection = exports.nlrp_database:getConnection()
        elseif source == getResourceRootElement() then
            if getResourceFromName("nlrp_database") and getResourceState(getResourceFromName("nlrp_database")) == "running" then
                connection = exports.nlrp_database:getConnection()
            end
        end
    end
)

local registerEvent = function(eventName, element, func)
    addEvent(eventName, true)
    addEventHandler(eventName, element, func)
end

function setPlayerBankMoney(player, value)
    if not player then
        player = source
    end

    dbQuery( -- PÉNZZEL NEM SZÓRAKOZUNK, EGYBŐL MENTÜNK ADATBÁZISBA HA PL. CRASHELNE A SZERVER NE VESSZEN EL A JÁTÉKOSTÓL
        function (qh, sourcePlayer)
            setElementData(sourcePlayer, "char.bankMoney", value)
            triggerClientEvent(sourcePlayer, "nlrp_bankC:updateBalance", sourcePlayer)
            dbFree(qh)
        end, {player}, connection, "UPDATE characters SET bankMoney = ? WHERE charID = ?", value, getElementData(player, "char.ID")
    )
end
registerEvent("nlrp_bankS:setPlayerBankMoney", root, setPlayerBankMoney)

function givePlayerBankMoney(player, value)
    if not player then
        player = source
    end

    if exports.nlrp_chat:isPlayerPayActive(player) then return end

    if (getElementData(player, "char.Money") or 0) - value >= 0 then
		outputChatBox("[NLRP-Bank] #ffffffSikeres befizettél " .. format(value) .. " forint összeget!",player,183,255,0,true)
		outputChatBox("[NLRP-Bank] #ffffffEbből levonva: " .. format(value*tax) .. " forint adó!",player,228,53,53,true)

        local finalValue = getElementData(player, "char.bankMoney") + value-(value*tax)

        dbQuery( -- PÉNZZEL NEM SZÓRAKOZUNK, EGYBŐL MENTÜNK ADATBÁZISBA HA PL. CRASHELNE A SZERVER NE VESSZEN EL A JÁTÉKOSTÓL
            function (qh, sourcePlayer)
                setElementData(sourcePlayer, "char.bankMoney", finalValue)
                exports.nlrp_core:takeMoney(sourcePlayer, value)
                triggerClientEvent(sourcePlayer, "nlrp_bankC:updateBalance", sourcePlayer)

                dbFree(qh)
            end, {player}, connection, "UPDATE characters SET bankMoney = ?, money = ? WHERE charID = ?", finalValue, getElementData(player, "char.Money") - value, getElementData(player, "char.ID")
        )
    else
        exports["nlrp_alert"]:showAlert(player, "error", "Sikeretelen tranzakció!", "Nincs ennyi pénz a kezedben")
    end
end
registerEvent("nlrp_bankS:givePlayerBankMoney", root, givePlayerBankMoney)


function bekifizet(player,commandname,value)
	if value then
		if commandname == "betesz" then
			givePlayerBankMoney(player, tonumber(value))
		elseif commandname == "kivesz" then
			takePlayerBankMoney(player, tonumber(value))
		end
	else
		--outputChatBox("#db2828[Használd]#FFFFFF /"..commandname.." [összeg]",player,255,255,255,true)
	end
end
--addCommandHandler("betesz", bekifizet)
--addCommandHandler("kivesz", bekifizet)


function takePlayerBankMoney(player, value)
    if not player then
        player = source
    end
    if exports.nlrp_chat:isPlayerPayActive(player) then return end

    if getElementData(player, "char.bankMoney") > 0 and getElementData(player, "char.bankMoney") >= value then 
        outputChatBox("[NLRP-Bank] #ffffffSikeres felvettél " .. format(value) .. " forint összeget a számládról!",player,183,255,0,true)
        outputChatBox("[NLRP-Bank] #ffffffEbből levonva: " .. format(value*tax) .. " forint adó!",player,228,53,53,true)
        
        local finalValue = getElementData(player, "char.bankMoney") - value

        dbQuery( -- PÉNZZEL NEM SZÓRAKOZUNK, EGYBŐL MENTÜNK ADATBÁZISBA HA PL. CRASHELNE A SZERVER NE VESSZEN EL A JÁTÉKOSTÓL
            function (qh, sourcePlayer)
                setElementData(sourcePlayer, "char.bankMoney", finalValue)
                exports.nlrp_core:giveMoney(sourcePlayer, value-(value*tax))
                triggerClientEvent(sourcePlayer, "nlrp_bankC:updateBalance", sourcePlayer)

                dbFree(qh)
            end, {player}, connection, "UPDATE characters SET bankMoney = ?, money = ? WHERE charID = ?", finalValue, getElementData(player, "char.Money") + value, getElementData(player, "char.ID")
        )
    else
        exports["nlrp_alert"]:showAlert(player, "error", "Sikeretelen tranzakció!", "Nincs ennyi pénz a számládon")
    end
end

registerEvent("nlrp_bankS:takePlayerBankMoney", root, takePlayerBankMoney)


format = function(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 