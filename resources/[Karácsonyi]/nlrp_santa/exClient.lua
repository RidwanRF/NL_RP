local peds = {
	{1478.8001708984, -1667.8500976563, 14.553, "Télapó"},
}

local createdPeds = {}

local moneyAmounts = {1000, 2000, 5000}

local timers = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
	for key, value in ipairs(peds) do
		local skin = 195
		if key == 4 then
			skin = 195
		end

		createdPeds[key] = createPed(skin, value[1], value[2], value[3], math.random(0, 360))

		setElementFrozen(createdPeds[key], true)

		setElementData(createdPeds[key], "ped:name", value[4])
		setElementData(createdPeds[key], "name:tags", "Karácsony NPC")
		setElementData(createdPeds[key], "ped->CanTalk", true)
		setElementData(createdPeds[key], "ped->Number", key)
	end

	for key, value in ipairs(getElementsByType("ped")) do
		setElementData(value, "ped->CanTalk", true) -- előbb buggoltak a gecik
	end
end)

addEventHandler("onClientClick", root, function(key, state, _, _, _, _, _, element)
	if key == "right" and state == "down" and element and isElement(element) and getElementData(element, "name:tags") or "" == "Karácsony NPC" then
		local x, y, z = getElementPosition(localPlayer)
		local x2, y2, z2 = getElementPosition(element)

		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 10 then	
			local ped = element
				
			local canTalk = false
			for key, value in ipairs(createdPeds) do
				if ped == value then
					canTalk = true
				end
			end

			if not canTalk then return end -- biztonság kedvéért még 1x ellenőrizzük ezt a szart hogy drogos npc stb ne tiltsa

			if getElementData(ped, "ped->CanTalk") then
				setElementData(ped, "ped->CanTalk", false)
				timers[getElementData(ped, "ped->Number")] = setTimer(canPedTalk, 1000*60*60*24, 1, ped)

				local give = 1
				if give == 1 then
					local random1 = math.random(0, 50)

					if random1 then
						triggerServerEvent("ped->GiveItem", localPlayer, localPlayer)
						outputChatBox("#b7ff00[NextLevel] #e74c3cMikulás #ffffffadott neked egy ajándékot.", 0, 0, 0, true)
					end
				else
					outputChatBox("#b7ff00[NextLevel] #e74c3cMikulás #ffffffnem adott most semmit.", 0, 0, 0, true)	
				end
			else
				outputChatBox("#b7ff00[NextLevel] #e74c3cMikulás #ffffffjelenleg nem ér rá. Gyere vissza később.", 0, 0, 0, true)
			end
		end
	end
end)

function canPedTalk(ped)
	setElementData(ped, "ped->CanTalk", true)
end