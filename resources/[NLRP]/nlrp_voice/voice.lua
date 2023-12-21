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

local streamedOut = {}

addEventHandler("onClientPreRender", root,
	function ()
        local players = getElementsByType("player") -- table of sounds which will be transformed into 3D

        for k, v in ipairs(players) do
			if getElementData(v, "voice:speak") then
            -- Modify the sound's volume and pan to make it seem 3D, based on MTA source code

            local vecSoundPos = v.position
            local vecCamPos = Camera.position
            local fDistance = (vecSoundPos - vecCamPos).length
            local fMaxVol = v:getData("maxVol") or 75
            local fMinDistance = v:getData("minDist") or 5
            local fMaxDistance = v:getData("maxDist") or 25

            -- Limit panning when getting close to the min distance
            local fPanSharpness = 1.0
            if (fMinDistance ~= fMinDistance * 2) then
                fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / ((fMinDistance * 2) - fMinDistance)))
            end

            local fPanLimit = (0.65 * fPanSharpness + 0.35)

            -- Pan
            local vecLook = Camera.matrix.forward.normalized
            local vecSound = (vecSoundPos - vecCamPos).normalized
            local cross = vecLook:cross(vecSound)
            local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))

            local fDistDiff = fMaxDistance - fMinDistance;

            -- Transform e^-x to suit our sound
						--outputChatBox( #players.." - "..getPlayerName ( getLocalPlayer() ) .." CH: "..getElementData(getLocalPlayer(), "currentRadioChanTune").." - "..getPlayerName ( v ) .." CH: "..getElementData(v, "currentRadioChanTune"))

            local fVolume
						if (getElementData(v, "SpeakIntoRadio") and (getElementData(getLocalPlayer(), "currentRadioChanTune") > 0) and (getElementData(getLocalPlayer(), "currentRadioChanTune") == getElementData(v, "currentRadioChanTune"))) or ((getElementData(getLocalPlayer(), "callRoomNumber") == getElementData(v, "callRoomNumber")) and getElementData(v, "isInPhoneCall")) then
								--outputChatBox(tostring(getElementData(v, "SpeakIntoRadio")).." - "..getPlayerName ( v ))
								--outputChatBox(tostring(getElementData(v, "isInPhoneCall")).." - "..getPlayerName ( v ))
								fVolume = fMaxVol/2
						else
	            if (fDistance <= fMinDistance) then
	                fVolume = fMaxVol
	            elseif (fDistance >= fMaxDistance) then
	                fVolume = 0.0
	            else
	                fVolume = math.exp(-(fDistance - fMinDistance) * (5.0 / fDistDiff)) * fMaxVol
	            end
	            setSoundPan(v, fPan)
						end
					--	outputChatBox(""..getElementData(v, "currentRadioChanTune"))
					--	outputChatBox(""..tostring(getElementData(v, "SpeakIntoRadio")))
            -- Additionally add a compressor effect if there's occlusion (something in the way of line of sight) (todo: make the volume change smoother)
						if (getElementData(v, "SpeakIntoRadio") and (getElementData(getLocalPlayer(), "currentRadioChanTune") == getElementData(v, "currentRadioChanTune"))) or ((getElementData(getLocalPlayer(), "callRoomNumber") == getElementData(v, "callRoomNumber")) and getElementData(v, "isInPhoneCall")) then

						--	outputChatBox("Szólik: "..getElementData(v, "currentRadioChanTune"))
								setSoundVolume(v, fVolume)
						else
								if isLineOfSightClear(localPlayer.position, vecSoundPos, true, true, false, true, false, true, true, localPlayer) then -- line of sight clear
		                setSoundVolume(v, fVolume)
		            else
		                local fVolume = fVolume * 0.5 -- reduce volume by half
		                local fVolume = fVolume < 0.01 and 0 or fVolume -- treshold of 0.01 (anything below is forced to 0)
		                setSoundVolume(v, fVolume)
		            end
				end
			end
        end
    end
, false)

addEventHandler("onClientElementStreamIn", root,
    function ()
        if source:getType() == "player" then
        --    triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
        end
    end
)
local sw, sh = guiGetScreenSize ( ) -- Get the screen resolution (width and height)

function createText ( )
	dxDrawRectangle(sw-200,0,200,16,tocolor(0,0,0,255),true)
	if (getElementData(getLocalPlayer(),"isSpeak")) then
		dxDrawText ( "[Normál]", sw - 195, 0, sw - 195 + 190, 16, tocolor ( 219, 40, 40, 255 ), 1, "default-bold", "left", "top", false, false, true )
	else
		dxDrawText ( "[Normál]", sw - 195, 0, sw - 195 + 190, 16, tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "left", "top", false, false, true )
	end
	if (getElementData(getLocalPlayer(),"isSpeak") and getElementData(getLocalPlayer(), "isInPhoneCall")) then
		dxDrawText ( "[Telefon]", sw - 195, 0, sw - 195 + 195, 16, tocolor ( 219, 40, 40, 255 ), 1, "default-bold", "center", "top", false, false, true  )
	elseif (not(getElementData(getLocalPlayer(), "isInPhoneCall"))) then
		dxDrawText ( "[Telefon]", sw - 195, 0, sw - 195 + 195, 16, tocolor ( 255, 255, 255, 100 ), 1, "default-bold", "center", "top", false, false, true  )
	else
		dxDrawText ( "[Telefon]", sw - 195, 0, sw - 195 + 195, 16, tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "center", "top", false, false, true  )
	end
	if (getElementData(getLocalPlayer(),"isSpeak") and getElementData(getLocalPlayer(), "SpeakIntoRadio")) then
		dxDrawText ( "[Rádió]", sw - 195, 0, sw - 195 + 190, 16, tocolor ( 219, 40, 40, 255 ), 1, "default-bold", "right", "top", false, false, true  )
	elseif (not(getElementData(getLocalPlayer(), "SpeakIntoRadio"))) then
		dxDrawText ( "[Rádió]", sw - 195, 0, sw - 195 + 190, 16, tocolor ( 255, 255, 255, 100 ), 1, "default-bold", "right", "top", false, false, true  )
	else
		dxDrawText ( "[Rádió]", sw - 195, 0, sw - 195 + 190, 16, tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "right", "top", false, false, true  )
	end
