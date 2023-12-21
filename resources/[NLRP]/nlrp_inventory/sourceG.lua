local weightLimits = {}



crafts = {

	{"Molotov Koktél #DB2828-> #FFFFFF1db Tito's, 1db Kötszer",2,22,{66,1},{122,1}},

	{"P250 előállításához szükséges tervrajz",6,9,{313,1},{314,1},{315,1},{316,1},{317,1},{318,1}},

	{"Desert Eagle előállításához szükséges tervrajz",6,11,{313,1},{319,1},{320,1},{321,1},{322,1},{323,1}},

	{"UZI előállításához szükséges tervrajz",9,12,{313,1},{324,1},{325,1},{326,1},{327,1},{328,1},{329,1},{330,1},{331,1}},

	{"TEC-9 előállításához szükséges tervrajz",5,13,{313,1},{332,1},{333,1},{334,1},{335,1}},

	{"MPX előállításához szükséges tervrajz",7,14,{313,1},{336,1},{337,1},{338,1},{339,1},{340,1},{341,1}},

	{"M4 előállításához szükséges tervrajz",7,16,{313,1},{342,1},{343,1},{344,1},{345,1},{346,1},{347,1}},

	{"AK-47 előállításához szükséges tervrajz",9,15,{313,1},{348,1},{349,1},{350,1},{351,1},{352,1},{353,1},{354,1},{355,1}},

	{"M24 előállításához szükséges tervrajz",6,18,{313,1},{356,1},{357,1},{358,1},{359,1},{360,1}},

	{"Kar98 előállításához szükséges tervrajz",5,17,{313,1},{361,1},{362,1},{363,1},{364,1}},

--	{"DESC",ITEMEK SZAMA,ITEM AMIT AD,{KELL ITEM 1,KELL ITEM DB 1},{KELL ITEM 2,KELL ITEM DB 2}},

}



defaultSettings = {

	slotLimit = 50,

	width = 10,

	slotBoxWidth = 36,

	slotBoxHeight = 36,

	weightLimit = {

		player = 120,

		vehicle = 500,

		object = 1000

	},

	trashModels = {

		[1359] = true,

		[1439] = true

	},

	safeModel = 2332

}



availableWeapons = {

	["m4_v3_d1"] = {"M4 #ffffff| #90945cCamo","Egy Camo mintás M4-es gépfegyver."},  -- MINTA

}



--// Ide jönnek azok az item id-k amit halálkor el kell venni

