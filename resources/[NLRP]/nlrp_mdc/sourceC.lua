--[[MDC]]--

local BTK = {
    {"  Szabálysértések", ""},
    {"#acd373Gondatlan vezetés", "80 000 - 200 000 FT | Nincs"},
    {"#acd373Forgalom feltartása", "50 000FT /eset | Nincs"},
    {"#acd373Közvagyon megrongálás (Oszlop, Pózna, buszmegálló)", "25 000-150 000 FT| Nincs"},
    {"#acd373Tilosban parkolás", "50 000 FT | Nincs"},
    {"#acd373Kis mértékben rongált járművel való közlekedés", "25 000 FT | Nincs"},
    {"#acd373Közepesen rongált járművel való közlekedés", "50 000 FT | Nincs"},
    {"#acd373Súlyosan rongált járművel való közlekedés", "100 000 FT| Nincs"},
    {"#acd373Rendőri munka akadályozása", "200 000 - 300 000 FT| Nincs"},
    {"#acd373Közúti veszélyeztetés", "200 000-400 000 FT | Nincs"},
    {"#acd373Tilos jelzésen való áthajtás", "25 000 FT| Nincs"},
    {"#acd373Jogosítvány nélküli vezetés", "100 000 FT | Nincs"},
    {"#acd373Közfeladatot ellátó személyel szembeni tiszteletlenség", "25 000 FT /eset | Nincs"},
    {"#acd373KRESZ törvények megsértése", "10 000-50 000 FT | Nincs"},
    {"#acd373Közúti baleset okozása", "100 000 FT | Nincs"},
    {"#acd373Elsősegély csomag hiánya", "20 000 FT| Nincs"},
    {"#acd373Hivatalos okmányok hiánya (személyi, útlevél)", "10 000-20 000FT | Nincs"},
    {"#acd373Forgalmi engedély hiánya", "50 000 FT | Nincs"},
    {"#acd373Állami szervezet tulajdon megrongálása (hatósági jármű)", "150 000-500 000 FT | Nincs"},
    {"#acd373Bukósisak nélküli motor vezetés", "20 000 FT| Nincs"},
    {"#acd373Nitro", "80 000 FT | Nincs"},
    {"#acd373Neon", "80 000 FT | Nincs"},
    {"#acd373Színezett izzó", "25 000 FT| Nincs"},
    {"#acd373Járművezetés tiltott átengedése", "50 000 FT | Nincs"},
    {"#acd373Gyorshajtás", "20 000-100 000 FT| Nincs"},
    {"  Alapfokú bűncselekmények", ""},
    {"#E69138Hatóság Félrevezetése", "70 000-150 000 | 20 perc"},
    {"#E69138Rendőr elöli menekülés", "100 000-150 000 | 40 perc"},
    {"#E69138Rendőrtiszt utasításának megszegése", "150 000 FT | 30 perc"},
    {"#E69138Illegális rendezvény szervezése", "400 000 FT | 180 perc"},
    {"#E69138Illegális rendezvényen való részvétel", "75 000 FT | 40 perc"},
    {"#E69138Hivatali személy fenyegetése", "150 000-300 000 FT | 80 perc"},
    --{"#E69138Üzemanyag lopás", "$5000-$10 000 | 30 perc"},
    {"  Középfokú bűncselekmények", ""},
    {"#FF8000Rendőr megvesztegetése", "200 000 FT | 60 perc"},
    {"#FF8000Engedély nélküli töltény-birtoklás (35db felett)", "2 000 FT /lőszer | 40 perc"},
    {"#FF8000Drogbirtoklás", "40 000 FT /gramm | 25 perc"},
    {"#FF8000Rablás megkísérlése", "200 000 FT | 40 perc"},
    {"#FF8000Rablás", "400 000 | 80 perc"},
    {"#FF8000Könnyű,fokozott,súlyos testi sértés", "150 000-300 000 FT | 45 perc"},
    {"#FF8000Autólopás", "80 000 FT | 60 perc"},
    {"#FF8000Illegális Határátlápés", "80 000 FT | 20 perc"},
	--{"#FF8000D kategóriás jogositvány hiánya", "80 000 FT | Nincs"},
	--{"#FF8000Fuvarlevél hiánya", "150 000 FT | 20 perc"},
	--{"#FF8000Alkalmazott bejelentésének hiánya(cégnek)", "150 000 FT | Nincs"},
	--{"#FF8000Bejelentés nélküli munkavégzés(Alkalmazottnak)", "80 000 FT | Fuvar lefoglalása"},
	--{"#FF8000Illegális rakomány szállítása", "250 000 FT |Fuvar lefoglalása | 40 Perc"},
	
    {"  Magas, Súlyos bűncselekmények", ""},
    {"#ca5454Engedély nélküli behatolás", "120 000 FT | 60 perc"},
    {"#ca5454Honvédelmi területre való behatolás", "120 000 FT| 80 perc"},
    {"#ca5454Kormányhivatal területére való behatolás", "120 000 FT | 80 perc"},
    {"#ca5454Illegális fegyverhez tartozó töltények birtoklása ", "2 000 FT/lőszer | 60 perc"},
    {"#ca5454Hivatali személynek való kiadása", "200 000-500 000 FT| 100 perc"},
    {"#ca5454Jegyzetlen cég működése", "150 000-450 000 FT | 180 perc"},
    {"#ca5454Halálos közúti baleset okozása", "120 000 FT | 60 perc"},
    {"#ca5454Okirathamisítás", "50 000 FT | 60 perc"},
    {"#ca5454Hivatali személy megvesztegetése", "200 000 | 60 perc"},
    {"#ca5454Fogolyzendülés", "50 000-150 000 FT | 0-60 perc"},
    {"#ca5454Illegális Fegyver Alkotóelemek Birtoklása", "20 000 FT /db | 30 perc /db"},
    {"#ca5454Illegális Kábítószeralkotóelemek Birtoklása", "10 000 Ft/db | 30 perc/ db"},
    {"  Korrupció", ""},
    {"#3C78D8Büntetés elmulasztása", "400 000 FT | 160 perc"},
    {"#3C78D8ÁFA-s számla kiállításának elmulasztása", "350 000 FT | Nincs"},
    {"#3C78D8Fegyver / szolgálati felszerelés árusítása", "400 000 FT | 160 perc"},
    {"#3C78D8Illegális dolgok forgalmazása / birtoklása", "400 000 FT | 160 perc"},
    {"#3C78D8Szerződésszegés", "400 000 FT | Nincs"},
    {"#3C78D8Bejegyzetlen cég működtetése", "320.000 - 420.000 FT | 180-200 perc"},
}


local mdcLogin = false
local mdcPanel = false
------------------------
-- Editing Variables --
------------------------
-- Edit
local invitingText = ""
local actualEditing = ""

-- Login
local userNameEdit = ""
local passWordEdit = ""

-- Search
local plateSearchEdit = ""
local wantedPersonSearchEdit = ""
local ticketSearchEdit = ""

-- plateentering
local egysegSzamEdit = ""

-- 1. page
local cartypeEdit = ""
local plateEdit = ""
local wantedCarReasonEdit = ""

-- 2. page
local wantedPersonNameEdit = ""
local wantedPersonReasonEdit = ""
local wantedPersonDescriptionEdit = ""

-- 3. page
local ticketNameEdit = ""
local ticketMoneyEdit = ""
local ticketJailEdit = ""
local ticketReasonEdit = ""

------------------------
-- Editing Variables --
------------------------

local searchingPlate = false
local searchingPerson = false
local searchingTicket = false

if fileExists("sourceC.lua") then
	fileDelete("sourceC.lua")
end

local frakcioNev = nil

local maxShowBtk = 21
local normalDataGorgetBtk = 0

local maxShowTicket = 8
local normalDataGorgetTicket = 0

local alphaAnim = false
local alphaAnimDuration = 350
local alpha = 1
local lineAlpha = 0

local maxShowWantedCars = 7
local normalDataGorgetWantedCars = 0

local maxShowWantedPersons = 7
local normalDataGorgetWantedPersons = 0

local font = dxCreateFont("files/Roboto.ttf", 16)
local fontg = guiCreateFont("files/Roboto.ttf", 13)

local scSz = {guiGetScreenSize()}
local x,y = guiGetScreenSize()
local panelInMoving = false
local movingOffsetX, movingOffsetY = 0, 0;

local box = {400, 180}
local boxPosition = {(scSz[1]/2)-(box[1]/2), (scSz[2]/2-box[2]/2)}

local panel = {1000, 630}
local panelPosition = {(scSz[1]/2)-(panel[1]/2), (scSz[2]/2-panel[2]/2)}

local allowedMDC = {
    [596] = true,
    [597] = true,
    [598] = true,
    [599] = true,
    [601] = true,
    [490] = true,
    [479] = true,
    [604] = true,
    [427] = true,
}

function checkCursor()
    if not guiGetInputEnabled() and not isMTAWindowActive() and isCursorShowing( ) then
        return true
    else
        return false
    end
end

local mdcTickets = {}

function getTicketsClient(table)
    if (table) then
        mdcTickets = {}
        mdcTickets = table
    end
end
addEvent("getTicketsClient", true)
addEventHandler("getTicketsClient", getRootElement(), getTicketsClient)

local mdcWantedCars = {}

function getWantedCarsClient(table)
    if (table) then
        mdcWantedCars = {}
        mdcWantedCars = table
    end
end
addEvent("getWantedCarsClient", true)
addEventHandler("getWantedCarsClient", getRootElement(), getWantedCarsClient)

local mdcWantedPersons = {}

function getWantedPersonsClient(table)
    if (table) then
        mdcWantedPersons = {}
        mdcWantedPersons = table
    end
end
addEvent("getWantedPersonsClient", true)
addEventHandler("getWantedPersonsClient", getRootElement(), getWantedPersonsClient)

local maximumLetter = 20
addEventHandler('onClientCharacter', getRootElement(),
	function(character)
    local vehicle = getPedOccupiedVehicle(localPlayer)
		if mdcPanel or mdcLogin then
      -- 1. page
      if actualEditing == "plate" then
        maximumLetter = 9
      elseif actualEditing == "cartype" then
        maximumLetter = 28
      elseif actualEditing == "wantedcarreason" then
        maximumLetter = 35
      -- 2. page
      elseif actualEditing == "wantedpersonname" then
        maximumLetter = 17
      elseif actualEditing == "wantedpersonreason" then
        maximumLetter = 19
      elseif actualEditing == "wantedpersondescription" then
        maximumLetter = 35
      -- 3. page
      elseif actualEditing == "ticketname" then
        maximumLetter = 28
      elseif actualEditing == "ticketmoney" then
        maximumLetter = 9
      elseif actualEditing == "ticketjail" then
        maximumLetter = 9
      elseif actualEditing == "ticketreason" then
        maximumLetter = 28
      elseif actualEditing == "egysegszam" then
        maximumLetter = 10
      elseif actualEditing == "platesearch" then
        maximumLetter = 9
      elseif actualEditing == "wantedpersonsearch" then
        maximumLetter = 24
      elseif actualEditing == "ticketsearch" then
        maximumLetter = 23
      end
      if (string.len(invitingText) <= maximumLetter) then
				invitingText = invitingText .. character
        --outputDebugString(invitingText)
			end
		end
end)