end
addEventHandler ( "onClientRender", root, createText )

local voiceKeys

function playerPressedKey(button, press)
    if (press and button == "v" and not(isChatBoxInputActive())) and not(isCursorShowing ())  then
		cancelEvent()
		if getElementData(getLocalPlayer(), "SpeakIntoRadio") then
			setElementData(getLocalPlayer(), "SpeakIntoRadio", false)
			outputChatBox("#d7ff00[Rádió]#aaaaaa Elvetted az arcodtól a rádiót.", 255, 255, 255, true)
		else
			setElementData(getLocalPlayer(), "SpeakIntoRadio", true)
			outputChatBox("#d7ff00[Rádió]#aaaaaa Az arcodhoz raktad a rádiót.", 255, 255, 255, true)
		end
    end
	for keyName, state in pairs(voiceKeys) do
        if (tostring(button) == tostring(keyName)) then
			if (press) then
				if getElementData(getLocalPlayer(), "SpeakIntoRadio") then
					triggerServerEvent ( "pssst", resourceRoot, getLocalPlayer(), 1 )
				end
			else
				if getElementData(getLocalPlayer(), "SpeakIntoRadio") then
					triggerServerEvent ( "pssst", resourceRoot, getLocalPlayer(), 0 )
				end
			end
		end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)

local sending = 0

function psst (sender, data)
	if (getElementData(sender, "SpeakIntoRadio") and (getElementData(getLocalPlayer(), "currentRadioChanTune") > 0) and (getElementData(getLocalPlayer(), "currentRadioChanTune") == getElementData(sender, "currentRadioChanTune"))) then
		if (sender == getLocalPlayer()) then
			if data == 1 then
				local sound = playSound("files/me_on.mp3") --Play wasted.mp3 from the sounds folder
				setSoundVolume(sound, 0.5) -- set the sound volume to 50%
			else
				local sound = playSound("files/me_off.mp3") --Play wasted.mp3 from the sounds folder
				setSoundVolume(sound, 0.2) -- set the sound volume to 50%
			end
		else
			if data == 1 then
				local sound = playSound("files/on.mp3") --Play wasted.mp3 from the sounds folder
				setSoundVolume(sound, 0.5) -- set the sound volume to 50%
			else
				local sound = playSound("files/off.mp3") --Play wasted.mp3 from the sounds folder
				setSoundVolume(sound, 0.3) -- set the sound volume to 50%
			end
		end
	end
end
addEvent( "psst", true )
addEventHandler( "psst", localPlayer, psst )

function keysCommand ( controlName )
    if not controlName then
        return
    end
    local keys = getBoundKeys ( controlName )   -- get the keys bound to this control
    if not keys then                            -- make sure the control name is valid and any keys are bound to it
        return
    end
	voiceKeys = keys
    --outputChatBox ( "Keys bound to " .. controlName .. ":", 0, 255, 0 )
    --for keyName, state in pairs(keys) do
    --    outputChatBox ( keyName, 0, 255, 0 )
    --end
end
keysCommand("voiceptt")

addEventHandler("onClientPlayerVoiceStart",root,function()
	setElementData(source, "voicing", true)
	if source == getLocalPlayer() and sending == 0 then
  	--triggerServerEvent ( "pssst", resourceRoot, getLocalPlayer() )
		sending = 1
		setElementData(getLocalPlayer(), "voice:speak", true)
	end
end)

addEventHandler("onClientPlayerVoiceStop",root,function()
	setElementData(source, "voicing", false)
	if source == getLocalPlayer() and sending == 1 then
		sending = 0
		setElementData(getLocalPlayer(), "voice:speak", false)
	end
end)

addEventHandler("onClientElementStreamOut", root,
    function ()
        if source:getType() == "player" then
        --    triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
        --    setSoundPan(source, 0)
        --    setSoundVolume(source, 0)
        end
    end
)

addEventHandler("onClientResourceStart", resourceRoot,
    function ()
    --    triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true)) -- request server to start broadcasting voice data once the resource is loaded (to prevent receiving voice data while this script is still downloading)
    end
, false)

-- Only remove the following lines if you provide credit another way like through an F1 panel or something.
addCommandHandler("sver",
    function ()
        outputConsole("[VOICE] Server is running (modified) proximity-voice by Addlibs. Licensed under https://creativecommons.org/licenses/by/4.0/")
    end
)
