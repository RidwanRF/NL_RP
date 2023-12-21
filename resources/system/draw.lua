local kepS = {guiGetScreenSize()}

-- Fontok rajzolása
function getFontEleres(font)
	return "fontok/"..font
end

local fontok = {
	bankgthd = dxCreateFont (getFontEleres("bankgthd.ttf"), 12 ),
	nagybankgthd = dxCreateFont (getFontEleres("bankgthd.ttf"), 24 ),
	ikonfont = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 48 ),
	ikonfontnek = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 32 ),
	ikonfontonk = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 31 ),
	miniikonfont = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 4 ),
	miniikonfont_n = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 6 ),
	kisikonfont = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 18 ),
	nagyikonfont = dxCreateFont (getFontEleres("fontawesome-webfont.ttf"), 120 ),

	-- Open Sans Font
	helveti_caneue = dxCreateFont (getFontEleres("helveticaneue.otf"), 6 ),
	helveti_caneue_n = dxCreateFont (getFontEleres("helveticaneue.otf"), 7 ),
	helveti_caneue_na = dxCreateFont (getFontEleres("helveticaneue.otf"), 10 ),
	helveti_caneue_nagy = dxCreateFont (getFontEleres("helveticaneue.otf"), 14 ),
	helveti_caneue_bold = dxCreateFont (getFontEleres("helveticaneuebold.otf"), 9, true ),
	helveti_caneue_bold_nagy = dxCreateFont (getFontEleres("helveticaneuebold.otf"), 14, true ),
	helveti_caneue_bold_k = dxCreateFont (getFontEleres("helveticaneuebold.otf"), 8, true ),

	opensans_semi = dxCreateFont (getFontEleres("opensans_semi.ttf"), 12 ),
	opensans_bold = dxCreateFont (getFontEleres("opensans_bold.ttf"), 12 ),

	nagyopensans_semi = dxCreateFont (getFontEleres("opensans_semi.ttf"), 24 ),
	nagyopensans_bold = dxCreateFont (getFontEleres("opensans_bold.ttf"), 24 ),

	digitalis = dxCreateFont (getFontEleres("digitalis.ttf"), 24 ),

	gtafont = dxCreateFont (getFontEleres("gtafont.ttf"), 35 ),
	corefont = dxCreateFont (getFontEleres("corefont.ttf"), 24 ),

	coredashfont = dxCreateFont (getFontEleres("coredashfont.otf"), 20 ),

	-- Alap Fontok
	default = "default",
}

function fontSzovegRender(szoveg, x, y, b, f, szin, meret, font, ax, ay, clip, szotores, postgui, rot, rotx, roty, fszin)
	if not fszin then fszin = true end
	dxDrawText ( szoveg, x, y, x+b, y+f, szin, meret, fontok[font], ax, ay, clip, szotores, postgui, fszin, false, rot, rotx, roty )
end

function formInputRajzolas(x,y,sz,m,ertek)
	--formDobozRajzolasa(x,y,sz,m,tocolor(40,40,40,50),tocolor(80,80,80,50))
	fontSzovegRender(ertek,x+5,y,sz-10,m, tocolor(255,255,255,255), 1, "default", "left", "center", true, false, false)
end


-- Font Ikonok
-- UNICODE KERESÉS http://unicode-table.com/en
local fikonok = {
	figyelmeztetes = "",
	hiba = "",
	info = "",
	sikeres = "",
	fa_info = "",
	fa_phone = "",
	fa_toggle_right = "",
	fa_toggle_left = "",
	fa_toggle_down = "",
	fa_lock = "",
	fa_unlock = "",
	fa_map_marker = "",
	fa_user = "",
	fa_clock_o = "",
	fa_female = "",
	fa_male = "",
	fa_heart = "",
	fa_shield = "",
	fa_cutlery = "",
	fa_plus = "",
	fa_plus_square_o = "",
	fa_plus_square = "",
	fa_pencil = "",
	fa_eye = "",
	arrow_cricle_o_right = "",
	arrow_cricle_o_left = "",
	fa_arrow_left = "",
	fa_arrow_right = "",
	fa_arrow_down = "",
	sort_desc = "",
	sort_asc = "",
	fa_birthday_cake = "",
	fa_angle_double_left = "",
	fa_sign_out = "",
	fa_ellipsis_v = "",
	fa_gear = "",
	fa_list_ul = "",
	fa_check = "",
	fa_times = "",
	fa_trophy ="",
	fa_crosshairs ="",
	fa_toggle_off = "",
	fa_toggle_on = "",
	diamond = "",
	fa_car = "",
	fa_folder = "",
	fa_spinner = "",
	fa_ban = "",
	fa_dev = "",
	fa_check_square = "",
	fa_minus_square = "",
	fa_square_o = "",
	fa_check_square_o = "",
	fa_close = "",
	fa_users = "",
	fa_home = "",
	fa_suitcase = "",
	fa_briefcase = "",
	fa_cubes = "",
	fa_archive = "",
	fa_certificate = "",
	fa_star = "",
	fa_chat = "",
	fa_medikit = "",
	fa_trello = "",
	fa_building = "",
	fa_bank = "",
	fa_shopping_cart = "",
	fa_money = "",
	fa_mastercard = "",
	fa_visa = "",
	fa_amex = "",
	fa_paypal = "",
	fa_fire = "",
	fa_adm = "",
	admin = "",
	fa_techometer = "",
	fa_credit_card = "",
	fa_calendar = "",
	fa_signal = "",
	ban = "",
	kick = "",
	borton = "",
	fa_circle_tin = "",
	fa_circle = "",
	fa_angle_right = "",
	fa_microphone_slash = "",
	fa_microphone = "",
	fa_volume_off = "",
	fa_volume_up = "",
	fa_th = "",
	fa_chevron_circle_left = "",
	fa_dashboard = "",
	fa_tree = "",
	fa_trash = "",
	fa_leaf = "",
	fa_paint_brush = "",
	fa_sign_out = "",
	fa_long_arrow_up = "",
	fa_long_arrow_down = "",
	fa_long_arrow_right = "",
	fa_long_arrow_left = "",
	fa_cog = "",
	fa_power_off = "",
	fa_sort = "",
	fa_arrow_circle_up = "",
	settings = "",
	belepes = "",
	gamepad = "",
	volume1 = "",
	volume2 = "",
	volume3 = "",
	sizeR = "",
	sizeVekony = "",
	recycle = "",
}

