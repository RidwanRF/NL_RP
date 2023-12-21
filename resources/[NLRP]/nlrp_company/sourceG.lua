

--// /jaruelek és a lefoglaláshoz szükséges frakció ID-k.
--// Viszont a frakció rendszer miatt ezt nem tudtam normálisan táblázni, így se több, se kevesebb nem lehet 2 id-nél xd rip
factionIds = {1,999}

--// Járművek napi adója (Az jármű eredeti ára 0,5%-a jelenleg) (0.005 = 0,5%)  Példák: (1 = 100%) (0.5 = 50%) (0.05 = 5%)
vehicleTaxAmount = 0.005

function getVehicleTax()
	return vehicleTaxAmount
end

--// Jármű eltünése
unloadVehicleAfterQuit = 5*60 -- Másodperc


newCompanyPrice = 7000000

maxPedClick = 5
companyPed = {
	[1] = {skin=76,pos={1479.9395751953, -1785.7554931641, 18.25},int=0,dim=0,rot=0,name="Ügyintéző"}, --BEÁLLÍTANI
}

--shopPeds = { --// A kereskedéses pedek
	--[1] = {skin=40,pos={1049.4986572266, -1787.5478515625, 13.755942344666},int=0,dim=0,rot=261,name="Csautókereskedőh"}
--}

startJobPeds = {
	[1] = {skin=105,pos={2127.8044433594, -2275.4916992188, 20.671875},int=0,dim=0,rot=200,name="Antony -Garázs Mester-"}
}
destroyVehicleMarker = {2165.7978515625, -2257.3540039063, 13.309652328491}

slotPrice = 250

--// Berakodáshoz szükséges idő (Másodperc)
packUpTime = 30

function getVehicleExpFromShop(vehicle)
	return exports.nle_carshop:getVehicleExpFromShop(vehicle)
end

function getModelPriceFromShop(vehicle)
	return exports.nle_carshop:getVehicleOriginalPrice(vehicle)
end



function getVehicleNameFromShop(vehicle)
	return exports.nlrp_vehs:getVehicleNameFromModel(getElementModel(vehicle))
end

function getVehicleTypeFromShop(vehicle)
	return exports.nle_carshop:getVehicleTypeFromShop(vehicle)
end

--// Járművek/trailerek spawnolási pozícióji
spawnPoses = { --// X, Y, Z, ROT
	{2184.0090332031, -2206.1369628906, 14.6600522995, 226}, --jobbos box 3 ( kintről befelé nézve számolunk) 
	{2191.0031738281, -2198.0607910156, 14.667712211609, 226},-- Jobbos Box 2
	{2199.5983886719, -2192.5346679688, 14.667059898376, 216}, -- Jobbos Box 1
	{2232.5168457031, -2243.1604003906, 13.554685592651, 46},--balos box 1
	{2217.7697753906, -2258.2890625, 13.554685592651, 46},--balos box 2
	{2211.888671875, -2253.6799316406, 14.67754650116, 46},--balos box 3
	{2210.9208984375, -2265.890625, 13.554685592651, 46},--balos box 4
	{2202.8229980469, -2272.6164550781, 13.554685592651, 46},--balos box 5
	{2182.748046875, -2273.6604003906, 14.629323005676, 224}, --Középső box 1 
	{2174.2800292969, -2279.8120117188, 14.597011566162, 224},--Középső box 2
	{2166.4182128906, -2286.5080566406, 14.587745666504, 224},--Középső box 3
	{2160.2075195313, -2295.5974121094, 14.598421096802, 224},--Középső box 3
	{2162.9643554688, -2314.6557617188, 14.66854763031, 326}, --Szemközti box 1 (Jobbról)
	{2171.6577148438, -2321.5041503906, 14.662537574768, 326}, --Szemközti box 2 (Jobbról)
	{2178.177734375, -2328.7775878906, 14.654102325439, 326},--Szemközti box 3 (Jobbról)
}
spawnPoses_trailer = { --// X,Y,Z, ROT
	{103.72019958496, -283.57528686523, 1.578125, 0},--1
	{90.023681640625, -284.68984985352, 1.578125, 0},--2
	{77.383766174316, -284.30389404297, 1.578125, 0},--3
	{65.031829833984, -284.31369018555, 1.578125, 0},--4
	{52.031829833984, -284.31369018555, 1.578125, 0},--5
	{39.031829833984, -284.31369018555, 1.578125, 0},--6
}

