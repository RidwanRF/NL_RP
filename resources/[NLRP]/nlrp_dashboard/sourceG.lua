


panels = {
	{id=1,text="Áttekintés"},
	{id=2,text="Vagyon"},
	{id=3,text="Támogatás"},
	{id=4,text="Prémium Shop"},
	{id=5,text="Beállítások"},
}

donate_panels = {"Csomagok","Paypal","SMS"}
--// Első oldalon lévő pack-ok
donate_packs = {
	{name="#B7ff00NL PACK #1",image="images/donate/nlpack1.png"},
	{name="#fffa75NL PACK #2",image="images/donate/nlpack2.png"},
	{name="#e06666NL PACK #3",image="images/donate/nlpack3.png"},
	{name="#ab66e0NL PACK #4",image="images/donate/nlpack4.png"},
	{name="EGYEBEK",image="images/donate/others.png"},
}

walkstyles = {
	[1] = {text="Séta #1",data=0},
	[2] = {text="Séta #2",data=54},
	[3] = {text="Séta #3",data=118},
	[4] = {text="Séta #4",data=55},
	[5] = {text="Séta #5",data=124},
	[6] = {text="Séta #6",data=123},
	[7] = {text="Séta #7",data=56},
	[8] = {text="Séta #8",data=121},
	[9] = {text="Séta #9",data=122},
	[10] = {text="Séta #10",data=129},
	[11] = {text="Séta #11",data=131},
	[12] = {text="Séta #12",data=132},
}

fights = {
	[1] = {text="Harc stílus #1",data=4},
	[2] = {text="Harc stílus #2",data=5},
	[3] = {text="Harc stílus #3",data=6},
	[4] = {text="Harc stílus #4",data=7},
	[5] = {text="Harc stílus #5",data=15},
	[6] = {text="Harc stílus #6",data=16},
}

crosshairs = {1,2,3,4,5,6,7,8,9}

bindableKeys = {
	["radio"] = {
		["V"] = true,["P"] = true,["O"] = true,["Z"] = true,
	},
	--[[
	["voice"] = {
		["V"] = true,["P"] = true,["O"] = true,["Z"] = true,
	}, ]]--
}

