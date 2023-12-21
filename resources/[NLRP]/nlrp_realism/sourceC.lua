



local lastTick = getTickCount()
local s = {guiGetScreenSize()}

local old_zone = "Unknown"
local now_zone = "Unknown"

local now_celsius = 0

addEventHandler("onClientRender",root,
	function()
		if not isTimer(weatherTimer) then
			local zoneName = getZoneName(Vector3(getElementPosition(localPlayer)),true)
			if zoneName ~= now_zone then
				old_zone = now_zone
				now_zone = zoneName
				if weathers[zoneName] then
					triggerServerEvent("getServerWeather",resourceRoot,localPlayer,zoneName)
				end
			end
		end
	end
)

addEvent("changeWeather",true)
addEventHandler("changeWeather",localPlayer,
	function(weatherID,celsius)
		if not celsius then celsius = 0 end

		setWeather(weatherID)
		now_celsius = celsius
	end
)

local sounds = {}
addEventHandler("onClientResourceStart",resourceRoot,
	function()		
		setMinuteDuration(999999999)
		
		weatherTimer = setTimer( function() end,1000,1)

		setTime(getRealTime().hour,getRealTime().minute)
		setTimer( function()
			--setTime(getRealTime().hour,getRealTime().minute)
		end,5000,0)

		if getElementData(localPlayer,"reach->account->loggedin") then
			local zoneName = getZoneName(Vector3(getElementPosition(localPlayer)),true)
			triggerServerEvent("getServerWeather",resourceRoot,localPlayer,zoneName)
		end
	end
)


addEventHandler("onClientElementDataChange",root,
	function(data,old,new)
		if source == localPlayer then
			if data == "loggedIn" then
				if new then
					local zoneName = getZoneName(Vector3(getElementPosition(localPlayer)),true)
					triggerServerEvent("getServerWeather",resourceRoot,localPlayer,zoneName)
				end
			end
		end
	end
)

function getCelsius()
	return now_celsius
end