function getIkonByNev(nev)
	return fikonok[nev] or "?"
end

function ikonRender(ikon, x, y, szin, meret, rotacio)
	dxDrawText ( getIkonByNev(ikon), x, y, kepS[1], kepS[2], szin, meret, fontok["ikonfont"], "left", "top", false, false, false, false, false, rotacio, x+getIkonSzelesseg(ikon, meret)/2, y+getIkonSzelesseg(ikon, meret)/2)
end

function ikonHatterrel(ikon, x, y, w, h, color, meret)
	local textWithoutHEX = getIkonByNev(ikon)
	dxDrawText(textWithoutHEX, x - 1, y - 1, w - 1, h - 1, tocolor(0, 0, 0, 255), meret, fontok["ikonfont"])
	dxDrawText(textWithoutHEX, x - 1, y + 1, w - 1, h + 1, tocolor(0, 0, 0, 255), meret, fontok["ikonfont"])
	dxDrawText(textWithoutHEX, x + 1, y - 1, w + 1, h - 1, tocolor(0, 0, 0, 255), meret, fontok["ikonfont"])
	dxDrawText(textWithoutHEX, x + 1, y + 1, w + 1, h + 1, tocolor(0, 0, 0, 255), meret, fontok["ikonfont"])
	dxDrawText(getIkonByNev(ikon), x, y, w, h, color, meret, fontok["ikonfont"])
end

function kisIkonRender(ikon, x, y, szin, meret, rotacio)
	dxDrawText ( getIkonByNev(ikon), x, y, kepS[1], kepS[2], szin, meret, fontok["kisikonfont"], "left", "top", false, false, false, false, false, rotacio, x+getIkonSzelesseg(ikon, meret)/2, y+getIkonSzelesseg(ikon, meret)/2)
end

function getFontSzelesseg(szoveg, meret, font)
	return dxGetTextWidth ( szoveg, meret, fontok[font] )
end

function getIkonSzelesseg(ikon, meret)
	return dxGetTextWidth ( getIkonByNev(ikon), meret, fontok["ikonfont"] )
end

function getIkonMagassag(meret)
	return dxGetFontHeight ( fontok["ikonfont"], meret )
end

-- FORMOK rajzolása
local dobozB = {15, 3} -- Mennyit kell levonni szélből
local dobozS = {17, 1, 0, 5} -- Méretek (Hossz, Szelsseg, ???, Padding)

function formDobozRajzolasa(x, y, sz, m, hszin, kszin, elore)
	-- Keret
	dxDrawRectangle ( x, y+dobozS[4]/2-2, 1, m-dobozS[4]+4, kszin or tocolor(60,63,63,255), elore) -- Bal oldal
	dxDrawRectangle ( x+sz-(dobozS[1]-dobozB[1]-1), y+dobozS[4]/2-1, 1, m-dobozS[4]+3, kszin or tocolor(60,63,63,255), elore) -- Jobb oldal
	dxDrawRectangle ( x+dobozS[4]/2-2, y, sz-dobozS[4]+5, 1, kszin or tocolor(60,63,63,255), elore) -- Teteje oldal
	dxDrawRectangle ( x+dobozS[4]/2-3+1, y+m-(dobozS[1]-dobozB[1]-1), sz-dobozS[4]+5, 1, kszin or tocolor(60,63,63,255), elore) -- Alja oldal

	dxDrawRectangle(x+1, y+1, sz-2, m-2, hszin or tocolor(60,63,63,100), elore)
end

function toolTipRajzolas(szoveg, x, y, sz, m, alpha, tmsz, tmm, elore)
	local egerX, egerY = getCursorPosition()
	if not egerX or not egerY then return end
	local valpha = 150
	if(alpha) then
		valpha = alpha
	end
	if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
		local maxsz, maxm = dxGetTextWidth ( szoveg, 0.7, fontok["opensans_semi"] )+20, 25
		formDobozRajzolasa(x+sz, y-10, math.min(maxsz,tmsz or maxsz), math.min(maxm,tmm or maxm), tocolor(20,20,20,valpha), tocolor(40,40,40,valpha+30), elore)
		fontSzovegRender(szoveg,x+sz,y-10,math.min(maxsz,tmsz or maxsz),math.min(maxm,tmm or maxm), tocolor(255,255,255,200), 0.7, "opensans_semi", "center", "center", true, true, elore)
	end
end

