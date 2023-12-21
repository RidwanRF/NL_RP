




local generatedCount = 0

local server_weathers = {
	["Los Santos"] = 0,
	["San Fierro"] = 0,
	["Red County"] = 0,
	["Flint County"] = 0,
	["Whetstone"] = 0,
}

local server_celsius = {
	["Los Santos"] = 0,
	["San Fierro"] = 0,
	["Red County"] = 0,
	["Flint County"] = 0,
	["Whetstone"] = 0,
}


addEventHandler("onResourceStart",resourceRoot,
	function()
		generateWeathers()
		setTimer( function()
			generateWeathers()
		end,(60*1000)*80,0)
	end
)

function generateWeathers()
	generatedCount = generatedCount + 1
	for k,v in pairs(server_weathers) do
		local random = math.random(1,#avaible_weathers)
		server_weathers[k] = avaible_weathers[random].id
		server_celsius[k] = avaible_weathers[random].celius + math.random(-200,200)/100 + hourPrecentages[getRealTime().hour]
	end
	if generatedCount > 1 then
		for _,player in ipairs(getElementsByType("player")) do
			if getElementData(player,"loggedIn") then
				local zone = getZoneName(Vector3(getElementPosition(player)),true)
				if server_weathers[zone] then
					outputChatBox("#b7ff00[Időjárás]:#ffffff Jelenleg #66ff66" .. getWeatherTextByID(server_weathers[zone]) .. "#ffffff idő van #66ff66" .. zone .. "#ffffff környékén! #66ff66(" .. server_weathers[zone] .. "°)",player,0,0,0,true)
					triggerClientEvent(player,"changeWeather",player,server_weathers[zone],server_celsius[zone])
				end
			end
		end
	end
end

addEvent("getServerWeather",true)
addEventHandler("getServerWeather",resourceRoot,
	function(player,zone)
		if player and zone then
			if getElementData(player,"loggedIn") then
				if server_weathers[zone] then
					triggerClientEvent(player,"changeWeather",player,server_weathers[zone],server_celsius[zone])
				end
			end
		end
	end
)

addCommandHandler("setweather",
	function(player,cmd,id)
		if getElementData(player,"acc.adminLevel") >= 7 then
			if id then
				if tonumber(id) then
					id = tonumber(id)
					if id >= 0 and id <= 175 then
						local x,y,z = getElementPosition(player)
						local zone = getZoneName(x,y,z,true)
						if server_weathers[zone] then
							server_weathers[zone] = id

							outputChatBox("#b7ff00[NextLevel]#ffffff Sikeresen beállítottad az időjárást #66ff66'" .. zone .. "'#ffffff környékén! #66ff66(ID: " .. id .. ")",player,0,0,0,true)
							--exports.reach_admins:sendMessageToAdmins("#66ff66" .. getElementData(player,"reach->account->adminName") .. "#ffffff beállította az időjárást #66ff66'" .. zone .. "'#ffffff környékén! #66ff66(ID: " .. id .. ")")
						
							for k,v in ipairs(getElementsByType("player")) do
								local pzone = getZoneName(Vector3(getElementPosition(v)),true)
								if pzone == zone then
									triggerClientEvent(v,"changeWeather",v,server_weathers[zone],server_celsius[zone])
								end
							end
						else
							outputChatBox("#b7ff00[NextLevel]#ffffff Ezen a helyen nem tudsz #66ff66időjárást#ffffff állítani!",player,0,0,0,true)
						end
					else
						outputChatBox("#b7ff00[NextLevel]#ffffff Hibás #66ff66időjárás#ffffff ID lett megadva!",player,0,0,0,true)
					end
				else
					outputChatBox("#b7ff00[NextLevel]#ffffff Hibás #66ff66időjárás#ffffff ID lett megadva!",player,0,0,0,true)
				end
			else
				outputChatBox("#b7ff00[NextLevel]#ffffff /" .. cmd .. " [ID]",player,0,0,0,true)
			end
		else
			outputChatBox("#b7ff00[NextLevel]#ffffff Nincs #66ff66jogosultságod#ffffff a parancs használatához! #66ff66(/" .. cmd .. ")",player,0,0,0,true)
		end
	end
)