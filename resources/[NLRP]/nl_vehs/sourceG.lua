availableMods = {
	-- [Fájl elérés] = {model id vagy model neve, jármű neve - ha nincs az alap model neve lesz, kikapcsolható-e}
	["job/mrwhoop"] = {423,"Fagylaltos kocsi"},
	--["job/sweeper"] = {"sweeper", "Úttisztító jármű", true},
	--["job/utility"] = {552, "utility", "Utjavito jármű", true},
	--["job/utiltr1"] = {611, "utility", "Utjavito jármű uténnfutó", true},
	["job/tropic"] = {454, "Jacht", true},

--	["pdsd/copbike"] = {523, "Rendőrségi motor"},
	--["pdsd/police_la"] = {598, "Audi A6"}, --EZ SZAR , 2 percenként crash
--	["pdsd/swatvan"] = {601, "BTR TEK"},
	["pdsd/police_ls"] = {596, "Mercedes-Benz A45 AMG"},
	["pdsd/copcarsf"] = {597, "Mercedes Benz GLE 63 AMG"},
	--["pdsd/597"] = {597, "Lexus"},
	--["pdsd/596"] = {596, "Valamipd"},
	["pdsd/enforcer"] = {427, "Lenco Bearcat (Law Enforcement)"},
	["pdsd/fbi_rancher"] = {490, "Cadillac Escalade"},
	["pdsd/heli"] = {497, "Eurocopter"},


	["lsfd/ambulan"] = {416, "Mercedes Benz Sprinter"},
	["lsfd/firetruk"] = {407, "Pierce Arrow XT Tűzoltó"},
	["lsfd/firela"] = {544, "Pierce Arrow XT Létrás tűzoltó"},
	["lsfd/raindanc"] = {563, "Teher heli"},
	--["lsfd/barracks"] = {433, "LSFD"},

                 --Company Kocsik
    ["trucks/benson"] = {499, "Volkswagen Crafter"},
	["trucks/flatbed"] = {455, "Mac ponyvás Teherautó"},
	["trucks/rdtrain"] = {515, "Volvo FH750"},
	["trucks/rumpo"] = {440, "Renault Master"},
	["trucks/tanker"] = {514, "Kenworth T680"},
	["trucks/scania"] = {403, "Scania S730"},
	["trucks/tankertrailer"] = {584, "Tartályos pótkocsi"},
	["trucks/trailer1"] = {435, "Hűtős pótkocsi"},
	["trucks/trailer2"] = {450, "NL Ponyvás Pótkocsi"},
	["trucks/trailer3"] = {591, "Ponyvás pótkocsi"},
	["trucks/boxville"] = {498, "Mercedes Benz Sprinter"},

	["lsc/towtruck"] = {525, "Vontató"},
	
	["ppkocsik/esperanto"] = {419, "BMW M8 #Import", true}, --vito
	["ppkocsik/ubul"] = {470, "Mercedes-Benz Brabus 700G 6X6 #Import", true}, -- Ubul levente
	["civil/banshee"] = {429, "Dodge Viper #Import", true},  --Gergőwágen

	
	["civil/admiral"] = {445, "BMW M5", true},  --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/alpha"] = {602, "Lamborghini Huracan LP610-4", true}, --Porsche 911 GT3 RS volt
	["civil/bmx"] = {481, "BMX kerékpár", true}, --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/bravura"] = {401, "BMW M4", true},   --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/buffalo"] = {402, "Pontiac Firebird", true},  --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/bullet"] = {541, "Merceds-Benz S63 AMG", true}, --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/cabbie"] = {438, "Lexus IS 350", true},  --Mercedes Benz E220cdi volt --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/cadrona"] = {527, "Ford Mustang GT", true},   --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/cheetah"] = {415, "Bugatti Veyron", true},  --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/club"] = {589, "BMW 635csi", true}, --Rolls Royce Wraith volt		--- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/tampa"] = {549, "Audi R8", true},    --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/elegant"] = {507, "BMW M5 E39", true},  --Mercedes Benz E500   --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/euros"] = {587, "Nissan GT-R R35", true},  --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/faggio"] = {462, "Honda Click", true}, --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/fcr900"] = {521, "Ducatti", true}, --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/feltzer"] = {533, "Chevrolet Corvette C8", true}, --Porsche 718 Boxster Svolt			 --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/fortune"] = {526, "Aston Martin Vantage", true}, --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/hotrina"] = {494, "LaFerrari", true}, 			 --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/hotrinb"] = {502, "Mercedes-Benz C63 AMG w205", true},  --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/huntley"] = {579, "Mercedes Benz G63 AMG", true},   --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/infernus"] = {411, "Ferrari 488 GTB", true},   --- EZ AZ ÚJ  --- NEM OKOZ CRASHT
	["civil/yosemite"] = {554, "Ford Raptor", true},	--- EZ AZ ÚJ --- NEM OKOZ CRASHT
	["civil/hotring"] = {503, "Bugatti Chiron", true}, 	--- EZ AZ ÚJ 	--- NEM OKOZ CRASHT
	["civil/intruder"] = {546, "Lada 2107", true},	--- EZ AZ ÚJ --- NEM OKOZ CRASHT
	["civil/majestic"] = {517, "Chevrolet Camaro SS", true},	--- EZ AZ ÚJ --- NEM OKOZ CRASHT
	["civil/landstal"] = {400, "Porsche Cayenne Turbo", true}, --BMW X5 volt	--- EZ AZ ÚJ --- NEM OKOZ CRASHT
	["civil/manana"] = {410, "Mercedes-Benz SLR McLaren 722 Edition", true}, --- EZ AZ ÚJ
	["civil/nrg500"] = {522	, "BMW R1200", true},--- EZ AZ ÚJ
	["civil/phoenix"] = {603, "Mercedes-Benz AMG GT", true}, --- EZ AZ ÚJ Gyanússss
	["civil/pony"] = {413, "Ford Econoline 150", true}, --- EZ AZ ÚJ
	["civil/reefer"] = {453, "Halászhajó", true},
	--["civil/sabre"] = {475, "Dodge Challenger SRT Hellcat", true},  
	--["civil/sanchez"] = {468, "Crossmotor", true},
	["civil/savanna"] = {567, "Chevrolet Impala", true}, --EZ AZ ÚJ ?????????????? Kicserélve ez és Beraktam ezt! 03.08 éjfélkor
	["civil/sentinel"] = {405, "Alfa Romeo Giulia", true}, -- --EZ AZ ÚJ ??????????????  EZ
	--["civil/slamvan"] = {535, "Toyota GT86 Rocket Bunny", true}, 
	["civil/solair"] = {458, "Volkswagen Passat B6", true}, --Merceds-Benz GLE Coupe ERRE MEG 
	["civil/stafford"] = {580, "Audi RS4", true},  -------	  						ERRE
	["civil/stallion"] = {439, "Dodge Charger R/T", true},
	["civil/stretch"] = {409, "Lincoln Limusine", true},
	["civil/sunrise"] = {550, "Mercedes Benz C32 AMG", true}, --
	["civil/supergt"] = {506, "McLaren Senna", true},  -----
	["civil/turismo"] = {451, "Aston Martin Vulcan", true}, 
	["civil/vincent"] = {540, "Subaru Impreza ST", true}, 
	["civil/wayfarer"] = {586, "Harley Davidson Knucklehead", true},
	--["civil/willard"] = {529, "Merceds-Benz S65", true},  --
	["civil/primo"] = {547, "Ford Focus RS", true}, 
	["civil/virgo"] = {491, "Audi RS5", true},
	["civil/picador"] = {600, "Acura NSX", true},
	["civil/hermes"] = {474, "BMW M3 E36", true}, --03.05 
	["civil/buccaneer"] = {518, "Nissan 370z Nismo", true}, --
	["civil/zr350"] = {477, "Ferrari F355", true}, --03.05
	["civil/perennial"] = {404, "Audi Q7", true}, --
	["civil/nebula"] = {516, "Kia Stinger", true}, -- 
	--["ppkocsik/tornado"] = {576, "Semmi", true}, 
	
	


	
	["civil/sultan"] = {560, "Nissan 240sx", true},     
	["civil/stratum"] = {561, "Mitsubishi Evo X", true},  
	["civil/uranus"] = {558, "Nissan Skyline GT-R R32", true},  
	["civil/flash"] = {565, "Nissan Skyline GT-R R34", true}, 
	["civil/jester"] = {559, "Toyota Supra", true}, 
	
	
	--["civil/merit"] = {551, "BMW 750i", true},
	--["civil/blistac"] = {496, "Volkswagen Golf 7", true},
	--["civil/windsor"] = {555, "Koenigsegg Jesko", true}, 
	--["civil/glendale"] = {466, "Mercedes Benz C63 AMG w204", true},   			 4ajtós ÜRES
	--["civil/premier"] = {426, "Semmi", true}, Tanuló autó
	--["civil/rancher2"] = {505, "Kuka", true},
	--["civil/camper"] = {483, "Barkas B1000-1", true}, 							 2ajtós busz
	--["civil/remingtn"] = {534, "Lincolt Town Cupé", true},  ---------------		 2Ajtós
	--["civil/oceanic"] = {467, "Chevrolet Capris", true},  ---------------			 4Ajtós
	--["civil/yankee"] = {456, "Vapid Truck", true}, 
	--["civil/tahoma"] = {566, "Mercedes Benz C250", true}, ---------------    		4ajtós Lötyög a skinje
	--["civil/clover"] = {542, "Semmi", true}, 
	--["civil/blade"] = {536, "Ford Thunderbird", true},							2ajtós 
	--["civil/mesa"] = {500, "Jeep Wrangler", true},------------				 	2Ajtós
	--["civil/moonbeam"] = {418, "üres", true}, ---------------    					4ajtós
	--["civil/washing"] = {421, "BMW 760i", true},                					4ajtós
	--["civil/rancher"] = {489, "Mercedes	Benz G65 AMG", true},--					2 ajtós
	--["civil/green"] = {492, "Üres", true}, ---------------------- 				4ajtós
	--["civil/emperor"] = {585, "Audi 80 Kombi", true}, 							4ajtós
	---["civil/sadlshit"] = {605, "Ford Damaged", true},  Vállalkozás kocsi
	--["civil/bobcat"] = {422, "Declasse", true}, 
	--["civil/rustler"] = {476, "B-11 Vadász repülő", true},
	--["civil/journey"] = {508, "Lakoauto", true}, 
	--["civil/maverick"] = {487, "Helikopter", true}, 
	--["civil/bus"] = {431, "MAC Volan", true},
	--["civil/regina"] = {479, "Aston Martin DBX", true},

	
	
	

}

vehicleNames = {}

for k, v in pairs(availableMods) do
	local model = tonumber(v[1]) or getVehicleModelFromName(v[1])

	if model then
		vehicleNames[model] = v[2]
	end
end

_getVehicleNameFromModel = getVehicleNameFromModel
_getVehicleName = getVehicleName

function getVehicleNameFromModel(model)
	if vehicleNames[model] then
		return vehicleNames[model]
	end

	return _getVehicleNameFromModel(model)
end

function getVehicleName(vehicleElement)
	local model = getElementModel(vehicleElement)

	if vehicleNames[model] then
		return vehicleNames[model]
	end

	return _getVehicleName(vehicleElement)
end

function getVehicleNameList()
	local list = {}

	for k, v in pairs(availableMods) do
		table.insert(list, v[2])
	end

	return list
end