function toolTipRajzolasEgerrel(szoveg, x, y, sz, m, minusertek, alpha, tmsz, tmm, elore)
	local egerX, egerY = getCursorPosition()
	if not egerX or not egerY then return end
	local valpha = 150
	if(alpha) then
		valpha = alpha
	end
	if not minusertek then
		minusertek = 0
	end
	if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
		local maxsz, maxm = dxGetTextWidth ( szoveg, 0.7, fontok["opensans_semi"] )+20, 25
		formDobozRajzolasa(egerX*kepS[1]-minusertek, egerY*kepS[2], math.min(maxsz,tmsz or maxsz), math.min(maxm,tmm or maxm), tocolor(20,20,20,valpha), tocolor(40,40,40,valpha+30), elore)
		fontSzovegRender(szoveg,egerX*kepS[1]-minusertek,egerY*kepS[2],math.min(maxsz,tmsz or maxsz),math.min(maxm,tmm or maxm), tocolor(255,255,255,200), 0.7, "opensans_semi", "center", "center", true, true, elore)
	end
end

function formDobozRajzolasaCimmel(x, y, sz, m, hszin, kszin, cszin, cimhossz)
	-- Keret
	dxDrawRectangle ( x, y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255)) -- Bal oldal
	dxDrawRectangle ( x+sz-(dobozS[1]-dobozB[1]-1), y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255)) -- Jobb oldal
	dxDrawRectangle ( x+dobozS[4]/2, y, sz-dobozS[4], 1, kszin or tocolor(60,63,63,255)) -- Teteje oldal
	dxDrawRectangle ( x+dobozS[4]/2, y+m-(dobozS[1]-dobozB[1]-1), sz-dobozS[4], 1, kszin or tocolor(60,63,63,255)) -- Alja oldal

	dxDrawRectangle(x+1, y+1, sz-2, m-2, hszin or tocolor(60,63,63,100))

	dxDrawRectangle (x+1, y+1, sz-2, cimhossz or 25, cszin or tocolor(40,40,40,50))
end


function formGombRajzolas(x,y,sz,m,nev,ikon)
	local kiegmeret = 0
	local egerX, egerY = getCursorPosition()
	local peremSzin = {80,80,80}
	local gombSotet = 20
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			gombSotet = 40
			peremSzin = exports.sas_dashboard:getInterfaceColor()
		end
	end
	formDobozRajzolasa(x,y,sz,m,tocolor(gombSotet,gombSotet,gombSotet,50),tocolor(peremSzin[1],peremSzin[2],peremSzin[3],50))
	if(ikon) then -- Ha van ikon akkor eltoljuk méret szerint
		kiegmeret = getIkonSzelesseg(ikon, 0.2)+5
		fontSzovegRender( getIkonByNev(ikon),x+5,y,kiegmeret,m, tocolor(255,255,255,150), 0.55, "kisikonfont", "center", "center", true, false, false)

	end
	fontSzovegRender(nev,x+5+kiegmeret,y,sz-10-kiegmeret,m, tocolor(255,255,255,150), 0.8, "opensans_semi", "center", "center", true, false, false)

end

function formGombRajzolas2(x,y,sz,m,nev,ikon)
	local kiegmeret = 0
	local egerX, egerY = getCursorPosition()
	local peremSzin = {80,80,80}
	local gombSotet = 20
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			gombSotet = 40
			peremSzin = exports.cg_dashboard:getInterfaceColor()
		end
	end
	formDobozRajzolasa(x,y,sz,m,tocolor(gombSotet,gombSotet,gombSotet,50),tocolor(peremSzin[1],peremSzin[2],peremSzin[3],50))
	if(ikon) then -- Ha van ikon akkor eltoljuk méret szerint
		kiegmeret = getIkonSzelesseg(ikon, 0.2)+5
		fontSzovegRender( getIkonByNev(ikon),x+5,y,kiegmeret,m, tocolor(255,255,255,150), 0.55, "kisikonfont", "center", "center", true, false, false)

	end
	fontSzovegRender(nev,x+5+kiegmeret,y,sz-10-kiegmeret,m, tocolor(255,255,255,150), 0.8, "opensans_semi", "center", "center", true, false, false)

end

function dxDrawClickableRectangle(x,y,sz,m,color,postgui)
	local egerX, egerY = getCursorPosition()
	local gombSotet = 200
	if not color then
		color = {0,0,0}
	end
	if not postgui then
		postgui = false
	end
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			gombSotet = 255
		end
	end
	dxDrawRectangle(x,y,sz,m,tocolor(color[1], color[2], color[3], gombSotet),postgui)
end


function gombRajzolasSzinnel(x,y,sz,m,szin)
	local kiegmeret = 0
	local egerX, egerY = getCursorPosition()
	local peremAlpha = 0
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			peremAlpha = 200
		end
	end
	formDobozRajzolasa(x,y,sz,m,szin,tocolor(255,255,255,peremAlpha))
end

function formFeketeFeher(x,y,sz,m,szoveg,alpha,minusertek,meret,font,valtozo,valtozomaxertek)
	local egerX, egerY = getCursorPosition()
	local gombSotet = 0
	local szovegszin = 255
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			gombSotet = 255
			szovegszin = 0
		end
	end
	if valtozo and valtozomaxertek then
		if valtozo == valtozomaxertek then
			gombSotet = 255
			szovegszin = 0
		end
	end
	dxDrawRectangle(x,y,sz,m,tocolor(gombSotet,gombSotet,gombSotet,alpha or 255))
	if not minusertek then
		minusertek = 0
	end
	if(szoveg) then
		fontSzovegRender( szoveg,x+5-minusertek,y,sz,m, tocolor(szovegszin,szovegszin,szovegszin,255), meret or 0.6, font or "coredashfont", "center", "center", true, false, false)
	end
end