--//  fuvar választó marker(ek) 
jobMarkers = {
	{80.95556640625, -241.17646789551, 1.578125}, --BlueBerry Main Telephely 
}

--// MUNKA LEADÁSÁNAK POZÍCIÓJI (Ped és marker)
--// A marker a lerakodáshoz, a ped pedig a fuvarlevélhez
finishJob = {
	[1] = {
		ped = {name="Áruátvétel",skin=70,pos={ 854.01336669922, -603.99090576172, 18.421875},rot=0},
		marker = {pos={844.95666503906, -596.19262695313, 18.292293548584},color={173,255,0,100},size=2}, --Dilimore 
    },
    [2] = {
		ped = {name="Áruátvétel",skin=70,pos={ 1327.1108398438, 285.36755371094, 20.045194625854},rot=0},
		marker = {pos={1335.453125, 286.50967407227, 19.561452865601},color={173,255,0,100},size=2}, --Montgomery Sprunk gyár
    },
	[3] = {
		ped = {name="Áruátvétel",skin=70,pos={1335.3843994141, 318.16879272461, 20.096399307251},rot=0},
		marker = {pos={1339.1828613281, 333.91241455078, 19.70786857605},color={173,255,0,100},size=2},--Montgomery raktár
    },
	[4] = {
		ped = {name="Áruátvétel",skin=70,pos={303.7177734375, -226.40115356445, 1.578125},rot=0},
		marker = {pos={293.66369628906, -215.84315490723, 1.4296875},color={173,255,0,100},size=2}, --Blueberry Raktár
    },
	[5] = {
		ped = {name="Áruátvétel",skin=70,pos={162.56958007813, -51.350727081299, 1.578125},rot=0},
		marker = {pos={169.87571716309, -44.590423583984, 1.578125},color={173,255,0,100},size=2}, --Blueberry Raktár
    },
	[6] = {
		ped = {name="Áruátvétel",skin=70,pos={-1831.2225341797, 110.47700500488, 15.1171875},rot=0},
		marker = {pos={-1842.3907470703,120.83895874023, 15.1171875},color={173,255,0,100},size=2}, --SanFierro Solarin Industries
    },
	[7] = {
		ped = {name="Áruátvétel",skin=70,pos={-1714.1359863281, -62.436031341553, 3.5546875},rot=0},
		marker = {pos={-1698.3609619141, -91.248741149902, 3.5546379089355},color={173,255,0,100},size=2},--SanFierro kikötő
    },
	[8] = {
		ped = {name="Áruátvétel",skin=70,pos={-2457.3203125, 773.64593505859, 35.171875},rot=0},
		marker = {pos={-2465.8854980469, 780.04821777344, 35.171875},color={173,255,0,100},size=2},--SanFierro Áruház
    },
	[9] = {
		ped = {name="Áruátvétel",skin=70,pos={-2089.9416503906, 84.320587158203, 35.313430786133},rot=0},
		marker = {pos={-2096.5966796875, 94.693084716797 ,35.3203125},color={173,255,0,100},size=2},--San Fierro Doherty
    },
	[10] = {
		ped = {name="Áruátvétel",skin=70,pos={-1847.6553955078, 1416.80078125, 7.1875},rot=0},
		marker = {pos={-1864.2229003906, 1407.7231445313, 7.1875},color={173,255,0,100},size=2},--SanFierro tenger part
    },
	[11] = {
		ped = {name="Áruátvétel",skin=70,pos={-1873.9146728516, -218.08226013184, 18.375},rot=0},
		marker = {pos={-1880.2053222656, -201.25090026855, 16.881061553955},color={173,255,0,100},size=2}, --SanFierro Raktár 
    },
	[12] = {
		ped = {name="Áruátvétel",skin=70,pos={-2004.4940185547, -2365.4411621094, 30.625},rot=0},
		marker = {pos={-1987.4093017578, -2381.4155273438, 30.625},color={173,255,0,100},size=2}, --AngelPine Fűrészüzem
    },
	[13] = {
		ped = {name="Áruátvétel",skin=70,pos={-553.47973632813, -505.30526733398, 25.5234375},rot=0},
		marker = {pos={-535.83447265625, -495.08041381836, 25.517845153809},color={173,255,0,100},size=2}, -- FallenTre Csarnok
    },
	[14] = {
		ped = {name="Áruátvétel",skin=70,pos={-77.949890136719, -1136.1218261719, 1.078125},rot=0}, -- Határ utáni benzinkót mellett
		marker = {pos={-71.032485961914, -1117.6328125, 1.078125},color={173,255,0,100},size=2},
    },
	[15] = {
		ped = {name="Áruátvétel",skin=70,pos={2270.7075195313, -2037.1883544922, 13.546875},rot=0},
		marker = {pos={2249.0444335938, -2018.4083251953, 13.546875},color={173,255,0,100},size=2}, --LS Willowfield
    },
	[14] = {
		ped = {name="Áruátvétel",skin=70,pos={2543.0520019531, -2238.3889160156, 13.546875},rot=0},
		marker = {pos={2549.6665039063, -2227.1538085938, 13.373973846436},color={173,255,0,100},size=2}, --Dokkok
    },
	[15] = {
		ped = {name="Áruátvétel",skin=70,pos={2548.0593261719, -2404.4890136719, 13.632863998413},rot=0},
		marker = {pos={2558.3862304688, -2405.7414550781, 13.635080337524},color={173,255,0,100},size=2}, --dokkok
    },
	[16] = {
		ped = {name="Áruátvétel",skin=70,pos={2710.2082519531, -2384.4301757813, 13.6328125},rot=0},
		marker = {pos={2699.9641113281, -2391.8979492188, 13.6328125},color={173,255,0,100},size=2}, --Dokkok
    },
	[17] = {
		ped = {name="Áruátvétel",skin=70,pos={2701.4548339844, -2417.271484375, 13.6328125},rot=0},--dokkok
		marker = {pos={2714.8232421875, -2410.5209960938, 13.6328125},color={173,255,0,100},size=2}, 
    },
	[18] = {
		ped = {name="Áruátvétel",skin=70,pos={2615.3405761719, -2382.1201171875, 13.625},rot=0},
		marker = {pos={2604.7673339844, -2366.20703125, 13.545643806458},color={173,255,0,100},size=2}, --Dokkok
    },
	[19] = {
		ped = {name="Áruátvétel",skin=70,pos={2449.6875, -2620.0920410156, 13.664762496948},rot=0},
		marker = {pos={2461.3779296875, -2598.4846191406, 13.661907196045},color={173,255,0,100},size=2}, --dokkok
    },
	[20] = {
		ped = {name="Áruátvétel",skin=70,pos={2219.6936035156, -2666.6203613281, 13.537183761597},rot=0}, --dokkok
		marker = {pos={2232.2822265625,-2682.6589355469, 13.546217918396},color={173,255,0,100},size=2}, 
    },
	[21] = {
		ped = {name="Áruátvétel",skin=70,pos={1138.5971679688, -1202.0405273438, 18.99739265441},rot=0},
		marker = {pos={1151.6705322266, -1212.2984619141, 18.66986656189},color={173,255,0,100},size=2}, --Korháznál
    },
	[22] = {
		ped = {name="Áruátvétel",skin=70,pos={ 2243.9011230469, -2246.9060058594, 14.764669418335},rot=0},
		marker = {pos={2230.5026855469, -2240.5842285156, 13.554685592651},color={173,255,0,100},size=2}, --LS Központi company
    },
	[23] = {
		ped = {name="Áruátvétel",skin=70,pos={1766.7191162109, -1705.12890625, 13.479452133179},rot=0},
		marker = {pos={1783.1336669922, -1695.6926269531, 13.471839904785},color={173,255,0,100},size=2}, --Szerelőtelepnél
    },
}
finishJob_oil = {
	[1] = {
		ped = {name="Áruátvétel",skin=70,pos={2348.9431152344, -1355.5014648438, 24.00625038147},rot=0},
		marker = {pos={2352.0915527344, -1370.1669921875, 24.00625038147},color={173,255,0,100},size=2},--nyugati
    },
	[2] = {
		ped = {name="Áruátvétel",skin=70,pos={ 1927.2407226563, -1767.2576904297, 13.388124465942},rot=0},
		marker = {pos={1927.1607666016, -1789.5065917969, 14.490614891052},color={173,255,0,100},size=2},--Déli
    },
	[3] = {
		ped = {name="Áruátvétel",skin=70,pos={-1623.8395996094, -2693.6469726563, 48.742660522461},rot=0},
		marker = {pos={-1612.9345703125, -2702.7575683594, 48.5390625},color={173,255,0,100},size=2},--whetston
    },
	[4] = {
		ped = {name="Áruátvétel",skin=70,pos={-2231.4204101563, -2558.2065429688, 31.921875},rot=0},
		marker = {pos={-2245.8835449219, -2567.2431640625, 31.921875},color={173,255,0,100},size=2},--AngelPine
    },
	[5] = {
		ped = {name="Áruátvétel",skin=70,pos={-1710.8944091797, 399.41189575195, 7.1872444152832},rot=0},
		marker = {pos={-1706.9050292969, 384.56201171875, 7.1872444152832},color={173,255,0,100},size=2},--SF
    },
	[6] = {
		ped = {name="Áruátvétel",skin=70,pos={-78.977317810059, -1169.6630859375, 2.1512889862061},rot=0},
		marker = {pos={-98.954307556152, -1167.1961669922, 2.6169638633728},color={173,255,0,100},size=2},--Határ utáni benya
    },
	[7] = {
		ped = {name="Áruátvétel",skin=70,pos={1382.6306152344, 464.8049621582, 20.202850341797},rot=0},
		marker = {pos={1360.1265869141, 476.24899291992, 20.2109375},color={173,255,0,100},size=2},--Montgomery
    },
	[8] = {
		ped = {name="Áruátvétel",skin=70,pos={-2419.0791015625, 969.85375976563, 45.296875},rot=0},
		marker = {pos={-2416.5034179688, 953.21466064453, 45.296875},color={173,255,0,100},size=2},--SF Belső
    },
	[9] = {
		ped = {name="Áruátvétel",skin=70,pos={663.44085693359, -566.70373535156, 16.3359375},rot=0},
		marker = {pos={653.88134765625, -583.68511962891, 16.328144073486},color={173,255,0,100},size=2},--DiliMore
    },
}


