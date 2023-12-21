
--// Munka elvégzésére adott idő (percben)
jobCancelTime = 30


--// Következő küldi-ig várni kell X percet
newQuestTime = 30


--// Küldetéses bácsi
ped_data = {
	skin = 218, --// Skin ID természetesen
	pos = {2499.357421875, -947.24987792969, 82.470779418945}, --// X,Y,Z Pozíció
	rot = 180, --// Rotáció
	name = "Marchello De Marino", -- // Név ugyebár
	tag = "Quest", --// Név mögötti cucc zárójelbe
}

--// Ide kerülnek az autó pozíciók amikor autó lopós küldetést kapsz
vehicle_poses = { --{x,y,z,rotáció}
	{346.96005249023, -1809.7719726563, 4.5094537734985,0},
	{1268.8482666016, -1796.1228027344, 13.406679153442,0},
	{1669.2109375, -1708.9991455078, 15.378410339355,0},
	{1840.7286376953, -1870.9981689453, 13.159485816956,0},
	{2058.015625, -2097.6159667969, 13.311839103699,0},
	{2062.7224121094, -2104.2385253906, 15.255000114441,0},
	{2091.2822265625, -1599.8618164063, 13.130533218384,0},
	{2103.10546875, -1771.6365966797, 13.161977767944,0},
	{2792.4182128906, -1875.5046386719, 9.6218414306641,0},
	{2489.0146484375, -1953.220703125, 13.19164276123,0},
	{2376.6809082031, -1927.6239013672, 13.15075302124,0},
	{2554.8659667969, -2407.9172363281, 13.401990890503,0},
	{2487.0180664063, -2484.4118652344, 13.423283576965,0},
	{2736.66796875, -2430.46875, 13.40190410614,0},
	{1408.0240478516, -2331.439453125, 13.312404632568,0},
	{1925.1745605469, -1792.3455810547, 13.177832603455,0},
	{1438.19140625, -1651.1379394531, 13.31621837616,0},
	{1172.5812988281, -912.40386962891, 43.132717132568,0},
	{881.90759277344, -866.01879882813, 77.697570800781,0},
	{910.40515136719, -724.02331542969, 108.19269561768,0},
	{444.23779296875, -1301.5441894531, 14.958827018738,0},
	{203.72186279297, -1446.3145751953, 12.840040206909,0}, 
	{1994.0892333984, -1275.4180908203, 23.869426727295,0}, -- Gleen Park
	{1652.0804443359, -1017.0029296875, 23.947448730469,0}, -- Mullholland, Bank melledt nagypark
	{2148.880859375, -1184.9936523438, 23.869020462036,0}, -- Jefferson
	{2347.966796875, -1253.5852050781, 22.548973083496,0}, -- East los Santos
	{2390.6704101563, -1490.3244628906, 23.877109527588,0}, -- East Los Santos
	{2488.1398925781, -1554.5476074219, 24.105274200439,0}, --  East Los Santos
	{2498.2614746094, -1754.3197021484, 13.49678707122,0}, -- Ganton
	{2417.5529785156, 91.764122009277, 26.476,90}, -- Palomino
	{1388.9099121094, 265.50134277344, 19.5669,156}, -- montgomery
	{313.60244750977, -49.009860992432, 1.6,180}, -- Blueberry
	{167.34803771973, -183.15774536133, 1.578,270}, -- Blueberry
	{-589.82647705078, -472.45779418945, 25.52,180}, -- Fallen Tree gyár izé
	{872.71069335938, -595.41278076172, 18.2066,90}, -- Dilimore
	
}
--// Jármű ID-k amiket kaphat a fiatalember
vehicle_ids = {400,402,589,587,474,458,529,404,477,517,502,516,554,579,546,550,527,401,491,580,547}

