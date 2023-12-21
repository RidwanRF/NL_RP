function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function getKocsiValosNev(id)
	return getVehicleNameFromModel ( id )
end

function jelszoKodolas(jelszo)
	local hossz = utfLen(jelszo)
	return string.rep ("*", hossz) -- Csillagokat rakunk helyette
end

function szamForma(szam)
	local bal,szam2,jobb = string.match(szam,'^([^%d]*%d)(%d*)(.-)$')
	return bal..(szam2:reverse():gsub('(%d%d%d)','%1,'):reverse())..jobb
end

function tabla_masolas( t )
	if type(t) == 'table' then
		local r = {}
		for k, v in pairs( t ) do
			r[k] = tabla_masolas( v )
		end
		return r
	else
		return t
	end
end

function jelszoHash(felhasznalo, jelszo)
	return hash ( mysqlBeallitasok["jelszoEncode"], string.lower(felhasznalo)..jelszo )
end

function penzForma(szam)
	local formazas = szam
    while true do  
		formazas, k = string.gsub(formazas, "^(-?%d+)(%d%d%d)", '%1 %2')
		if (k==0) then
		  break
		end
	end
	return formazas
end

function penzLevonas(jatekos, mennyi)
	if(jatekos) then
		if(vanPenze(jatekos, mennyi)) then
			setElementData(jatekos, "char.Money", getElementData(jatekos, "char.Money")-mennyi)
			return true
		else
			return false
		end
	else
		return false
	end
end

function vanPenze(jatekos, mennyi)
	if(jatekos) then
		return getElementData(jatekos, "char.Money") >= mennyi
	else
		return false
	end
end