function drawLoginPanel()
    if panelInMoving then  -- mozgatás ellenőrzése
      local egerW = {getCursorPosition()}
      local egerP = {egerW[1]*x, egerW[2]*y}
      panelPosition[1] = egerP[1] - movingOffsetX
      panelPosition[2] = egerP[2] - movingOffsetY
    end
    if mdcLogin then
        roundedRectangle(boxPosition[1], boxPosition[2], box[1], box[2], tocolor(0,0,0,180))
        dxDrawRectangle(boxPosition[1],boxPosition[2], box[1], 30, tocolor(0,0,0,180))
        dxDrawText("#7cc576NLRP #598ED7- MDC Bejelentkezés", boxPosition[1]+5, boxPosition[2]+3, 0, 0, tocolor(255, 255, 255, 255),0.8,font,"left","top", false, false, false, true)
        if isInSlot(boxPosition[1]+box[1]-30, boxPosition[2]+3, 20, 20) then
            dxDrawImage(boxPosition[1]+box[1]-30, boxPosition[2]+4, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
            --dxDrawText("#ca5454X", boxPosition[1]+box[1]-13, boxPosition[2]+1, 20, 20, tocolor(255, 255, 255, 255),0.7,font,"left","top", false, false, false, true)
        else
            dxDrawImage(boxPosition[1]+box[1]-30, boxPosition[2]+4, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
            --dxDrawText("#ffffffX", boxPosition[1]+box[1]-13, boxPosition[2]+1, 20, 20, tocolor(255, 255, 255, 255),0.7,font,"left","top", false, false, false, true)
        end

        dxDrawText("Felhasználónév:", boxPosition[1]+5, boxPosition[2]+47, 0, 0, tocolor(255, 255, 255, 255),0.8,font,"left","top", false, false, false, true)
        dxDrawText("Jelszó:", boxPosition[1]+5, boxPosition[2]+97, 0, 0, tocolor(255, 255, 255, 255),0.8,font,"left","top", false, false, false, true)

        dxDrawRectangle(boxPosition[1]+167, boxPosition[2]+40, 225, 35, tocolor(99,99,99,200))
        dxDrawRectangle(boxPosition[1]+167, boxPosition[2]+90, 225, 35, tocolor(99,99,99,200))

        if isInSlot(boxPosition[1]+5, boxPosition[2]+137, 386, 35) then
            dxDrawRectangle(boxPosition[1]+5, boxPosition[2]+137, 386, 35, tocolor(89,142,215, 190))
        else
            dxDrawRectangle(boxPosition[1]+5,boxPosition[2]+137, 386, 35, tocolor(89,142,215, 170))
        end
        dxDrawText("Bejelentkezés", boxPosition[1]+5,boxPosition[2]+137, boxPosition[1]+5+386,boxPosition[2]+137+35, tocolor(0,0,0,200),0.8,font,"center","center", false, false, false, true)

        actualPassword = passWordEdit
        local visiblePassword = "", 0
        for i=1,#actualPassword do
            visiblePassword = visiblePassword .. "*"
        end
        if actualEditing == "password" then
          passWordEdit = invitingText
          local w = dxGetTextWidth(visiblePassword, 0.7, font)

          dxDrawLine(boxPosition[1]+167+5+w+3, boxPosition[2]+90+3, boxPosition[1]+167+5+w+3, boxPosition[2]+90+35-3, tocolor(0, 0, 0, lineAlpha), 2)

          --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
        end
        dxDrawText(visiblePassword, boxPosition[1]+167+5, boxPosition[2]+90, 0, boxPosition[2]+90+35, tocolor(255,255,255, 255), 0.7, font, "left", "center")

        if actualEditing == "username" then
          userNameEdit = invitingText
          local w = dxGetTextWidth(userNameEdit, 0.7, font)

          dxDrawLine(boxPosition[1]+167+5+w+3, boxPosition[2]+40+3, boxPosition[1]+167+5+w+3, boxPosition[2]+40+35-3, tocolor(0, 0, 0, lineAlpha), 2)

          --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
        end
        dxDrawText(userNameEdit, boxPosition[1]+167+5, boxPosition[2]+40, 0, boxPosition[2]+40+35, tocolor(255,255,255, 255), 0.7, font, "left", "center")
    end
end
addEventHandler("onClientRender", getRootElement(), drawLoginPanel)

local alphaSzamlalo = 0
function drawMdcPanel()
    if mdcPanel or mdcLogin then
      if alphaAnim then
        if alphaSzamlalo <= 30 then
          alphaSzamlalo = alphaSzamlalo + 1
          if alphaSzamlalo > 15 then
            lineAlpha = 0
          end
        end
        if alphaSzamlalo == 30 then
          lineAlpha = 255
          alphaSzamlalo = 0
        end
      end
    end
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if mdcPanel then
        roundedRectangle(panelPosition[1], panelPosition[2], panel[1], panel[2], tocolor(0,0,0,180))
        dxDrawRectangle(panelPosition[1],panelPosition[2], panel[1], 30, tocolor(0,0,0,180))
        dxDrawText("#7cc576NLRP #598ED7- Mobile Data Computer", panelPosition[1]+5, panelPosition[2]+3, 0, 0, tocolor(255, 255, 255, 255),0.8,font,"left","top", false, false, false, true)
        if isInSlot(panelPosition[1]+panel[1]-30, panelPosition[2]+3, 20, 20) then
            dxDrawImage(panelPosition[1]+panel[1]-30, panelPosition[2]+4, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
        else
            dxDrawImage(panelPosition[1]+panel[1]-30, panelPosition[2]+4, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
        end
        if not getElementData(vehicle, "mdc:plateentered") then
            dxDrawText("Add meg az egységszámot:", panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2-40, 0, 0, tocolor(168,168,168,220), 0.7, font)
            dxDrawRectangle(panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2-15, 200, 30, tocolor(168,168,168,220))
            if isInSlot(panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2+20, 200, 30) then
                dxDrawRectangle(panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2+20, 200, 30, tocolor(89,142,215, 210))
            else
                dxDrawRectangle(panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2+20, 200, 30, tocolor(89,142,215, 170))
            end
            dxDrawText("Beállítás", panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2+20,panelPosition[1]+panel[1]/2-100+200, panelPosition[2]+panel[2]/2+20+30, tocolor(0,0,0,220), 0.7, font, "center", "center")

            if actualEditing == "egysegszam" then
              egysegSzamEdit = invitingText
              local w = dxGetTextWidth(egysegSzamEdit, 0.7, font)

              dxDrawLine(panelPosition[1]+panel[1]/2-100+w+3+5, panelPosition[2]+panel[2]/2-15+3, panelPosition[1]+panel[1]/2-100+w+3+5,panelPosition[2]+panel[2]/2-15+30-3, tocolor(0, 0, 0, lineAlpha), 2)

              --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
            end
            dxDrawText(egysegSzamEdit, panelPosition[1]+panel[1]/2-100+5, panelPosition[2]+panel[2]/2-15, 0, panelPosition[2]+panel[2]/2-15+30, tocolor(255,255,255, 255), 0.7, font, "left", "center")


        elseif getElementData(vehicle, "mdc:plateentered") then
            if getElementData(vehicle, "mdc:page") == 1 then
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+70, 730, 25, tocolor(0,0,0,200))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+95, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+120, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+145, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+170, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+195, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+220, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+245, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+985, panelPosition[2]+95, 5, 175, tocolor(0,0,0,255))

                dxDrawRectangle(panelPosition[1]+251, panelPosition[2]+315, 749, 30, tocolor(0,0,0,155))
                dxDrawText("Körözés kiadása", panelPosition[1]+251+749/2-dxGetTextWidth("Körözés kiadása", 0.8, font)/2, panelPosition[2]+320, 607, 20, tocolor(255,255,255,255), 0.8, font)

                dxDrawText("Keresés a körözött járművek között rendszám alapján:", panelPosition[1]+260, panelPosition[2]+280, 0, 0, tocolor(255,255,255,255), 0.8, font)
                dxDrawRectangle(panelPosition[1]+260+455, panelPosition[2]+280, 100, 25, tocolor(99,99,99,200))

                if actualEditing == "platesearch" then
                  plateSearchEdit = invitingText
                  local w = dxGetTextWidth(plateSearchEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+260+455+w+3+5, panelPosition[2]+280+3, panelPosition[1]+260+455+w+3+5,panelPosition[2]+280+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(plateSearchEdit, panelPosition[1]+260+455+5, panelPosition[2]+280, 0, panelPosition[2]+280+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")





                if isInSlot(panelPosition[1]+260+455+105, panelPosition[2]+280, 70, 25) then -- search butt
                    dxDrawRectangle(panelPosition[1]+260+455+105, panelPosition[2]+280, 70, 25, tocolor(89,142,215,210))
                else
                    dxDrawRectangle(panelPosition[1]+260+455+105, panelPosition[2]+280, 70, 25, tocolor(89,142,215,180))
                end
                dxDrawText("Keres",panelPosition[1]+260+455+105, panelPosition[2]+280,panelPosition[1]+260+455+105+70, panelPosition[2]+280+25,tocolor(0,0,0,255), 0.7, font, "center", "center")


                dxDrawText("Rendszám:", panelPosition[1]+258, panelPosition[2]+393, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                dxDrawText("Indoklás:", panelPosition[1]+258, panelPosition[2]+428, 607, 20, tocolor(255,255,255, 255), 0.8, font)

                dxDrawRectangle(panelPosition[1]+385, panelPosition[2]+358, 275, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+385, panelPosition[2]+393, 100, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+385, panelPosition[2]+428, 410, 25, tocolor(99,99,99,200))

                dxDrawText("Jármű típusa:", panelPosition[1]+258, panelPosition[2]+358, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                if actualEditing == "cartype" then
                  cartypeEdit = invitingText
                  local w = dxGetTextWidth(cartypeEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+390+w+3, panelPosition[2]+358+3, panelPosition[1]+390+w+3, panelPosition[2]+358+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(cartypeEdit, panelPosition[1]+390, panelPosition[2]+358, 0, panelPosition[2]+358+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")

                if actualEditing == "plate" then
                  plateEdit = invitingText
                  local w = dxGetTextWidth(plateEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+390+w+3, panelPosition[2]+393+3, panelPosition[1]+390+w+3,panelPosition[2]+393+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(plateEdit, panelPosition[1]+390, panelPosition[2]+393, 0, panelPosition[2]+393+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")

                if actualEditing == "wantedcarreason" then
                  wantedCarReasonEdit = invitingText
                  local w = dxGetTextWidth(wantedCarReasonEdit, 0.7, font)

                  dxDrawLine(panelPosition[1]+390+w+3, panelPosition[2]+428+3, panelPosition[1]+390+w+3,panelPosition[2]+428+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(wantedCarReasonEdit, panelPosition[1]+390, panelPosition[2]+428, 0, panelPosition[2]+428+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if isInSlot(panelPosition[1]+255, panelPosition[2]+463, 540, 25) then
                    dxDrawRectangle(panelPosition[1]+255, panelPosition[2]+463, 540, 25, tocolor(89,142,215,210))
                else
                    dxDrawRectangle(panelPosition[1]+255, panelPosition[2]+463, 540, 25, tocolor(89,142,215,180))
                end
                dxDrawText("Körözés kiadása", panelPosition[1]+255, panelPosition[2]+463, panelPosition[1]+255+540, panelPosition[2]+463+25, tocolor(0,0,0,220), 0.8, font, "center", "center")

                dxDrawText("Típus", panelPosition[1]+265, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Rendszám", panelPosition[1]+511, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Indok", panelPosition[1]+611, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                local korozottjarmuvek = 0
                if not searchingPlate then
                  for k,v in ipairs(mdcWantedCars) do
                      if (k > normalDataGorgetWantedCars and korozottjarmuvek < maxShowWantedCars) then
                          korozottjarmuvek = korozottjarmuvek + 1
                          dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*korozottjarmuvek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+511, panelPosition[2]+74+25*korozottjarmuvek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[3] .. "", panelPosition[1]+611, panelPosition[2]+74+25*korozottjarmuvek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20) then
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
                          else
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
                          end
                      end
                  end
                elseif searchingPlate then
                  for k,v in ipairs(mdcWantedCars) do
                      if (k > normalDataGorgetWantedCars and korozottjarmuvek < maxShowWantedCars) then
                        if v[2] == plateSearchEdit then
                          korozottjarmuvek = korozottjarmuvek + 1
                          dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*korozottjarmuvek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+511, panelPosition[2]+74+25*korozottjarmuvek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[3] .. "", panelPosition[1]+611, panelPosition[2]+74+25*korozottjarmuvek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20) then
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
                          else
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
                          end
                        end
                      end
                  end
                end
            elseif getElementData(vehicle, "mdc:page") == 2 then
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+70, 730, 25, tocolor(0,0,0,200))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+95, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+120, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+145, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+170, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+195, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+220, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+245, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+985, panelPosition[2]+95, 5, 175, tocolor(0,0,0,255))

                dxDrawRectangle(panelPosition[1]+251, panelPosition[2]+315, 749, 30, tocolor(0,0,0,155))
                dxDrawText("Körözés kiadása", panelPosition[1]+251+749/2-dxGetTextWidth("Körözés kiadása", 0.8, font)/2, panelPosition[2]+320, 607, 20, tocolor(255,255,255,255), 0.8, font)

                dxDrawText("Keresés a körözött személyek között név alapján:", panelPosition[1]+260, panelPosition[2]+280, 0, 0, tocolor(255,255,255,255), 0.8, font)
                dxDrawRectangle(panelPosition[1]+260+415, panelPosition[2]+280, 100+138, 25, tocolor(99,99,99,200))

                if actualEditing == "wantedpersonsearch" then
                  wantedPersonSearchEdit = invitingText
                  local w = dxGetTextWidth(wantedPersonSearchEdit, 0.7, font)

                  dxDrawLine(panelPosition[1]+260+415+w+3+5, panelPosition[2]+280+3, panelPosition[1]+260+415+w+3+5,panelPosition[2]+280+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(wantedPersonSearchEdit, panelPosition[1]+260+415+5, panelPosition[2]+280, 0, panelPosition[2]+280+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if isInSlot(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25) then -- search butt
                    dxDrawRectangle(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25, tocolor(89,142,215,210))
                else
                    dxDrawRectangle(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25, tocolor(89,142,215,180))
                end
                dxDrawText("Keres",panelPosition[1]+260+415+105+138, panelPosition[2]+280,panelPosition[1]+260+415+105+138+70, panelPosition[2]+280+25,tocolor(0,0,0,255), 0.7, font, "center", "center")



                dxDrawText("Név:", panelPosition[1]+258, panelPosition[2]+358, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                dxDrawText("Indoklás:", panelPosition[1]+258, panelPosition[2]+393, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                dxDrawText("Személyleírás:", panelPosition[1]+258, panelPosition[2]+428, 607, 20, tocolor(255,255,255, 255), 0.8, font)

                dxDrawRectangle(panelPosition[1]+385, panelPosition[2]+358, 275, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+385, panelPosition[2]+393, 410, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+385, panelPosition[2]+428, 410, 50, tocolor(99,99,99,200))


                if actualEditing == "wantedpersonname" then
                  wantedPersonNameEdit = invitingText
                  local w = dxGetTextWidth(wantedPersonNameEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+390+w+3, panelPosition[2]+358+3, panelPosition[1]+390+w+3, panelPosition[2]+358+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(wantedPersonNameEdit, panelPosition[1]+390, panelPosition[2]+358, 0, panelPosition[2]+358+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if actualEditing == "wantedpersonreason" then
                  wantedPersonReasonEdit = invitingText
                  local w = dxGetTextWidth(wantedPersonReasonEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+390+w+3, panelPosition[2]+393+3, panelPosition[1]+390+w+3,panelPosition[2]+393+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(wantedPersonReasonEdit, panelPosition[1]+390, panelPosition[2]+393, 0, panelPosition[2]+393+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")

                if actualEditing == "wantedpersondescription" then
                  wantedPersonDescriptionEdit = invitingText
                  local w = dxGetTextWidth(wantedPersonDescriptionEdit, 0.7, font)

                  dxDrawLine(panelPosition[1]+390+w+3, panelPosition[2]+428+3, panelPosition[1]+390+w+3,panelPosition[2]+428+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(wantedPersonDescriptionEdit, panelPosition[1]+390, panelPosition[2]+428, 0, panelPosition[2]+428+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")



                if isInSlot(panelPosition[1]+255, panelPosition[2]+490, 540, 25) then
                    dxDrawRectangle(panelPosition[1]+255, panelPosition[2]+490, 540, 25, tocolor(89,142,215,210))
                else
                    dxDrawRectangle(panelPosition[1]+255, panelPosition[2]+490, 540, 25, tocolor(89,142,215,180))
                end
                dxDrawText("Körözés kiadása", panelPosition[1]+255, panelPosition[2]+490, panelPosition[1]+255+540, panelPosition[2]+490+25, tocolor(0,0,0,220), 0.8, font, "center", "center")


                dxDrawText("Név", panelPosition[1]+265, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Indok", panelPosition[1]+440, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Személyleírás", panelPosition[1]+630, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)

                if not searchingPerson then
                  local korozottszemelyek = 0
                  for k,v in ipairs(mdcWantedPersons) do
                      if (k > normalDataGorgetWantedPersons and korozottszemelyek < maxShowWantedPersons) then
                          korozottszemelyek = korozottszemelyek + 1
                          dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*korozottszemelyek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+440, panelPosition[2]+74+25*korozottszemelyek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[4] .. "", panelPosition[1]+630, panelPosition[2]+74+25*korozottszemelyek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)

                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20) then
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
                          else
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
                          end
                      end
                  end
                elseif searchingPerson then
                  local korozottszemelyek = 0
                  for k,v in ipairs(mdcWantedPersons) do
                      if (k > normalDataGorgetWantedPersons and korozottszemelyek < maxShowWantedPersons) then
                        if string.find(wantedPersonSearchEdit, v[1]) then
                            korozottszemelyek = korozottszemelyek + 1
                            dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*korozottszemelyek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                            dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+440, panelPosition[2]+74+25*korozottszemelyek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                            dxDrawText("#ffffff" .. v[4] .. "", panelPosition[1]+630, panelPosition[2]+74+25*korozottszemelyek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)

                            if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20) then
                                dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
                            else
                                dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
                            end
                        end
                      end
                  end
                end
            elseif getElementData(vehicle, "mdc:page") == 3 then
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+70, 730, 25, tocolor(0,0,0,200))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+95, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+120, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+145, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+170, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+195, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+220, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+245, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+985, panelPosition[2]+95, 5, 175, tocolor(0,0,0,255))

                dxDrawRectangle(panelPosition[1]+251, panelPosition[2]+315, 749, 30, tocolor(0,0,0,155))
                dxDrawText("Büntetés hozzáadása", panelPosition[1]+251+749/2-dxGetTextWidth("Büntetés hozzáadása", 0.8, font)/2, panelPosition[2]+320, 607, 20, tocolor(255,255,255,255), 0.8, font)

                dxDrawText("Név:", panelPosition[1]+258, panelPosition[2]+358, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                dxDrawText("Bírság:", panelPosition[1]+258, panelPosition[2]+393, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                dxDrawText("Börtönbüntetés:", panelPosition[1]+258, panelPosition[2]+428, 607, 20, tocolor(255,255,255, 255), 0.8, font)
                dxDrawText("Indok:", panelPosition[1]+258, panelPosition[2]+463, 607, 20, tocolor(255,255,255, 255), 0.8, font)

                dxDrawRectangle(panelPosition[1]+395, panelPosition[2]+358, 275, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+395, panelPosition[2]+393, 100, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+395, panelPosition[2]+428, 100, 25, tocolor(99,99,99,200))
                dxDrawRectangle(panelPosition[1]+395, panelPosition[2]+463, 275, 25, tocolor(99,99,99,200))


                dxDrawText("Keresés a kiosztott büntetések között név alapján:", panelPosition[1]+260, panelPosition[2]+280, 0, 0, tocolor(255,255,255,255), 0.8, font)
                dxDrawRectangle(panelPosition[1]+260+415+5, panelPosition[2]+280, 95+138, 25, tocolor(99,99,99,200))

                if actualEditing == "ticketsearch" then
                  ticketSearchEdit = invitingText
                  local w = dxGetTextWidth(ticketSearchEdit, 0.7, font)

                  dxDrawLine(panelPosition[1]+260+415+w+3+10, panelPosition[2]+280+3, panelPosition[1]+260+415+w+3+10,panelPosition[2]+280+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(ticketSearchEdit, panelPosition[1]+260+415+10, panelPosition[2]+280, 0, panelPosition[2]+280+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if isInSlot(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25) then -- search butt
                    dxDrawRectangle(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25, tocolor(89,142,215,210))
                else
                    dxDrawRectangle(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25, tocolor(89,142,215,180))
                end
                dxDrawText("Keres",panelPosition[1]+260+415+105+138, panelPosition[2]+280,panelPosition[1]+260+415+105+138+70, panelPosition[2]+280+25,tocolor(0,0,0,255), 0.7, font, "center", "center")



                if actualEditing == "ticketname" then
                  ticketNameEdit = invitingText
                  local w = dxGetTextWidth(ticketNameEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+400+w+3, panelPosition[2]+358+3, panelPosition[1]+400+w+3, panelPosition[2]+358+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(ticketNameEdit, panelPosition[1]+400, panelPosition[2]+358, 0, panelPosition[2]+358+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if actualEditing == "ticketmoney" then
                  ticketMoneyEdit = invitingText
                  local w = dxGetTextWidth(ticketMoneyEdit, 0.7, font)

				          dxDrawLine(panelPosition[1]+400+w+3, panelPosition[2]+393+3, panelPosition[1]+400+w+3,panelPosition[2]+393+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(ticketMoneyEdit, panelPosition[1]+400, panelPosition[2]+393, 0, panelPosition[2]+393+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")

                if actualEditing == "ticketjail" then
                  ticketJailEdit = invitingText
                  local w = dxGetTextWidth(ticketJailEdit, 0.7, font)

                  dxDrawLine(panelPosition[1]+400+w+3, panelPosition[2]+428+3, panelPosition[1]+400+w+3,panelPosition[2]+428+25-3, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(ticketJailEdit, panelPosition[1]+400, panelPosition[2]+428, 0, panelPosition[2]+428+25, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if actualEditing == "ticketreason" then
                  ticketReasonEdit = invitingText
                  local w = dxGetTextWidth(ticketReasonEdit, 0.7, font)

                  dxDrawLine(panelPosition[1]+400+w+3, panelPosition[2]+428+3+35, panelPosition[1]+400+w+3,panelPosition[2]+428+25-3+35, tocolor(0, 0, 0, lineAlpha), 2)

                  --dxDrawLine(panelPosition[1]+390+w+10, panelPosition[2]+358+3, panelPosition[1]+390+w+13, panelPosition[2]+358+25-3, int color, [float width=1, bool postGUI=false])
                end
                dxDrawText(ticketReasonEdit, panelPosition[1]+400, panelPosition[2]+428+35, 0, panelPosition[2]+428+25+35, tocolor(255,255,255, 255), 0.7, font, "left", "center")


                if isInSlot(panelPosition[1]+255, panelPosition[2]+500, 415, 25) then
                    dxDrawRectangle(panelPosition[1]+255, panelPosition[2]+500, 415, 25, tocolor(89,142,215,210))
                else
                    dxDrawRectangle(panelPosition[1]+255, panelPosition[2]+500, 415, 25, tocolor(89,142,215,180))
                end
                dxDrawText("Büntetés hozzáadása", panelPosition[1]+255, panelPosition[2]+500, panelPosition[1]+255+415, panelPosition[2]+500+25, tocolor(0,0,0,220), 0.8, font, "center", "center")


                dxDrawText("Név", panelPosition[1]+265, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Bírság", panelPosition[1]+511, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Börtönbüntetés", panelPosition[1]+565, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Indok", panelPosition[1]+690, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                if not searchingTicket then
                  local ticketek = 0
                  for k,v in ipairs(mdcTickets) do
                      if (k > normalDataGorgetTicket and ticketek < maxShowTicket) then
                          ticketek = ticketek + 1
                          dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+511, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[3] .. "", panelPosition[1]+565, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          dxDrawText("#ffffff" .. v[4] .. "", panelPosition[1]+690, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20) then
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
                          else
                              dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
                          end
                      end
                  end
                elseif searchingTicket then
                  local ticketek = 0
                  for k,v in ipairs(mdcTickets) do
                      if (k > normalDataGorgetTicket and ticketek < maxShowTicket) then
                        if v[1] == ticketSearchEdit then
                            ticketek = ticketek + 1
                            dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                            dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+511, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                            dxDrawText("#ffffff" .. v[3] .. "", panelPosition[1]+565, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                            dxDrawText("#ffffff" .. v[4] .. "", panelPosition[1]+690, panelPosition[2]+74+25*ticketek, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                            if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20) then
                                dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20, "files/cancel.png", 0,0,0, tocolor(202,84,84,200))
                            else
                                dxDrawImage(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20, "files/cancel.png", 0,0,0, tocolor(255,255,255,200))
                            end
                        end
                      end
                  end
                end
            elseif getElementData(vehicle, "mdc:page") == 4 then
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+70, 730, 25, tocolor(0,0,0,200))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+95, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+120, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+145, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+170, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+195, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+220, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+245, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+270, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+295, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+320, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+345, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+370, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+395, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+420, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+445, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+470, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+495, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+520, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+545, 725, 25, tocolor(0,0,0,130))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+570, 725, 25, tocolor(0,0,0,155))
                dxDrawRectangle(panelPosition[1]+260, panelPosition[2]+595, 725, 25, tocolor(0,0,0,130))

                --dxDrawRectangle(panelPosition[1]+985, panelPosition[2]+95, 5, 525, tocolor(0,0,0,255))
                dxDrawText("Megnevezés", panelPosition[1]+265, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                dxDrawText("Büntetés [Pénzbírság | Börtönbüntetés]", panelPosition[1]+665+20, panelPosition[2]+73, 607, 20, tocolor(89,142,215, 240), 0.7, font)
                local btk = 0
                for k,v in ipairs(BTK) do
                    if (k > normalDataGorgetBtk and btk < maxShowBtk) then
                        btk = btk + 1
                        dxDrawText("#ffffff" .. v[1] .. "", panelPosition[1]+265, panelPosition[2]+74+25*btk, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                        dxDrawText("#ffffff" .. v[2] .. "", panelPosition[1]+665+20, panelPosition[2]+74+25*btk, 607, 20, tocolor(89,142,215, 240), 0.7, font,"left","top",false,false,false,true)
                    end
                end
           --    exports.sas_system:gorgetesRajzolas(panelPosition[1]+985, panelPosition[2]+95, 5, 525, #BTK, maxShowBtk, normalDataGorgetBtk)
            end

            if isInSlot(panelPosition[1]+251, panelPosition[2]+30, 187.25, 30) then
                dxDrawRectangle(panelPosition[1]+251, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,210))
                dxDrawText("Körözött járművek", panelPosition[1]+344.625-dxGetTextWidth("Körözött járművek", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            else
                dxDrawRectangle(panelPosition[1]+251, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,180))
                dxDrawText("Körözött járművek", panelPosition[1]+344.625-dxGetTextWidth("Körözött járművek", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            end
            if isInSlot(panelPosition[1]+438.25, panelPosition[2]+30, 187.25, 30) then
                dxDrawRectangle(panelPosition[1]+438.25, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,210))
                dxDrawText("Körözött személyek", panelPosition[1]+531.875-dxGetTextWidth("Körözött személyek", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            else
                dxDrawRectangle(panelPosition[1]+438.25, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,180))
                dxDrawText("Körözött személyek", panelPosition[1]+531.875-dxGetTextWidth("Körözött személyek", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            end
            if isInSlot(panelPosition[1]+625.125, panelPosition[2]+30, 187.25, 30) then
                dxDrawRectangle(panelPosition[1]+625.125, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,210))
                dxDrawText("Büntetések", panelPosition[1]+718.75-dxGetTextWidth("Büntetések", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            else
                dxDrawRectangle(panelPosition[1]+625.125, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,180))
                dxDrawText("Büntetések", panelPosition[1]+718.75-dxGetTextWidth("Büntetések", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            end
            if isInSlot(panelPosition[1]+812.375, panelPosition[2]+30, 187.25, 30) then
                dxDrawRectangle(panelPosition[1]+812.375, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,210))
                dxDrawText("BTK", panelPosition[1]+718.75+187.25-dxGetTextWidth("BTK", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            else
                dxDrawRectangle(panelPosition[1]+812.375, panelPosition[2]+30, 187.25, 30, tocolor(89,142,215,180))
                dxDrawText("BTK", panelPosition[1]+718.75+187.25-dxGetTextWidth("BTK", 0.8, font)/2, panelPosition[2]+34, 155.75, 30, tocolor(0,0,0,220), 0.8, font)
            end


            dxDrawRectangle(panelPosition[1], panelPosition[2]+30, 249, 600, tocolor(0,0,0,120))
            dxDrawRectangle(panelPosition[1]+249, panelPosition[2]+30, 2, 600, tocolor(0,0,0,255))
            local group = getElementData(vehicle, "mdc:group")
            dxDrawImage(panelPosition[1]+56, panelPosition[2]+62, 136, 181, "files/pdlogo.png")
            dxDrawText("Egységszám: #598ED7" .. getElementData(vehicle, "mdc:group") .. "-" .. getElementData(vehicle, "mdc:egysegszam") .. "", panelPosition[1]+124.5-dxGetTextWidth("Egységszám: " .. getElementData(vehicle, "mdc:group") .. "-" .. getElementData(vehicle, "mdc:egysegszam") .. "", 0.8, font)/2, panelPosition[2]+278, 0, 0, tocolor(255, 255, 255, 255),0.8,font,"left","top", false, false, false, true)
            if isInSlot(panelPosition[1]+50, panelPosition[2]+308, 150, 35) then
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+308, 150, 35, tocolor(89,142,215,240))
                dxDrawText("Egységcsere", panelPosition[1]+124.5-dxGetTextWidth("Egységcsere", 0.8, font)/2, panelPosition[2]+315, 125, 30, tocolor(0,0,0,220), 0.8, font)
            else
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+308, 150, 35, tocolor(89,142,215,225))
                dxDrawText("Egységcsere", panelPosition[1]+124.5-dxGetTextWidth("Egységcsere", 0.8, font)/2, panelPosition[2]+315, 125, 30, tocolor(0,0,0,220), 0.8, font)
            end
            if getElementData(vehicle, "mdc:duty") == 1 then
                szolgalat = "#DC143Coff"
                szolgalatblack = "off"
            elseif getElementData(vehicle, "mdc:duty") == 2 then
                szolgalat = "#598ED7járőr"
                szolgalatblack = "járőr"
            elseif getElementData(vehicle, "mdc:duty") == 3 then
                szolgalat = "#598ED7üldözés"
                szolgalatblack = "üldözés"
            elseif getElementData(vehicle, "mdc:duty") == 4 then
                szolgalat = "#598ED7akció"
                szolgalatblack = "akció"
            end
            dxDrawText("Szolgálat: " .. szolgalat, panelPosition[1]+118-dxGetTextWidth("Szolgálat: " .. szolgalatblack, 0.7, font)/2, panelPosition[2]+351, 0, 0, tocolor(255, 255, 255, 255),0.8,font,"left","top", false, false, false, true)

            if isInSlot(panelPosition[1]+50, panelPosition[2]+379, 150, 35) then
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+379, 150, 35, tocolor(220,20,60,240))
            else
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+379, 150, 35, tocolor(220,20,60,225))
            end
            dxDrawText("OFF", panelPosition[1]+124.5-dxGetTextWidth("OFF", 0.8, font)/2, panelPosition[2]+386, 150, 35, tocolor(0,0,0,220), 0.8, font)

            if isInSlot(panelPosition[1]+50, panelPosition[2]+419, 150, 35) then
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+419, 150, 35, tocolor(89,142,215,240))
            else
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+419, 150, 35, tocolor(89,142,215,225))
            end
            dxDrawText("Járőr", panelPosition[1]+124.5-dxGetTextWidth("Járőr", 0.8, font)/2, panelPosition[2]+426, 150, 35, tocolor(0,0,0,220), 0.8, font)

            if isInSlot(panelPosition[1]+50, panelPosition[2]+459, 150, 35) then
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+459, 150, 35, tocolor(89,142,215,240))
            else
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+459, 150, 35, tocolor(89,142,215,225))
            end
            dxDrawText("Üldözés", panelPosition[1]+124.5-dxGetTextWidth("Üldözés", 0.8, font)/2, panelPosition[2]+466, 150, 35, tocolor(0,0,0,220), 0.8, font)

            if isInSlot(panelPosition[1]+50, panelPosition[2]+499, 150, 35) then
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+499, 150, 35, tocolor(89,142,215,240))
            else
                dxDrawRectangle(panelPosition[1]+50, panelPosition[2]+499, 150, 35, tocolor(89,142,215,225))
            end
            dxDrawText("Akció", panelPosition[1]+124.5-dxGetTextWidth("Akció", 0.8, font)/2, panelPosition[2]+506, 150, 35, tocolor(0,0,0,220), 0.8, font)

        end
    end
end
addEventHandler("onClientRender", getRootElement(), drawMdcPanel)

function OnClick(button, state, x,y)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if mdcLogin then
        if button == "left" and state == "down" then
            if mdcLogin and isInSlot(boxPosition[1]+box[1]-30, boxPosition[2]+4, 20, 20) then
                mdcLogin = false
                playSound("sound/mdcon.mp3")
                --playSound("sound/mdcnavklikk.mp3")
                removeEventHandler("onClientRender", getRootElement(), drawLoginPanel)
            elseif mdcLogin and isInSlot(boxPosition[1]+5, boxPosition[2]+137, 386, 35) then
                --mdcLogin = false
                --mdcPanel = true
                playSound("sound/mdcon.mp3")
                --addEventHandler("onClientRender", getRootElement(), drawMdcPanel)
                --triggerServerEvent("sendMessageToPolice", root, "#ffffff" .. getPlayerName(localPlayer) .. " #ca5454(" .. getVehiclePlateText(vehicle) .. ") #ffffffbejelentkezett az #598ED7MDCbe#ffffff.")
              --  setElementData(vehicle, "mdc:loggedin", true)
              --  removeEventHandler("onClientRender", getRootElement(), drawLoginPanel)--]]
                validateMdcLogin()
            end
        end
    end
end
addEventHandler("onClientClick", getRootElement(), OnClick)


function clickOnEdits(button, state, x,y)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if button == "left" and state == "down" then
          if mdcPanel then
            if getElementData(vehicle, "mdc:plateentered") then
              if getElementData(vehicle, "mdc:page") == 1 then
                  if isInSlot(panelPosition[1]+385, panelPosition[2]+358, 275, 25) then
                    actualEditing = "cartype"
                    invitingText = cartypeEdit
                    alphaAnim = true
                    lineAlpha = 255
                  elseif isInSlot(panelPosition[1]+385, panelPosition[2]+393, 100, 25) then
                    actualEditing = "plate"
                    invitingText = plateEdit
                    alphaAnim = true
                    lineAlpha = 255
                  elseif isInSlot(panelPosition[1]+385, panelPosition[2]+428, 410, 25) then
                    actualEditing = "wantedcarreason"
                    invitingText = wantedCarReasonEdit
                    alphaAnim = true
                    lineAlpha = 255
                  elseif isInSlot(panelPosition[1]+260+455, panelPosition[2]+280, 100, 25) then
                    actualEditing = "platesearch"
                    invitingText = plateSearchEdit
                    alphaAnim = true
                    lineAlpha = 255
                  else
                    actualEditing = ""
                  end
              elseif getElementData(vehicle, "mdc:page") == 2 then
                if isInSlot(panelPosition[1]+385, panelPosition[2]+358, 275, 25) then
                  actualEditing = "wantedpersonname"
                  invitingText = wantedPersonNameEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+385, panelPosition[2]+393, 410, 25) then
                  actualEditing = "wantedpersonreason"
                  invitingText = wantedPersonReasonEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+385, panelPosition[2]+428, 410, 50) then
                  actualEditing = "wantedpersondescription"
                  invitingText = wantedPersonDescriptionEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+260+415, panelPosition[2]+280, 100+138, 25) then
                  actualEditing = "wantedpersonsearch"
                  invitingText = wantedPersonSearchEdit
                  alphaAnim = true
                  lineAlpha = 255
                else
                  actualEditing = ""
                end
              elseif getElementData(vehicle, "mdc:page") == 3 then
                if isInSlot(panelPosition[1]+395, panelPosition[2]+358, 275, 25) then
                  actualEditing = "ticketname"
                  invitingText = ticketNameEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+395, panelPosition[2]+393, 100, 25) then
                  actualEditing = "ticketmoney"
                  invitingText = ticketMoneyEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+395, panelPosition[2]+428, 100, 25) then
                  actualEditing = "ticketjail"
                  invitingText = ticketJailEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+395, panelPosition[2]+463, 275, 25) then
                  actualEditing = "ticketreason"
                  invitingText = ticketReasonEdit
                  alphaAnim = true
                  lineAlpha = 255
                elseif isInSlot(panelPosition[1]+260+415+5, panelPosition[2]+280, 95+138, 25) then
                  actualEditing = "ticketsearch"
                  invitingText = ticketSearchEdit
                  alphaAnim = true
                  lineAlpha = 255
                else
                  actualEditing = ""
                end
              end
            end
          end
          if mdcLogin then
            if isInSlot(boxPosition[1]+167, boxPosition[2]+40, 225, 35) then
              --outputDebugString("key")
              actualEditing = "username"
              invitingText = userNameEdit
              alphaAnim = true
              lineAlpha = 255
            elseif isInSlot(boxPosition[1]+167, boxPosition[2]+90, 225, 35) then
              actualEditing = "password"
              invitingText = passWordEdit
              alphaAnim = true
              lineAlpha = 255
            else
              actualEditing = ""
            end
          end
          local vehicle = getPedOccupiedVehicle(localPlayer)
          if mdcPanel then
            if not getElementData(vehicle, "mdc:plateentered") then
              if isInSlot(panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2-15, 200, 30) then
                actualEditing = "egysegszam"
                invitingText = egysegSzamEdit
                alphaAnim = true
                lineAlpha = 255
              else
                actualEditing = ""
              end
            end
          end
    end
end
addEventHandler("onClientClick", getRootElement(), clickOnEdits)

local backupBlip = nil

function OnClick(button, state, x,y)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if mdcPanel then
        if button == "left" and state == "down" then
            if mdcPanel and isInSlot(panelPosition[1]+panel[1]-30, panelPosition[2]+4, 20, 20) then
                mdcPanel = false
				        showChat(true)
                playSound("sound/mdcoff.mp3")
                --playSound("mdcnavklikk.mp3")
                removeEventHandler("onClientRender", getRootElement(), drawMdcPanel)
            elseif mdcPanel and not getElementData(vehicle, "mdc:plateentered") and isInSlot(panelPosition[1]+panel[1]/2-100, panelPosition[2]+panel[2]/2+20, 200, 30) then
                setElementData(vehicle, "mdc:plateentered", true)
                setElementData(vehicle, "mdc:egysegszam", egysegSzamEdit)
                setElementData(vehicle, "mdc:duty", 1)
                setElementData(vehicle, "mdc:page", 1)
                triggerServerEvent("sendMessageToPoliceG", root, "#ffffffA #DC143C" .. getElementData(vehicle, "mdc:group") .."-" .. egysegSzamEdit .. ". #ffffffszámú egység #598ED7létrejött#ffffff.", egysegSzamEdit)
                playSound("sound/mdcpatrol.mp3")
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and isInSlot(panelPosition[1]+50, panelPosition[2]+308, 150, 35) then
                triggerServerEvent("sendMessageToPolice", root, "#ffffffA #DC143C" .. getElementData(vehicle, "mdc:group") .."-" .. getElementData(vehicle, "mdc:egysegszam") .. ". #ffffffszámú egység #598ED7feloszlott#ffffff.", egysegSzamEdit)
                setElementData(vehicle, "mdc:plateentered", false)
                setElementData(vehicle, "mdc:egysegszam", false)
                playSound("sound/mdcnavklikk.mp3")
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:duty") ~= 1 and isInSlot(panelPosition[1]+50, panelPosition[2]+379, 150, 35) then
                setElementData(vehicle, "mdc:duty", 1)
                playSound("sound/mdcpatrol.mp3")
                triggerServerEvent("destroyBlipServer", root, vehicle)
                triggerServerEvent("sendMessageToPoliceG", root, "#ffffffA #DC143C" .. getElementData(vehicle, "mdc:group") .."-" .. getElementData(vehicle, "mdc:egysegszam") .. ". #ffffffszámú egység #598ED7kiállt a szolgálatból#ffffff.")
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:duty") ~= 2 and isInSlot(panelPosition[1]+50, panelPosition[2]+419, 150, 35) then
                setElementData(vehicle, "mdc:duty", 2)
                playSound("sound/mdcpatrol.mp3")
                triggerServerEvent("createDutyBlipServer", root, vehicle)
                triggerServerEvent("sendMessageToPoliceG", root, "#ffffffA #DC143C" .. getElementData(vehicle, "mdc:group") .."-" .. getElementData(vehicle, "mdc:egysegszam") .. ". #ffffffszámú egység szolgálati állapota: #598ED7járőr#ffffff.")
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:duty") ~= 3 and isInSlot(panelPosition[1]+50, panelPosition[2]+459, 150, 35) then
                setElementData(vehicle, "mdc:duty", 3)
                playSound("sound/mdcpatrol.mp3")
                triggerServerEvent("createBackupBlipServer", root, vehicle)
                triggerServerEvent("sendMessageToPoliceG", root, "#ffffffA #DC143C" .. getElementData(vehicle, "mdc:group") .."-" .. getElementData(vehicle, "mdc:egysegszam") .. ". #ffffffszámú egység szolgálati állapota: #598ED7üldözés#ffffff.")
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:duty") ~= 4 and isInSlot(panelPosition[1]+50, panelPosition[2]+499, 150, 35) then
                setElementData(vehicle, "mdc:duty", 4)
                playSound("sound/mdcpatrol.mp3")
                triggerServerEvent("createBackupBlipServer", root, vehicle)
                triggerServerEvent("sendMessageToPoliceG", root, "#ffffffA #DC143C" .. getElementData(vehicle, "mdc:group") .."-" .. getElementData(vehicle, "mdc:egysegszam") .. ". #ffffffszámú egység szolgálati állapota: #598ED7akció#ffffff.")
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") ~= 1 and isInSlot (panelPosition[1]+251, panelPosition[2]+30, 187.25, 30) then
                playSound("sound/mdcnavklikk.mp3")
                setElementData(vehicle, "mdc:page", 1)
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") ~= 2 and isInSlot (panelPosition[1]+438.25, panelPosition[2]+30, 187.25, 30) then
                playSound("sound/mdcnavklikk.mp3")
                setElementData(vehicle, "mdc:page", 2)
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") ~= 3 and isInSlot (panelPosition[1]+625.125, panelPosition[2]+30, 187.25, 30) then
                playSound("sound/mdcnavklikk.mp3")
                setElementData(vehicle, "mdc:page", 3)
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") ~= 4 and isInSlot (panelPosition[1]+812.375, panelPosition[2]+30, 187.25, 30) then
                playSound("sound/mdcnavklikk.mp3")
                setElementData(vehicle, "mdc:page", 4)
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") == 3 then
                if isInSlot(panelPosition[1]+255, panelPosition[2]+500, 415, 25) then
                  if ticketNameEdit ~= "" and ticketMoneyEdit ~= "" and ticketJailEdit ~= "" and ticketReasonEdit ~= "" then
                      playSound("sound/mdcnavklikk.mp3")
                      triggerServerEvent("addTicket", localPlayer, ticketNameEdit, ticketMoneyEdit, ticketJailEdit, ticketReasonEdit)
                      triggerServerEvent("getTicketsServer", root)
                      ticketNameEdit = ""
                      ticketMoneyEdit = ""
                      ticketJailEdit = ""
                      ticketReasonEdit = ""
                  else
                    exports.sas_hud:addNotification("Minden mezőt ki kell töltened!", "error")
                  end
                end

                if isInSlot(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25) then
                  if not searchingTicket then
                    searchingTicket = true
                  else
                    searchingTicket = false
                  end
                end
                -- delete
                if not searchingTicket then
                  local ticketek = 0
                  for k,v in ipairs(mdcTickets) do
                      if (k > normalDataGorgetTicket and ticketek < maxShowTicket) then
                          ticketek = ticketek + 1
                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20) then
                              triggerServerEvent("deleteFromTickets", root, v[5])
                              triggerServerEvent("getTicketsServer", root)
                              playSound("sound/mdcnavklikk.mp3")
                          end
                      end
                  end
                elseif searchingTicket then
                  local ticketek = 0
                  for k,v in ipairs(mdcTickets) do
                      if (k > normalDataGorgetTicket and ticketek < maxShowTicket) then
                        if v[1] == ticketSearchEdit then
                            ticketek = ticketek + 1
                            if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*ticketek, 20, 20) then
                                triggerServerEvent("deleteFromTickets", root, v[5])
                                triggerServerEvent("getTicketsServer", root)
                                playSound("sound/mdcnavklikk.mp3")
                            end
                        end
                      end
                  end
                end
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") == 2 then
                if isInSlot(panelPosition[1]+255, panelPosition[2]+490, 540, 25) then
                  if wantedPersonNameEdit ~= "" and wantedPersonReasonEdit ~= "" and wantedPersonDescriptionEdit ~= "" then
                    playSound("sound/mdcnavklikk.mp3")
                    triggerServerEvent("addWantedPerson", localPlayer, wantedPersonNameEdit, wantedPersonReasonEdit, wantedPersonDescriptionEdit)
                    triggerServerEvent("getWantedPersonsServer", root)
                    wantedPersonNameEdit = ""
                    wantedPersonReasonEdit = ""
                    wantedPersonDescriptionEdit = ""
                  else
                    exports.sas_hud:addNotification("Minden mezőt ki kell töltened!", "error")
                  end
                end
                if isInSlot(panelPosition[1]+260+415+105+138, panelPosition[2]+280, 70, 25) then
                  if not searchingPerson then
                    searchingPerson = true
                  else
                    searchingPerson = false
                  end
                end
                -- delete
                if not searchingPerson then
                  local korozottszemelyek = 0
                  for k,v in ipairs(mdcWantedPersons) do
                      if (k > normalDataGorgetWantedPersons and korozottszemelyek < maxShowWantedPersons) then
                          korozottszemelyek = korozottszemelyek + 1
                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20) then
                              triggerServerEvent("deleteFromWantedPersons", root, v[3])
                              triggerServerEvent("getWantedPersonsServer", root)
                              playSound("sound/mdcnavklikk.mp3")
                          end
                      end
                  end
                elseif searchingPerson then
                  local korozottszemelyek = 0
                  for k,v in ipairs(mdcWantedPersons) do
                      if (k > normalDataGorgetWantedPersons and korozottszemelyek < maxShowWantedPersons) then
                          if string.find(wantedPersonSearchEdit, v[1]) then
                            korozottszemelyek = korozottszemelyek + 1
                            if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottszemelyek, 20, 20) then
                                triggerServerEvent("deleteFromWantedPersons", root, v[3])
                                triggerServerEvent("getWantedPersonsServer", root)
                                playSound("sound/mdcnavklikk.mp3")
                            end
                          end
                      end
                  end
                end
            elseif mdcPanel and getElementData(vehicle, "mdc:plateentered") and getElementData(vehicle, "mdc:page") == 1 then
                if isInSlot(panelPosition[1]+255, panelPosition[2]+463, 540, 25) then
                  if cartypeEdit ~= "" and plateEdit ~= "" and wantedCarReasonEdit ~= "" then
                      playSound("sound/mdcnavklikk.mp3")
                      triggerServerEvent("addWantedCar", localPlayer, cartypeEdit, plateEdit, wantedCarReasonEdit)
                      triggerServerEvent("getWantedCarsServer", root)
                      cartypeEdit = ""
                      plateEdit = ""
                      wantedCarReasonEdit = ""
                  else
                    exports.sas_hud:addNotification("Minden mezőt ki kell töltened!", "error")
                  end
                end
                if isInSlot(panelPosition[1]+260+455+105, panelPosition[2]+280, 70, 25) then
                  if not searchingPlate then
                    searchingPlate = true
                  else
                    searchingPlate = false
                  end
                end
                --delete
                if not searchingPlate then
                  local korozottjarmuvek = 0
                  for k,v in ipairs(mdcWantedCars) do
                      if (k > normalDataGorgetWantedCars and korozottjarmuvek < maxShowWantedCars) then
                          korozottjarmuvek = korozottjarmuvek + 1
                          if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20) then
                            triggerServerEvent("deleteFromWantedCars", root, v[4])
                            triggerServerEvent("getWantedCarsServer", root)
                            playSound("sound/mdcnavklikk.mp3")
                          end
                      end
                  end
                elseif searchingPlate then
                  local korozottjarmuvek = 0
                  for k,v in ipairs(mdcWantedCars) do
                      if (k > normalDataGorgetWantedCars and korozottjarmuvek < maxShowWantedCars) then
                        if v[2] == plateSearchEdit then
                            korozottjarmuvek = korozottjarmuvek + 1
                            if isInSlot(panelPosition[1]+960, panelPosition[2]+73+25*korozottjarmuvek, 20, 20) then
                              triggerServerEvent("deleteFromWantedCars", root, v[4])
                              triggerServerEvent("getWantedCarsServer", root)
                              playSound("sound/mdcnavklikk.mp3")
                            end
                        end
                      end
                  end
                end
            end
        end
    end
end
addEventHandler("onClientClick", getRootElement(), OnClick)

function panelMoving( key, state, aX, aY, wX, wY, wZ, element )
  if (key == "left" and state == "down") then
    if mdcPanel then
      if(isInSlot(panelPosition[1],panelPosition[2], panel[1], 30)) then
        egerW = {getCursorPosition()}
        egerP = {egerW[1]*x, egerW[2]*y}
        panelInMoving = true
        movingOffsetX = egerP[1] - panelPosition[1]
        movingOffsetY = egerP[2] - panelPosition[2]
      end
    end
  else
    panelInMoving = false
  end
end
addEventHandler ( "onClientClick", getRootElement(), panelMoving )


local backupBlip = {}
local dutyBlip = {}

function createBackupBlipClient(vehicle)
    local x,y,z = getElementPosition(vehicle)
    if isElement(dutyBlip[vehicle]) then
        destroyElement(dutyBlip[vehicle])
    end
    backupBlip[vehicle] = createBlip(x,y,z,1)
    setElementData(backupBlip[vehicle], "blip:Name", "" .. getElementData(vehicle, "mdc:group") .. " - " .. getElementData(vehicle, "mdc:egysegszam") ..". számú egység. (Erősítés)")
    setElementData(backupBlip[vehicle],"blipIcon", "target")
    setElementData(backupBlip[vehicle],"blipSize", 14.5)
    setElementData(backupBlip[vehicle],"blipColor", tocolor(255,0,0,255))
    setElementData(backupBlip[vehicle],"blipTooltipText", "Ize")
    setElementData(backupBlip[vehicle], 'exclusiveBlip', true)
    attachElements(backupBlip[vehicle], vehicle)
end
addEvent("createBackupBlipClient", true)
addEventHandler("createBackupBlipClient", getRootElement(), createBackupBlipClient)

function destroyBlipClient(vehicle)
    if isElement(backupBlip[vehicle]) then
        destroyElement(backupBlip[vehicle])
    end
    if isElement(dutyBlip[vehicle]) then
        destroyElement(dutyBlip[vehicle])
    end
end
addEvent("destroyBlipClient", true)
addEventHandler("destroyBlipClient", getRootElement(), destroyBlipClient)

function createDutyBlipClient(vehicle)
    local x,y,z = getElementPosition(vehicle)
    if isElement(backupBlip[vehicle]) then
        destroyElement(backupBlip[vehicle])
    end
	if (isMDCAllowedPD(thePlayer)) or (isMDCAllowedNAV(thePlayer)) then
    dutyBlip[vehicle] = createBlip(x,y,z,1)
    setElementData(dutyBlip[vehicle], "blipName", "" .. getElementData(vehicle, "mdc:group") .. " - " .. getElementData(vehicle, "mdc:egysegszam") ..". számú egység.")
    attachElements(dutyBlip[vehicle], vehicle)
	end
end
addEvent("createDutyBlipClient", true)
addEventHandler("createDutyBlipClient", getRootElement(), createDutyBlipClient)

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


function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
    if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
        return true
    else
        return false
    end
end

function showLoginMDCPanel()
    local veh = getPedOccupiedVehicle(localPlayer)
    local model = getElementModel(veh)
    if veh and allowedMDC[model] then
        if not getElementData(veh, "mdc:loggedin") then
            mdcLogin = true
            playSound("sound/mdcon.mp3")
            addEventHandler("onClientRender", getRootElement(), drawLoginPanel)
            triggerServerEvent("getTicketsServer", root)
            triggerServerEvent("getWantedCarsServer", root)
            triggerServerEvent("getWantedPersonsServer", root)
        elseif getElementData(veh, "mdc:loggedin") then
            mdcPanel = true
            playSound("sound/mdcon.mp3")
            addEventHandler("onClientRender", getRootElement(), drawMdcPanel)
            triggerServerEvent("getTicketsServer", root)
            triggerServerEvent("getWantedCarsServer", root)
            triggerServerEvent("getWantedPersonsServer", root)
			      showChat(false)
        end
    end
end
addCommandHandler("mdc", showLoginMDCPanel)

function loginMdcClient (frakcio)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    mdcLogin = false
    mdcPanel = true
    playSound("login.mp3")
    addEventHandler("onClientRender", getRootElement(), drawMdcPanel)
    setElementData(vehicle, "mdc:group", frakcio)
    triggerServerEvent("sendMessageToPoliceG", root, "#ffffff" .. getPlayerName(localPlayer):gsub("_", " ") .. " #ca5454(" .. getVehiclePlateText(vehicle) .. ") #ffffffbejelentkezett az #598ED7MDCbe#ffffff.")
    setElementData(vehicle, "mdc:loggedin", true)
    removeEventHandler("onClientRender", getRootElement(), drawLoginPanel)
end
addEvent("loginMdcClient", true)
addEventHandler("loginMdcClient", getRootElement(), loginMdcClient)

function validateMdcLogin()
    if not isTimer(theTimer) then
        theTimer = setTimer(function() end, 10000, 1)
        if userNameEdit ~= "" and passWordEdit ~= "" then
            triggerServerEvent("mdcLoginServer", localPlayer, userNameEdit, passWordEdit)
        else
            exports.sas_hud:addNotification("Tölts ki minden mezőt!", "error")
        end
    end
end

addEventHandler("onClientVehicleExit", getRootElement(),
    function(thePlayer, seat)
    --if model == 596 then
      if localPlayer == thePlayer then
          if mdcLogin or mdcPanel then
              mdcLogin = false
              mdcPanel = false
              removeEventHandler("onClientRender", getRootElement(), drawLoginPanel)
              removeEventHandler("onClientRender", getRootElement(), drawMdcPanel)
              --end
          end
      end
    end
)

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end

        if (not bgColor) then
            bgColor = borderColor;
        end

        --> Background
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);

        --> Border

        dxDrawRectangle(x-2, y, 2, h+2, tocolor(0, 0, 0, 255), postGUI);
        dxDrawRectangle(x-2, y-2, w+4, 2, tocolor(0, 0, 0, 255), postGUI);
        dxDrawRectangle(x+w, y, 2, h, tocolor(0, 0, 0, 255), postGUI);
        dxDrawRectangle(x, y+h, w+2, 2, tocolor(0, 0, 0, 255), postGUI);
    end
end

bindKey("mouse_wheel_down", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 4 then
            if normalDataGorgetBtk < #BTK - maxShowBtk then
                normalDataGorgetBtk = normalDataGorgetBtk + 1
            end
        end
    end
)

bindKey("mouse_wheel_up", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 4 then
            if normalDataGorgetBtk > 0 then
                normalDataGorgetBtk = normalDataGorgetBtk - 1
            end
        end
    end
)

bindKey("mouse_wheel_down", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 3 then
            if normalDataGorgetTicket < #mdcTickets - maxShowTicket then
                normalDataGorgetTicket = normalDataGorgetTicket + 1
            end
        end
    end
)

bindKey("mouse_wheel_up", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 3 then
            if normalDataGorgetTicket > 0 then
                normalDataGorgetTicket = normalDataGorgetTicket - 1
            end
        end
    end
)

bindKey("mouse_wheel_down", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 2 then
            if normalDataGorgetWantedPersons < #mdcWantedPersons - maxShowWantedPersons then
                normalDataGorgetWantedPersons = normalDataGorgetWantedPersons + 1
            end
        end
    end
)

bindKey("mouse_wheel_up", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 2 then
            if normalDataGorgetWantedPersons > 0 then
                normalDataGorgetWantedPersons = normalDataGorgetWantedPersons - 1
            end
        end
    end
)

bindKey("mouse_wheel_down", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 1 then
            if normalDataGorgetWantedCars < #mdcWantedCars - maxShowWantedCars then
                normalDataGorgetWantedCars = normalDataGorgetWantedCars + 1
            end
        end
    end
)

bindKey("mouse_wheel_up", "down",
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if mdcPanel and getElementData(vehicle, "mdc:page") == 1 then
            if normalDataGorgetWantedCars > 0 then
                normalDataGorgetWantedCars = normalDataGorgetWantedCars - 1
            end
        end
    end
)

--[[Szirénapanel]]--


--[[CCTV]]--

local kepernyom = {guiGetScreenSize()}
local camIsActive = false
local currentCam = 1
local screenX, screenY = guiGetScreenSize()
local fontSizeMultipler = screenX / 1920
local font = dxCreateFont("files/ocr.ttf", 17.5 * fontSizeMultipler, false, "antialiased")
local markerFont = dxCreateFont(":sas_hud/files/fonts/Roboto.ttf", 12)
local cameraShader = dxCreateShader( "fx/blackwhite.fx" )

local kameraHelyek = {
    {"Fegyház #1 (#1)",-1060.9959716797, -666.73742675781, 35.910709381104, -970.52233886719, -700.82904052734, 10.370844841003,0,0},
    {"Fegyház #2 (#2)",-1110.0573730469, -652.64074707031, 48.910118103027, -1050.3012695313, -586.33984375, 3.8170173168182,0,0},
    {"Fegyház #3 (#3)",-1083.3349609375, -694.28491210938, 48.910419464111, -1019.0045776367, -758.63861083984, 7.434953212738,0,0},
    {"Fegyház #4 (#4)",-1077.8431396484, -690.80212402344, 33.910274505615, -1155.9947509766, -635.78204345703, 4.497462272644,0,0},
    {"LSPD (#6)",1556.3441162109, -1680.9958496094, 34.941444396973, 1474.3969726563, -1670.5687255859, -21.414068222046,0,0},
    {"Mozi (#7)",1290.4072265625, -1701.9157714844, 34.249870300293, 1364.4340820313, -1727.6647949219, -27.855001449585,0,0},
    {"Városháza #1 (#8)",1462.0522460938, -1710.2192382813, 34.249504089355, 1490.0539550781, -1798.3283691406, -3.8644149303436,0,0},
    {"Városháza #2 (#9)",1535.2255859375, -1810.4128417969, 30.249526977539, 1608.6801757813, -1756.1029052734, -10.430453300476,0,0},
    {"Déli benzinkút (#10)",1947.6257324219, -1795.9260253906, 24.842552185059, 1896.9736328125, -1739.9786376953, -40.764343261719,0,0},
    {"Well Stacked Pizza (#11)",2126.310546875, -1768.1181640625, 24.842109680176, 2056.8415527344, -1792.0972900391, -42.974411010742,0,0},
    {"Skate Park (#12)",1869.9289550781, -1445.7255859375, 33.841735839844, 1925.2375488281, -1383.7097167969, -21.790887832642,0,0},
    {"Északi benzinkút (#13)",974.64929199219, -910.65759277344, 62.51277923584, 1030.5869140625, -960.45935058594, -3.7500867843628,0,0},
    {"Szerelőtelep (#14)",1637.2315673828, -2202.7470703125, 24.636747360229, 1567.3928222656, -2140.4248046875, -10.554937362671,0,0},
    {"Edzőterem (#15)",2209.6142578125, -1746.5892333984, 27.18921661377, 2264.2651367188, -1678.1990966797, -21.143661499023,0,0},
    {"Versenypálya bejárat (#16)",2847.8273925781, -2031.1984863281, 25.873859405518, 2890.4118652344, -2100.701171875, -32.056835174561,0,0},
    {"Taxitelep (#17)",2034.9736328125, -1940.6685791016, 38.538215637207, 2075.2563476563, -1880.6346435547, -30.550333023071,0,0},
    {"Alhambra Club (#18)",1802.931640625, -1677.396484375, 35.049472808838, 1881.2371826172, -1689.4478759766, -25.966974258423,0,0},
    {"Kórház (#19)",1239.1826171875, -1260.9274902344, 33.676296234131, 1174.6690673828, -1330.1248779297, 1.276424407959,0,0},
}
----

addEventHandler("onClientMarkerHit",cctvMarker,
  function(thePlayer)
     if thePlayer == getLocalPlayer() then
       setCameraMatrix(kameraHelyek[currentCam][2],kameraHelyek[currentCam][3],kameraHelyek[currentCam][4],kameraHelyek[currentCam][5],kameraHelyek[currentCam][6],kameraHelyek[currentCam][7])
       setElementInterior(localPlayer, kameraHelyek[currentCam][8])
       setElementDimension (localPlayer, kameraHelyek[currentCam][9])
       setElementFrozen(localPlayer, true)
       setElementData(localPlayer, "enableall", false)
       camIsActive = true
       showChat(false)
       addEventHandler("onClientRender",getRootElement(),cctvRender)
     end
  end
)

-- 250 450
--function markerText()
  --if not camIsActive then
    --local x1,y1,z1 = getElementPosition ( cctvMarker )
    --local px, py, pz = getElementPosition(localPlayer)
    --local screenWidth, screenHeight = guiGetScreenSize ( )
   -- local x1_, y1_, dis = getScreenFromWorldPosition( x1, y1-0.1, z1+1.5 )
--if getDistanceBetweenPoints3D(x1,y1,z1, px, py, pz) <= 10 then
   --   dxDrawText("[CCTV]\nHasználat:\n[W][A][S][D][Q][E] - Mozgatás\n[JOBB/BAL NYIL] - Kamera váltás\n[Backspace] - Kilépés", x1_+2, y1_+1,x1_+10,0, tocolor ( 0, 0, 0, 255 ), 1, markerFont, "center", "top" )
    --  dxDrawText("#d9534f[CCTV]\n#FFFFFFHasználat:\n#7cc576[W][A][S][D][Q][E] #FFFFFF- Mozgatás\n#7cc576[JOBB/BAL NYIL] #ffffff- Kamera váltás\n#7cc576[Backspace] #ffffff- Kilépés", x1_, y1_,x1_+10,0, tocolor ( 0, 0, 0, 255 ), 1, markerFont, "center", "top",false,false,false,true )
  --  end
  --end
--end
addEventHandler("onClientRender",getRootElement(),markerText)

function cctvRender ()
      if camIsActive then
        local hour, min, sec = getRealTime().hour, getRealTime().minute, getRealTime().second
        if hour < 10 then
            hour = "0"..hour
        end
        if min < 10 then
            min = "0"..min
        end
        if sec < 10 then
            sec = "0"..sec
        end
        startShader()
        local scale = dxGetTextWidth(kameraHelyek[currentCam][1], 0.9, font)
        local scale2 = dxGetTextWidth(exports['global']:formatDate("Y.m.d") .. " " .. hour .. ":" .. min .. ":" .. sec .. "", 0.9, font)
          --dxDrawRectangle("center", "bottom",kepernyom[1],kepernyom[2],tocolor(0,0,0,50)) -- Kamera shader
        --  dxDrawRectangle("center", "bottom",kepernyom[1],kepernyom[2],tocolor(255,255,255,50)) -- Kamera shader
        --  dxDrawRectangle("center", "bottom",kepernyom[1],kepernyom[2],tocolor(163,198,255,255/2.5)) -- Kamera shader
          --dxDrawRectangle(kepernyom[1]-100,kepernyom[2]-30,100, 30,tocolor(0,0,0,255))
          dxDrawRectangle(kepernyom[1]-scale-30-20,kepernyom[2]-60,scale+20, 35,tocolor(0,0,0,255)) -- CCTV Pozíció neve
          dxDrawRectangle(30,kepernyom[2]-60,scale2+20, 33,tocolor(0,0,0,255)) -- Dátum
          dxDrawText("" .. kameraHelyek[currentCam][1] .. "",0,kepernyom[2]-60,kepernyom[1]-35, kepernyom[2]-60+35,tocolor(255,255,255,255),0.9,font, "right", "center", false, false, false, true)
          dxDrawText("" .. exports['global']:formatDate("Y.m.d") .. " " .. hour .. ":" .. min .. ":" .. sec .. "" .. "",40,kepernyom[2]-60,100, kepernyom[2]-60+35,tocolor(255,255,255,255),0.9,font, "left", "center", false, false, false, true)
      end
end

addEventHandler( "onClientRender", root,
    function()
      if camIsActive then
          if isCursorShowing() then
              local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
              local px, py, pz = getCameraMatrix()
              local hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, worldx, worldy, worldz )
              local cursorX, cursorY = screenx*kepernyom[1], screeny*kepernyom[2]
              dxDrawImage(cursorX-40, cursorY-40, 80, 80, "files/pointer.png",0,0,0,tocolor(66, 66, 66, 255))
              if hit then
                  if elementHit then
                    if getElementType(elementHit) == "vehicle" then
                      local plate = getVehiclePlateText(elementHit)
                      dxDrawRectangle(cursorX+50, cursorY-20, dxGetTextWidth("Rendszám: " .. plate, 0.8, font)+25, 40, tocolor(66, 66, 66, 200))
                      dxDrawText( "Rendszám: " .. plate, cursorX+60, cursorY-20,cursorX, cursorY-20+40,tocolor(255,255,255,255),0.8, font,"left", "center" )
                    end
                  end
              end
          end
      end
    end
)
local differentX, differentY = 0, 0


addEventHandler("onClientKey",getRootElement(),function(button,state)
    if camIsActive then
      if button == "backspace" and state then
          setCameraTarget(localPlayer)
          setElementFrozen(localPlayer,false)
          showChat(true)
          camIsActive = false
          showCursor(false)
          stopShader()
          setElementInterior(localPlayer, 10)
          setElementDimension (localPlayer, 31)
          setElementData(localPlayer, "enableall", true)
          currentCam = 1
      elseif button == "arrow_r" and state then
        if currentCam ~= #kameraHelyek then
          currentCam = currentCam + 1
          differentX = 0
          differentY = 0
          setCameraMatrix(kameraHelyek[currentCam][2],kameraHelyek[currentCam][3],kameraHelyek[currentCam][4],kameraHelyek[currentCam][5],kameraHelyek[currentCam][6],kameraHelyek[currentCam][7])
        end
      elseif button == "arrow_l" and state then
        if currentCam ~= 1 then
          currentCam = currentCam -1
          differentX = 0
          differentY = 0
          setCameraMatrix(kameraHelyek[currentCam][2],kameraHelyek[currentCam][3],kameraHelyek[currentCam][4],kameraHelyek[currentCam][5],kameraHelyek[currentCam][6],kameraHelyek[currentCam][7])
        end
      end
    end
    if button == "backspace" and state then
      local vehicle = getPedOccupiedVehicle(localPlayer)
  		if mdcPanel or mdcLogin then

  			if string.len(invitingText) >= 1 then
  				invitingText = string.sub(invitingText, 1, string.len(invitingText)-1)
  			end
      end
		end
    if button and state then
      if mdcPanel or mdcLogin then
        if actualEditing ~= "" then
          playSound("sound/key" .. math.random(1,3) .. ".mp3")
        end
      end
    end
end)

function markerHiteles(hitPlayer, matchingDimension)
    if getElementData(source, "marker.isZoneCamera") then
        setElementData(hitPlayer, "char.inMarkerZone", true)
        setElementData(hitPlayer, "char.MarkerZoneName", getElementData(source, "marker.ZoneName"))
    end
end
addEventHandler("onClientMarkerHit", getRootElement(), markerHiteles)

function markerLeave(leftPlayer, matchingDimension)
    if getElementData(source, "marker.isZoneCamera") then
        setElementData(leftPlayer, "char.inMarkerZone", false)
        setElementData(leftPlayer, "char.MarkerZoneName", false)
    end
end
addEventHandler("onClientMarkerLeave", getRootElement(), markerLeave)

function cameraFireing(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if (hitElement and getElementType(hitElement) == "player" and hitElement ~= source) then
        if getElementData(source, "char.inMarkerZone") then
            triggerServerEvent("sendMessageToPoliceG", root, "#ffffffAz egyik kamera #ca5454(" .. getElementData(hitElement, "char.MarkerZoneName") .. ") #fffffflövést észlelt.")
        end
    end
end
addEventHandler("onClientPlayerWeaponFire", root, cameraFireing)

function cameraKilling(killerElement, weapon, bodypart)
    if (getElementType(source) == "player") then
        if getElementData(source, "char.inMarkerZone") then
            triggerServerEvent("sendMessageToPoliceG", root, "#ffffffAz egyik kamera #ca5454(" .. getElementData(source, "char.MarkerZoneName") .. ") #ffffffölést észlelt.")
        end
    end
end
addEventHandler("onClientPlayerWasted", getLocalPlayer(), cameraKilling)

function dxCreateBorder(x,y,w,h,color)
    dxDrawRectangle(x,y,w+1,1,color) -- Fent
    dxDrawRectangle(x,y+1,1,h,color) -- Bal Oldal
    dxDrawRectangle(x+1,y+h,w,1,color) -- Lent Oldal
    dxDrawRectangle(x+w,y+1,1,h,color) -- Jobb Oldal
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

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
    if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
        return true
    else
        return false
    end
end

function logOut()
  local vehicle = getPedOccupiedVehicle(localPlayer)
  if vehicle then
    setElementData(vehicle, "mdc:loggedin", false)
    setElementData(vehicle, "mdc:plateentered", false)
    mdcPanel = false
    mdcLogin = true
  end
end
addCommandHandler("logoutmdc", logOut)


-- custom camera

local _, _, vehicleRotation = 0,0,60
local cameraRotation = 60


cameraSettings = {
				["distance"] = 1,
				["movingSpeed"] = 4,
				["currentX"] = math.rad(cameraRotation),
				["defaultX"] = math.rad(cameraRotation),
				["currentY"] = math.rad(cameraRotation),
				["currentZ"] = math.rad(15),
				["maximumZ"] = math.rad(200),
				["minimumZ"] = math.rad(-200),
				["freeModeActive"] = false,
				["zoomTick"] = 0,
				["zoom"] = 60
}

local CAM = getCamera()--The camera is always the same element, so use this local variable to save cpu power.
function getCameraRotation ()
    return getElementRotation(CAM) --rx, ry, rz
end

function cameraMoveToVehicle()
	if camIsActive then
    local rot1, rot2, rot3 = getCameraRotation()
		-- camera assets
		local vehX, vehY, vehZ = kameraHelyek[currentCam][2],kameraHelyek[currentCam][3],kameraHelyek[currentCam][4]
		local rendesX, rendesY, rendesZ = kameraHelyek[currentCam][5],kameraHelyek[currentCam][6],kameraHelyek[currentCam][7]
		local cameraX = rendesX
		local cameraY = rendesY + differentX
		local cameraZ = rendesZ + differentY
	--	setCameraMatrix(moveX+plus,moveY,moveZ, vehX, vehY, vehZ)
		setCameraMatrix(vehX, vehY, vehZ, cameraX, cameraY, cameraZ)


		if getKeyState("s") then
			differentY = differentY-1
		else
			if not getKeyState("w") then
			--	differentY = 0
			end
		end
		if getKeyState("w") then
			differentY = differentY+1
		else
			if not getKeyState("s") then
				--differentY = 0
			end
		end

		if getKeyState("d") then
			differentX = differentX -1
		else
			if not getKeyState("a") then
			--	differentX = 0
			end
		end
		if getKeyState("a") then
			differentX = differentX+1
		else
			if not getKeyState("d") then
			--	differentX = 0
			end
		end
		--outputChatBox(differentX)
		local cameraX = cameraSettings["currentX"]-  differentX --* cameraSettings["movingSpeed"]
		local cameraY = cameraSettings["currentY"]-  differentX --* cameraSettings["movingSpeed"]
		local cameraZ = cameraSettings["currentZ"] + (differentY * cameraSettings["movingSpeed"])	/	math.pi

		cameraZ = math.max(cameraSettings["minimumZ"], math.min(cameraSettings["maximumZ"], cameraZ))

		cameraSettings["currentX"] = cameraX
		cameraSettings["currentY"] = cameraY
		cameraSettings["currentZ"] = cameraZ
	end
end
addEventHandler ( "onClientRender", getRootElement(), cameraMoveToVehicle )
