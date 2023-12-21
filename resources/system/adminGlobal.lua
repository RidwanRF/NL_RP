

function getAdmins()
	local players = exports.sas_system:getpoolElementsByType("player")
	local admins = { }
	local count = 1
	for key, value in ipairs(players) do
		if isPlayerAdmin(value) and getPlayerAdminLevel(value) <= 100 then
			admins[count] = value
			count = count + 1
		end
	end
	return admins
end

function isPlayerAdminduty(thePlayer)
	return getElementData(thePlayer, "adminduty") or false
end

function isPlayerAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 1
end

function isEgyesAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 1
end

function isKettesAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 2
end

function isHarmasAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 3
end

function isNegyesAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 4
end

function isOtosAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 5
end

function isFoAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 6
end

function isSuperAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 7
end

function isTulajdonos(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 8
end

function isDeveloper(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 9
end

function isSysAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 10
end

function getPlayerAdminLevel(thePlayer)
	return isElement( thePlayer ) and tonumber(getElementData(thePlayer, "adminlevel")) or 0
end

local titles = { "Admin Segéd", "1-es Admin", "2-es Admin", "3-as Admin", "Fõ Admin", "Szuper Admin", "Tulajdonos", "Scripter", "VezérScripter"}
function getPlayerAdminTitle(thePlayer)
	local text = titles[getPlayerAdminLevel(thePlayer)] or " "
	--local ideiglenes = getElementData(thePlayer, "ideiglenes") or 0

	--if (ideiglenes==1) then
	--    text = "Ideiglenes " .. text
	--end

	return text
end

function getAccurateAdminTitle(thePlayer)
	local text = titles[getPlayerAdminLevel(thePlayer)] or " "
	--local ideiglenes = getElementData(thePlayer, "ideiglenes") or 0

	--if (ideiglenes==1) then
	--    text = "Ideiglenes " .. text
	--end

	return text
end

function isPlayerScripter(thePlayer)
	return isScripter(thePlayer)
end