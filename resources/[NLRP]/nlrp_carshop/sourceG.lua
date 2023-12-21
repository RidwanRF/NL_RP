vehicleBrands = {"Felső kategória", "Közép kategória", "Alsó kategória", "Kerékpárok", "Motorok", "Munka járművek",}

vehiclesInShop = {
    ["Felső kategória"] = {
	
        {503, 1000000000, nil, 6}, -- Bugatti Chiron 1mrd

        {451, 1000000000, nil, 6}, -- Aston Martin Vulcan 1mrd 2,5m font

        {494, 800000000, nil, 7}, -- LaFerrari 800m

        {506, 570000000, nil, 7}, -- McLaren Senna 570m

        {415, 540000000, nil, 8}, -- Bugatti Veyron 540m

        {410, 200000000, nil, 8}, -- Mercedes-Benz SLR McLaren 722 Edition 200m

        {411, 110000000, nil, 9}, -- Ferrari 488 GTB 90m

        {579, 85000000, nil, 10}, -- Mercedes Benz G63 AMG 70m
		
		{535, 75000000, nil, 10}, -- Toyota GT86 Rocket Bunny 10m

        {600, 65000000, nil, 10}, -- Acura NSX 64m

        {602, 55000000, nil, 10}, -- Lamborghini Huracan LP610-4 55m

        {526, 55000000, nil, 15}, -- Aston Martin Vantage 55m

        {603, 52000000, nil, 15}, -- Mercedes-Benz AMG GT 52m

        {533, 50000000, nil, 15}, -- Chevrolet Corvette C8 50m

        {549, 40000000, nil, 15}, -- Audi R8 40m

        {477, 38000000, nil, 15}, -- Ferrari F355 28m

        {541, 35000000, nil, 15}, -- Merceds-Benz S63 AMG 26m

        {502, 30000000, nil, 15}, -- Mercedes-Benz C63 AMG w205 25m


    },
    ["Közép kategória"] = {
	---25millióig--
	
        {554, 30000000, nil, 30}, -- Ford Raptor  25m

        {491, 27000000}, -- Audi RS5  21m

        {400, 25000000, nil, 30}, -- Porsche Cayenne Turbo  19m

        {439, 23000000, nil, 30}, -- Dodge Charger R/T  18m

        {475, 21000000, nil, 30}, -- Dodge Challenger SRT Hellcat  18m

        {587, 200000000, nil, 40}, -- Nissan GTR  15m

        {401, 180000000}, -- BMW M4  14m

        {589, 15000000}, -- BMW 635csi  13m

        {518, 14000000, nil, 20}, -- Nissan 370z Nismo  12,5m

        {529, 13000000, nil, 35}, -- Merceds-Benz S65  12m

        {527, 12000000}, -- Ford Mustang  12m

        {558, 12000000, nil, 15}, -- Nissan Skyline GT-R R32  12m

        {580, 12000000}, -- Audi RS4 12m

        {402, 11000000}, -- Pontiac Firebird 11m

        {516, 10000000}, -- Kia Stinger  10m

        {405, 10000000}, -- Alfa Romeo Giulia  10m

        {559, 11000000}, -- Toyota Supra 11m

		
    },
	["Alsó kategória"] = {
	---10millióig--
	
        {547, 8000000, nil, 50}, -- Ford Focus RS 8m

        {517, 7000000, nil, 50}, -- Chevrolet Camaro SS 7m

        {567, 7000000}, -- Chevrolet Impala 7m

        {438, 7000000}, -- Lexus IS 350 7m

        {560, 6500000}, -- Nissan 240sx 6,5m
	
        {507, 6000000}, -- BMW M5 E39 6m
	
        {404, 6000000}, -- Audi Q7 6m
	
        {561, 6000000}, -- Mitsubishi Evo X 6m
	
        {540, 5500000}, -- Subaru Impreza ST 5,5m
	
        {474, 500000}, -- BMW M3 E36 ST 5m (9 amugy)
	
        {550, 3000000}, -- Mercedes Benz C32 AMG 3m
	
        --{562, 4000000}, -- BMW M3 E46 4m
	
        {458, 2500000}, -- Volkswagen Passat B6 2,5m
	
        {546, 75000},-- Lada 2107 50-100k
        
    },
    ["Kerékpárok"] = {
		
		{481, 25000}, ---- BMX
		
		{510, 35000}, -- Mountain bike
	
    },
   ["Motorok"] = {
		
        {586, 7200000}, -- Harley Davidson knucklehead
		--{463, 3850000}, -- Chopper Üres 
        {522, 6500000}, --BMW R1200
        {521, 7200000}, --Ducatti valami
		{468, 3000000}, --Cross motor
		{462, 120000}, --Honda Click
       
    },
	["Munka járművek"] = {
        
        {422, 450000}, -- Bobcat
    },

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