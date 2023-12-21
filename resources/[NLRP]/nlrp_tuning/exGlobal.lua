availableTuningMarkers = {
	-- x y z cameramatrix (1-6)
	{1714.6075439453, -1769.5726318359, 13.655158996582}, 	{1729.6075439453, -1769.5726318359, 13.655158996582},  	{ -2656.7797851563, -2201.3532714844, 2.765266418457}, 	{ 2653.4948730469, -2075.3283691406, 13.57656288147}, { 1853.5543212891, 912.67742919922, 10.8}, 
}

availableWheelSizes = {
	["front"] = {
		["verynarrow"] = {0x100, 1},
		["narrow"] = {0x200, 2},
		["wide"] = {0x400, 4},
		["verywide"] = {0x800, 5}
	},
	["rear"] = {
		["verynarrow"] = {0x1000, 1},
		["narrow"] = {0x2000, 2},
		["wide"] = {0x4000, 4},
		["verywide"] = {0x8000, 5}
	}
}

tuningMenu = {
	[1] = {
		["categoryName"] = "Teljesítmény",
		
		["subMenu"] = {
			[1] = {
				["categoryName"] = "Motor",
				["upgradeData"] = "engine",
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true},
				["handlingFlags"] = {{"engineAcceleration", 0.6}, {"maxVelocity", 9.5}, {"dragCoeff", -0.05}},

				["subMenu"] = {
					[1] = {["categoryName"] = "Gyári csomag", ["tuningPrice"] = 0, ["priceIgMoney"] = true},
					[2] = {["categoryName"] = "Utcai csomag", ["tuningPrice"] = 2500000 , ["priceIgMoney"] = true},
					[3] = {["categoryName"] = "Profi csomag", ["tuningPrice"] = 5000000 , ["priceIgMoney"] = true},
					[4] = {["categoryName"] = "Verseny csomag", ["tuningPrice"] = 10000000 , ["priceIgMoney"] = true},
					[5] = {["categoryName"] = "Gear csomag", ["tuningPrice"] = 1000  , ["priceIgMoney"] = false}
				}
			},

			[2] = {
				["categoryName"] = "Turbó",
				["upgradeData"] = "turbo",
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true},
				["handlingFlags"] = {{"engineAcceleration", 0.6}},

				["subMenu"] = {
					[1] = {["categoryName"] = "Gyári csomag", ["tuningPrice"] = 0, ["priceIgMoney"] = true},
					[2] = {["categoryName"] = "Utcai csomag", ["tuningPrice"] = 2500000, ["priceIgMoney"] = true},
					[3] = {["categoryName"] = "Profi csomag", ["tuningPrice"] = 5000000, ["priceIgMoney"] = true},
					[4] = {["categoryName"] = "Verseny csomag", ["tuningPrice"] = 10500000, ["priceIgMoney"] = true},
					[5] = {["categoryName"] = "Gear csomag", ["tuningPrice"] =1000, ["priceIgMoney"] = false}
				}
			},

			[3] = {
				["categoryName"] = "Váltó",
				["upgradeData"] = "gearbox",
				["handlingFlags"] = {{"maxVelocity", 6}},

				["subMenu"] = {
					[1] = {["categoryName"] = "Gyári csomag", ["tuningPrice"] = 0, ["priceIgMoney"] = true},
					[2] = {["categoryName"] = "Utcai csomag", ["tuningPrice"] = 250000, ["priceIgMoney"] = true},
					[3] = {["categoryName"] = "Profi csomag", ["tuningPrice"] = 4000000, ["priceIgMoney"] = true},
					[4] = {["categoryName"] = "Verseny csomag", ["tuningPrice"] = 8000000, ["priceIgMoney"] = true},
					[5] = {["categoryName"] = "Gear csomag", ["tuningPrice"] = 1000, ["priceIgMoney"] = false}
				}
			},

			[4] = {
				["categoryName"] = "ECU",
				["upgradeData"] = "ecu",
				["handlingFlags"] = {{"dragCoeff", -0.2}},

				["subMenu"] = {
					[1] = {["categoryName"] = "Gyári csomag", ["tuningPrice"] = 0, ["priceIgMoney"] = true},
					[2] = {["categoryName"] = "Utcai csomag", ["tuningPrice"] = 1750000, ["priceIgMoney"] = true},
					[3] = {["categoryName"] = "Profi csomag", ["tuningPrice"] = 3750000, ["priceIgMoney"] = true},
					[4] = {["categoryName"] = "Verseny csomag", ["tuningPrice"] = 7500000, ["priceIgMoney"] = true},
					[5] = {["categoryName"] = "Gear csomag", ["tuningPrice"] = 1000, ["priceIgMoney"] = false}
				}				
			},


			[5] = {
				["categoryName"] = "Gumik",
				["upgradeData"] = "tires",
				["cameraSettings"] = {"wheel_rb_dummy", 60, 10, 4},
				["handlingFlags"] = {{"tractionMultiplier", 0.05}, {"tractionLoss", 0.02}},

				["subMenu"] = {
					[1] = {["categoryName"] = "Gyári csomag", ["tuningPrice"] = 0, ["priceIgMoney"] = true},
					[2] = {["categoryName"] = "Utcai csomag", ["tuningPrice"] = 1250000, ["priceIgMoney"] = true},
					[3] = {["categoryName"] = "Profi csomag", ["tuningPrice"] = 2500000, ["priceIgMoney"] = true},
					[4] = {["categoryName"] = "Verseny csomag", ["tuningPrice"] = 4000000, ["priceIgMoney"] = true},
					[5] = {["categoryName"] = "Gear csomag", ["tuningPrice"] = 1000, ["priceIgMoney"] = false}
				}
			},

			[6] = {
				["categoryName"] = "Fékek",
				["upgradeData"] = "brakes",
				["handlingFlags"] = {{"brakeDeceleration", 0.02}, {"brakeBias", 0.08}},
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},


				["subMenu"] = {
					[1] = {["categoryName"] = "Gyári csomag", ["tuningPrice"] = 0, ["priceIgMoney"] = true},
					[2] = {["categoryName"] = "Utcai csomag", ["tuningPrice"] = 1250000, ["priceIgMoney"] = true},
					[3] = {["categoryName"] = "Profi csomag", ["tuningPrice"] = 25000000, ["priceIgMoney"] = true},
					[4] = {["categoryName"] = "Verseny csomag", ["tuningPrice"] = 5000000, ["priceIgMoney"] = true},
					[5] = {["categoryName"] = "Gear csomag", ["tuningPrice"] = 1000, ["priceIgMoney"] = false}
				}
			}
		}
	},

	[2] = {
		["categoryName"] = "Optika",
		["availableUpgrades"] = {},
		["subMenu"] = {
			-- default tunings
			[1] = {["categoryName"] = "Első lökhárító", ["upgradeSlot"] = 14, ["tuningPrice"] = 220000, ["cameraSettings"] = {"bump_front_dummy", 130, 10, 6}},
			[2] = {["categoryName"] = "Hátsó lökhárító", ["upgradeSlot"] = 15, ["tuningPrice"] = 220000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[3] = {["categoryName"] = "Motorháztető", ["upgradeSlot"] = 0, ["tuningPrice"] = 180000},
			[4] = {["categoryName"] = "Kipufogó", ["upgradeSlot"] = 13, ["tuningPrice"] = 190000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[5] = {["categoryName"] = "Légterelő", ["upgradeSlot"] = 2, ["tuningPrice"] = 200000, ["cameraSettings"] = {"boot_dummy", -65, 3, 8}},
			[6] = {["categoryName"] = "Kerekek", ["upgradeSlot"] = 12, ["tuningPrice"] = 600000},
			[7] = {["categoryName"] = "Küszöb", ["upgradeSlot"] = 3, ["tuningPrice"] = 55000, ["cameraSettings"] = {"ug_wing_right", 65, 3, 4}},
			[8] = {["categoryName"] = "Tetőlégterelő", ["upgradeSlot"] = 7, ["tuningPrice"] = 38000},
			[9] = {["categoryName"] = "Hidraulika", ["upgradeSlot"] = 9, ["tuningPrice"] = 150000},
	
		}
	},

	[3] = {
		["categoryName"] = "Fényezés",

		["subMenu"] = {
			[1] = {["categoryName"] = "Első szín", ["tuningPrice"] = 1500000},
			[2] = {["categoryName"] = "Második szín", ["tuningPrice"] = 1500000},
			[3] = {["categoryName"] = "Izzó világítás", ["tuningPrice"] = 750000}
		}
	},

	[4] = {
		["categoryName"] = "Extrák",

		["subMenu"] = {
			[1] = {
				["categoryName"] = "Első kerék szélesség",
				["upgradeData"] = "wheelsize_f",

				["subMenu"] = {
					[1] = {["categoryName"] = "Extra keskeny", ["tuningPrice"] = 5000, ["priceIgMoney"] = true, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = "Keskeny", ["tuningPrice"] = 15000, ["priceIgMoney"] = true, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = "Normál", ["tuningPrice"] = 0, ["priceIgMoney"] = true, ["tuningData"] = "default"},
					[4] = {["categoryName"] = "Széles", ["tuningPrice"] = 20000, ["priceIgMoney"] = true, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = "Extra széles", ["tuningPrice"] = 400000, ["priceIgMoney"] = true, ["tuningData"] = "verywide"}
				}
			},

			[2] = {
				["categoryName"] = "Hátsó kerék szélesség",
				["upgradeData"] = "wheelsize_r",

				["subMenu"] = {
					[1] = {["categoryName"] = "Extra keskeny", ["tuningPrice"] = 5000, ["priceIgMoney"] = true, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = "Keskeny", ["tuningPrice"] = 15000, ["priceIgMoney"] = true, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = "Normál", ["tuningPrice"] = 200, ["priceIgMoney"] = true, ["tuningData"] = "default"},
					[4] = {["categoryName"] = "Széles", ["tuningPrice"] = 20000, ["priceIgMoney"] = true, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = "Extra széles", ["tuningPrice"] = 400000, ["priceIgMoney"] = true, ["tuningData"] = "verywide"}
				}
			},

			[3] = {
				["categoryName"] = "LSD ajtó",
				["subMenu"] = {
					[1] = {["categoryName"] = "Kiszerelés", ["tuningPrice"] = 0, ["priceIgMoney"] = true, ["tuningData"] = false},
					[2] = {["categoryName"] = "Felszerelés", ["tuningPrice"] = 150000, ["priceIgMoney"] = false, ["tuningData"] = true}
				}
			},	

			[4] = {
				["categoryName"] = "Paintjob",
				["upgradeData"] = "paintjob", 

				["subMenu"] = {}
			},				
			
			[5] = {
				["categoryName"] = "Air-Ride",
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeSlot"] = 17,
				["subMenu"] = {
					[1] = {["categoryName"] = "Kiszerelés", ["tuningPrice"] = 0, ["priceIgMoney"] = true, ["tuningData"] = false},
					[2] = {["categoryName"] = "Felszerelés", ["tuningPrice"] = 4000000, ["priceIgMoney"] = true, ["tuningData"] = true}
				}
			},	
			
			[6] = {
				["categoryName"] = "Meghajtás",
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeSlot"] = 17,
				["subMenu"] = {
					[1] = {["categoryName"] = "Elsőkerék meghajtás", ["tuningPrice"] = 17000, ["priceIgMoney"] = true, ["tuningData"] = "fwd"},
					[2] = {["categoryName"] = "Összkerék meghajtás", ["tuningPrice"] = 55000, ["priceIgMoney"] = true, ["tuningData"] = "awd"},
					[3] = {["categoryName"] = "Hátsókerék meghajtás", ["tuningPrice"] = 35000, ["priceIgMoney"] = true, ["tuningData"] = "rwd"}
				}
			},				
			
			[7] = {
				["categoryName"] = "Variáns",
				["subMenu"] = {
					[1] = {["categoryName"] = "Kiszerelés", ["tuningPrice"] = 0, ["priceIgMoney"] = true, ["tuningData"] = 255},
					[2] = {["categoryName"] = "Variáns 1", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 0},
					[3] = {["categoryName"] = "Variáns 2", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 1},
					[4] = {["categoryName"] = "Variáns 3", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 2},
					[5] = {["categoryName"] = "Variáns 4", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 3},
					[6] = {["categoryName"] = "Variáns 5", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 4},
					[7] = {["categoryName"] = "Variáns 6", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 5},
					[8] = {["categoryName"] = "Variáns 7", ["tuningPrice"] = 5250000, ["priceIgMoney"] = true, ["tuningData"] = 6},
				}
			},				
			
			[8] = {
				["categoryName"] = "Fordulási szög",
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeSlot"] = 17,
				["subMenu"] = {
					[1] = {["categoryName"] = "Kiszerelés", ["tuningPrice"] = 0, ["priceIgMoney"] = true, ["tuningData"] = false},
					[2] = {["categoryName"] = "30°", ["tuningPrice"] = 200000, ["priceIgMoney"] = true, ["tuningData"] = 30},
					[3] = {["categoryName"] = "40°", ["tuningPrice"] = 220000, ["priceIgMoney"] = true, ["tuningData"] = 40},
					[4] = {["categoryName"] = "50°", ["tuningPrice"] = 250000, ["priceIgMoney"] = true, ["tuningData"] = 50},
					[5] = {["categoryName"] = "60°", ["tuningPrice"] = 300000, ["priceIgMoney"] = true, ["tuningData"] = 60}
				}
			},				
			[9] = {
				["categoryName"] = "Rendszám",
				["cameraSettings"] = {"door_lf_dummy", -65, 3, 8},
				["upgradeSlot"] = 17,
				["subMenu"] = {
				},
			},				
			
			[10] = {
				["categoryName"] = "Neon",
				["cameraSettings"] = {"chassis_dummy", 0, 3, 10},
				["upgradeSlot"] = 19,
				["subMenu"] = {
					[1] = {["categoryName"] = "Kiszerelés", ["tuningPrice"] = 0,["priceIgMoney"] = true, ["tuningData"] = false},
					[2] = {["categoryName"] = "Fehér", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "white"},
					[3] = {["categoryName"] = "Kék", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "blue"},
					[4] = {["categoryName"] = "Zöld", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true,["tuningData"] = "green"},
					[5] = {["categoryName"] = "Piros", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true,["tuningData"] = "red"},
					[6] = {["categoryName"] = "Citromsárga", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "yellow"},
					[7] = {["categoryName"] = "Rózsaszín", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "pink"},
					[8] = {["categoryName"] = "Narancssárga", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "orange"},
					[9] = {["categoryName"] = "Világoskék", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "lightblue"},
					[10] = {["categoryName"] = "Raszta", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "rasta"},
					[11] = {["categoryName"] = "Fehér + Világoskék", ["tuningPrice"] = 2000000, ["priceIgMoney"] = true, ["tuningData"] = "ice"},
				}
			},				
		}
	}
}

function getMainCategoryIDByName(name)
	if name then
		for categoryID, row in ipairs(tuningMenu) do
			if name == row["categoryName"] then
				return categoryID
			end
		end
	end
	
	return -1
end

function hasMoney(element, amount)
	local money = element:getData("char.Money")
	if money >= amount then
		return true
	else
		return false
	end
end

function takeMoney(element, amount)
	if hasMoney(element, amount) then
		element:setData("char.Money", element:getData("char.Money") - amount)
		return true
	else
		return false
	end
end

function hasPremium(element, amount)
	local pp = element:getData("char.PP")
	if pp >= amount then
		return true
	else
		return false
	end
end

function takePremium(element, amount)
	if hasPremium(element, amount) then
		element:setData("char.PP", element:getData("char.PP") - amount)
		return true
	else
		return false
	end
end

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then -- Make sure there's a valid vehicle and a property string
        local handlingTable = getVehicleHandling ( element ) -- Get the handling as table and save as handlingTable
        local value = handlingTable[property] -- Get the value from the table
        
        if value then -- If there's a value (valid property)
            return value -- Return it
        end
    end
    
    return false -- Not an element, not a vehicle or no valid property string. Return failure
end