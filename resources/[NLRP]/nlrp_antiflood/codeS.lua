local floodLimit = 7

local nembant = { [10]=true, [9]=true }

local commands = {
    -- Ha valaki ezeket floodolja a rendszer 15x egymás után automatikusan ki kickeli a szerverről.
    ['say'] = true,
    ['do'] = true,
    ['me'] = true,
    ['r'] = true,
    ['b'] = true,
    ['pm'] = true,
    ['fix'] = true,
    ['unflip'] = true,
    ['asay'] = true,
    ['pm'] = true,
    ['vá'] = true,
    ['heal'] = true,
}

local floodingPlayers = {}

function playerChat(cmd)
    if commands[cmd] then 
        if not floodingPlayers[source] and not ( nembant[getElementData(source, "acc:id")] ) then 
            floodingPlayers[source] = 1
        elseif not ( nembant[getElementData(source, "acc:id")] ) then
            floodingPlayers[source] = floodingPlayers[source] + 1
            if floodingPlayers[source]>floodLimit then 
                kickPlayer(source, 'Rendszer', '[Ki lettél rúgva Flood miatt.] ' .. string.lower(cmd) .. ' parancsot...')
            end
        end
    end
end 
addEventHandler('onPlayerCommand', root, playerChat)

function resetTable()
    floodingPlayers = {}
end 
setTimer(resetTable, 10000, 0)