shopCategorys = {
	[0] = {name="Kategóriák"},
	[1] = {name="Fegyverek",
		items = {
			{id=233,count=1,price=26000}, -- Arany
			{id=232,count=1,price=26000}, -- Goldwood
			{id=239,count=1,price=24000}, -- Blaze 
			{id=234,count=1,price=22000}, -- Colorful
			{id=235,count=1,price=20000}, -- Ruby
			{id=238,count=1,price=18000}, -- Galxy
			{id=237,count=1,price=16000}, -- Redcamo
			{id=236,count=1,price=12000}, -- Winter
		
		
			{id=183,count=1,price=20000}, -- Gold AK
			{id=188,count=1,price=18000}, -- Ruby
			{id=187,count=1,price=16000}, -- Galaxy
			{id=185,count=1,price=14000}, -- Fade
			{id=189,count=1,price=12500}, -- Red Camo
			{id=186,count=1,price=11000}, -- Pinky
			{id=182,count=1,price=9000}, -- Bright Water
			{id=180,count=1,price=7000}, -- Shadow
			{id=181,count=1,price=5500}, -- Camo
			{id=184,count=1,price=4500}, -- Rusty
			
			
			{id=191,count=1,price=20000}, -- Gold M4
			{id=195,count=1,price=18000}, -- Galaxy 
			{id=194,count=1,price=16000}, -- Red Camo 
			{id=196,count=1,price=14000}, -- Bright 
			{id=193,count=1,price=12000}, --  Winter
			{id=192,count=1,price=10000}, -- Pink
			{id=190,count=1,price=5000}, -- Camo
			
			
			{id=198,count=1,price=20000}, -- Gold MPX
			{id=207,count=1,price=18000}, -- Colorful
			{id=206,count=1,price=17000}, -- Ruby
			{id=202,count=1,price=16000}, -- Galaxy
			{id=204,count=1,price=14000}, -- Red Camo
			{id=199,count=1,price=12000}, -- Bright Water 
			{id=205,count=1,price=9000}, -- Pink
			{id=203,count=1,price=7000}, -- Winter
			{id=201,count=1,price=6000}, -- Next
			{id=200,count=1,price=5000}, -- Carbon
			{id=197,count=1,price=4000}, -- Camo 
			
			
			{id=208,count=1,price=20000}, -- Gold USP-s 
			{id=212,count=1,price=18000}, -- Galaxy 
			{id=210,count=1,price=14000}, -- Red Camo
			{id=211,count=1,price=13000}, -- Pinky
			{id=213,count=1,price=10000}, -- Bright
		--	{id=214,count=1,price=7000}, -- Winter
			{id=209,count=1,price=3000}, -- Camo
			
			
			{id=215,count=1,price=20000}, -- Gold Deagle
			{id=222,count=1,price=18000}, --  Colorful
			{id=221,count=1,price=15000}, -- Ruby
			{id=220,count=1,price=13000}, -- Galaxy
			{id=219,count=1,price=12000}, -- Red Camo
			{id=217,count=1,price=11000}, -- Pinky
			{id=218,count=1,price=6000}, -- Bright
			{id=216,count=1,price=3500}, -- Camo
			
			
			{id=223,count=1,price=20000}, -- Arany Lefűrészelt csövű
			{id=228,count=1,price=18000}, -- Colorful
			{id=227,count=1,price=16000}, -- Ruby
			{id=229,count=1,price=13000}, -- Galaxy
			{id=224,count=1,price=12000}, -- Red Camo
			{id=226,count=1,price=11000}, -- Pinky
			{id=230,count=1,price=10000}, -- Bright
			{id=231,count=1,price=5000}, -- Winter
			{id=225,count=1,price=4000}, -- Camo
			
			
			
		},
	},
	[2] = {name="Lőszerek",
		items = {
			{id=3,count=50,price=500}, --9mm
			{id=4,count=50,price=700}, --kisgép
			{id=8,count=50,price=1000}, -- Sörétes
			{id=5,count=30,price=1000}, --Ak
			{id=6,count=30,price=1000}, --M4
			{id=7,count=10,price=2000}, -- Sniper töli


		},
	},
	[3]	 = {name="Egyéb",
		items = {
			{id=385,count=1,price=250}, -- Névcédula
			{id=386,count=1,price=750}, -- Fegyver javító
			
			{id=389,count=1,price=250}, -- Fix Kártya
			{id=391,count=1,price=250}, -- Heal Kártya
			{id=392,count=1,price=250}, -- Armor kártya
			{id=390,count=1,price=250}, -- Unflip

		},
	},
	[4] = {name="Szezonális Itemek",
		items = {
		
			--[[{id=250,count=1,price=20000}, -- AK Frosty
			{id=241,count=1,price=18000}, -- AK BlackIce
			{id=245,count=1,price=14000}, -- AK IceCave
			{id=248,count=1,price=12500}, -- AK SnowFlake
			{id=252,count=1,price=10500}, -- AK Icy
			{id=246,count=1,price=9000}, -- AK Glacier
			{id=242,count=1,price=8500}, -- AK Candies
			{id=244,count=1,price=7000}, -- AK CandyCane
			{id=249,count=1,price=6000}, -- AK DarkSnowFlake
			{id=251,count=1,price=5500}, -- AK Santa
			{id=243,count=1,price=5500}, -- AK Red Candies
			{id=247,count=1,price=5000}, -- AK Xmas
		
		
			{id=259,count=1,price=20000}, --M4 Frosty
			{id=253,count=1,price=18000}, -- M4 Black Ice
			{id=260,count=1,price=16000}, -- M4 Icy
			{id=298,count=1,price=14000}, -- M4 Emerald Flake
			{id=257,count=1,price=12500}, -- M4 SnowFlake
			{id=255,count=1,price=10500}, --  M4 IceCave
			{id=256,count=1,price=9000}, -- M4 Glacier
			{id=254,count=1,price=8500}, -- M4 Candies
			{id=258,count=1,price=7000}, --M4 DarkSnowFlake
			{id=297,count=1,price=5000}, -- M4 SnowDots
			
			
			{id=270,count=1,price=20000}, -- MPX Frosty
			{id=261,count=1,price=18000}, -- MPX Black Ice
			{id=268,count=1,price=14000}, -- MPX SnowFlake
			{id=272,count=1,price=12000}, -- MPX Icy
			{id=271,count=1,price=11000}, -- MPX Emerald Flake
			{id=265,count=1,price=10500}, -- MPX IceCave
			{id=266,count=1,price=8500}, --MPX Glacier
			{id=264,count=1,price=7000}, -- MPX CandyCane
			{id=262,count=1,price=6000}, -- MPX Candies
			{id=269,count=1,price=5500}, -- MPX DarkSnowFlake
			{id=267,count=1,price=5000}, --MPX Xmas
			{id=263,count=1,price=5000}, --  MPX SnowDots
			
			
			{id=282,count=1,price=20000}, -- USP Frosty
			{id=273,count=1,price=17500}, -- USP BlackIce
			{id=277,count=1,price=14000}, -- USP IceCave
			{id=284,count=1,price=12000}, -- USP Icy
			{id=276,count=1,price=10500}, -- USP CandyCane
			{id=275,count=1,price=9000}, -- USP RedCandies
			{id=280,count=1,price=8000}, -- USP SnowFlake
			{id=278,count=1,price=8000}, -- USP Glacier
			{id=281,count=1,price=7000}, -- USP DarkSnowFlake
			{id=274,count=1,price=7000}, -- USP Candies
			{id=279,count=1,price=6000}, -- USP Xmas
			{id=283,count=1,price=5000}, -- USP Santa
			
			
			{id=294,count=1,price=20000}, -- Deagle Frosty
			{id=285,count=1,price=18000}, -- Deagle BlackIce
			{id=296,count=1,price=15000}, -- Deagle Icy
			{id=292,count=1,price=12500}, -- Deagle SnowFlake
			{id=289,count=1,price=10500}, -- Deagle IceCave
			{id=290,count=1,price=9500}, -- Deagle Glacier
			{id=293,count=1,price=8500}, -- Deagle DarkSnowFlake
			{id=286,count=1,price=8000}, -- Deagle Candies
			{id=287,count=1,price=7000}, -- Deagle RedCandies
			{id=288,count=1,price=6000}, -- Deagle CandyCane
			{id=295,count=1,price=5500}, -- Deagle Santa
			{id=291,count=1,price=5000}, -- Deagle Xmas
			
			
			{id=306,count=1,price=20000}, -- P250 Frosty
			{id=304,count=1,price=18000}, -- P250 BlackIce
			{id=307,count=1,price=15000}, -- P250 Icy
			{id=308,count=1,price=13000}, -- P250 Snowflake
			{id=305,count=1,price=11000}, -- P250 IceCave
			{id=302,count=1,price=10500}, -- P250 EmeraldFlake
			{id=309,count=1,price=8500}, -- P250 CandyCane
			{id=303,count=1,price=7000}, -- P250 SnowDots --]]

		},
	},
}

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1 '):reverse())..right 
end

function getTuningName(id)
	local text = "#AAAAAAGyári"
	if id == 1 then
		text = "#00FF64Utcai Csomag"
	elseif id == 2 then
		text = "#FF00C1Profi Csomag"
	elseif id == 3 then
		text = "#00FFFFVerseny Csomag"
	elseif id == 4 then
		text = "#FFD700Gear Csomag"
	end
	return text
end

function getAirRideText(state)
	if state then
		return "#FFD700Van"
	else
		return "#AAAAAANincs"
	end
end