
function detainPlayer(vehicle, player)
	if vehicle and player then
		if getVehicleOccupant(vehicle, 2) and getVehicleOccupant(vehicle, 3) then
			exports.nlrp_alert:showAlert("error", "A járműben nincs már hely szabad hely", source)
			return   
		end

		local targetSeat = 2
		if getVehicleOccupant(vehicle, 2) then
			targetSeat = 3
		end

		warpPedIntoVehicle(player, vehicle, targetSeat)

		setElementData(player, "player.seatBelt", true)
	end
end
addEvent("nlrp_detainS:detainPlayer", true)
addEventHandler("nlrp_detainS:detainPlayer", root, detainPlayer)

function removePlayerFromVehicle(player, cmd, target)
	if not target then
		outputChatBox(exports.nlrp_core:getServerTag("usage") .. "/" .. cmd .. " [Játékos ID]", player, 0, 0, 0, true)
	else
		if not isPedInVehicle(player) then
			local targetPlayer, targetPlayerName = exports.nlrp_core:findPlayer(thePlayer, target)
			if exports.nlrp_core:inDistance3D(player, targetPlayer, 4) then
				if targetPlayer ~= player then
					if isPedInVehicle(targetPlayer) then
						setElementData(targetPlayer, "player.seatBelt", false)

						removePedFromVehicle(targetPlayer)

						local x, y, z = getElementPosition(player)

						setElementPosition(targetPlayer, x, y, z)
						
						exports.nlrp_chat:sendLocalMeAction(player, "kiszedett valakit a járműből.")
					else
						exports.nlrp_alert:showAlert(player, "error", "A játékos nincs jármúben")
					end
				else
					exports.nlrp_alert:showAlert(player, "error", "Magadat nem szedheted ki")
				end
			else
				exports.nlrp_alert:showAlert(player, "error", "A játékos túl messze van")
			end
		else
			exports.nlrp_alert:showAlert(player, "error", "Járműben ülve nem szedheted ki")
		end
	end
end
addCommandHandler("kiszed", removePlayerFromVehicle)