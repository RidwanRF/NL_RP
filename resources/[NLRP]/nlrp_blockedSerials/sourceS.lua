
local blockedSerials = {
	["2BF67E21EAA1D4795F162CBC61072CA4"] = true, --floodos gyerek
	["73F4A174994875009AD550D83442CAF3"] = true, -- MONSTER
	["A2DFD8262A56659F99F80E7C53E2B7F2"] = true, -- milan123 
	["7D7AC99556E464082D619A8EE62C86E3"] = true, -- Meheszm06
	["01F3C54CEF90AFB6FEE851E6AEA63492"] = true, --szkiddaj
	["CC0FD9D5065233298CD92820B7B68D13"] = true, --Nico
	["5B408E4932ACFD87C7DD83467361FB93"] = true, --Flash
	["3CF4BBA09C9556C46A7DBE359C37F902"] = true, --Valami kis kölyök aki beugat voiceba amikor csatlakozik fel Krisztian Bandahj
	["61BCC140ACB312EC17E10832EB716993"] = true, --Zlx1 faszom izé
	["6A9B1BC62A8B6A0662B262F92E0351A2"] = true, --Almaspite
	["C1C4B25C812985FA349AB8AE88A4CE44"] = true, --ThirstySpoon
	["D96EA31F9F1B6890966B762A5D987902"] = true, --Valami veréb, hírdetett és " A jó kurva anyádnak csinálsz ilyen szar szervert"
	["AA3FDC724B148BFE19B0773F12467EF4"] = true, --Lakatos János - SARP EDIT
	["14F4965A5469BBB97318B753118B9994"] = true, --zsoltika10 transporternél megsétáltattuk.
--	["99AAEDC1D1EC47F81AEFB459E34CED94"] = true, --Freonidas  -  freonidas0007@gmail.com  -  Issei_Hyoudou  -  Pénz buggoltatás a kaszinóban.
    ["83E1FDA1C3372E6E73749EF7CE11F544"] = true, --Nyomorék gyerek bann helyett
	["CEEAACC8068C68D83B0C2AAFA5E36994"] = true, --Társa
	["DC312A6635327EAB33108A5CF0C2E644"] = true, --Szerver flood
	["142FB9ABB0FC55634FC97FA499835E43"] = true, --Szerver flood Balog Roland
	["E4AE012ACDFE774181C6D58C6AE90FB3"] = true, --Szerver flood
	["5E134BCBBB7A88C767CBFD65034F8DA3"] = true, --Szerver flood
	["5197D8C23C8597DEDE92FCB08C0FDD02"] = true, --Szerver flood
	["BB98C5E192C0BEC2AB9B58358334BD53"] = true, --Szerver flood
	["0F6E0ACA6B7C9F7369AEC59431A696A1"] = true, --
	["DC312A6635327EAB33108A5CF0C2E644"] = true, --Pénzbuggoltató (zer0cska)
	["3B7B461D122B3C216A4BC05422D71243"] = true, --Pénzbuggoltató Zsuko
}

addEventHandler("onPlayerConnect",root,
	function(_,_,_,serial)
		if blockedSerials[serial] then
			cancelEvent()
		end
	end
)