function formIkonosGombRajzolas(x,y,sz,m,nev,szin)
	local kiegmeret = 0
	local egerX, egerY = getCursorPosition()
	local peremSzin = {80,80,80}
	local gombSotet = 20
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			gombSotet = 40
			peremSzin = alapBeallitasok["szerverSzin"]["rgb"]
		end
	end
	formDobozRajzolasa(x,y,sz,m,tocolor(gombSotet,gombSotet,gombSotet,50),tocolor(peremSzin[1],peremSzin[2],peremSzin[3],50))
	fontSzovegRender( getIkonByNev(nev),x+5+kiegmeret,y,sz-10-kiegmeret,m, szin or tocolor(255,255,255,150), 0.2, "ikonfont", "center", "center", true, false, false)

end

function formGombAlphavalRajzolas(x,y,sz,m,alpha,nev,ikon) -- ez jó
	local kiegmeret = 0
	local egerX, egerY = getCursorPosition()
	local peremSzin = {80,80,80}
	local gombSotet = 20
	if(egerX and egerY) then
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then
			gombSotet = 40
			peremSzin = alapBeallitasok["szerverSzin"]["rgb"]
		end
	end
	formDobozRajzolasa(x,y,sz,m,tocolor(gombSotet,gombSotet,gombSotet,alpha),tocolor(peremSzin[1],peremSzin[2],peremSzin[3],alpha))
	if(ikon) then -- Ha van ikon akkor eltoljuk méret szerint
		kiegmeret = getIkonSzelesseg(ikon, 0.2)+5
		ikonRender(ikon, x+5,y+4, tocolor(255,255,255,150), 0.2, 0)
	end
	fontSzovegRender(nev,x+5+kiegmeret,y,sz-10-kiegmeret,m, tocolor(255,255,255,150), 0.8, "opensans_semi", "center", "center", true, false, false)

end

