addEvent("fallAnimByBulletDamage", true)
addEventHandler("fallAnimByBulletDamage", getRootElement(),
	function ()
		if isElement(source) then
			setPedAnimation(source, "PED", "FALL_collapse", 2000, false, true, true, false)
		end
	end
)

exports.nlrp_admin:addAdminCommand("afelsegit", 1, "Játékos felsegítése a halálból")
addCommandHandler("asegit",
	function (localPlayer, cmd, target)
		if getElementData(localPlayer, "acc.adminLevel") >= 1 then
			if not target then
				outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [Játékos név / ID]", localPlayer, 0, 0, 0, true)
			else
				local targetPlayer, targetPlayerName = exports.nlrp_core:findPlayer(localPlayer, target)

				if targetPlayer then
					if getElementHealth(targetPlayer) <= 20 or isPedDead(targetPlayer) then
						local playerPosX, playerPosY, playerPosZ = getElementPosition(targetPlayer)
						local playerInterior = getElementInterior(targetPlayer)
						local playerDimension = getElementDimension(targetPlayer)
						local playerSkin = getElementModel(targetPlayer)

						spawnPlayer(targetPlayer, playerPosX, playerPosY, playerPosZ, getPedRotation(targetPlayer), playerSkin, playerInterior, playerDimension)
						healPlayer(targetPlayer)
						setPedAnimation(targetPlayer)
						setCameraTarget(targetPlayer, targetPlayer)
						setElementData(targetPlayer, "char.Hunger", 100)
						setElementData(targetPlayer, "char.Thirst", 100)

						outputChatBox(exports.nlrp_core:getServerTag("admin") .. "Sikeresen felsegítetted #32b3ef" .. targetPlayerName .. " #ffffffjátékost.", localPlayer, 0, 0, 0, true)
						outputChatBox(exports.nlrp_core:getServerTag("admin") .. "#32b3ef" .. (getElementData(localPlayer, "acc.adminNick") or "Admin") .. " #fffffffelsegített téged.", targetPlayer, 0, 0, 0, true)
					else
						outputChatBox(exports.nlrp_core:getServerTag("admin") .. "A kiválasztott játékos nem ájult és/vagy nincs meghalva.", localPlayer, 0, 0, 0, true)
					end
				end
			end
		end
	end
)

exports.nlrp_admin:addAdminCommand("agyogyit", 1, "Játékos meggyógyítása")
addCommandHandler("agyogyit",
	function (localPlayer, cmd, target)
		if getElementData(localPlayer, "acc.adminLevel") >= 1 then
			if not target then
				outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [Játékos név / ID]", localPlayer, 0, 0, 0, true)
			else
				local targetPlayer, targetPlayerName = exports.nlrp_core:findPlayer(localPlayer, target)

				if targetPlayer then
					if isPedDead(targetPlayer) then
						outputChatBox(exports.nlrp_core:getServerTag("admin") .. "A kiválasztott játékos halott! A felélesztéshez használd az #ffa600/afelsegit #ffffffparancsot.", localPlayer, 0, 0, 0, true)
					else
						setElementData(targetPlayer, "char.Hunger", 100)
						setElementData(targetPlayer, "char.Thirst", 100)
						healPlayer(targetPlayer)
						setPedAnimation(targetPlayer)
						setCameraTarget(targetPlayer, targetPlayer)

						outputChatBox(exports.nlrp_core:getServerTag("admin") .. "Sikeresen meggyógyítottad #32b3ef" .. targetPlayerName .. " #ffffffjátékost.", localPlayer, 0, 0, 0, true)
						outputChatBox(exports.nlrp_core:getServerTag("admin") .. "#32b3ef" .. (getElementData(localPlayer, "acc.adminNick") or "Admin") .. " #ffffffmeggyógyított téged.", targetPlayer, 0, 0, 0, true)
					end
				end
			end
		end
	end
)

function healPlayer(playerElement)
	if isElement(playerElement) then
		setElementHealth(playerElement, 100)
		setElementData(playerElement, "isPlayerDeath", false)
		setElementData(playerElement, "bulletDamages", false)
		--setElementData(playerElement, "boneDamages", false)
		setElementData(playerElement, "bloodLevel", 100)
		setElementData(playerElement, "deathReason", false)
		setElementData(playerElement, "customDeath", false)
	end
end

addEvent("reSpawnInJail", true)
addEventHandler("reSpawnInJail", getRootElement(),
	function ()
		if isElement(source) then
			local adminJail = getElementData(source, "acc.adminJailTime") or 0
			local inJail = getElementData(source, "char.arrested")
			setElementData(source, "char.Hunger", 100)
			setElementData(source, "char.Thirst", 100)

			if adminJail > 0 then
				triggerEvent("movePlayerBackToAdminJail", source)
			elseif inJail then
				triggerEvent("movePlayerBackToJail", source)
			end

			healPlayer(source)
			setPedAnimation(source)
		end
	end
)

local moneyTakePrecent = 1 -- '1= 100%' fele = 0.50 az pénzt vesz el halálkor..
addEvent("takeMoneyPrecentOnDeath",true)
addEventHandler("takeMoneyPrecentOnDeath",resourceRoot,
	function(player)
		if player then
			local money = getElementData(player,"char.Money")
			moneyPrecent = money*moneyTakePrecent
			setElementData(player,"char.Money",money-moneyPrecent)
		end
	end
)

addEvent("spawnToHospital", true)
addEventHandler("spawnToHospital", getRootElement(),
	function ()
		if isElement(source) then
			local playerSkin = getElementModel(source)

			spawnPlayer(source, 1187.8898925781, -1340.1527099609, 13.5703125, 90, playerSkin, 0, 0)
			healPlayer(source)
			setElementData(source, "char.Hunger", 100)
			setElementData(source, "char.Thirst", 100)
			setPedAnimation(source)
			setCameraTarget(source, source)
		end
	end
)

addEvent("killPlayerAnimTimer", true)
addEventHandler("killPlayerAnimTimer", getRootElement(),
	function ()
		if isElement(source) then
			local playerId = getElementData(source, "playerID")

			setElementHealth(source, 0)
			setPedAnimation(source)
		end
	end
)

addEvent("bringBackInjureAnim", true)
addEventHandler("bringBackInjureAnim", getRootElement(),
	function (state)
		if isElement(source) then
			if state then
				setPedAnimation(source)
			elseif isPedInVehicle(source) then
				setPedAnimation(source, "ped", "car_dead_lhs", -1, false, false, false)
			else
				setPedAnimation(source, "wuzi", "cs_dead_guy", -1, false, false, false)
			end
		end
	end
)