function szerverChatUrites(jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
	outputChatBox(" ", jatekos)
end

function kliensChatUrites()
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
end


function getJatekosErtekSzazalek(ertek, maxErtek)
	return (ertek/maxErtek)*100
end

function xadatFrissit(jatekos, adat, xadat, ertek, ujertek)
	local regiErtek = getElementData(jatekos, adat.."."..xadat)
	if(regiErtek) then
		if(ujertek) then
			regiErtek = ertek
		else
			regiErtek = regiErtek + ertek
		end
		setElementData(jatekos, adat.."."..xadat, regiErtek)
	end
end



function getJelenIdo()
	jido = getRealTime()
	ora = jido.hour
	perc = jido.minute
	masodperc = jido.second
	if masodperc < 10 then
		masodperc = "0"..masodperc
	end
	if perc < 10 then
		perc = "0"..perc
	end
	if ora < 10 then
		ora = "0"..ora
	end
	return {ora, perc, masodperc}
end

function ezSzam(szoveg)
	for i = 1, string.len(szoveg) do
		local vanTalalat = false
		for szam = 0, 9 do
			if(string.sub(szoveg, i, i) == tostring(szam)) then
				vanTalalat = true
				break
			end
		end
		if not vanTalalat then -- Ha a számjegyek közül egyik se felelt meg a jelen karakternek akkor ez nem szám tehát vissza térünk hamis értékkel
			return false
		end
	end
	return true
end

function string.insert(value, insert, place)

	if place == nil then
		place = string.len(value)+1
	end

	return string.sub(value, 1,place-1) .. string.gsub(string.sub(value, place,place), string.sub(value, place,place), insert) .. string.sub(value, place, string.len(value))

end


function legkozelebbiJarmu(jatekos, tavolsag)
	local kivalasztottJarmu = false
	if isElement(jatekos) then
		if not tavolsag then tavolsag = 6 end
		
		local jatekosX, jatekosY, jatekosZ = getElementPosition(jatekos)
		local jatekosInterior = getElementInterior(jatekos)
		local jatekosDimension = getElementDimension(jatekos)
		for index, jarmu in ipairs(getElementsByType("vehicle"), getRootElement(), true) do
			--if getVehicleType(jarmu) ~= "BMX" and getVehicleType(jarmu) ~= "Bike" then

				local jarmuX, jarmuY, jarmuZ = getElementPosition(jarmu)
				local jarmuInterior = getElementInterior(jarmu)
				local jarmuDimension = getElementDimension(jarmu)
				if jarmuInterior == jatekosInterior and jarmuDimension == jatekosDimension then
					local jelenTav = getDistanceBetweenPoints3D(jatekosX, jatekosY, jatekosZ, jarmuX, jarmuY, jarmuZ)
					if jelenTav <= tavolsag then
						kivalasztottJarmu = jarmu
						tavolsag = jelenTav
					end
				end
			--end
		end
	end
	return kivalasztottJarmu
end

function getJarmuFordulatszam(jarmu)
	local jarmuFordulatszam = 0
    if (jarmu) then  
        if (getVehicleEngineState(jarmu) == true) then
            if getVehicleCurrentGear(jarmu) > 0 then             
                jarmuFordulatszam = math.floor(((getElementSebesseg(jarmu, "km/h")/getVehicleCurrentGear(jarmu))*120) + 0.5) 
                if (jarmuFordulatszam < 650) then
                    jarmuFordulatszam = math.random(650, 750)
                elseif (jarmuFordulatszam >= 9800) then
                    jarmuFordulatszam = math.random(9800, 9900)
                end--[[
				if(getVehicleCurrentGear(jarmu) > jelengear) then
					pluszfordulat = pluszfordulat + jelengear*500
				end
				if(getVehicleCurrentGear(jarmu) < jelengear) then
					pluszfordulat = pluszfordulat - jelengear*250
				end--]]
            else
                jarmuFordulatszam = math.floor((getElementSebesseg(jarmu, "km/h")*120) + 0.5)
                if (jarmuFordulatszam < 650) then
                    jarmuFordulatszam = math.random(400, 600)
                elseif (jarmuFordulatszam >= getElementSebesseg(jarmu, "km/h")*50) then
                    jarmuFordulatszam = getElementSebesseg(jarmu, "km/h")*50
                end
            end
        else
            jarmuFordulatszam = 0
        end
        return tonumber(jarmuFordulatszam)
    else
        return 0
    end
end

function getElementSebesseg(element, tipus)
    assert(isElement(element), "Hibás érték az elsőre (element kötelező, kapott " .. type(element) .. ")")
    assert(getElementType(element) == "player" or getElementType(element) == "ped" or getElementType(element) == "object" or getElementType(element) == "vehicle", "Hibás típus (player/ped/object/vehicle elfogadott, kapott " .. getElementType(element) .. ")")
    assert((tipus == nil or type(tipus) == "string" or type(tipus) == "number") and ((tonumber(tipus) and (tonumber(tipus) == 0 or tipus == tonumber(tipus) == 1 or tonumber(tipus) == 2)) or tipus == "m/s" or tipus == "km/h" or tipus == "mph"), "Hibas sebesseg lekeres")
    tipus = tipus == nil and 0 or ((not tonumber(tipus)) and tipus or tonumber(tipus))
    local mult = (tipus == 0 or tipus == "m/s") and 50 or ((tipus == 1 or tipus == "km/h") and 180 or 111.84681456)
    return (Vector3.create(getElementVelocity(element)) * mult).length
end

function ezSzokoEv(ev)
    if ev then ev = math.floor(ev)
    else ev = getRealTime().year + 1900 end
    return ((ev % 4 == 0 and ev % 100 ~= 0) or ev % 400 == 0)
end

function getIdoMS(ev, honap, nap, ora, perc, mp)
    -- Változók számolása
    local honapmpk = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datumido = getRealTime()
    ev, honap, nap = ev or datumido.year + 1900, honap or datumido.month + 1, nap or datumido.monthday
    ora, perc, mp = ora or datumido.hour, perc or datumido.minute, mp or datumido.second
 
    -- Ido Milisec kiszámolása
    for i=1970, ev-1 do timestamp = timestamp + (ezSzokoEv(i) and 31622400 or 31536000) end
    for i=1, honap-1 do timestamp = timestamp + ((ezSzokoEv(ev) and i == 2) and 2505600 or honapmpk[i]) end
    timestamp = timestamp + 86400 * (nap - 1) + 3600 * ora + 60 * perc + mp
 
    timestamp = timestamp - 7200
 
    return timestamp
end

function getIdoByTS(idovalum)
	local time = getRealTime(idovalum)
	ora = time.hour
	perc = time.minute
	masodperc = time.second
	if masodperc < 10 then
		masodperc = "0"..masodperc
	end
	if perc < 10 then
		perc = "0"..perc
	end
	if ora < 10 then
		ora = "0"..ora
	end
	return (time.year+1900)..". "..(time.month+1)..". "..time.monthday..". "..ora..":"..perc
end

function kerekites(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function visszaIdo(timestamp)
	local ido = kerekites((0.0+timestamp-getIdoMS()) / 3600.0)
	local aido = (0.0+timestamp-getIdoMS()) / 3600.0
	local meddig = "?"
	if(aido >= 0 and aido < 1) then
		meddig = kerekites(aido*60).." perc"
	elseif(ido >= 1 and ido < 24) then
		meddig = ido.." óra"
	elseif(ido >= 24 and ido < (24*7)) then
		if(ido % 24 == 0) then
			meddig = (ido/24).." nap"
		else
			meddig = kerekites((ido/24)).." nap és "..(ido%24).." óra"
		end
	elseif(ido >= (24*7)) then
		if(ido % (24*7) == 0) then
			meddig = (ido/24/7).." hét"
		else
			if(ido % 24 == 0) then
				meddig = kerekites((ido/24/7)).." hét és "..kerekites((ido/24)%7).." nap"
			else
				meddig = kerekites((ido/24/7)).." hét, "..kerekites((ido/24)%7).." nap és "..(ido%24).." óra"
			end
		end
	end
	return meddig
end