local menuKlikkTimer = nil
function formMenuRajzolas(x,y,sz,m,panelsz,adat)
	local egerX, egerY = getCursorPosition()
	local ikonbaVan = false
	local menubeVan = false
	if(egerX and egerY) then -- Ha az egér látszik ^^
		if(dobozbaVan(x,y,sz,m,egerX*kepS[1], egerY*kepS[2])) then -- Ikonba van az egér
			ikonbaVan = true
			if(getKeyState("mouse1") and not menuKlikkTimer) then -- Ha kattint és a panelünk még nincs megjelenítve!
				adat[1] = not adat[1]
				adat[2] = nil
				menuKlikkTimer = true
				setTimer(function() menuKlikkTimer = nil end, 500, 1)
			end
		end
	end
	if adat[1] then -- Ha megvan jelenítve csak akkor renderel!
		local menuMagassag = 25
		dxDrawRectangle(x, y, sz, m, tocolor(40,40,40,150))
		dxDrawRectangle(x, y, sz, 1, tocolor(40,40,40,255)) -- Felső
		dxDrawRectangle(x, y, 1, m, tocolor(40,40,40,255)) -- Balos
		dxDrawRectangle(x+sz-1, y, 1, m, tocolor(40,40,40,255)) -- Jobbos
		dxDrawRectangle(x+sz-panelsz, y+m-1, panelsz-sz, 1, tocolor(40,40,40,255)) -- Alsó

		for az, menu in ipairs(adat[3]) do
			local ux, uy = x+sz-panelsz, y+m+((az-1)*menuMagassag)
			local hatterSzin = {40,40,40}
			dxDrawRectangle(ux, uy, panelsz, menuMagassag, tocolor(40,40,40,150))
			if(egerX and egerY) then -- Ha az egér látszik ^^
				if(dobozbaVan(ux, uy, panelsz, menuMagassag,egerX*kepS[1], egerY*kepS[2])) then
					menubeVan = true
					local alapBeallitasok = exports['sas_system']:getAlapBeallitasok()
					local szin = alapBeallitasok["szerverSzin"]["rgb"]
					dxDrawRectangle(ux, uy, panelsz, menuMagassag, tocolor(szin[1],szin[2],szin[3],100))
					if(getKeyState("mouse1")) then -- Kiválasztás
						adat[1] = false
						adat[2] = az
					end
				end
			end

			dxDrawRectangle(ux, uy, panelsz, menuMagassag, tocolor(hatterSzin[1],hatterSzin[2],hatterSzin[3],170))
			dxDrawRectangle(ux, uy, 1, menuMagassag, tocolor(40,40,40,255)) -- Balos
			dxDrawRectangle(ux+panelsz-1, uy, 1, menuMagassag, tocolor(40,40,40,255)) -- Jobbos
			fontSzovegRender(menu,ux, uy, panelsz, menuMagassag, tocolor(255,255,255,150), 0.8, "opensans_semi", "center", "center", true, false, false)
			local elvAlpha = 100
			if(az == #adat[3]) then -- Az utolsó pontnál teszünk egy lezárót
				elvAlpha = 255
			end
			dxDrawRectangle(ux, uy+menuMagassag-1, panelsz, 1, tocolor(40,40,40,elvAlpha)) -- Alsó2

		end
		if(not ikonbaVan and not menubeVan) then -- Ha megvan jelenítve a lenyillás és kihúzza az egeret a menüpontokon vagy az ikonterületen kivül akkor a menü eltűnik :P
			adat[1] = false
			adat[2] = nil
		end
	end
	return adat[1], adat[2], adat[3]
end

local comboBoxok = {}
local comboKlikkTimer = nil

function formComboRajzolas(x,y,sz,m,adat)
	local nyilnalEger = false
	local egerX, egerY = getCursorPosition()
	if(egerX and egerY) then
		if(dobozbaVan(x+sz-10-getIkonSzelesseg("fa_toggle_down", 0.2),y+4,getIkonSzelesseg("fa_toggle_down", 0.2),getIkonSzelesseg("fa_toggle_down", 0.2),egerX*kepS[1], egerY*kepS[2])) then
			nyilnalEger = true
		end
	end
	if(not comboBoxok[adat[1]]) then -- Kombo box zárva
		formDobozRajzolasa(x,y,sz,m,tocolor(40,40,40,50),tocolor(80,80,80,50))
		fontSzovegRender(adat[3][adat[2]],x+5,y,sz-10,m, tocolor(255,255,255,150), 1, "default", "left", "center", true, false, false)
	else
		formDobozRajzolasa(x,y,sz,m*#adat[3],tocolor(40,40,40,100),tocolor(80,80,80,50))
		for sorszam, ertek in ipairs ( adat[3] ) do
			local menuSzin = 255
			if(adat[2] == sorszam) then
				menuSzin = 60
			end
			fontSzovegRender(ertek,x+5,y+((sorszam-1)*m),sz-10,m, tocolor(menuSzin,menuSzin,menuSzin,150), 1, "default", "left", "center", true, false, false)
			-- Új érték kiválasztás
			if(egerX and egerY) then
				if(dobozbaVan(x+5,y+((sorszam-1)*m),sz-10,m,egerX*kepS[1], egerY*kepS[2]) and getKeyState("mouse1") and not comboKlikkTimer and not nyilnalEger) then
					adat[2] = sorszam
					comboBoxok[adat[1]] = nil
				end
			end
			if(sorszam ~= #adat[3]) then -- Ha nem az utolsót rendereljük teszünk elválasztó cuccot :Padding
				dxDrawRectangle(x+5,y+((sorszam-1)*m),sz-10,1,tocolor(40,40,40,50))
			end
		end
	end
	local ikonSzin = 40
	if(comboBoxok[adat[1]]) then
		ikonSzin = 255
	end

	-- Combo lenyitás kezelés
	local egerX, egerY = getCursorPosition()
	if(nyilnalEger and getKeyState("mouse1") and not comboKlikkTimer) then
		comboKlikkTimer = true
		if(not comboBoxok[adat[1]]) then-- Ha nincs lenyitva
			comboBoxok[adat[1]] = true
		else
			comboBoxok[adat[1]] = nil
		end
		setTimer(function() comboKlikkTimer = nil end, 500, 1)
	end
	ikonRender("fa_toggle_down", x+sz-10-getIkonSzelesseg("fa_toggle_down", 0.2),y+4, tocolor(ikonSzin,ikonSzin,ikonSzin,150), 0.2, 0)
	return adat[2]
end

-- HUD rajzolása
function dobozRajzolas(x, y, sz, m, hszin, kszin, cszin)

	-- Keret
	dxDrawRectangle ( x, y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255)) -- Bal oldal
	dxDrawRectangle ( x+sz-(dobozS[1]-dobozB[1]-1), y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255)) -- Jobb oldal
	dxDrawRectangle ( x+dobozS[4]/2, y, sz-dobozS[4], 1, kszin or tocolor(60,63,63,255)) -- Teteje oldal
	dxDrawRectangle ( x+dobozS[4]/2, y+m-(dobozS[1]-dobozB[1]-1), sz-dobozS[4], 1, kszin or tocolor(60,63,63,255)) -- Alja oldal

	dxDrawRectangle(x+1, y+1, sz-2, m-2, hszin or tocolor(60,63,63,100))

	dxDrawRectangle (x+1, y+1, sz-2, 25, cszin or tocolor(40,40,40,50))
	dxDrawRectangle (x+1, y+m-35+1, sz-2, 35, cszin or tocolor(40,40,40,50))
end

function radarKeret(x, y, sz, m, vastagsag, alpha,r,g,b)
	if not alpha then
		alpha = 180
	end
	if not r and not g and not b then
		r,g,b = 0,0,0
	end

	dxDrawRectangle ( x, y-vastagsag, sz, vastagsag, tocolor(r,g,b,alpha) ) -- Felso
	dxDrawRectangle ( x-vastagsag, y-vastagsag, vastagsag, m+(vastagsag*2), tocolor(r,g,b,alpha) ) -- Bal
	dxDrawRectangle ( x+sz, y-vastagsag, vastagsag, m+(vastagsag*2), tocolor(r,g,b,alpha) ) -- Jobb
	dxDrawRectangle ( x, y+m, sz, vastagsag, tocolor(r,g,b,alpha) ) -- Also
end

function hudCsikRajzolas(x,y,sz,m,ertek,maxertek,szin,szazalek,nemlatszik)
	-- Keret
	dxDrawRectangle(x,y-1,sz,1,tocolor(0, 0, 0, 50)) -- Felso
	dxDrawRectangle(x,y+m,sz,1,tocolor(0, 0, 0, 50)) -- Also
	dxDrawRectangle(x+sz,y,1,m,tocolor(0, 0, 0, 50)) -- Jobb
	dxDrawRectangle(x-1,y,1,m,tocolor(0, 0, 0, 50)) -- Bal

	local jszazalek = exports['sas_system']:getJatekosErtekSzazalek(ertek, maxertek)/100
	dxDrawRectangle(x,y,sz,m,tocolor(szin[1], szin[2], szin[3], 25))
	if(not nemlatszik) then
		dxDrawRectangle(x,y,sz*jszazalek,m,tocolor(szin[1], szin[2], szin[3], 125))
	end

	if(szazalek) then -- Rendereljük hány százalék
		fontSzovegRender(math.floor(jszazalek*100).."%",x,y,math.max(40,sz*jszazalek),m, tocolor(255,255,255,150), 0.6, "bankgthd", "center", "center", true, true, false)
	end
end

--[[function hudXPRajzolas(x,y,sz,m,ertek,maxertek,szin,szint)
	-- Keret
	dxDrawRectangle(x,y-1,sz,1,tocolor(0, 0, 0, 150)) -- Felso
	dxDrawRectangle(x,y+m,sz,1,tocolor(0, 0, 0, 150)) -- Also
	dxDrawRectangle(x+sz,y,1,m,tocolor(0, 0, 0, 150)) -- Jobb
	dxDrawRectangle(x-1,y,1,m,tocolor(0, 0, 0, 150)) -- Bal

	local jszazalek = exports['sas_system']:getJatekosErtekSzazalek(ertek, maxertek)/100
	dxDrawRectangle(x,y,sz,m,tocolor(0, 0, 0, 150))
	dxDrawRectangle(x,y,sz,m,tocolor(szin[1], szin[2], szin[3], 25))
	dxDrawRectangle(x,y,sz*jszazalek,m,tocolor(szin[1], szin[2], szin[3], 125))

	local egerX, egerY = getCursorPosition()
	local szoveg = math.floor(jszazalek*100).."%"
	if(egerX and egerY and getElementData(localPlayer, "belepve")) then
		if(dobozbaVan(x, y, sz, m, egerX*kepS[1], egerY*kepS[2])) then
			local tp = getElementData(localPlayer, "karakter.tapasztalat")
			szoveg = szamForma(tonumber(tp)).." / "..szamForma(tonumber(getJatekosSzuksegesXP(tp)))
		end
	end
	fontSzovegRender(szoveg,x,y,sz,m, tocolor(255,255,255,150), 0.6, "bankgthd", "center", "center", true, true, false)
end]]

function formBillengyuzetGombRajzolas(gomb, x, y, sz, m, ezikon)
	formDobozRajzolasa(x, y, sz, m, tocolor(0,0,0,200), tocolor(20,20,20,230))
	if(ezikon) then
		fontSzovegRender( getIkonByNev(gomb), x, y, sz, m, tocolor(255,255,255,200), 0.50, "kisikonfont", "center", "center", true, true, false)
	else
		fontSzovegRender(string.upper(gomb), x, y, sz, m, tocolor(255,255,255,200), 0.8, "opensans_bold", "center", "center", true, true, false)
	end
end

function formBillengyuzetGombRajzolasSzinnel(gomb, x, y, sz, m, szin, ezikon)
	formDobozRajzolasa(x, y, sz, m, tocolor(0,0,0,200), tocolor(20,20,20,230))
	if(ezikon) then
		fontSzovegRender( getIkonByNev(gomb), x, y, sz, m, szin, 0.50, "kisikonfont", "center", "center", true, true, false)
	else
		fontSzovegRender(string.upper(gomb), x, y, sz, m, szin, 0.8, "opensans_bold", "center", "center", true, true, false)
	end
end

function hudCsikRajzolas2(x,y,sz,m,ertek,maxertek,szin)
	-- Keret
	dxDrawRectangle(x,y-1,sz,1,tocolor(0, 0, 0, 150)) -- Felso
	dxDrawRectangle(x,y+m,sz,1,tocolor(0, 0, 0, 150)) -- Also
	dxDrawRectangle(x+sz,y,1,m,tocolor(0, 0, 0, 150)) -- Jobb
	dxDrawRectangle(x-1,y,1,m,tocolor(0, 0, 0, 150)) -- Bal

	local jszazalek = exports['sas_system']:getJatekosErtekSzazalek(ertek, maxertek)/100
	dxDrawRectangle(x,y,sz,m,tocolor(0, 0, 0, 150))
	dxDrawRectangle(x,y,sz,m,tocolor(szin[1], szin[2], szin[3], 25))
	dxDrawRectangle(x,y,sz*math.min(jszazalek,1),m,tocolor(szin[1], szin[2], szin[3], 125))

	local egerX, egerY = getCursorPosition()
	local szoveg = math.floor(jszazalek*100).."%"
	if(egerX and egerY and getElementData(localPlayer, "belepve")) then
		if(dobozbaVan(x, y, sz, m, egerX*kepS[1], egerY*kepS[2])) then
			szoveg = szamForma(ertek).." / "..szamForma(maxertek)
		end
	end
	fontSzovegRender(szoveg,x,y,sz,m, tocolor(255,255,255,150), 0.6, "bankgthd", "center", "center", true, true, false)
end

function oszlopRajzolas(x,y,sz,m,ertek,maxertek,szin,szint)
	-- Keret
	dxDrawRectangle(x,y-1,sz,1,tocolor(0, 0, 0, 150)) -- Felso
	dxDrawRectangle(x,y+m,sz,1,tocolor(0, 0, 0, 150)) -- Also
	dxDrawRectangle(x+sz,y,1,m,tocolor(0, 0, 0, 150)) -- Jobb
	dxDrawRectangle(x-1,y,1,m,tocolor(0, 0, 0, 150)) -- Bal

	local jszazalek = exports['sas_system']:getJatekosErtekSzazalek(ertek, maxertek)/100
	dxDrawRectangle(x,y,sz,m,tocolor(0, 0, 0, 150))
	dxDrawRectangle(x,y,sz,m,tocolor(szin[1], szin[2], szin[3], 25))
	local szazalekos = math.min(jszazalek,1)
	dxDrawRectangle(x,y+m-(m*szazalekos),sz,m*szazalekos,tocolor(szin[1], szin[2], szin[3], 125))

	local egerX, egerY = getCursorPosition()
	local szoveg = math.floor(jszazalek*100).."%"
	if(egerX and egerY and getElementData(localPlayer, "belepve")) then
		if(dobozbaVan(x, y, sz, m, egerX*kepS[1], egerY*kepS[2])) then
			szoveg = szamForma(ertek).." / "..szamForma(maxertek)
		end
	end
	fontSzovegRender(szoveg,x,y,sz,m, tocolor(255,255,255,150), 0.6, "bankgthd", "center", "center", true, true, false)
end

function panelRajzolas(x, y, sz, m, hszin, kszin, cszin)
	-- Keret
	dxDrawRectangle ( x, y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255)) -- Bal oldal
	dxDrawRectangle ( x+sz-(dobozS[1]-dobozB[1]-1), y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255)) -- Jobb oldal
	dxDrawRectangle ( x+dobozS[4]/2, y, sz-dobozS[4], 1, kszin or tocolor(60,63,63,255)) -- Teteje oldal
	dxDrawRectangle ( x+dobozS[4]/2, y+m-(dobozS[1]-dobozB[1]-1), sz-dobozS[4], 1, kszin or tocolor(60,63,63,255)) -- Alja oldal

	dxDrawRectangle(x+1, y+1, sz-2, m-2, hszin or tocolor(60,63,63,100))

	dxDrawRectangle (x+1, y+1, sz-2, 50, cszin or tocolor(40,40,40,50))
	dxDrawRectangle (x+1, y+m-50+1, sz-2, 50, cszin or tocolor(40,40,40,50))
