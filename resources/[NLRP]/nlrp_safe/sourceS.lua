local connection = exports.nlrp_database:getConnection()

function loadSafes ( )
	dbQuery(
		function (qh)
			local result, rows = dbPoll(qh, 0)
			if rows > 0 then
				for _, row in pairs(result) do
					safe = createObject ( 2332, tonumber(row.PosX), tonumber(row.PosY), tonumber(row.PosZ)-0.5, 0, 0, 0 )
					setElementDimension ( safe, tonumber(row.Dim) )
					setElementInterior ( safe, tonumber(row.Interior),tonumber(row.PosX), tonumber(row.PosY), tonumber(row.PosZ)-0.5 )
					setElementData(safe, "isSafe", true)
					setElementData(safe, "isInteractable", true)
					setElementData(safe, "object.name", "Széf")
					setElementData(safe, "safe.dbID", row.ID)
					setElementData(safe, "safe.Owner", row.Owner)
				end
			end
		end, connection, "SELECT * FROM safes")
end
addEventHandler ( "onResourceStart", resourceRoot, loadSafes )