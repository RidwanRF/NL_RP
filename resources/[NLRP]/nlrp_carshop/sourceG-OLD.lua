vehicleBrands = {"Limitált Autók", "Felső Kategória", "Alsó Kategória", "Izom Autók", "Motorok", "Frakció"}

vehiclesInShop = {
    ["Limitált Autók"] = {
	
        --{494, 19990000, nil, 7}, --LaFerrari

        --{558, 17990000, nil, 7}, --Koenigsegg Jesko  --Kihuzott kocsik később kerülnek be

        {451, 175500000, nil, 6}, -- Aston Martin Vulcan
		
        {503, 170000000, nil, 6}, -- Bugatti Chiron
		
        --{589, 16600000, nil, 5}, -- Rolls Royce Wraith
		
        {404, 151000000, nil, 5}, -- Lamborghini Urus
		
        {410, 126500000, nil, 5}, -- Mercedes-Benz SLR McLaren
		
        --{429, 11950000, nil, 5}, -- W-Motors Fenyr
		
        {506, 103050000, nil, 9}, -- McLaren P1

        {562, 99990000, nil, 5}, -- Aston Martin Vintage
	
        --{535, 85000000, nil, 5}, -- Toyota GT86
	
        {555, 77500000, nil, 6}, -- Bentley Continental
		
        {541, 73750000, nil, 7}, -- Mercedes-Benz S63 AMG
		
        {587, 62550000, nil, 5}, -- Nissan GTR

        {533, 59500000, nil, 7}, -- Porsche 718 
		
        --{516, 55800000, nil, 15}, -- BMW 540i G30
		
        --{502, 55950000, nil, 13}, -- Mercedes-Benz C63 AMG
		
        {529, 55500000, nil, 5}, -- Mercedes-Benz S500
		
        {458, 55500000, nil, 5}, -- Mercedes-Benz GLE Coupe
		
        --{489, 4500000, nil, 5}, -- Mercedes-Benz G65
		
        {401, 50000000, nil, 7}, -- BMW M4
		
        --{566, 4570000, nil, 10}, -- Mercedes-Benz C250
		
        --{475, 3950000, nil, 10}, -- Dodge Challenger SRT Hellcat
		
		{561, 2500000, nil, 15}, --BMW M5 e39
		
    },
    ["Felső Kategória"] = {
	
        {477, 17180000}, -- Ferrari F355 
		
        {549, 12450000}, -- Audi R8
		
        {527, 9500000}, -- Ford Mustang 
		
        {445, 6550000}, -- BMW M5
		
        {565, 5220000}, --Subaru BRZ
		
        {580, 4600000}, -- Audi RS4
		
        {560, 4550000}, -- Evo X
		
        {466, 4350000}, -- Mercedes-Benz C63 régebbi
		
        {579, 4100000}, -- Range Rover Sport 
		
        {405, 3820000}, -- Audi A8
		
		--{518, 3520000}, --Nissan Silvia s15
		
        {421, 3410000}, -- BMW 760i
		
        --{559, 3270000}, -- Toyota Supra   
		
		{540, 3200000}, -- Subaru impreza ST
		
        {400, 3000000}, -- BMW X5
		
        {526, 2800000}, -- BMW M3
		
        
		
    },
	["Alsó Kategória"] = {
	
        {438, 2760000}, -- Mercedes Benz E220cdi
	
        {496, 1220000},-- Volks Wagen Scirocco
	
        {413, 477000}, --Ford Econoline 150
		
		{422, 466000}, --Declasse
	
        {507, 450000},  -- Mercedes Benz E500

		{550, 320000}, --  Mercedes Benz E320

		{585, 140000}, -- Audi 80 Kombi

        {483, 130000},   --Barkas B1000-1
		
        {546, 45000}, ---- Lada 2107
		
        
    },
    ["Izom Autók"] = {
		--{439, 6500000, nil, 13}, -- Dodge Challenger R/T
		
		{474, 4150000}, --Plymouth Hemi Cuda
		
        {534, 3630000}, -- Lincolt Town Cupé

		{517, 4150000}, --Chevrolet SS
		
		{576, 3250000}, --Chevrolet Bel Air
		
        {402, 3050000}, -- Pontiac Firebird

        {567, 3020000}, -- Chevrolet Impala

        {603, 2600000}, -- Dodge Coronet

        {467, 1050000}, -- Chevrolet Capris


    },
    ["Motorok"] = {
		
        {586, 3200000}, -- Harley Davidson knucklehead
		--{463, 3850000}, -- Chopper Üres 
        {522, 2500000}, --BMW R1200
        {521, 2200000}, --Ducatti valami
		{468, 1000000}, --Cross motor
		{462, 20000}, --Honda Click
       
    },
	--[[["Frakció"] = {
        
        {999, 250000}, --
        {999, 2500000}, --
        {999, 1850000}, --
        {999, 2000000}, --
    },--]]

}

function getVehicleShopPirce(model)
	local price = 0
	for category,_ in pairs(vehiclesInShop) do
		for i,row in ipairs(vehiclesInShop[category]) do
			if model == row[1] then
				price = row[2]
				break
			end
		end
	end
	return price
end