end

function gorgetesRajzolas(x, y, sz, m, osszes, lathato, holvan, szin1, szin2)
	if(osszes> lathato) then
		--local beallitottszin = exports.cg_dashboard:getInterfaceColor()
		dxDrawRectangle(x, y, sz, m, szin1 or tocolor(0,0,0,200))
		dxDrawRectangle(x, y+((holvan)*(m/(osszes))), sz, m/math.max((osszes/lathato),1), szin2 or tocolor(124, 197, 118, 255))
	end
end

function hudPenzRender(x, y, szamjegyek, penz, penznem, szin)
	local ujpenz = tostring(penz)
	local penzHossza = string.len(ujpenz)
	local ujstring = "#cccccc"

	for i = 1, szamjegyek-penzHossza do
		ujstring = ujstring .. "0"
	end
	ujstring = ujstring .. tostring(szin)
	for i = 1, penzHossza do
		ujstring = ujstring .. string.sub(ujpenz, i, i)
	end
	ujstring = ujstring .. penznem
	fontSzovegRender(ujstring,x-200,y,200,35, tocolor(szin[1],szin[2],szin[3],150), 0.5, "gtafont", "right", "center", true, true, false, 0, 0, 0, true)
end

function hudPenzRenderKerettel(x, y, penz, penznem, szin, alpha)
	local ujpenz = tostring(penz)

	local ujstring = "#cccccc"

	if(penz > 0) then
		ujstring = ujstring .. "+"
	elseif(penz < 0) then
		ujstring = ujstring .. "-"
		ujpenz = string.sub(ujpenz, 2, string.len(ujpenz)-1)
	end

	local penzHossza = string.len(ujpenz)


	ujstring = ujstring .. tostring(szin)
	for i = 1, penzHossza do
		ujstring = ujstring .. string.sub(ujpenz, i, i)
	end
	ujstring = ujstring .. penznem
	fontSzovegRenderKerettel(ujstring,x-200,y,200,35, tocolor(255, 255, 255, math.min(255, alpha)), 0.5, "gtafont", "center", "center", true, true, tocolor(0,0,0,math.min(70, alpha)))

