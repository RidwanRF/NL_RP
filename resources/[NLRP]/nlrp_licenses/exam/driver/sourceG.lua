--[[
questions = {
    [1] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "A közlekedés során ki felügyeli a közlekedés szabályosságát, biztonságát?",
        ["answers"] = {
            [1] = "A lakosság, aki mindig figyel.",
            [2] = "Mindenki, aki a közlekedésben részt vesz.",
            [3] = "A közlekedési hatóság.",
            [4] = "Az Állam rendvédelme.",
        },
        ["good"] = 4,
    },
    
    [2] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Hol olvashatunk a a közlekedéssel kapcsolatos jogsértésekről?",
        ["answers"] = {
            [1] = "San Andreas Állam Büntető törvénykönyvben.",
            [2] = "A polgári törványkönyvben.",
            [3] = "Infokommunikációs eszközzel, ami képes e cél kiszolgálására.",
            [4] = "Nincs lehetőség ilyenre.",
        },
        ["good"] = 1,
    },

    [3] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Kiknek kell rendelkezniük vezetői engedéllyel?",
        ["answers"] = {
            [1] = "Az állam lakosainak.",
            [2] = "Minden sofőrnek, kivétel a rendvédelmi szervezetek tagjainak.",
            [3] = "Akinek szüksége van rá.",
            [4] = "Azok állampolgároknak akik a nyilvános utakon, autópályákon vezetik a gépjárműveiket.",
        },
        ["good"] = 4,
    },

    [4] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Milyen esetben nem a vezetőre szabályk ki a biztonsági öv becsatolás hiányosságát.",
        ["answers"] = {
            [1] = "Ha az utas nem töltötte be a 16. életévét.",
            [2] = "Ha az utas még gyermekkorú.",
            [3] = "Ha a sofőrnek erre hivatalos felmentése van.",
        },
        ["good"] = 1,
    },

    [5] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Kik számára kötelező a biztonsági öv használata?",
        ["answers"] = {
            [1] = "Azon személy számára aki veszélyben érzi magát a forgalomban.",
            [2] = "Az elöl utazoknak.",
            [3] = "A jármű össze utasa számára.",
            [4] = "Elegendő csak jármű vontatás közben.",
        },
        ["good"] = 3,
    },

    [6] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Hány oldalú és milyen színű a STOP tábla?",
        ["answers"] = {
            [1] = "9 oldalú, piros színű.",
            [2] = "6 oldalú, sárga figyelmeztető színű..",
            [3] = "8 oldalú, piros színű.",
        },
        ["good"] = 3,
    },

    [7] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Milyen alakja van az elsőbség adás táblának??",
        ["answers"] = {
            [1] = "Háromszög.",
            [2] = "Lefele egy csúcsot mutató háromszög.",
            [3] = "Felfele egy csúcsot mutató háromszög.",
        },
        ["good"] = 2,
    },

    [8] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mire szólít fel az elsőbség adás tábla?",
        ["answers"] = {
            [1] = "Le kell lassítania és készen kell állnia a megállásra, mivel át kell engednie bármely járművet.",
            [2] = "Le kell lassítania és készen kell állnia a megállásra, mivel át kell engednie bármely járművet, biciklist vagy gyalogost.",
            [3] = "Le kell lassítania és készen kell állnia a megállásra, mivel át kell engednie bármely járművet, vagy gyalogost.",
        },
        ["good"] = 2,
    },

    [9] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Jobbkéz szabály elve szerint egy jobbról érkező járművel szemben elsőbbsége van?",
        ["answers"] = {
            [1] = "Igen elsőbbségem van.",
            [2] = "Ha lemondok az elsőbbségemről akkor ezt a jogom elvesztem, így nincsen.",
            [3] = "Nincs elsőbbségem.",
        },
        ["good"] = 3,
    },

    [10] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Los Santos városán megengedett nyílvános útjain mennyi a megengedett maximális sebesség?",
        ["answers"] = {
            [1] = "50 MPH.",
            [2] = "70 MPH.",
            [3] = "65MPH.",
        },
        ["good"] = 3,
    },

    [11] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mennyi a maximálisan megengedett sebesség a négysávos útszakoszokon?",
        ["answers"] = {
            [1] = "90 MPH.",
            [2] = "70 MPH.",
            [3] = "45MPH.",
        },
        ["good"] = 1,
    },

    [12] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Los Santos városán kívűl megengedett maximális sebesség?",
        ["answers"] = {
            [1] = "60 MPH.",
            [2] = "75 MPH.",
            [3] = "95 MPH.",
        },
        ["good"] = 2,
    },

    [13] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Los Santos városán megengedett nyílvános útjain mennyi a megengedett maximális sebesség?",
        ["answers"] = {
            [1] = "50 MPH.",
            [2] = "70 MPH.",
            [3] = "65MPH.",
        },
        ["good"] = 1,
    },

    [14] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mikor használd a dudát?",
        ["answers"] = {
            [1] = "Traffipax jelzése miatt a másik autósnak.",
            [2] = "Riadalom keltés céljából.",
            [3] = "Csak akkor, ha mindenképpen szükséges a baleset elkerülése érdekében..",
        },
        ["good"] = 3,
    },

    [15] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mikor NE használd a dudát?",
        ["answers"] = {
            [1] = "Ha egy másik jármű túl lassan halad, és ön azt szeretné, hogy gyorsabban haladjanak.",
            [2] = "Ha egy szűk útszakaszon halad a gépjárművel.",
            [3] = "Ha valami forgalmas csomóponthoz ért.",
        },
        ["good"] = 1,
    },

    [16] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Egy igazoltatás során mikor szállhat ki a járműből?",
        ["answers"] = {
            [1] = "Ha elkérik az iratait és át kell adja.",
            [2] = "Ha a rendőr arra utasítja önt.",
            [3] = "Amint félre áll a járművel a rendőr utasítására azon nyomban ki kell szállnia.",
        },
        ["good"] = 2,
    },

    [17] = {
        ["image"] = ":nlrp_licenses_OLD/150x150.png",
        ["question"] = "Los Santos városán megengedett nyílvános útjain mennyi a megengedett maximális sebesség?",
        ["answers"] = {
            [1] = "50 MPH.",
            [2] = "70 MPH.",
            [3] = "65MPH.",
        },
        ["good"] = 1,
    },

    [18] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mit jelent a pirossal áthúott tábla?",
        ["answers"] = {
            [1] = "Tilos.",
            [2] = "A tábla szabályozó végét.",
            [3] = "Település végét.",
        },
        ["good"] = 1,
    },

    [19] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mit jelent a sárga és fekete kör alakú jelzés?",
        ["answers"] = {
            [1] = "Egyenrangú kereszteződés.",
            [2] = "Veszélyes anyag kerülhet az útra.",
            [3] = "Vasúti átjáróhoz közeledik.",
        },
        ["good"] = 3,
    },

    [20] = {
        ["image"] = ":nlrp_licenses/150x150.png",
        ["question"] = "Mit jelent a 4-oldalú gyémánt alakú jelzés?",
        ["answers"] = {
            [1] = "Középület közelettét jelöli.",
            [2] = "Figyelmezteti önt a különleges útviszonyokra.",
            [3] = "Nem kell figyelembe venni.",
        },
        ["good"] = 2,
    },
}]]


