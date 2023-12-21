



-- PIROS = 214,76,69 #d64c45
-- SÁRGA = 214,175,66 #d6af42
-- ZÖLD = 116,179,71 #74b347
-- KÉK = 84,144,196 #5490c4

avaible_weathers = {
	{id=0,text="erősen napsütéses, meleg",celius=33},
	{id=1,text="erősen napsütéses, meleg",celius=30},
	{id=2,text="derült, meleg",celius=26},
	{id=3,text="derült, meleg",celius=30},
	{id=4,text="felhős, hűvös",celius=18},
	{id=5,text="napsütéses, meleg",celius=29},
	{id=6,text="napsütéses, meleg",celius=28},
	{id=7,text="felhős, hűvös",celius=17},
	{id=13,text="napsütéses, meleg",celius=29},
	{id=14,text="napsütéses, meleg",celius=31},
	--{id=15,text="felhős, hűvös",celius=19},
	--{id=16,text="esős, viharos",celius=16},
	--{id=8,text="esős, viharos",celius=15},
	{--id=9,text="ködös, hűvös",celius=21},
}

hourPrecentages = {
	[0] = -5.9,
	[1] = -6.1,
	[2] = -6.2,
	[3] = -6.6,
	[4] = -6.8,
	[5] = -6.9,
	[6] = -7.1,
	[7] = -3.9,
	[8] = -2.5,
	[9] = -0.8,
	[10] = 0.9,
	[11] = 1.5,
	[12] = 1.7,
	[13] = 1.9,
	[14] = 2.1,
	[15] = 1.8,
	[16] = 1.5,
	[17] = 1.4,
	[18] = 0.6,
	[19] = -0.4,
	[20] = -1.3,
	[21] = -2.9,
	[22] = -4.8,
	[23] = -5.7,
}

weathers = {
	["Los Santos"] = true,
	["San Fierro"] = true,
	["Red County"] = true,
	["Flint County"] = true,
	["Whetstone"] = true,
}

function getWeatherTextByID(weatherID)
	local text = false
	for k,v in ipairs(avaible_weathers) do
		if v.id == weatherID then
			text = v.text
			break
		end
	end
	return text
end






function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end