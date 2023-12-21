function healFunction(sourcePlayer, commandName, targetPlayer)
	if exports.nlrp_groups:isPlayerHavePermission(sourcePlayer, "heal") then
		if not targetPlayer then
			outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. commandName .. " [Játékos név / ID]", sourcePlayer, 0, 0, 0, true)
		else
			targetPlayer, targetName = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)
      if targetPlayer then
        x, y, z = getElementPosition(sourcePlayer)
        x1, y1, z1 = getElementPosition(targetPlayer)
        distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1)
        if distance < 2 then
          if isPedDead(targetPlayer) then
            outputChatBox("#ffffffA kiválasztott játékos halott! A felélesztéshez használd az #ffa600/ujraeleszt #ffffffparancsot.", sourcePlayer, 0, 0, 0, true)
          else
            healPlayer(targetPlayer)
            setPedAnimation(targetPlayer)
            setCameraTarget(targetPlayer, targetPlayer)
			setElementData(targetPlayer, "char.Hunger", 100)
			setElementData(targetPlayer, "char.Thirst", 100)
			local money = getElementData(targetPlayer,"char.Money")
			setElementData(targetPlayer,"char.Money",money-20000)

			local playerGroups = exports.nlrp_groups:getPlayerGroups(sourcePlayer)
			for factionID,_ in pairs(playerGroups) do
				exports.nlrp_groups:setGroupMoney(tonumber(factionID),20000)
			end

            outputChatBox("#ffffffSikeresen meggyógyítottad #32b3ef"..targetName.." #ffffffjátékost.", sourcePlayer, 0, 0, 0, true)
          end
        else
          outputChatBox("#ffffffMenj közelebb a játékoshoz.", sourcePlayer, 0, 0, 0, true)
        end
      end
		end
	end
end
addCommandHandler("heal", healFunction)
addCommandHandler("gyogyit", healFunction)

function reviewFunction(sourcePlayer, commandName, targetPlayer)
	if exports.nlrp_groups:isPlayerHavePermission(sourcePlayer, "reanimation") then
		if not targetPlayer then
			outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. commandName .. " [Játékos név / ID]", sourcePlayer, 0, 0, 0, true)
		else
			targetPlayer, targetName = exports.nlrp_core:findPlayer(sourcePlayer, targetPlayer)

      if targetPlayer then
        x, y, z = getElementPosition(sourcePlayer)
        x1, y1, z1 = getElementPosition(targetPlayer)
        distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1)
        if distance < 2 then
			if not isPedHeadless( targetPlayer ) then
				if getElementHealth(targetPlayer) <= 20 or isPedDead(targetPlayer) then
					local playerPosX, playerPosY, playerPosZ = getElementPosition(targetPlayer)
					local playerInterior = getElementInterior(targetPlayer)
					local playerDimension = getElementDimension(targetPlayer)
					local playerSkin = getElementModel(targetPlayer)

					spawnPlayer(targetPlayer, playerPosX, playerPosY, playerPosZ, getPedRotation(targetPlayer), playerSkin, playerInterior, playerDimension)
					healPlayer(targetPlayer)
					setElementData(targetPlayer, "char.Hunger", 100)
					setElementData(targetPlayer, "char.Thirst", 100)
					setPedAnimation(targetPlayer)
					setCameraTarget(targetPlayer, targetPlayer)

					outputChatBox("#ffffffSikeresen felsegítetted #32b3ef" .. targetName .. " #ffffffjátékost.", sourcePlayer, 0, 0, 0, true)
				else
					outputChatBox("#ffffffA kiválasztott játékos nem ájult és/vagy nincs meghalva.", sourcePlayer, 0, 0, 0, true)
				end
			else
				outputChatBox("#ffffffNincs feje, hogy akarod te így újra éleszteni???", sourcePlayer, 0, 0, 0, true)
			end
        else
          outputChatBox("#ffffffMenj közelebb a játékoshoz.", sourcePlayer, 0, 0, 0, true)
        end
      end
		end
	end
end
addCommandHandler("review", reviewFunction)
addCommandHandler("ujraeleszt", reviewFunction)

function healPlayer(playerElement)
	if isElement(playerElement) then
		setElementHealth(playerElement, 100)
		setElementData(playerElement, "isPlayerDeath", false)
		setElementData(playerElement, "bulletDamages", false)
		--setElementData(playerElement, "boneDamages", false)
		setElementData(playerElement, "bloodLevel", 100)
		setElementData(playerElement, "deathReason", false)
		setElementData(playerElement, "customDeath", false)
		setElementData(playerElement, "usingBandage", false)
	end
end
