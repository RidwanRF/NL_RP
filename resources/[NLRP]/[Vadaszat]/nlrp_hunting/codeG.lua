weaponDamages = {
    -- {weapon, damage}
	{0, 1}, -- kéz
	{1, 2}, -- boxer
	{2, 2}, -- golfütő
	{3, 2}, -- gumibot
	{5, 2}, -- bézbózütő
	{6, 2}, -- lapát
	{7, 2}, -- dákó
	{4, 5}, -- kés
	{8, 10}, -- katana
	{9, 1}, -- láncfűrés
	{10, 12}, -- bárd
	-- pisztolyok
	{22, 25}, -- colt 45
	{23, 30}, -- hangtompítós
	{24, 35}, -- desert eagle
	-- Kis shotgun
	{25, 95}, -- shotgun
	{26, 82}, -- rövidcsövű
	{27, 30}, -- combat
	-- uzi meg ilyen szarok
	{28, 25}, -- uzi
	{28, 30}, -- tec9
	{28, 40}, -- mp5
	-- nagy kaliber
	{30, 50}, -- ak
	{31, 60}, -- m4
	-- vadász puska ilyenek
	{33, 80}, -- vadász
	{34, 90}, -- mesterlövész
	
	{35, 0}, -- mesterlövész
	{36, 0}, -- mesterlövész
	{37, 0}, -- mesterlövész
	{38, 0}, -- mesterlövész
	{16, 0}, -- mesterlövész
	{17, 0}, -- mesterlövész
	{18, 0}, -- mesterlövész
	{39, 0}, -- mesterlövész
}
maxDist = 25
maxInteract = 2
rectangleSize = {200,115,180,25}
animTexts = {
    {"Lassan az állat felé nyúlsz"},
	{"Ellenőrzöd az állapotát"},
	{"Meghalt az állat"},
	{"Lassan két kézzel megpróbálod megfordítani"},
	{"A zsebedből kiveszel egy kést"},
	{"Előkészíted az eltervezett dolgot"},
	{"Elkezded az eltervezett dolgot"},
	{"...Késsel való műveletek..."},
	{"...Késsel való műveletek..."},
	{"...Késsel való műveletek..."},
	{"...Késsel való műveletek..."},
	{"...Késsel való műveletek..."},
	{"Sikerült már csak összegyűjtöd az eltervezett dolgokat!"},
	{"És kész is"},
}
itemReceivers = {
    --[skinID] = {bőrID, trófeaID, bőrPénz, trófeaPénz, "név"}
	[312] = {367, 370, 3000, 2200, "Jegesmedve"},
	[309] = {365, 368, 3000, 2200, "Szarvas"},
	[310] = {366, 369, 3000, 2200, "Vaddisznó"},
	[304] = {0, 0, 0, 0, "Csirke"},
}