deathTakeItemIDs = {

	[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[314]=true,[315]=true,[316]=true,[317]=true,[318]=true,[319]=true,[320]=true,[321]=true,[321]=true,[323]=true,[324]=true,[325]=true,[326]=true,[327]=true,[328]=true,[329]=true,[330]=true,[331]=true,[332]=true,[333]=true,[334]=true,[335]=true,[336]=true,[337]=true,[338]=true,[339]=true,[340]=true,[341]=true,[342]=true,[343]=true,[344]=true,[345]=true,[346]=true,[347]=true,[348]=true,[349]=true,[350]=true,[351]=true,[352]=true,[353]=true,[354]=true,[355]=true,[356]=true,[357]=true,[358]=true,[359]=true,[360]=true,[361]=true,[362]=true,[363]=true,[364]=true

}



availableItems = {
	-- [ItemID] = {Név, Leírás, Súly, Stackelhető, Fegyver ID, Töltény item ID}
	[1] = {"Lakás kulcs", false, 0},
	[2] = {"Jármű kulcs", false, 0},

	[3] = {"5x9mm-es töltény", "Colt45, Desert 5x9mm-es töltény", 0.001, true, false, false, minAdminLevel=9},
	[4] = {"Kis gépfegyver töltények", "Kis gépfegyver töltények (UZI,TEC-9,MPX)", 0.001, true, false, false, minAdminLevel=9},
	[5] = {"AK47-es töltény", false, 0.001, true, false, false, minAdminLevel=9},
	[6] = {"M4-es gépfegyver töltény", false, 0.001, true, false, false, minAdminLevel=9},
	[7] = {"Vadászpuska töltény", "Hosszú Vadászpuska töltény", 0.001, true, false, false, minAdminLevel=9},
	[8] = {"Sörétes töltény", false, 0.001, true, false, false, minAdminLevel=9},

	[9] = {"P250", "P250-es.", 3, false, 22, 3, minAdminLevel=9},
	[10] = {"USP-S", "Egy USP-S hangtompítós fegyver.", 3, false, 23, 3, minAdminLevel=9},
	[11] = {"Desert Eagle ", false , 3, false, 24, 3, minAdminLevel=9},

	[12] = {"Micro UZI", "Egy Micro UZI pisztoly.", 3, false, 28, 4, minAdminLevel=9},
	[13] = {"Tec 9", "Egy Tec 9 .", 3, false, 32, 4, minAdminLevel=9},
	[14] = {"MPX", "Egy MPX.", 3, false, 29, 4, minAdminLevel=9},

	[15] = {"AK-47", "AK-47-es gépfegyver.", 3, false, 30, 5, minAdminLevel=9},
	[16] = {"M4", "M4-es gépfegyver.", 3, false, 31, 6, minAdminLevel=9},

	[17] = {"Kar98", "Vadász puska a pontos és határozott lövéshez.", 3, false, 33, 7, minAdminLevel=9},
	[18] = {"M24", "Mesterlövész puska a pontos és határozott lövéshez.", 3, false, 34, 7, minAdminLevel=9},

	[19] = {"Sörétes puska", "Nagy kaliberű sörétes puska.", 3, false, 25, 8, minAdminLevel=9},
	[20] = {"Fűrészelt csövű", "Nagy kaliberű sörétes puska levágott csővel.", 3, false, 26, 8, minAdminLevel=9},
	[21] = {"SPAZ-12 taktikai sörétes puska", "SPAZ-12 taktikai sörétes puska elit fegyver.", 3, false, 27, 8, minAdminLevel=9},

	[22] = {"Molotov koktél", false, 1, false, 18, 22, minAdminLevel=9},
	[23] = {"Gránát", false, 1, false, 16, 23, minAdminLevel=9},
	[24] = {"Könnygázgránát", false, 1, false, 17, 24, minAdminLevel=9},

	[25] = {"Festékszóró", "Egy festékpatronnal működő festékszóró.", 1, false, 41, 42, minAdminLevel=9},
	[26] = {"Könnygáz spray", "Tömegoszlatásra, önvédelemre kitalált, hatásos spray.", 1, false, 41, 43, minAdminLevel=9},
	[27] = {"Porral oltó", "Egy porral oltó, mely hatásos védelmet nyújt kisebb tüzek ellen.", 1, false, 42, minAdminLevel=9},
	[28] = {"Fényképezőgép", "Egy fényképezőgép mellyel megörökítheted a pillanatokat.", 1, false, 43, 44, minAdminLevel=9},

	[29] = {"Gumibot", false, 1, false, 3, 29, minAdminLevel=9},

	[30] = {"Golfütő", false, 1, false, 2, 30, minAdminLevel=9},

	[31] = {"Kés", false, 1, false, 4, 31, minAdminLevel=9},

	[32] = {"Baseball ütő", false, 1, false, 5, 32, minAdminLevel=9},

	[33] = {"Csákány", false, 1, false, 6, 33},

	[34] = {"Biliárd ütő", false, 1, false, 7, 34, minAdminLevel=9},

	[35] = {"Katana", false, 1, false, 8, 35, minAdminLevel=9},

	[36] = {"Láncfűrész", false, 1, false, 9, 36, minAdminLevel=9},



	[37] = {"Balta", false, 1, false, 10, 37},

	[38] = {"Dildo", false, 1, false, 11, 38, minAdminLevel=9},

	[39] = {"Vibrator", false, 1, false, 12, 39, minAdminLevel=9},

	[40] = {"Virág", false, 1, false, 14, 40, minAdminLevel=9},

	[41] = {"Járó bot", false, 1, false, 15, 41, minAdminLevel=9},



	[42] = {"Festék patron", false, 0.05, true, false, false, minAdminLevel=9},

	[43] = {"Könnygáz patron", false, 0.05, true, false, false, minAdminLevel=9},

	[44] = {"SD Kártya", "Kamerába való SD kártya", 0.005, true, false, false, minAdminLevel=9},



	[45] = {"Hamburger", "Egy guszta, jól megpakolt hamburger.", 0.8},

	[46] = {"Hot-dog", false, 0.8},

	[47] = {"Szendvics", false, 0.8},

	[48] = {"Taco", false, 0.8},

	[49] = {"Fánk", false, 0.8},

	[50] = {"Süti", false, 0.8},

	[51] = {"Puding", false, 0.8},



	[52] = {"Fanta", "Üdítő.", 0.8},

	[53] = {"Coca Cola", "Üdítő.", 0.8},

	[54] = {"PEPSI Cola", "Üdítő.", 0.8},

	[55] = {"7up", "Üdítő.", 0.8},

	[56] = {"Dr Pepper", "Üdítő.", 0.8},



	[57] = {"Red Bull", "Energia ital.", 0.8},

	[58] = {"Monster", "Energia ital.", 0.8},

	[59] = {"Hell", "Energia ital.", 0.8},



	[60] = {"Indigo H2O", "Ásványvíz.", 0.8},

	[61] = {"FIJI Water", "Ásványvíz.", 0.8},



	[62] = {"Bud Light", "Sör.", 0.8},

	[63] = {"Budweiser", "Sör.", 0.8},



	[64] = {"Spring 44", "Vodka.", 0.8},

	[65] = {"Hangar One", "Vodka.", 0.8},

	[66] = {"Tito’s", "Vodka.", 0.8},



	[67] = {"Buffalo Trace", "Whisky.", 0.8},

	[68] = {"Jim Beam", "Whisky.", 0.8},

	[69] = {"Jack Daniel's", "Whisky.", 0.8},



	[70] = {"Kávé", false, 0.8},



	[71] = {"Telefon", false, 0.05},

	[72] = {"Unused slot", false, 0.8, false, false, false, minAdminLevel=9},

	[73] = {"Telefon könyv", false, 0.8, false, false, false, minAdminLevel=9},

	[74] = {"Gáz maszk", false, 0.8, false, false, false, minAdminLevel=9},

	[75] = {"Fény rúd", false, 0.005, true, false, false, minAdminLevel=9},

	[76] = {"Faltörő kos", false, 0.8, false, false, false, minAdminLevel=9},

	[77] = {"Bilincs", false, 0.025, true, false, false, minAdminLevel=9},

	[78] = {"Bilincs kulcs", false, 0.025, true, false, false, minAdminLevel=9},

	[79] = {"Rádió", false, 0.8, false, false, false, minAdminLevel=9},

	[80] = {"Kötél", false, 0.8, false, false, false, minAdminLevel=9},

	[81] = {"Szonda", false, 0.8, false, false, false, minAdminLevel=9},

	[82] = {"Hi-Fi", false, 0.8, false, false, false, minAdminLevel=9},

	[83] = {"Sí maszk", false, 0.8, false, false, false, minAdminLevel=9},

	[84] = {"Benzin kanna", false, 0.8, false, false, false, minAdminLevel=9},

	[85] = {"Széf", "A lerakáshoz kattints rá jobb klikkel.", 0.8, false, false, false, minAdminLevel=9},

	[86] = {"Jelvény", false, 0.05, false, false, false, minAdminLevel=9},

	[87] = {"Azonosító", false, 0.8, false, false, false, minAdminLevel=9},

	[88] = {"Kendő", false, 0.8, false, false, false, minAdminLevel=9},

	[89] = {"GPS", false, 0.8, false, false, false, minAdminLevel=9},

	[90] = {"Elsősegély doboz", false, 0.8, false, false, false, minAdminLevel=9},

	[91] = {"Rohampajzs", false, 0.8, false, false, false, minAdminLevel=9},

	[92] = {"Hűtőszekrény", false, 0.8, false, false, false, minAdminLevel=9},

	[93] = {"Sisak", false, 0.8, false, false, false, minAdminLevel=9},

	[94] = {"Ajándék", false, 0.8, false, false, false, minAdminLevel=9},

	[95] = {"Pénzes zsák", false, 0.8, false, false, false, minAdminLevel=9},

	[96] = {"Kapu kulcs", false, 0.8, false, false, false, minAdminLevel=9},

	[97] = {"Cigaretta", false, 0.8},

	[98] = {"Egy doboz cigi", false, 0.8},

	[99] = {"Öngyújtó", false, 0.01},

	[100] = {"Befizetési Csekk", false, 0, false, false, false, minAdminLevel=9},

	[101] = {"Csekk tömb", false, 0.01, false, false, false, minAdminLevel=9},

	[102] = {"Kifizetési utalvány", false, 0, false, false, false, minAdminLevel=9},

	[103] = {"Üres kifizetési utalvány", false, 0, false, false, false, minAdminLevel=9},

	[104] = {"Üres befizetési csekl", false, 0, false, false, false, minAdminLevel=9},

	[105] = {"Gyógyszer", false, 0.01},

	[106] = {"Vitamin", false, 0.8},

	[107] = {"Defiblirátor", false, 0.8, false, false, false, minAdminLevel=9},

	[108] = {"Orvosi táska", false, 0.8, false, false, false, minAdminLevel=9},

	[109] = {"GPS", false, 0.8, false, false, false, minAdminLevel=9},

	[110] = {"Sokkoló", "Sokkoló pisztoly", 0.25, false, 24, -1, minAdminLevel=9},

	[111] = {"Jogosítvány", "Jogosítvány", 0, false, false, false, minAdminLevel=9},

	[112] = {"Személyigazolvány", "Személyi", 0, false, false, false, minAdminLevel=9},

	[113] = {"Vizsga záradék", "Vizsgának az eredményei papírra írva", 0, false, false, false, minAdminLevel=9},

	[114] = {"Megafon", false, 0.01, false, false, false, minAdminLevel=9},



	[115] = {"Szén", false, 0.25, true, false, false, minAdminLevel=9},

	[116] = {"Aranyrög", false, 0.75, true, false, false, minAdminLevel=9},

	[117] = {"Gyémánt", false, 0.5, true, false, false, minAdminLevel=9},



	[118] = {"Parkolási bírság", false, 0, false, false, false, minAdminLevel=9},

	[119] = {"Bírság", false, 0, false, false, false, minAdminLevel=9},

	[120] = {"Bírság tömb", false, 0.01, false, false, false, minAdminLevel=9},

	[121] = {"Parkolási bírság tömb", false, 0.01, false, false, false, minAdminLevel=9},



	[122] = {"Kötszer", "Kötszer a vérzés lassítására", 0.001, true},


	--[ItemID] = {Név, Leírás, Súly, Stackelhető, Fegyver ID, Töltény item ID
	
	[123] = {"Feldolgozatlan Marihuana", false, 0.01, true, false, false, minAdminLevel=9},

	[124] = {"Feldolgozatlan Kokacserje", false, 0.01, true, false, false, minAdminLevel=9},

	[125] = {"Joint", false, 0.01, false, false, false, minAdminLevel=9},

	[126] = {"Kokain", false, 0.01, false, false, false, minAdminLevel=9},

	[127] = {"Kék Villogó", false, 0.01, false, false, false, minAdminLevel=9},

	[128] = {"Narancssárga Villogó", false, 0.01, false, false, false, minAdminLevel=9},

	[129] = {"Fegyver Doboz", false, 0.01, false, false, false, minAdminLevel=9},

	[130] = {"Lőszer Doboz", false, 0.01, false, false, false, minAdminLevel=9},

	[131] = {"NLPack #1", "#A9E8A12xGlock #aaaaaa+ #A9E8A1100x5x9mm #aaaaaa+ #ffd70010M Ft #aaaaaa+ #2AA1EE3500 NL Coin", 0.01, false, false, false, minAdminLevel=9},

	[132] = {"NLPack #2", "#A9E8A12xUZI #aaaaaa+ #A9E8A1200xKisgépfegyver töltény #aaaaaa+ #ffd70020M Ft #aaaaaa+ #2AA1EE6000 NL Coin", 0.01, false, false, false, minAdminLevel=9},

	[133] = {"NLPack #3", "#A9E8A12xAk-47 #aaaaaa+ #A9E8A1300x7.62mm #aaaaaa+ #ffd7002.5MFt #aaaaaa+ #2AA1EE12.000 NL Coin", 0.01, false, false, false, minAdminLevel=9},

	[134] = {"NLPack #4", "#A9E8A12xAk-47 #aaaaaa+ #A9E8A12xM4 #aaaaaa+ #A9E8A11200x7.62mm #aaaaaa+ #A9E8A11200x5.52mm #aaaaaa+ #ffd70060M Ft#aaaaaa+ #2AA1EE25.000 NL Coin", 0.01, false, false, false, minAdminLevel=9},

	[135] = {"Húsvéti Tojás", "Vajon mit rejthet?", 0.01, false, false, false, minAdminLevel=9},

	[136] = {"Feszítővas", "Fel tudod vele feszíteni a széfet.", 0.01, false, false, false, minAdminLevel=9},

	[137] = {"Kulcs Másoló Készlet", "Ezzel az eszközzel le tudod másolni a kocsid kulcsát.", 0.01, false, false, false, minAdminLevel=6},

	[138] = {"Drogzsák", "Ebben a fekete nejlonban valamilyen drog lapul.", 0.01, false, false, false, minAdminLevel=9},

	[139] = {"Horgászbot", "Halak és egyéb dolgok kifogására szolgál", 0.01, false, 666, 139},

	[140] = {"Belépő nyakpass", "Egy nyakbaakasztható belépő.", 0.01, true, false, false, minAdminLevel=6},

	--Tengeri világ

	[141] = {"Bakancs", "Kifogható tengeri hulladék", 0.05, false, false, false, minAdminLevel=6},

	[142] = {"Hínár", "Kifogható tengeri hínár", 0.05, false, false, false, minAdminLevel=6},

	[143] = {"Döglött hal", "Kifogható tengeri hal tetem", 0.05, false, false, false, minAdminLevel=6},

	[144] = {"Konzervdoboz", "Kifogható tengeri hulladék", 0.05, false, false, false, minAdminLevel=6},

	[145] = {"Horgászhal", "Kifogható tengeri élőlény", 1, false, false, false, minAdminLevel=6},

	[146] = {"Fehér cápa", "Kifogható tengeri élőlény", 6, false, false, false, minAdminLevel=6},

	[147] = {"Óriás polip", "Kifogható tengeri élőlény", 5, false, false, false, minAdminLevel=6},

	[148] = {"Chauliodus sloani csontos hal", "Kifogható tengeri élőlény", 1, false, false, false, minAdminLevel=6},

	[149] = {"Kardhal", "Kifogható tengeri élőlény", 2, false, false, false, minAdminLevel=6},

	[150] = {"Rák", "Kifogható tengeri élőlény", 1, false, false, false, minAdminLevel=6},

	[151] = {"Sárga doktorhal", "Kifogható tengeri élőlény", 0.7, false, false, false, minAdminLevel=6},

	[152] = {"Hal", "Kifogható tengeri élőlény", 0.5, false, false, false, minAdminLevel=6},

	[153] = {"Harcsa", "Kifogható tengeri élőlény", 0.4, false, false, false, minAdminLevel=6},

	[154] = {"Lazac", "Kifogható tengeri élőlény", 0.3, false, false, false, minAdminLevel=6},

	[155] = {"Kék tengeri csillag", "Kifogható tengeri élőlény", 0.2, false, false, false, minAdminLevel=6},

	[156] = {"Mélytengeri halászhal", "Kifogható tengeri élőlény", 0.7, false, false, false, minAdminLevel=6},

	[157] = {"Kincses láda", "Kincset rejthet", 3, false, false, false, minAdminLevel=9},

	[158] = {"Mélytengeri hal", "Kifogható tengeri élőlény", 0.8, false, false, false, minAdminLevel=6},

	[159] = {"Szakadt háló", "Kifogható tengeri hulladék", 0.2, false, false, false, minAdminLevel=6},

	[160] = {"Doktor hal", "Kifogható tengeri élőlény", 0.05, false, false, false, minAdminLevel=6},

	[161] = {"Pörölycápa", "Kifogható tengeri élőlény", 5, false, false, false, minAdminLevel=6},

	[162] = {"Koi ponty", "Kifogható tengeri élőlény", 1.2, false, false, false, minAdminLevel=6},

	[163] = {"Mauri arany maszk", "Kifogható tengeri kincs", 0.6, false, false, false, minAdminLevel=9},

	[164] = {"Inka arany maszk", "Kifogható tengeri kincs", 0.6, false, false, false, minAdminLevel=9},

	[165] = {"Gyűrű harcsa", "Kifogható tengeri élőlény", 0.4, false, false, false, minAdminLevel=6},

	[166] = {"Gömbhal", "Kifogható tengeri élőlény", 0.3, false, false, false, minAdminLevel=6},

	[167] = {"Vödör maradvány", "Kifogható tengeri élőlény", 0.1, false, false, false, minAdminLevel=6},

	[168] = {"Deszka", "Kifogható tengeri hulladék", 0.1, false, false, false, minAdminLevel=6},

	[169] = {"Cápafog nyaklánc", "Kifogható tengeri kincs", 0.7, false, false, false, minAdminLevel=6},

	[170] = {"Teknős", "Kifogható tengeri élőlény", 2, false, false, false, minAdminLevel=6},

	[171] = {"Makócápa", "Kifogható tengeri élőlény", 5, false, false, false, minAdminLevel=6},

	[172] = {"Nagy aranymakrahal", "Kifogható tengeri élőlény", 2, false, false, false, minAdminLevel=6},

	[173] = {"Tonhal", "Kifogható tengeri élőlény", 1, false, false, false, minAdminLevel=6},

	[174] = {"Rája", "Kifogható tengeri élőlény", 3, false, false, false, minAdminLevel=6},

	[175] = {"Rózsa hal", "Kifogható tengeri élőlény", 1, false, false, false, minAdminLevel=6},

	[176] = {"Zebra hal", "Kifogható tengeri élőlény", 0.5, false, false, false, minAdminLevel=6},

	[177] = {"Kékúszóju tontal", "Kifogható tengeri élőlény", 0.5, false, false, false, minAdminLevel=6},

	[178] = {"Taxi Tábla", false, 0.01, false, false, false, minAdminLevel=9},

	[179] = {"Nyomtatvány", "Egy nyomtatvány", 0.01, true, false, false, minAdminLevel=6},



	--// Skines fegyverek

	--[180] = {"vALAMI FEGYVER","Valami fegyver leírása", 3, false, 30, 5, skin={texture="FegyverNeve",skinImage="Skin elérési útja"}, minAdminLevel=9 },
}

getItemMinimumAdminLevel = function(id)
	local level = 0
	if availableItems[id] then
		if availableItems[id].minAdminLevel then
			level = availableItems[id].minAdminLevel
		end
	end
	return level
end



function isKeyItem(itemId)

	return itemId <= 2 or itemId == 96

end



function isPaperItem(itemId)

	return (itemId >= 100 and itemId <= 104) or (itemId >= 111 and itemId <= 113) or (itemId >= 118 and itemId <= 121) or itemId == 240 or itemId == 372 or itemId ==  373 or itemId == 374  or itemId == 375 or itemId == 376 or itemId == 384

end



function isSpecialItem(itemId)

	return (itemId >= 45 and itemId <= 70) or itemId == 97 or itemId == 98 or itemId == 125 or itemId == 125 or itemId == 126

end



function isFoodItem(itemId)

	return itemId >= 45 and itemId <= 51

end



function isDrinkItem(itemId)

	return itemId >= 52 and itemId <= 70

end



function getFoodItems()

	local items = {}



	for i = 1, #availableItems do

		if isFoodItem(i) then

			table.insert(items, i)

		end

	end



	return items

end



function getDrinkItems()

	local items = {}



	for i = 1, #availableItems do

		if isDrinkItem(i) then

			table.insert(items, i)

		end

	end



	return items

end



function isPhoneItem(itemId)

	return itemId == 71 or itemId == 72

end



specialItemUsage = {

	[97] = 5,

	[98] = 2,

	[125] = 50,

	[126] = 100

}



for i = 45, 70 do

	if i <= 51 then

		specialItemUsage[i] = 50

	else

		specialItemUsage[i] = 5

	end

end



perishableItems = {

    --[66] = 270 -- 4 és fél óra (270 perc)

    [45] = 300,

    [46] = 300,

    [47] = 300,

    [48] = 300,

    [49] = 300,

    [50] = 300,

    [51] = 300,

    [105] = 480, --8 óra, gyógyszer

    [106] = 480, --8 óra, vitamin

    [118] = 2880, -- parkolási bírság

    [119] = 2880, -- bírság

}



perishableEvent = {

	[118] = "ticketPerishableEvent",

	[119] = "ticketPerishableEvent2"

}



function getItemList()

	return availableItems

end



function getItemInfoForShop(itemId)

	return getItemName(itemId), getItemDescription(itemId), getItemWeight(itemId)

end



function getItemNameList()

	local nameList = {}



	for i = 1, #availableItems do

		nameList[i] = getItemName(i)

	end



	return nameList

end



function getItemDescriptionList()

	local descriptionList = {}



	for i = 1, #availableItems do

		descriptionList[i] = getItemDescription(i)

	end



	return descriptionList

end



function getItemName(itemId)

	if availableItems[itemId] then

		return availableItems[itemId][1]

	end

	return false

end



function getItemDescription(itemId)

	if availableItems[itemId] then

		return availableItems[itemId][2]

	end

	return false

end



function getItemWeight(itemId)

	if availableItems[itemId] then

		return availableItems[itemId][3]

	end

	return false

end



function isItemStackable(itemId)

	if availableItems[itemId] then

		return availableItems[itemId][4]

	end

	return false

end



function getItemWeaponID(itemId)

	if availableItems[itemId] then

		return availableItems[itemId][5] or 0

	end

	return false

end



function getItemAmmoID(itemId)

	if availableItems[itemId] then

		return availableItems[itemId][6]

	end

	return false

end



function isWeaponItem(itemId)

	if availableItems[itemId] and getItemWeaponID(itemId) > 0 then

		return true

	end

	return false

end



function isAmmoItem(itemId)

	return (itemId >= 3 and itemId <= 8) or (itemId >= 42 and itemId <= 44)

end



local nonStackableItems = {}



for i = 1, #availableItems do

	if not isItemStackable(i) then

		nonStackableItems[i] = true

	end

end



function getNonStackableItems()

	return nonStackableItems

end



disabledVehicleTypes = {

	["BMX"] = true,

	["Train"] = true,

	["Trailer"] = true

}



function getWeightLimit(elementType, element)

	if element and getElementType(element) == "vehicle" and disabledVehicleTypes[getVehicleType(element)] then

		return 0

	end



	if element and getElementType(element) == "vehicle" then

		if getVehicleType(element) == "Bike" or getVehicleType(element) == "Quad" then

			return 15

		end

	end



	return weightLimits[getElementModel(element)] or defaultSettings.weightLimit[elementType]

end



function isTrashModel(model)

	if defaultSettings.trashModels[model] then

		return true

	end



	return false

end



function isSafeModel(model)

	if model == defaultSettings.safeModel then

		return true

	end



	return false

end



function getElementDatabaseId(element, elementType)

	local elementType = elementType or getElementType(element)



	if elementType == "player" then

		return getElementData(element, "char.ID")

	elseif elementType == "vehicle" then

		return getElementData(element, "vehicle.dbID")

	elseif elementType == "object" then

		if isSafeModel(getElementModel(element)) then

			return getElementData(element, "safe.dbID")

		end

	end

end



local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } } -- numbers/lowercase chars/uppercase chars

function generateString ( len )
    
    if tonumber ( len ) then
        math.randomseed ( getTickCount () )

        local str = ""
        for i = 1, len do
            local charlist = allowed[math.random ( 1, 3 )]
            str = str .. string.char ( math.random ( charlist[1], charlist[2] ) )
        end

        return str
    end
    
    return false
    
end

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 