--// Leadott járműért járó pénzek | [Jármű ID] = Ár forintban
vehicle_prices = {
	[400] = 170000, -- Porsche Cayanne turbo
	[402] = 80000, -- Pontiac Firebird
	[589] = 155000, -- BMW 635csi
	[587] = 195000, -- Nissan GT-R R35
	[474] = 55000, -- BMW M3 E36
	[458] = 45000, -- Volkswagen Passat
	[529] = 40000, -- Mercedes-Benz S65
	[404] = 155000, -- Audi Q7
	[477] = 175000, -- Ferrari F355
	[517] = 35000, -- Chevrolet SS
	[502] = 145000, -- Mercedes C63
	[516] = 75000, -- Kia stinger
	[554] = 165000, -- Raptor
	[579] = 225000, -- Mercedes G63 	
	[546] = 30000, -- Lada		[550] = 40000, -- Mercedes-Benz C32 AMG W203		[527] = 180000, --  Ford Mustang 		[401] = 175000, --  BMW M4		[491] = 152000, --  Audi RS5		[580] = 149000, --  Audi RS4		[547] = 79000, --  Ford Focus RS
}

--// Ide jönnek a lehetséges színek az autókra. {name = "szín neve" , rgb = {R,G,B} }
vehicle_colors = { 
	{name="Narancssárga",rgb={255,140,18}},
	{name="Piros",rgb={255,10,10}},
	{name="Sötét kék",rgb={21,49,161}},
	{name="Fehér",rgb={200,200,200}},
	{name="Világos barna",rgb={139,119,101}},
	{name="Tenger kék",rgb={0,190,255}},
	{name="Cián kék",rgb={0,255,255}},
	{name="Szűrke",rgb={105,105,105}},
	{name="Sötét zöld",rgb={0,100,0}},
	{name="Arany",rgb={255,215,0}},
	{name="Sárga",rgb={255,255,0}},
	{name="Barna",rgb={139,69,19}},
	{name="Piros",rgb={255,0,0}},
	{name="Rózsaszín",rgb={255,105,180}},
	{name="Lila",rgb={160,32,240}},
	{name="Rózsaszín",rgb={208,32,140}},
	
	
	
}

--//Feltörés animáció ideje (Mennyi idő legyen a feltörés.. ._. )
lockpickTime = 30 -- Másodpercen értendő
lockpickDistance = 4 --// Mekkora távolságból lehet elkezdeni a /feltör parancsot

--// A jármű leadásának a pozíciója (Amikor feltörni kell egy autót majd ide kell elhozni)
dropDownPos = {-1730.900390625, 1525.7684326172, 7.185} 

--//Item szállításos kocsi pozíció (x,y,z,rotáció)
vehicle_pos = { 
     {2509.083984375, -954.46221923828, 82.068954467773, 0},
	 {2513.9750976563, -954.90753173828, 82.079513549805, 0},
	 {2518.5432128906, -955.59094238281, 82.09253692627, 0},
	 {2494.4470214844, -952.02410888672, 82.014198303223, 0},
	 {2504.6594238281, -941.37310791016, 82.113204956055, 0},
	 {2508.818359375, -940.88366699219, 82.234153747559, 0},
	 {2514.9880371094, -938.80413818359, 82.638236999512, 0},
	 {2526.7744140625, -950.97009277344, 82.152725219727, 0},
	 {2525.1252441406, -945.85980224609, 82.567848205566, 0},
}

--// Item szállításos itemek id-je
availableItems = {
	{id=379,price=3750}, --Zárjegy cigi
	{id=380,price=4000}, --muriatic
	{id=381,price=4000}, --Fecskendő
	{id=382,price=5500}, --lőszer
	{id=383,price=6000}, --thermite
}

--// Item szállítós kocsi leadása (mármint a marker pozíció)
dropDownMarker = {2496.3601074219, -939.82318115234, 82.019348144531}

function isJobItem(id)
	local r = false
	for k,v in ipairs(availableItems) do
		if v.id == id then
			r =  true
		end
	end
	return r
end

function getItemPrice(id)
	local price = 0
	for k,v in ipairs(availableItems) do
		if v.id == id then
			price =  v.price
		end
	end
	return price
end

--// Item szállításos ped pozíciói | {x,y,z,rotáció}
ped_poses = { 
	{-2098.388671875, -2528.6530761719, 30.630062103271, 0},
	{-1904.4138183594, -1646.5731201172, 21.75, 0},
	{-2028.3488769531, -101.26725006104, 35.1640625, 0},
	{-1834.5015869141, 1428.0487060547, 7.1875, 0},
}



function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;

    return x+dx, y+dy;
end

function getNearestVehicle(player,distance)
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local vint,vdim = getElementInterior(v),getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 