end

local logoAnimacioErtek = 0
function logoAnimacio(x, y, sz, m)
	local valosID = logoAnimacioErtek
	if (string.len(valosID)==2) then
		valosID = "000" .. valosID
	elseif (string.len(valosID)==1) then
		valosID = "0000" .. valosID
	end

	dxDrawImage(x, y, sz, m, "kepek/logo/"..valosID..".png", 0, 0, 0)

	if(getTickCount() % 3 == 0) then
		logoAnimacioErtek = logoAnimacioErtek + 1
		-- Ha véletlen túllépjük a képek számátű
		if(logoAnimacioErtek > 60) then
			logoAnimacioErtek = 0
		end
	end
end

-- Form Kiegek
function formKilepesRender(dx, dy, sz, m, font)
	local visszaErtek = true
	local szinPlusz = 0
	local egerX, egerY = getCursorPosition() -- Egér százalékos pozíció
	local pirosR, pirosG, pirosB = 255, 255, 255
	if(egerX and egerY) then
		if(dobozbaVan(dx+sz-25, dy+1, 24, 24, egerX*kepS[1], egerY*kepS[2])) then
			pirosR, pirosG, pirosB = 255, 70, 70
			if(getKeyState("mouse1")) then
				visszaErtek = false
			end
		end
	end
	fontSzovegRender("x", dx+5, dy+2, sz-10, m-5, tocolor(pirosR, pirosG, pirosB, 255), 1, font or "bankgthd", "right", "top")
	--dxDrawRectangle(dx+sz-25, dy+1, 24, 24, tocolor(50,10,10,szinPlusz/2))
	return visszaErtek
end

function korRajzolas( x, y, honnan, szelesseg, fordulat, fordulHonnan, fordulHova, szin )
	if ( type( x ) ~= "number" ) or ( type( y ) ~= "number" ) then
		return false
	end

	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end

	honnan = type( honnan ) == "number" and honnan or 50
	szelesseg = type( szelesseg ) == "number" and szelesseg or 5
	fordulat = type( fordulat ) == "number" and fordulat or 1
	fordulHonnan = clamp( type( fordulHonnan ) == "number" and fordulHonnan or 0, 0, 360 )
	fordulHova = clamp( type( fordulHova ) == "number" and fordulHova or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )

	if ( fordulHova < fordulHonnan ) then
		local idgFok = fordulHova
		fordulHova = fordulHonnan
		fordulHonnan = idgFok
	end

	for i = fordulHonnan, fordulHova, fordulat do
		local kX = math.cos( math.rad( i ) ) * ( honnan - szelesseg )
		local kY = math.sin( math.rad( i ) ) * ( honnan - szelesseg )
		local vX = math.cos( math.rad( i ) ) * ( honnan + szelesseg )
		local vY = math.sin( math.rad( i ) ) * ( honnan + szelesseg )

		dxDrawLine( kX + x, kY + y, vX + x, vY + y, szin, szelesseg )
	end

	return true