questions = {
    [1] = {
        ["image"] = false,
        ["question"] = "Adhat-e hangjelzést kikerülési szándékának jelzésére?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Talán",
            [3] = "Csak akkor ha észleli ha valaki már előzi",
            [4] = "Nem",
        },
        ["good"] = 4,
    },
    
    [2] = {
        ["image"] = false,
        ["question"] = "Olyan párhuzamos közlekedésre alkalmas úttesten közlekedik ahol a forgalmi sávokat elválasztó útburkolati jelek nem láthatók. Hol közlekedhet folyamatosan, ha az úton jelentéktelen a járműforgalom?",
        ["answers"] = {
            [1] = "A jobb szélső forgalmi sávban.",
            [2] = "Lakott területen bármelyik, lakott területen kívül a jobb szélső forgalmi sávban.",
            [3] = "Bármelyik forgalmi sávban.",
            [4] = "A bal szélső forgalmi sávban.",
        },
        ["good"] = 1,
    },

    [3] = {
        ["image"] = false,
        ["question"] = "Szabad-e megfordulni kijelölt gyalogos átkelőhelyen?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Csak éjszaka",
            [3] = "Csak ha éppen gyalogosok haladnak azon át",
            [4] = "Nem",
        },
        ["good"] = 1,
    },

    [4] = {
        ["image"] = false,
        ["question"] = "Szabad-e hátramenetet végezni villamos pályán?",
        ["answers"] = {
            [1] = "Nem",
            [2] = "Csak ha a villamos nem közlekedik",
            [3] = "Igen",
            [4] = "Csak ha senki nem látja"
        },
        ["good"] = 3,
    },

    [5] = {
        ["image"] = false,
        ["question"] = "A három külön úttesttel rendelkező út középső úttestjén...",
        ["answers"] = {
            [1] = "Megállni tilos",
            [2] = "Megállhat, de nem várakozhat",
            [3] = "Megállni, várakozni egyaránt szabad",
            [4] = "Tolatva kell közlekedni",
        },
        ["good"] = 2,
    },

    [6] = {
        ["image"] = false,
        ["question"] = "Mekkora a személygépkocsik megengedett legnagyobb sebessége lakott területen?",
        ["answers"] = {
            [1] = "50 km/h",
            [2] = "70 km/h",
            [3] = "30 km/h",
            [4] = "Amennyivel csak tudok menni",
        },
        ["good"] = 1,
    },

    [7] = {
        ["image"] = false,
        ["question"] = "Szállíthat-e motorkerékpárja oldalkocsijában két, 10 éven aluli gyermeket?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Csak akkor, ha az oldalkocsiban két ülés van.",
            [3] = "Nem",
            [4] = "Csak akkor ha az eggyik háttal ül a forgalomnak",
        },
        ["good"] = 1,
    },

    [8] = {
        ["image"] = false,
        ["question"] = "Legfeljebb mekkora sebességgel haladhat a teherszállításra kialakított motoros triciklijével?",
        ["answers"] = {
            [1] = "20 km/h sebességgel.",
            [2] = "40 km/h sebességgel.",
            [3] = "50 km/h sebességgel.",
            [4] = "30 km/h sebességgel.",
        },
        ["good"] = 2,
    },

    [9] = {
        ["image"] = false,
        ["question"] = "Közlekedhet-e főútvonal melletti kerékpárúton 12 éven aluli gyermek?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Igen, de csak kísérővel",
            [3] = "Nem",
            [4] = "Igen, de csak este",
        },
        ["good"] = 1,
    },

    [10] = {
        ["image"] = false,
        ["question"] = "Szabad-e kerékpárt más járművel vontatni?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Csak megfelelő út- és látási viszonyok között",
            [3] = "Nem",
            [4] = "Csak másik kerékpárral",
        },
        ["good"] = 3,
    },

    [11] = {
        ["image"] = false,
        ["question"] = "Segédmotoros kerékpáron szabad-e utast szállítani?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Nem",
            [3] = "Csak ha a vezető elmúlt 18 éves, és utasa 10 éven aluli",
            [4] = "Csak határon kívül",
        },
        ["good"] = 2,
    },

    [12] = {
        ["image"] = false,
        ["question"] = "Mekkora lehet a legnagyobb sebessége személygépkocsinak az autópályán?",
        ["answers"] = {
            [1] = "90 km/h",
            [2] = "100 km/h",
            [3] = "130 km/h",
            [4] = "120 km/h",
        },
        ["good"] = 3,
    },

    [13] = {
        ["image"] = ":nlrp_licenses/files/13.png",
        ["question"] = "Miként hat a zaj a gépkocsivezető szervezetére?",
        ["answers"] = {
            [1] = "Fokozza a vezető éberségét",
            [2] = "Ingerültséget, fáradtságot okoz",
            [3] = "Fejfájást okoz",
            [4] = "Semmit nem okoz",
        },
        ["good"] = 2,
    },

    [14] = {
        ["image"] = false,
        ["question"] = "Zuhogó eső miatt korlátozottak a látási viszonyok. Mikor kell kivilágítani a forgalomban részt vevő személygépkocsit?",
        ["answers"] = {
            [1] = "Csak éjszaka",
            [2] = "Minden esetben",
            [3] = "Csak lakott területen kívül",
            [4] = "Csak ha nem látok semmit",
        },
        ["good"] = 2,
    },

    [15] = {
        ["image"] = false,
        ["question"] = "Az alábbiak közül mit a legnehezebb felmérni előzéskor?",
        ["answers"] = {
            [1] = "A szükséges oldaltávolságot.",
            [2] = "A szembejövő jármű méreteit.",
            [3] = "A szembejövő jármű sebességét.",
            [4] = "",
        },
        ["good"] = 3,
    },

    [16] = {
        ["image"] = false,
        ["question"] = "Kell-e irányjelezni elinduláskor és megálláskor?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Nem",
            [3] = "Csak elinduláskor",
            [4] = "Csak megálláskor",
        },
        ["good"] = 1,
    },

    [17] = {
        ["image"] = false,
        ["question"] = "Ha nincs felfestve vonal az úttestre a STOP táblánál, akkor mi a teendő?",
        ["answers"] = {
            [1] = "Figyelmen kívűl hagyni a jelzést",
            [2] = "Azonnali megállás",
            [3] = "Megállni mielőtt belépünk a kereszteződésbe",
            [4] = "Ez az elsőbbséget jelenti számomra",
        },
        ["good"] = 3,
    },

    [18] = {
        ["image"] = false,
        ["question"] = "Megelőzhet-e gépkocsijával, a táblával jelzett útkereszteződésben egy kétkerekű motorkerékpárt?",
        ["answers"] = {
            [1] = "Igen",
            [2] = "Nem",
            [3] = "Csak ha nem esik az eső",
            [4] = "Csak ha jelzetta kerékpáros hogy mehetek",
        },
        ["good"] = 1,
    },

    [19] = {
        ["image"] = false,
        ["question"] = "Milyen alakú és színű a STOP tábla?",
        ["answers"] = {
            [1] = "8 oldalú, fehér színű",
            [2] = "8 oldalú, piros színű",
            [3] = "4 oldalú, piros színű",
            [4] = "3 oldalú, sárga színű",
        },
        ["good"] = 2,
    },

    [20] = {
        ["image"] = false,
        ["question"] = "Egy szirénázó mentőautó jön maga mögött, mit tesz?",
        ["answers"] = {
            [1] = "Gyorsítok, hisz mi van ha engem kerget",
            [2] = "Lassítok majd félrehúzódok, ezzel helyet adok neki.",
            [3] = "Megálok ott ahol vagyok",
            [4] = "Nemtudom",
        },
        ["good"] = 2,
    },

    [21] = {
        ["image"] = false,
        ["question"] = "Mi a tendő ha egy rendőr félreállít?",
        ["answers"] = {
            [1] = "Elhajtok",
            [2] = "Félreállok és várok",
            [3] = "Követem az utasításait",
            [4] = "Megállok ott ahol vagyok",
        },
        ["good"] = 2,
    },
}

