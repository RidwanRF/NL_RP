function dli(x,a,b,c)
        if (x==1) then  return a end
        if (x%10>1) and (x%10<5) and (not ((x%100>=10) and (x%100<=21))) then    return b end
        return c
end

function minutesToHours(minutes)
	local totalMin = tonumber(minutes)
	if totalMin then
		local hours = math.floor(totalMin/60)
		local minutes = totalMin - hours*60
		if hours and minutes then
			return hours,minutes
		else
			return 0,0
		end
	end
end

function secondsToMinutes(seconds)
	local totalSec = tonumber(seconds)
	if totalSec then
		local seconds = math.fmod(math.floor(totalSec), 60)
		local minutes = math.fmod(math.floor(totalSec/60), 60)
		if seconds and minutes then
			return seconds,minutes
		end
	end
end

function mathround(number, decimals, method)
    if number then
		decimals = decimals or 0
		local factor = 10 ^ decimals
		if (method == "ceil" or method == "floor") then 
			return math[method](number * factor) / factor
		else 
			return tonumber(("%."..decimals.."f"):format(number)) 
		end
	end
end

function toHex ( n )
    local hexnums = {"0","1","2","3","4","5","6","7",
                     "8","9","A","B","C","D","E","F"}
    local str,r = "",n%16
    if n-r == 0 then 
		str = hexnums[r+1]
    else 
		str = toHex((n-r)/16)..hexnums[r+1] 
	end
    return str
end

function cezar (txt)
	if txt then
		local len = string.len(txt)
		local tab = {}
		for k=1,len do
			table.insert (tab,string.byte(txt,k)+5)
		end
		local newString = toJSON (tab)
		return newString
	end
end

function uncezar (txt)
	if txt then
		local tab = fromJSON (txt)
		if tab then
			local str = ""
			for k,v in ipairs(tab) do
				local n = tonumber(v) - 5
				local char = string.char (n)
				str = str .. char
			end
			return str
		end
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)
 
    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
 
    return x+dx, y+dy;
 
end

function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

local gWeekDays = { "Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat" }
function formatDate(format, escaper, timestamp)
	Check("formatDate", "string", format, "format", {"nil","string"}, escaper, "escaper", {"nil","string"}, timestamp, "timestamp")
 
	escaper = (escaper or "'"):sub(1, 1)
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false
 
	time.year = time.year + 1900
	time.month = time.month + 1
 
	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), w = gWeekDays[time.weekday+1]:sub(1, 2), W = gWeekDays[time.weekday+1], y = tostring(time.year):sub(-2), Y = time.year }
 
	for char in format:gmatch(".") do
		if (char == escaper) then escaped = not escaped
		else formattedDate = formattedDate..(not escaped and datetime[char] or char) end
	end
 
	return formattedDate
end

function getNearestVehicle( player )
    local x, y, z = getElementPosition( player )
    local prevDistance
    local nearestVehicle
    for i, v in ipairs( getElementsByType( "vehicle" ) ) do
        local distance = getDistanceBetweenPoints3D( x, y, z, getElementPosition( v ) )
        if distance <= ( prevDistance or distance + 1 ) then
            prevDistance = distance
            nearestVehicle = v
        end
    end
    return nearestVehicle or false
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end
 
function getTimestamp(year, month, day, hour, minute, second)
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
 
    timestamp = timestamp - 3600
    if datetime.isdst then timestamp = timestamp + 3600 end
 
    return timestamp
end