end

function visszaSzamlaloRajz(szoveg, ido)
	local szin = alapBeallitasok["szerverSzin"]["rgb"]
	exports['sas_system']:fontSzovegRenderKerettel(szoveg, 20,kepS[2]-380, 320, 50, tocolor(szin[1], szin[2], szin[3], 255), 1, "nagybankgthd", "center", "center", true, true, tocolor(0,0,0,50))

	exports['sas_system']:fontSzovegRenderKerettel(string.format("%02d:%02d", ido/60, ido%60), 20,kepS[2]-340, 320, 50, tocolor(szin[1], szin[2], szin[3], 255), 1, "nagybankgthd", "center", "center", true, true, tocolor(0,0,0,50))
end

-- Képernyő elmosás kezelése
local elmosasShader
local kepernyoSource = dxCreateScreenSource(kepS[1], kepS[2])
local sotetsegRender = false

function elmosasBekapcsolasa(sotetseg)
	if not elmosasShader then
		elmosasShader, blurTec = dxCreateShader("shaderek/elmosasShader.fx")
		blurErosseg = 6 -- Elmosás erőssége
		sotetsegRender = sotetseg or false
	end
end

function elmosasKikapcsolasa( )
	if elmosasShader then
		elmosasShader = nil
	end
end

addEventHandler("onClientPreRender", root,
function()
    if (elmosasShader) then
        dxUpdateScreenSource(kepernyoSource)

        dxSetShaderValue(elmosasShader, "ScreenSource", kepernyoSource);
        dxSetShaderValue(elmosasShader, "BlurStrength", blurErosseg);
		dxSetShaderValue(elmosasShader, "UVSize", kepS[1]+5, kepS[2]+5);

        dxDrawImage(0, 0, kepS[1], kepS[2], elmosasShader)
		if(sotetsegRender) then
			--dxDrawRectangle(-5, -5, kepS[1]+10, kepS[2]+10, tocolor ( 0, 0, 0, 100 ))
		end
	end
end)

-- Klienses cuccok




function addV3logo(x, y, nyitas, progress, width, height)
--	dxDrawRectangle(kepS[1]/2-50, kepS[2]/2-50, 50, 50, tocolor(0,0,0,255))
--	local cTick = getTickCount ()
	--local progress = (cTick - lastTick2)/300
	if not width then
		width = 128
	end
	if not height then
		height = 128
	end
	if nyitas then
		left,top,_ = interpolateBetween (
			0,0,0,
			28,14,0,
			progress,"Linear"
		)
	end
	if not nyitas then
		left,top,_ = interpolateBetween (
			28,14,0,
			0,0,0,
			progress,"Linear"
		)
	end
	dxDrawImage(x+left, y+top, width, height, "files/logo2.png")
	dxDrawImage(x-left, y+top, width, height, "files/logo3.png")
	dxDrawImage(x, y, width, height, "files/logo1.png")
end
--addEventHandler("onClientRender", getRootElement(), V3logorender)


local sm = {}
sm.moov = 0
sm.object1, sm.object2 = nil, nil

local function camRender()
	local x1, y1, z1 = getElementPosition(sm.object1)
	local x2, y2, z2 = getElementPosition(sm.object2)
	setCameraMatrix(x1, y1, z1, x2, y2, z2)
end

local function removeCamHandler()
	if (sm.moov == 1) then
		sm.moov = 0
		removeEventHandler("onClientPreRender", root, camRender)
	end
end

function stopSmoothMoveCamera()
	if (sm.moov == 1) then
		if (isTimer(sm.timer1)) then killTimer(sm.timer1) end
		if (isTimer(sm.timer2)) then killTimer(sm.timer2) end
		if (isTimer(sm.timer3)) then killTimer(sm.timer3) end
		if (isElement(sm.object1)) then destroyElement(sm.object1) end
		if (isElement(sm.object2)) then destroyElement(sm.object2) end
		removeCamHandler()
		sm.moov = 0
	end
end

function smoothMoveCamera(x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time, easing)
	if (sm.moov == 1) then return false end
	sm.object1 = createObject(1337, x1, y1, z1)
	sm.object2 = createObject(1337, x1t, y1t, z1t)
	setElementAlpha(sm.object1, 0)
	setElementAlpha(sm.object2, 0)
    setElementCollisionsEnabled(sm.object1, false)
    setElementCollisionsEnabled(sm.object2, false)
	setObjectScale(sm.object1, 0.01)
	setObjectScale(sm.object2, 0.01)
	moveObject(sm.object1, time, x2, y2, z2, 0, 0, 0, (easing and easing or "InOutQuad"))
	moveObject(sm.object2, time, x2t, y2t, z2t, 0, 0, 0, (easing and easing or "InOutQuad"))

	addEventHandler("onClientPreRender", root, camRender, true, "low")
	sm.moov = 1
	sm.timer1 = setTimer(removeCamHandler, time, 1)
	sm.timer2 = setTimer(destroyElement, time, 1, sm.object1)
	sm.timer3 = setTimer(destroyElement, time, 1, sm.object2)

	return true
end
