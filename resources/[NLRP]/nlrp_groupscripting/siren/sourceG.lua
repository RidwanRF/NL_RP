gpsBlips = {}

allowedVehicles = {
    [599] = true, -- Police Ranger
    [598] = true, -- Police LS/SF/LV
    [597] = true, -- Police LS/SF/LV
    [596] = true, -- Police LS/SF/LV
    [523] = true, -- HPV1000
    [490] = true, -- FBI Rancher
    [528] = true, -- FBI Truck
    [407] = true, -- Fire Truck
    [544] = true, -- Fire Truck with ladder
    [416] = true, -- Ambulance
    [427] = true, -- Enforcer
    [433] = true, -- Barracks
    [570] = true, -- Patriot
    [432] = true, -- Rhino
    [601] = true, -- S.W.A.T.
    [428] = true, -- Securicar
    [552] = true, -- Securicar
    [542] = true, -- Rozsdamaris
	[479] = true, -- Audi A8
}

vehiclesSiren = {
    -- Police
    [599] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [542] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [598] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [490] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [597] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [596] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [527] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    [528] = {
        [1] = "federal_signal_smart_1.wav",
        [2] = "federal_signal_smart_2.wav",
        [3] = "federal_signal_smart_3.wav",
        ["horn"] = "federal_signal_smart_horn.wav",
    },
    -- Fire & EMS
    [407] = { -- Fire truck
        [1] = "whelen_alternate_manual.wav",
        [2] = "whelen_alternate_mech.wav",
        [3] = "whelen_alternate_wail.wav",
        ["horn"] = "whelen_gamma_horn.wav",
    },
    [544] = { -- Fire truck ladder
        [1] = "whelen_alternate_manual.wav",
        [2] = "whelen_alternate_mech.wav",
        [3] = "whelen_alternate_wail.wav",
        ["horn"] = "whelen_gamma_horn.wav",
    },
    [416] = { -- Ambulance
        [1] = "whelen_ws2100_1.wav",
        [2] = "whelen_ws2100_2.wav",
        [3] = "federal_signal_smart_1.wav",
        ["horn"] = "whelen_gamma_horn.wav",
    },
    [552] = { -- Ambulance
        [1] = "whelen_ws2100_1.wav",
        [2] = "whelen_ws2100_2.wav",
        [3] = "federal_signal_smart_1.wav",
        ["horn"] = "whelen_gamma_horn.wav",
	},	
	[479] = { -- Land Rover Sport
        [1] = "whelen_ws2100_1.wav",
        [2] = "whelen_ws2100_2.wav",
        [3] = "federal_signal_smart_1.wav",
        ["horn"] = "whelen_gamma_horn.wav",	
    },
}