--// Berakodás markerek
packMarkers = {
    {122.42089080811, -238.80142211914, 1.58, "oil"}, --Bal 1 kis tartály
	{139.80682373047, -238.4633026123, 1.58, "oil"}, --Bal 2 kicsi
	{155.91340637207, -262.0539855957, 1.58, "oil"},--Bal 3
	{164.30331420898, -314.32965087891, 1.58, "oil"},--1
	{151.2600402832, -315.10903930664, 1.58, "oil"},--2
	{136.63780212402, -315.03030395508, 1.58, "oil"},--3 balos
	{-172.53695678711, -276.31530761719, 1.7712646722794,},--szembe Középs
	{-173.15286254883, -261.91201782227, 1.6297509670258,},-- Szembe balos
	{-173.13919067383, -289.07672119141, 1.6328908205032,}, --Szembe jobbos -130.84892272949, -333.91998291016, 1.4296875
	{-130.84892272949, -333.91998291016, 1.4296875,},--Középső
	{-144.1602935791, -333.65274047852, 1.421875,},--balos
	{-116.5531463623, -333.45233154297, 1.4296875,},--jobbos
}

allJobs = { --// Egyértelmű
	["Furgon"] = {
		{name="Szilva",payment={60000,90000},weight={50,350}},
		{name="Alma",payment={60000,90000},weight={50,350}},
		{name="Tej",payment={60000,90000},weight={50,350}},
		{name="Kecske Sajt",payment={60000,90000},weight={50,350}},
		{name="Kenyér",payment={60000,90000},weight={50,350}},
		{name="Méz",payment={60000,90000},weight={50,350}},
		{name="Tojás",payment={60000,90000},weight={50,350}},
		{name="Konzervek",payment={60000,90000},weight={50,350}},
		{name="Szerszámok",payment={60000,90000},weight={50,350}},
		{name="Csavarok",payment={60000,90000},weight={50,350}},
		{name="Műtágya",payment={60000,90000},weight={50,350}},
		{name="Friss hús",payment={60000,90000},weight={50,350}},
		{name="Pékárú",payment={60000,90000},weight={50,350}},
		{name="Használt Abroncsok",payment={60000,90000},weight={50,350}},
		{name="Jármű Alkatrészek",payment={60000,90000},weight={50,350}},
		{name="Üres Rekeszek",payment={60000,90000},weight={50,350}},
		{name="Zsákok",payment={60000,90000},weight={50,350}},
		{name="Dobozok",payment={60000,90000},weight={50,350}},
		{name="palackozott Víz",payment={60000,90000},weight={50,350}},
		{name="Liszt",payment={60000,90000},weight={50,350}},
		{name="Búza",payment={60000,90000},weight={50,350}},
		{name="Üdítő",payment={60000,90000},weight={50,350}},
		{name="Játékok",payment={60000,90000},weight={50,350}},
		{name="Illegális Rakomány",payment={90000,130000},weight={350,400}},--Illegális
	},
	["Egyterű"] = {
		{name="Pékárú",payment={90000,130000},weight={550,850}},
		{name="Használt Abroncsok",payment={90000,130000},weight={550,850}},
		{name="Jármű Alkatrészek",payment={90000,130000},weight={550,850}},
		{name="Üres Rekeszek",payment={90000,130000},weight={550,850}},
		{name="Zsákok",payment={90000,130000},weight={550,850}},
		{name="Dobozok",payment={90000,130000},weight={550,850}},
		{name="palackozott Víz",payment={90000,130000},weight={550,850}},
		{name="Liszt",payment={90000,130000},weight={550,850}},
		{name="Búza",payment={90000,130000},weight={550,850}},
		{name="Üdítő",payment={90000,130000},weight={550,850}},
		{name="Játékok",payment={90000,130000},weight={550,850}},
		{name="Méz",payment={90000,130000},weight={550,850}},
		{name="Kézi szerszámok",payment={90000,130000},weight={550,850}},
		{name="Használt Abroncsok",payment={90000,130000},weight={550,850}},
		{name="Új Abroncsok",payment={90000,130000},weight={550,850}},
		{name="Jármű alkatrészek",payment={90000,130000},weight={550,850}},
		{name="Csomagolt motorolaj",payment={90000,130000},weight={550,850}},
		{name="Csempe",payment={90000,130000},weight={550,850}},
		{name="Gipszkarton",payment={90000,130000},weight={550,850}},
		{name="Iratok",payment={90000,130000},weight={550,850}},
		{name="Cukor",payment={90000,130000},weight={550,850}},
		{name="Rizs",payment={90000,130000},weight={550,850}},
		{name="Szépségápolási Termékek",payment={90000,130000},weight={550,850}},
		{name="Felnik",payment={90000,130000},weight={550,850}},
		{name="Függönyök",payment={90000,130000},weight={550,850}},
		{name="Redőnyök",payment={90000,130000},weight={550,850}},
		{name="használt Akkumlátorok",payment={90000,130000},weight={550,850}},
		{name="Cement",payment={90000,130000},weight={550,850}},
		{name="Fa forgács",payment={90000,130000},weight={550,850}},
		{name="Vegyi Anyagok",payment={90000,130000},weight={550,850}},
		{name="Orvosi Berendezések",payment={90000,130000},weight={550,850}},
		{name="Olajos Rongyok",payment={90000,130000},weight={550,850}},
		{name="Kávé",payment={90000,130000},weight={550,850}},
		{name="Állat eledel",payment={90000,130000},weight={550,850}},
		{name="Vasháló",payment={90000,130000},weight={550,850}},
		{name="Ajtók",payment={90000,130000},weight={550,850}},
		{name="Műanyag elemek",payment={90000,130000},weight={550,850}},
		{name="Iskolai Tanszerek",payment={90000,130000},weight={550,850}},
		{name="Növények",payment={90000,130000},weight={550,850}},
		{name="Szekrények",payment={90000,130000},weight={550,850}},
		{name="Felnik",payment={90000,130000},weight={550,850}},
		{name="Zuhanytálcák",payment={90000,130000},weight={550,850}},
		{name="Illegális Rakomány",payment={130000,170000},weight={850,950}}, ---Illegális fuvar
	},
	["Kis Teher Autó"] = {
		{name="Ruházat",payment={130000,170000},weight={2500,3500}},
		{name="Pékárú",payment={130000,170000},weight={2500,3500}},
		{name="Használt Abroncsok",payment={130000,170000},weight={2500,3500}},
		{name="Jármű Alkatrészek",payment={130000,170000},weight={2500,3500}},
		{name="Üres Rekeszek",payment={130000,170000},weight={2500,3500}},
		{name="Zsákok",payment={130000,170000},weight={2500,3500}},
		{name="Dobozok",payment={130000,170000},weight={2500,3500}},
		{name="palackozott Víz",payment={130000,170000},weight={2500,3500}},
		{name="Liszt",payment={130000,170000},weight={2500,3500}},
		{name="Búza",payment={130000,170000},weight={2500,3500}},
		{name="Üdítő",payment={130000,170000},weight={2500,3500}},
		{name="Játékok",payment={130000,170000},weight={2500,3500}},
		{name="Méz",payment={130000,170000},weight={2500,3500}},
		{name="Kézi szerszámok",payment={130000,170000},weight={2500,3500}},
		{name="Használt Abroncsok",payment={130000,170000},weight={2500,3500}},
		{name="Új Abroncsok",payment={130000,170000},weight={2500,3500}},
		{name="Jármű alkatrészek",payment={130000,170000},weight={2500,3500}},
		{name="Csomagolt motorolaj",payment={130000,170000},weight={2500,3500}},
		{name="Csempe",payment={130000,170000},weight={2500,3500}},
		{name="Gipszkarton",payment={130000,170000},weight={2500,3500}},
		{name="Iratok",payment={130000,170000},weight={2500,3500}},
		{name="Cukor",payment={130000,170000},weight={2500,3500}},
		{name="Rizs",payment={130000,170000},weight={2500,3500}},
		{name="Szépségápolási Termékek",payment={130000,170000},weight={2500,3500}},
		{name="Felnik",payment={130000,170000},weight={2500,3500}},
		{name="Függönyök",payment={130000,170000},weight={2500,3500}},
		{name="Redőnyök",payment={130000,170000},weight={2500,3500}},
		{name="használt Akkumlátorok",payment={130000,170000},weight={2500,3500}},
		{name="Cement",payment={130000,170000},weight={2500,3500}},
		{name="Fa forgács",payment={130000,170000},weight={2500,3500}},
		{name="Vegyi Anyagok",payment={130000,170000},weight={2500,3500}},
		{name="Orvosi Berendezések",payment={130000,170000},weight={2500,3500}},
		{name="Olajos Rongyok",payment={130000,170000},weight={2500,3500}},
		{name="Kávé",payment={130000,170000},weight={2500,3500}},
		{name="Állat eledel",payment={130000,170000},weight={2500,3500}},
		{name="Vasháló",payment={130000,170000},weight={2500,3500}},
		{name="Ajtók",payment={130000,170000},weight={2500,3500}},
		{name="Műanyag elemek",payment={130000,170000},weight={2500,3500}},
		{name="Iskolai Tanszerek",payment={130000,170000},weight={2500,3500}},
		{name="Növények",payment={130000,170000},weight={2500,3500}},
		{name="Szekrények",payment={130000,170000},weight={2500,3500}},
		{name="Felnik",payment={130000,170000},weight={2500,3500}},
		{name="Zuhanytálcák",payment={130000,170000},weight={2500,3500}},
		{name="Illegális Rakomány",payment={170000,250000},weight={3500,3900}}, ---Illegális fuvar	
	},
	["Teher Autó"] = {
	    {name="Ruházat",payment={250000,400000},weight={12500,3500}},
		{name="Pékárú",payment={250000,400000},weight={2500,3500}},
		{name="Használt Abroncsok",payment={250000,400000},weight={2500,3500}},
		{name="Jármű Alkatrészek",payment={250000,400000},weight={2500,3500}},
		{name="Üres Rekeszek",payment={250000,400000},weight={2500,3500}},
		{name="Zsákok",payment={250000,400000},weight={2500,3500}},
		{name="Dobozok",payment={250000,400000},weight={2500,3500}},
		{name="palackozott Víz",payment={250000,400000},weight={2500,3500}},
		{name="Liszt",payment={250000,400000},weight={2500,3500}},
		{name="Búza",payment={250000,400000},weight={2500,3500}},
		{name="Üdítő",payment={250000,400000},weight={2500,3500}},
		{name="Játékok",payment={250000,400000},weight={2500,3500}},
		{name="Méz",payment={250000,400000},weight={2500,3500}},
		{name="Kézi szerszámok",payment={250000,400000},weight={2500,3500}},
		{name="Használt Abroncsok",payment={250000,400000},weight={2500,3500}},
		{name="Új Abroncsok",payment={250000,400000},weight={2500,3500}},
		{name="Jármű alkatrészek",payment={250000,400000},weight={2500,3500}},
		{name="Csomagolt motorolaj",payment={250000,400000},weight={2500,3500}},
		{name="Csempe",payment={250000,400000},weight={2500,3500}},
		{name="Gipszkarton",payment={250000,400000},weight={2500,3500}},
		{name="Iratok",payment={250000,400000},weight={2500,3500}},
		{name="Cukor",payment={250000,400000},weight={2500,3500}},
		{name="Rizs",payment={250000,400000},weight={2500,3500}},
		{name="Szépségápolási Termékek",payment={250000,400000},weight={2500,3500}},
		{name="Felnik",payment={250000,400000},weight={2500,3500}},
		{name="Függönyök",payment={250000,400000},weight={2500,3500}},
		{name="Redőnyök",payment={250000,400000},weight={2500,3500}},
		{name="használt Akkumlátorok",payment={250000,400000},weight={2500,3500}},
		{name="Cement",payment={250000,400000},weight={2500,3500}},
		{name="Fa forgács",payment={250000,400000},weight={2500,3500}},
		{name="Vegyi Anyagok",payment={250000,400000},weight={2500,3500}},
		{name="Orvosi Berendezések",payment={250000,400000},weight={2500,3500}},
		{name="Olajos Rongyok",payment={250000,400000},weight={2500,3500}},
		{name="Kávé",payment={250000,400000},weight={2500,3500}},
		{name="Állat eledel",payment={250000,400000},weight={2500,3500}},
		{name="Vasháló",payment={250000,400000},weight={2500,3500}},
		{name="Ajtók",payment={250000,400000},weight={2500,3500}},
		{name="Műanyag elemek",payment={250000,400000},weight={2500,3500}},
		{name="Iskolai Tanszerek",payment={250000,400000},weight={2500,3500}},
		{name="Növények",payment={250000,400000},weight={2500,3500}},
		{name="Szekrények",payment={250000,400000},weight={2500,3500}},
		{name="Felnik",payment={250000,400000},weight={2500,3500}},
		{name="Zuhanytálcák",payment={250000,400000},weight={2500,3500}},
		{name="Illegális Rakomány",payment={400000,600000},weight={3500,3900}}, ---Illegális fuvar
	},
	["Nyerges Vontató"] = {
		{name="Ruházat",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Pékárú",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Használt Abroncsok",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Jármű Alkatrészek",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Üres Rekeszek",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Zsákok",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Dobozok",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="palackozott Víz",payment={400000,530000},weight={30500,40000},trailer=435},
		{name="Liszt",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Búza",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Üdítő",payment={400000,530000},weight={30500,40000},trailer=435},
		{name="Játékok",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Méz",payment={400000,530000},weight={30500,40000},trailer=435},
		{name="Kézi szerszámok",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Használt Abroncsok",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Új Abroncsok",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Jármű alkatrészek",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Csomagolt motorolaj",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Csempe",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Gipszkarton",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Iratok",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Cukor",payment={400000,530000},weight={30500,40000},trailer=435},
		{name="Rizs",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Szépségápolási Termékek",payment={400000,530000},weight={30500,40000},trailer=435},
		{name="Felnik",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Függönyök",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Redőnyök",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="használt Akkumlátorok",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Cement",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Fa forgács",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Vegyi Anyagok",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Orvosi Berendezések",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Olajos Rongyok",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Kávé",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Állat eledel",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Vasháló",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Ajtók",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Műanyag elemek",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Iskolai Tanszerek",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Növények",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Szekrények",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Felnik",payment={400000,530000},weight={30500,40000},trailer=591},
		{name="Zuhanytálcák",payment={400000,530000},weight={30500,40000},trailer=450},
		{name="Illegális Rakomány",payment={530000,590000},weight={40000,45000},trailer=450}, ---Illegális fuvar
		{name="Illegális Rakomány",payment={530000,590000},weight={40000,45000},trailer=591}, ---Illegális fuvar
		{name="Nyersolaj",payment={400000,530000},weight={30500,40000},trailer=584},
		{name="Finomított olaj",payment={400000,530000},weight={30500,40000},trailer=584},
		{name="Gázolaj",payment={400000,530000},weight={30500,40000},trailer=584},
		{name="Benzin",payment={400000,530000},weight={30500,40000},trailer=584},
		{name="Kőolaj",payment={400000,530000},weight={30500,40000},trailer=584},
		{name="Motorolaj",payment={400000,530000},weight={30500,40000},trailer=584},
	},
}
function getJobsByType(type)
	local jobs = {}
	if allJobs[type] then
		for i = 1,math.random(2,8) do
			local v = allJobs[type][math.random(1,#allJobs[type])]
			if not v.trailer then v.trailer = false end
			jobs[i] = {
				name = v.name,
				payment = math.random(v.payment[1],v.payment[2]),
				weight = math.random(tonumber(v.weight[1]),tonumber(v.weight[2])),
				trailer = v.trailer,
			} 
		end
	end
	return jobs
end

panels = {
	{id=1,text="Kezdőlap"},
	{id=2,text="Tagok"},
	{id=3,text="Rangok"},
	{id=4,text="Járművek"},
	{id=5,text="Tevékenységnapló"},
}

availableLevels = {
	[1] = 1000,
	[2] = 2130,
	[3] = 3400,
	[4] = 4500,
	[5] = 4750,
	[6] = 4920,
	[7] = 6120,
	[8] = 6500,
	[9] = 6700,
	[10] = 6900,
	[11] = 7100,
	[12] = 7400,
	[13] = 7700,
	[14] = 8100,
	[15] = 8400,
	[16] = 8600,
	[17] = 8910,
	[18] = 9320,
	[19] = 9720,
	[20] = 10060,
	[21] = 11510,
	[22] = 12900,
	[23] = 13240,
	[24] = 14500,
	[25] = 15900,
	[26] = 16500,
	[27] = 18000,
}

function getEXPToNextLevel(level)
	local xp = 0
	if availableLevels[level] then
		xp = availableLevels[level]
	else
		if level > #availableLevels then
			xp = availableLevels[#availableLevels] + (10000*(level-#availableLevels))
		end
	end
	return xp
end

taxesByRank = {
	[1] = 25000,
	[2] = 40000,
	[3] = 60000,
	[4] = 85000,
	[5] = 120000,
}

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 

gWeekDays = { "Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat" }
gMonthNames = {"Január","Február","Március","Április","Május","Június","Július","Augusztus","Szeptember","Október","November","December"}
function formatDate(format, escaper, timestamp)
	--check("formatDate", "string", format, "format", {"nil","string"}, escaper, "escaper", {"nil","string"}, timestamp, "timestamp")
	
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

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
    
    --timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
    
    return timestamp
end

function getCompanyVehicles(id)
	local vehicles = {}
	for _,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v,"company.companyID") then
			if tonumber(getElementData(v,"company.companyID")) == tonumber(id) then
				table.insert(vehicles,v)
			end
		end
	end
	return vehicles
end

function findVehicleByDBID(id)
	local vehicle = false
	for _,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v,"company.vehicleID") == id then
			vehicle = v
			break
		end
	end
	return vehicle
end


local characters = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

function createRandomPlateText()
	local plate = ""

 	for i = 1, 3 do
    	plate = plate..characters[math.random(1, #characters)]
	end
	plate = plate.."-"
	for i = 1, 3 do
		plate = plate..math.random(1, 9)
	end
	
	return plate
end


function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix (element)
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z
end