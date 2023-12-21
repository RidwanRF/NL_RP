local con = exports.nlrp_connection:getConnection()



function yunkDeleteVehicle(player, veh, cost)

	if isElement(player) and isElement(veh) and (cost) then

		if getElementData(player, "loggedin") then

			local vehid = tonumber(getElementData(veh, "veh:id"))

			local result = dbPoll(dbQuery(con, "DELETE FROM vehicle WHERE id='" .. vehid .. "'"), -1)

			if result then

				if getElementData(veh, "veh:id") == vehid and getElementData(player, "acc:id") == getElementData(veh, "veh:owner") or getElementData(player, "acc:admin") >= 7 then

					

					destroyElement(veh)

					exports.nlrp_admin:outputAdminMessage(getPlayerName(player) .. " #ffffffjárműve bezúzatva. (ID: #d7a360" .. vehid .. "#ffffff)")

					

					setTimer( function()

						setElementData(player, "char:money", getElementData(player, "char:money")+cost)

						dbExec(con, "UPDATE characters SET money='" .. getElementData(player, "char:money") .. "' WHERE account='" .. getElementData(player, "acc:id") .. "'")

						return

					end, 200, 1)

					return

				end

			end

		end

	end

end

addEvent("junk:deleteVehicle", true)

addEventHandler("junk:deleteVehicle", root, yunkDeleteVehicle)