sirenPos = {
    [597] = {
        [1] = {
            {-0.3, -0.3, 1.1, 255, 0, 0, 225, 225}, -- HÁTSÓ FENT
            {0.3, -0.3, 1.1, 0, 0, 255, 225, 225},-- HÁTSÓ FENT

            {-0.3, 2.6, 0.125, 255, 0, 0, 225, 225}, -- ELSŐ LENT
            {0.3, 2.6, 0.125, 0, 0, 255, 225, 225} -- ELSŐ LENT
        },
        [2] = {
            {-0.3, -0.3, 1.1, 255, 0, 0, 225, 225}, -- HÁTSÓ FENT
            {0.3, -0.3, 1.1, 0, 0, 255, 225, 225},-- HÁTSÓ FENT
        },
    },
    [596] = {
        [1] = {
            {-0.3, -0.42, 1.02, 255, 0, 0, 255, 255},
            {0.3, -0.42, 1.02, 0, 0, 255, 255, 255},
            {-0.3, -2.9, 0.3, 255, 255, 0, 225, 225},
            {0.3, -2.9, 0.3, 255, 255, 0, 225, 225},
        },
        [2] = {
            {-0.3, -0.42, 1.02, 255, 0, 0, 255, 255},
            {0.3, -0.42, 1.02, 0, 0, 255, 255, 255},
        },
    },
    [552] = {  -- MK munkas kocsi1
        [1] = {
            {-0.1, -1.2, 1.45, 255, 102, 0, 255, 255},
            {0.1, -1.2, 1.45, 255, 102, 0, 255, 255},
			
            {-0.95, -3, 0.4, 255, 102, 0, 225, 225},
            {0.95, -3, 0.4, 255, 102, 0, 225, 225},
			
            {-0.3, 2.75, 0.15, 255, 102, 0, 225, 225}, -- hűtőrácsS
            {0.3, 2.75, 0.15, 255, 102, 0, 225, 225}, -- hűtőrács
        },
        [2] = {
            {-0.1, -1.2, 1.45, 255, 102, 0, 255, 255},
            {0.1, -1.2, 1.45, 255, 102, 0, 255, 255},
        },
    },
	[490] = {  -- MK munkas kocsi1
        [1] = {
            {-0.1, -1.2, 1.45, 255, 102, 0, 255, 255},  --piros
            {0.1, -1.2, 1.45, 255, 102, 0, 255, 255},
			
            {-0.95, -3, 0.4, 255, 102, 0, 225, 225},
            {0.95, -3, 0.4, 255, 102, 0, 225, 225},
			
            {-0.3, 2.75, 0.15, 255, 102, 0, 225, 225}, -- hűtőrácsS
            {0.3, 2.75, 0.15, 255, 102, 0, 225, 225}, -- hűtőrács
        },
        [2] = {
            {0.1, 1, 0.35, 0, 0, 255, 255, 255},  --piros
            {-0.1, 1, 0.35, 255, 0, 0, 255, 255},  --piros
        },
    },
    [598] = {
        [1] = {
            {0, 0.85, 0.23, 0, 0, 255, 225, 225},
            {0.3, -0.5, 0.9, 255, 0, 0, 225, 225},
            {-0.3, -0.5, 0.9, 0, 0, 255, 225, 225},
        },
        [2] = {
            {0.3, -0.5, 0.9, 255, 0, 0, 225, 225},
            {-0.3, -0.5, 0.9, 0, 0, 255, 225, 225},
        }
    },
    [416] = {
        [1] = { --Minden mas
            {0.55, 0.2, 1.95, 255, 0, 0, 225, 225}, -- tető elöl
            {-0.5, 0.2, 1.95, 0, 0, 255, 225, 225}, -- tető elöl
            {0.4, 0.2, 1.95, 255, 0, 0, 225, 225}, -- tető elöl
            {-0.4, 0.2, 1.95, 0, 0, 255, 225, 225}, -- tető elöls

            {-0.3, 2.75, 0.15, 255, 0, 0, 225, 225}, -- hűtőrácsS
            {0.3, 2.75, 0.15, 0, 0, 255, 225, 225}, -- hűtőrács

            {-0.55, -2.8, 1.95, 0, 0, 255, 225, 225}, -- hátul felül
            {0.55, -2.8, 1.95, 0, 0, 255, 225, 225}, -- hátul felüls
        },
        [2] = {  --mk
            {0.55, 0.2, 1.95, 255, 102, 0, 225, 225}, -- tető elöl
            {-0.5, 0.2, 1.95, 255, 102, 0, 225, 225}, -- tető elöl
            {0.4, 0.2, 1.95, 255, 102, 0, 225, 225}, -- tető elöl
            {-0.4, 0.2, 1.95, 255, 102, 0, 225, 225}, -- tető elöls

			{-0.55, -2.8, 1.95, 255, 102, 0, 225, 225}, -- hátul felül
            {0.55, -2.8, 1.95, 255, 102, 0, 225, 225}, -- hátul felüls

            {-0.3, 2.75, 0.15, 255, 102, 0, 225, 225}, -- hűtőrács
            {0.3, 2.75, 0.15, 255, 102, 0, 225, 225}, -- hűtőrács
		
        },
    },
	[479] = { --A8
        [1] = {
            {-0.3, -0.2, 1, 255, 0, 0, 225, 225},
            {0.3, -0.2, 1, 0, 0, 255, 225, 225},

            {-0.45, -2.4, 0.45, 255, 255, 0, 225, 225},
            {0.45, -2.4, 0.45, 255, 255, 0, 225, 225},
        },
        [2] = {
            {-0.3, -0.2, 1, 255, 0, 0, 225, 225},
            {0.3, -0.2, 1, 0, 0, 255, 225, 225},
	
                
		}
	}	
}

function getAllowedVehicles()
    return allowedVehicles
end