--+----------------------------------------------------------------------------------------------------------------------------------------
--|   Script by K "Addlibs" Stasiak, downloaded from MTA community.
--|
--|   Licensed under Creative Commons Attribution 4.0 International Public License
--|   https://creativecommons.org/licenses/by/4.0/
--|
--|   You are free to copy and redistribute the script, to remix, transform, and build upon the script for any purpose, even commercially.
--|   You must give appropriate credit, provide a link to the license, and indicate if changes were made.
--|   You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
--+----------------------------------------------------------------------------------------------------------------------------------------

--addEventHandler("onPlayerJoin", root,
    --function () -- client has just joined and the proximity voice resource isn't yet running on the client (thus they'd be able to hear everything without limitations on distance)
    --    local players = getElementsByType("player", root, true) -- table of sounds which will be transformed into 3D
    --    for k, v in ipairs(players) do
    --      setPlayerVoiceIgnoreFrom(v, nil)
    --      setPlayerVoiceBroadcastTo(v, players)
    --    end
  --  end
--)

local players = getElementsByType("player", root, true) -- table of sounds which will be transformed into 3D
for k, v in ipairs(players) do
  setPlayerVoiceIgnoreFrom(v, nil)
  setPlayerVoiceBroadcastTo(v, players)
end

addEvent("proximity-voice::broadcastUpdate", true)
addEventHandler("proximity-voice::broadcastUpdate", root,
    function (broadcastList) -- client has streamed in or out another player and the broadcast list has changed
        if client and source == client then else return end
        setPlayerVoiceIgnoreFrom(source, nil)
        setPlayerVoiceBroadcastTo(source, broadcastList)
    end
)

function pssst(playerSource, data)
  local players = getElementsByType("player", root, true)
  for k, v in ipairs(players) do
    triggerClientEvent ( v, "psst", v, playerSource, data)
  end
end
addEvent( "pssst", true )
addEventHandler( "pssst", resourceRoot, pssst ) -- Bound to this resource only, saves on CPU usage.


addEventHandler( 'onPlayerVoiceStart', root,
    function()
		setElementData(source,"isSpeak", true)
    end
)

addEventHandler("onPlayerVoiceStop",root,function()
	setElementData(source,"isSpeak", false)
end)