drivePositions = {
    {
        ["position"] = {1047.9250488281, -1494.5432128906, 13.387801170349},
        ["speedlimit"] = 60,
    },
    {
        ["position"] = {1034.9056396484, -1583.8485107422, 13.3828125},
        ["speedlimit"] = 60,
    },
    {
        ["position"] = {1017.53125, -1792.9180908203, 13.813630104065},
        ["speedlimit"] = 60,
    },
	{
	    ["position"] = {897.87280273438, -1768.7958984375, 13.3828125},
        ["speedlimit"] = 60,
	},
    {
        ["position"] = {813.31011962891, -1747.5073242188, 13.3828125},
        ["speedlimit"] = 60,
	},
    { 
	    ["position"] = {820.58862304688, -1596.1961669922, 13.3828125},
        ["speedlimit"] = 60,
	},
    {	
	    ["position"] = {776.04016113281, -1567.2912597656, 13.384543418884},
        ["speedlimit"] = 60,
	},	
    {
        ["position"] = {800.09185791016, -1413.7043457031, 13.394305229187},
        ["speedlimit"] = 60,	
	},
    {	
	    ["position"] = {1032.4034423828, -1407.4915771484, 13.115085601807},
        ["speedlimit"] = 60,
	},	
	     
    --[[{
        ["position"] = {847.18054199219, -1766.5688476563, 13.386378288269},
        ["speedlimit"] = 25,
    },
    {
        ["position"] = {724.80291748047, -1754.6217041016, 14.399353027344},
        ["speedlimit"] = 25,
    },
    {
        ["position"] = {634.36779785156, -1699.55078125, 14.866591453552},
        ["speedlimit"] = 25,
    },--]]
}