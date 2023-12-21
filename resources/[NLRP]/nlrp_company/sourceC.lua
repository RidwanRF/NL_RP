
local s = {guiGetScreenSize()}
local panel = false
local loaded = false

local size = {1000,600}
local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

local loaded_company = {}

local selected_type = 1

local page = 1

local maxLine = 12
local rowSize = 42.5
local scroll = 0
local selected = 0

local logo_texture = dxCreateTexture("images/logo.png","argb",true,"clamp")

local payTaxes = false

local buySlot = false

local packTick = getTickCount()

local sellsize = {370,230}
local sellpos = {s[1]/2-sellsize[1]/2,s[2]/2-sellsize[2]/2}

local sellToPlayer = false
--dxCreateEdit("sellTo_player","","Játékos ID..",sellpos[1]+10,sellpos[2]+50,sellsize[1]-20,35,11)
--dxCreateEdit("sellTo_price","","Ár (Forint)..",sellpos[1]+10,sellpos[2]+50+45,sellsize[1]-20,35,11)

addEventHandler("onClientRender",root,
    function()
        if sellToPlayer then
            dxDrawRectangle(sellpos[1],sellpos[2],sellsize[1],sellsize[2],tocolor(40,40,40,200))
            dxDrawRectangle(sellpos[1],sellpos[2],sellsize[1],40,tocolor(40,40,40,200))
            dxDrawText("Írd be a játékos ID-jét, és az árat!",sellpos[1]+sellsize[1]/2,sellpos[2]+40/2,nil,nil,tocolor(222,222,222,222),1,fonts[12],"center","center",false,false,false,true)
        
            dxDrawRectangle(sellpos[1]+10,sellpos[2]+50,sellsize[1]-20,35,tocolor(35,35,35,200))

            dxDrawRectangle(sellpos[1]+10,sellpos[2]+50+45,sellsize[1]-20,35,tocolor(35,35,35,200))

            dxDrawRectangle(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10-45,sellsize[1]-20,35,tocolor(183,255,0,175))
            if isCursorOnBox(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10-45,sellsize[1]-20,35) then dxDrawRectangle(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10-45,sellsize[1]-20,35,tocolor(255,255,255,30)) end
            dxDrawText("Eladás",sellpos[1]+sellsize[1]/2,sellpos[2]+sellsize[2]-35-10-45+35/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center")

            dxDrawRectangle(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10,sellsize[1]-20,35,tocolor(228,58,58,175))
            if isCursorOnBox(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10,sellsize[1]-20,35) then dxDrawRectangle(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10,sellsize[1]-20,35,tocolor(255,255,255,10)) end
            dxDrawText("Mégse",sellpos[1]+sellsize[1]/2,sellpos[2]+sellsize[2]-35-10+35/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center")
        end
        if panel then
            dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(40,40,40,200))
            dxDrawRectangle(pos[1],pos[2],size[1],40,tocolor(40,40,40,200))
            dxDrawImage(pos[1]+size[1]-40,pos[2]+8,400/11,259/11,logo_texture)
            dxDrawText("Vállalkozás panel",pos[1]+size[1]/2,pos[2]+40/2,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","center",false,false,false,true)
            if panel == "noCompany" then
                dxDrawText("Ahhoz, hogy vállalkozást alapíts,\nrendelkezned kell vállalkozói engedéllyel,\namelyet a Városházán tudsz igényelni.",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","center",false,false,false,true)
            elseif panel == "company" then
                if not loaded then
                    dxDrawText("Vállakozás adatok betöltése..",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","center",false,false,false,true)
                else
                    local charID = getElementData(localPlayer,"char.ID")

                    for i = 1,#panels do
                        dxDrawRectangle(pos[1]+(i-1)*(size[1]/#panels),pos[2]+40,size[1]/#panels,35,tocolor(55,55,55,100))
                        if i ~= #panels then
                            dxDrawRectangle(pos[1]+(i)*(size[1]/#panels)-0.5,pos[2]+40,1,35,tocolor(25,25,25,200))
                        end
                        if page == i then
                            dxDrawBorder(pos[1]+(i-1)*(size[1]/#panels)+1,pos[2]+40+1,size[1]/#panels-2,35-2,1,tocolor(183,255,0,175))
                        end
                        dxDrawText(panels[i].text,pos[1]+(i-1)*(size[1]/#panels)+(size[1]/#panels)/2,pos[2]+40+35/2,nil,nil,tocolor(222,222,222,222),1,fonts[13],"center","center")
                    end
                    dxDrawRectangle(pos[1],pos[2]+40+35,size[1],1,tocolor(25,25,25,200))

                    if page == 1 then
                        dxDrawText("Vállalkozás neve#dedede:",pos[1]+300,pos[2]+120,nil,nil,tocolor(183,255,0,222),1,fonts[16],"center","top",false,false,false,true)
                        dxDrawText(loaded_company["name"],pos[1]+300,pos[2]+145,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top",false,false,false,true)
                        
                        dxDrawText("Járművek száma#dedede:",pos[1]+size[1]-300,pos[2]+220,nil,nil,tocolor(183,255,0,222),1,fonts[16],"center","top",false,false,false,true)
                        dxDrawText(#getCompanyVehicles(loaded_company["id"]) .. "/" .. loaded_company["vehicleSlot"],pos[1]+size[1]-300,pos[2]+245,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top",false,false,false,true)
                        if playerHavePermission() then
                            dxDrawRectangle(pos[1]+size[1]-230,pos[2]+245,30,30,tocolor(183,255,0,200))
                            dxDrawText("+",pos[1]+size[1]-230+32/2,pos[2]+245+30/2,nil,nil,tocolor(5,5,5,250),1,fonts[14],"center","center")
                        end
                        dxDrawText("Tagok száma#dedede:",pos[1]+300,pos[2]+220,nil,nil,tocolor(183,255,0,222),1,fonts[16],"center","top",false,false,false,true)
                        dxDrawText(#loaded_company["membersCount"] .. "/" .. loaded_company["memberSlot"],pos[1]+300,pos[2]+245,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top",false,false,false,true)
                        if playerHavePermission() then
                            dxDrawRectangle(pos[1]+350,pos[2]+245,30,30,tocolor(183,255,0,200))
                            dxDrawText("+",pos[1]+350+32/2,pos[2]+245+30/2,nil,nil,tocolor(5,5,5,250),1,fonts[14],"center","center")
                        end
                        dxDrawText("Rangod#dedede:",pos[1]+size[1]-300,pos[2]+120,nil,nil,tocolor(183,255,0,222),1,fonts[16],"center","top",false,false,false,true)
                        dxDrawText(loaded_company["ranks"][(getElementData(localPlayer,"char.CompanyRank"))].name,pos[1]+size[1]-300,pos[2]+145,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top",false,false,false,true)
                        
                        if playerHavePermission() then
                            dxDrawText("Számla egyenleg#dedede:",pos[1]+300,pos[2]+320,nil,nil,tocolor(183,255,0,222),1,fonts[16],"center","top",false,false,false,true)
                            dxDrawText(format(loaded_company["balance"]) .. "ft",pos[1]+300,pos[2]+345,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top",false,false,false,true)
                            
                            dxDrawText("Tag felvétele#dedede:",pos[1]+size[1]-300,pos[2]+320,nil,nil,tocolor(183,255,0,222),1,fonts[16],"center","top",false,false,false,true)
                            dxDrawRectangle(pos[1]+size[1]-300-100,pos[2]+350,200-30,30,tocolor(75,75,75,250))
                            dxDrawRectangle(pos[1]+size[1]-300-100+200-30,pos[2]+350,30,30,tocolor(183,255,0,200))
                            dxDrawText("+",pos[1]+size[1]-300-100+200-30/2,pos[2]+350+30/2,nil,nil,tocolor(10,10,10,200),1,fonts[15],"center","center",false,false,false,true)
                        
                            if dxGetActiveEditName() == "newPlayer" then
                                local text = dxGetEditText("newPlayer")
                                local player = exports.nlrp_core:findPlayer(text)

                                if player then
                                    dxDrawText("Talált játékos",pos[1]+size[1]-300,pos[2]+390,nil,nil,tocolor(222,222,222,222),1,fonts[12],"center","top",false,false,false,true)
                                    dxDrawText(getElementData(player,"char.Name"):gsub("_"," ") .. " (" .. getElementData(player,"playerID") .. ")",pos[1]+size[1]-300,pos[2]+410,nil,nil,tocolor(222,222,222,222),1,fonts[12],"center","top",false,false,false,true)
                                else
                                    dxDrawText("#e43232Nem található játékos",pos[1]+size[1]-300,pos[2]+390,nil,nil,tocolor(222,222,222,222),1,fonts[12],"center","top",false,false,false,true)
                                end
                            end

                            dxDrawText("Vállalkozás számla",pos[1]+size[1]/2,pos[2]+size[2]-190,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top")
                            dxDrawRectangle(pos[1]+300,pos[2]+size[2]-160,size[1]-600,40,tocolor(75,75,75,250))

                            dxDrawRectangle(pos[1]+665,pos[2]+size[2]-160+5,30,30,tocolor(228,50,50,200))
                            dxDrawText("-",pos[1]+665+32/2,pos[2]+size[2]-160+6+30/2,nil,nil,tocolor(5,5,5,250),1,fonts[14],"center","center")

                            dxDrawRectangle(pos[1]+665-35,pos[2]+size[2]-160+5,30,30,tocolor(183,255,0,200))
                            dxDrawText("+",pos[1]+665-35+32/2,pos[2]+size[2]-160+6+30/2,nil,nil,tocolor(5,5,5,250),1,fonts[14],"center","center")
                        end

                        dxDrawText("Vállalkozás azonosítója: #" .. format(loaded_company["id"]),pos[1]+size[1]/2,pos[2]+size[2]-30,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","top",false,false,false,true)
                    
                        --// XP
                        local xpToNextLevel = getEXPToNextLevel(loaded_company["level"])
                        dxDrawText("Szint: " .. loaded_company["level"],pos[1]+200,pos[2]+size[2]-75-20,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","top",false,false,false,true)
                        dxDrawText("EXP: " .. format(loaded_company["xp"]) .. "/" .. format(xpToNextLevel),pos[1]+200+(size[1]-400),pos[2]+size[2]-75-20,nil,nil,tocolor(222,222,222,222),1,fonts[12],"right","top",false,false,false,true)
                        dxDrawRectangle(pos[1]+200,pos[2]+size[2]-75,size[1]-400,25,tocolor(55,55,55,250))
                        dxDrawRectangle(pos[1]+200+2,pos[2]+size[2]-75+2,size[1]-400-4,25-4,tocolor(45,45,45,250))
                        dxDrawRectangle(pos[1]+200+2,pos[2]+size[2]-75+2,(size[1]-400-4)/xpToNextLevel*loaded_company["xp"],25-4,tocolor(183,255,0,200))
                    
                        if playerHavePermission() then
                            dxDrawRectangle(pos[1]+size[1]-195,pos[2]+size[2]-80,30,30,tocolor(183,255,0,200))
                            dxDrawText("+",pos[1]+size[1]-195+32/2,pos[2]+size[2]-80+30/2,nil,nil,tocolor(5,5,5,250),1,fonts[14],"center","center")
                        end
                    elseif page == 2 then
                        maxLine = 12
                        rowSize = 42.5

                        dxDrawRectangle(pos[1],pos[2]+75,252,(rowSize+1)*maxLine+2,tocolor(35,35,35,250))
                        for i = 1,maxLine do
                            local boxpos = {pos[1]+1,pos[2]+76+(i-1)*(rowSize+1)}
                            local boxsize = {250,rowSize}
                            dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(65,65,65,250))
                            local player = loaded_company["membersCount"][i+scroll]
                            if player then
                                if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
                                    dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(200,200,200,10))
                                end
                                if loaded_company["leader"] == player.dbid then
                                    dxDrawText("",boxpos[1]+10,boxpos[2]+boxsize[2]/2-2,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_11"],"left","center",false,false,false,true)
                                    dxDrawText(player.name:gsub("_"," "),boxpos[1]+40,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","center",false,false,false,true)
                                else
                                    if player.rank < 5 then
                                        dxDrawText(player.name:gsub("_"," "),boxpos[1]+10,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","center",false,false,false,true)
                                    else
                                        dxDrawText("",boxpos[1]+10,boxpos[2]+boxsize[2]/2-2,nil,nil,tocolor(222,222,222,222),1,fonts["fontawsome_11"],"left","center",false,false,false,true)
                                        dxDrawText(player.name:gsub("_"," "),boxpos[1]+40,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[12],"left","center",false,false,false,true)
                                    end
                                end
                                if findPlayerByName(player.name) then
                                    dxDrawRectangle(boxpos[1],boxpos[2],5,boxsize[2],tocolor(183,255,0,200))
                                else
                                    dxDrawRectangle(boxpos[1],boxpos[2],5,boxsize[2],tocolor(228,50,50,200))
                                end
                            end
                            if selected == i+scroll then
                                dxDrawBorder(boxpos[1]+1,boxpos[2]+1,boxsize[1]-2,boxsize[2]-2,1,tocolor(183,255,0,200))
                            end
                        end
                        if selected ~= 0 then
                            local player = loaded_company["membersCount"][selected]
                            if player then
                                local online_player = findPlayerByName(player.name)
                                if online_player then
                                    dxDrawText("Utoljára online: #dededeJelenleg elérhető",pos[1]+280,pos[2]+95,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                else
                                    dxDrawText("Utoljára online: #dedede" .. formatDate("Y/m/d - h:i:s","'",player.lastOnline),pos[1]+280,pos[2]+95,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                end

                                dxDrawText("Rang: #dedede" .. loaded_company["ranks"][tostring(player.rank)].name,pos[1]+280,pos[2]+140,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                dxDrawText("Részesedés: #dedede" .. loaded_company["ranks"][tostring(player.rank)].precent .. "%",pos[1]+280,pos[2]+185,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                if online_player then
                                    local x,y,z = getElementPosition(online_player)
                                    dxDrawText("Tartózkodási hely: #dedede" .. getZoneName(x,y,z),pos[1]+280,pos[2]+230,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                else
                                    dxDrawText("Tartózkodási hely: #dededeIsmeretlen",pos[1]+280,pos[2]+230,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                end

                                if player.taxPayed == 0 then
                                    dxDrawText("Járulék befizetve eddig: #e43232Még nem volt befizetve!",pos[1]+280,pos[2]+275,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                else
                                    if player.taxPayed <= getTimestamp() then
                                        dxDrawText("Járulék befizetve eddig: #e43232Lejárt ekkor: " .. formatDate("Y/m/d","'",player.taxPayed),pos[1]+280,pos[2]+275,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                    else
                                        dxDrawText("Járulék befizetve eddig: #dedede" .. formatDate("Y/m/d","'",player.taxPayed),pos[1]+280,pos[2]+275,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                    end
                                end

                                dxDrawText("Járulék befizetésének összege: #dedede" .. format(taxesByRank[tonumber(player.rank)]) .. "ft/Nap",pos[1]+280,pos[2]+320,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                            else
                                selected = 0
                            end

                            if playerHavePermission() then
                                local xsize = ((size[1]-252)/2)-2
                                dxDrawRectangle(pos[1]+252,pos[2]+size[2]-46-46-1,xsize*2+3,93,tocolor(40,40,40,250))

                                dxDrawRectangle(pos[1]+253,pos[2]+size[2]-46,xsize,45,tocolor(70,70,70,250))
                                if isCursorOnBox(pos[1]+253,pos[2]+size[2]-46,xsize,45) then
                                    dxDrawBorder(pos[1]+253,pos[2]+size[2]-46,xsize,45,2,tocolor(0,255,162,200),true)
                                end
                                dxDrawText("Lefokozás",pos[1]+253+xsize/2,pos[2]+size[2]-46+45/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,false,true)
                            
                                dxDrawRectangle(pos[1]+253,pos[2]+size[2]-46-46,xsize,45,tocolor(70,70,70,250))
                                if isCursorOnBox(pos[1]+253,pos[2]+size[2]-46-46,xsize,45) then
                                    dxDrawBorder(pos[1]+253,pos[2]+size[2]-46-46,xsize,45,2,tocolor(183,255,0,200),true)
                                end
                                dxDrawText("Előléptetés",pos[1]+253+xsize/2,pos[2]+size[2]-46-46+45/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,false,true)

                                dxDrawRectangle(pos[1]+253+xsize+1,pos[2]+size[2]-46,xsize,45,tocolor(70,70,70,250))
                                if isCursorOnBox(pos[1]+253+xsize+1,pos[2]+size[2]-46,xsize,45) then
                                    dxDrawBorder(pos[1]+253+xsize+1,pos[2]+size[2]-46,xsize,45,2,tocolor(228,50,50,200),true)
                                end
                                dxDrawText("Kirúgás a vállalkozásból",pos[1]+253+xsize+1+xsize/2,pos[2]+size[2]-46+45/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,false,true)

                                if not payTaxes then
                                    dxDrawRectangle(pos[1]+253+xsize+1,pos[2]+size[2]-46-46,xsize,45,tocolor(70,70,70,250))
                                    if isCursorOnBox(pos[1]+253+xsize+1,pos[2]+size[2]-46-46,xsize,45) then
                                        dxDrawBorder(pos[1]+253+xsize+1,pos[2]+size[2]-46-46,xsize,45,2,tocolor(183,255,0,200),true)
                                    end
                                    dxDrawText("Járulékok befizetése",pos[1]+253+xsize+1+xsize/2,pos[2]+size[2]-46-46+45/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,false,true)
                                else
                                    local text = dxGetEditText("payTax")
                                    if tonumber(text) then
                                        text = tonumber(text)
                                        if text <= 365 then
                                            dxDrawText("#dedede" .. format(text) .. " nap = " .. format(taxesByRank[player.rank]*text) .. "ft",pos[1]+253+xsize+1+xsize/2,pos[2]+size[2]-46-46-25,nil,nil,tocolor(0,0,0,222),1,fonts[12],"center","top",false,false,false,true)
                                        else
                                            dxDrawText("#e43232Egy évnél többet előre nem fizethetsz!",pos[1]+253+xsize+1+xsize/2,pos[2]+size[2]-46-46-20,nil,nil,tocolor(0,0,0,222),1,fonts[12],"center","top",false,false,false,true)
                                        end
                                    else
                                        dxDrawText("#e43232Hibás összeg lett megadva!",pos[1]+253+xsize+1+xsize/2,pos[2]+size[2]-46-46-20,nil,nil,tocolor(0,0,0,222),1,fonts[12],"center","top",false,false,false,true)
                                    end

                                    dxDrawRectangle(pos[1]+253+xsize+1+xsize-45-46,pos[2]+size[2]-46-46,45,45,tocolor(183,255,0,200))
                                    dxDrawText("",pos[1]+253+xsize+1+xsize-45-46+45/2,pos[2]+size[2]-46-46+45/2,nil,nil,tocolor(10,10,10,222),1,fonts["fontawsome_11"],"center","center")
                                    dxDrawRectangle(pos[1]+253+xsize+1+xsize-45,pos[2]+size[2]-46-46,45,45,tocolor(228,50,50,200))
                                    dxDrawText("",pos[1]+253+xsize+1+xsize-45+45/2,pos[2]+size[2]-46-46+45/2,nil,nil,tocolor(10,10,10,222),1,fonts["fontawsome_11"],"center","center")
                                end
                            end
                        end
                    elseif page == 3 then --// Rangok
                        maxLine = 5
                        rowSize = 50

                        dxDrawRectangle(pos[1],pos[2]+75,252,(rowSize+1)*maxLine+1,tocolor(35,35,35,250))
                        for i = 1,maxLine do
                            local boxpos = {pos[1]+1,pos[2]+76+(i-1)*(rowSize+1)}
                            local boxsize = {250,rowSize}
                            dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(65,65,65,250))
                            if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
                                dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(200,200,200,10))
                            end

                            if selected == i+scroll then
                                dxDrawBorder(boxpos[1]+1,boxpos[2]+1,boxsize[1]-2,boxsize[2]-2,1,tocolor(183,255,0,200))
                            end

                            dxDrawText(loaded_company["ranks"][tostring(i)].name,boxpos[1]+boxsize[1]/2,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center")
                        end

                        if selected ~= 0 then
                            local row = loaded_company["ranks"][tostring(selected)]
                            if row then
                                dxDrawText("Rang részesedése:#dedede " .. row.precent .. "%",pos[1]+280,pos[2]+95,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                                dxDrawText("Tagok száma ezen a rangon:#dedede " .. getPlayersWithThatRank(selected) .. "db",pos[1]+280,pos[2]+140,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","top",false,false,false,true)
                            
                                if playerHavePermission() then
                                    dxDrawText("Rang nevének szerkesztése:",pos[1]+280,pos[2]+230+45/2,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","center",false,false,false,true)
                                    dxDrawRectangle(pos[1]+size[1]-20-310-45,pos[2]+230,310,45,tocolor(45,45,45,200))
                                    dxDrawRectangle(pos[1]+size[1]-20-45,pos[2]+230,45,45,tocolor(183,255,0,150))
                                    dxDrawText("",pos[1]+size[1]-20-45/2,pos[2]+230+45/2,nil,nil,tocolor(10,10,10,222),1,fonts["fontawsome_11"],"center","center")
                                    dxDrawBorder(pos[1]+size[1]-20-310-45,pos[2]+230,310+45,45,2,tocolor(10,10,10,200))

                                    dxDrawText("Részesedés szerkesztése:",pos[1]+280,pos[2]+280+45/2,nil,nil,tocolor(183,255,0,222),1,fonts[14],"left","center",false,false,false,true)
                                    dxDrawRectangle(pos[1]+size[1]-20-310-45,pos[2]+280,310,45,tocolor(45,45,45,200))
                                    dxDrawRectangle(pos[1]+size[1]-20-45,pos[2]+280,45,45,tocolor(183,255,0,150))       
                                    dxDrawText("",pos[1]+size[1]-20-45/2,pos[2]+280+45/2,nil,nil,tocolor(10,10,10,222),1,fonts["fontawsome_11"],"center","center")
                                    dxDrawBorder(pos[1]+size[1]-20-310-45,pos[2]+280,310+45,45,2,tocolor(10,10,10,200))
                                end
                            end
                        end

                        dxDrawRectangle(pos[1],pos[2]+75+((rowSize+1)*maxLine+1),size[1],size[2]-75-(rowSize+1)*maxLine+1,tocolor(40,40,40,175))

                        dxDrawText("Vállalkozás üzenet:",pos[1]+20,pos[2]+75+((rowSize+1)*maxLine+1)+15,nil,nil,tocolor(183,255,0,200),1,fonts[15],"left","top",false,false,false,true)
                        dxDrawRectangle(pos[1]+20,pos[2]+75+((rowSize+1)*maxLine+1)+15+25,size[1]-40,130,tocolor(55,55,55,200))

                        dxDrawText(loaded_company["message"],pos[1]+25,pos[2]+80+((rowSize+1)*maxLine+1)+15+25,pos[1]+25+(size[1]-50),(pos[2]+80+((rowSize+1)*maxLine+1)+15+25)+120,tocolor(222,222,222,222),1,fonts[12],"left","top",true,true,false,false)

                        if playerHavePermission() then
                            dxDrawText("Üzenet szerkesztése:",pos[1]+20,pos[2]+75+((rowSize+1)*maxLine+1)+175,nil,nil,tocolor(183,255,0,200),1,fonts[15],"left","top",false,false,false,true)
                            
                            dxDrawRectangle(pos[1]+20,pos[2]+size[2]-65,size[1]-40-45,45,tocolor(55,55,55,200))
                            dxDrawRectangle(pos[1]+20+(size[1]-40)-45,pos[2]+size[2]-65,45,45,tocolor(183,255,0,150))
                            dxDrawText("",pos[1]+20+(size[1]-40)-45/2,pos[2]+size[2]-65+45/2,nil,nil,tocolor(10,10,10,222),1,fonts["fontawsome_11"],"center","center")
                            dxDrawBorder(pos[1]+20,pos[2]+size[2]-65,size[1]-40,45,2,tocolor(10,10,10,200))
                        end
                    elseif page == 5 then --// Tevékenységnapló
                        maxLine = 16
                        rowSize = 24.2

                        dxDrawRectangle(pos[1]+20,pos[2]+95,size[1]-40,rowSize,tocolor(65,65,65,235))
                        dxDrawText("Időpont:",pos[1]+20+5,pos[2]+95+rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[11],"left","center",false,false,false,true)
                        dxDrawText("Tevékenység leírása:",pos[1]+220,pos[2]+95+rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[11],"left","center",false,false,false,true)
                        for i = 1,maxLine do
                            local row = loaded_company["transactions"][i+scroll]
                            dxDrawRectangle(pos[1]+20,pos[2]+95+i*(rowSize+5),size[1]-40,rowSize,tocolor(55,55,55,200))
                            if row then
                                dxDrawText(formatDate("Y/m/d - h:i:s","'",row.time),pos[1]+20+5,pos[2]+95+i*(rowSize+5)+rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[11],"left","center",false,false,false,true)
                                dxDrawText(row.text,pos[1]+220,pos[2]+95+i*(rowSize+5)+rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[11],"left","center",false,false,false,true)
                            end
                        end
                    elseif page == 4 then --// Járművek
                        maxLine = 10
                        rowSize = 51.4

                        local companyVehicles = getCompanyVehicles(loaded_company["id"])
                        dxDrawRectangle(pos[1],pos[2]+75,310+2,(rowSize+1)*maxLine+1,tocolor(35,35,35,250))
                        for i = 1,maxLine do
                            local boxpos = {pos[1]+1,pos[2]+76+(i-1)*(rowSize+1)}
                            local boxsize = {310,rowSize}
                            dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(65,65,65,250))
                            local vehicle = companyVehicles[i+scroll]
                            if vehicle then
                                if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
                                    dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(200,200,200,10))
                                end

                                dxDrawText(getVehicleNameFromShop(vehicle),boxpos[1]+boxsize[1]/2,boxpos[2]+boxsize[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[13],"center","center",false,false,false,true)
                        
                                if selected == i+scroll then
                                    dxDrawBorder(boxpos[1]+1,boxpos[2]+1,boxsize[1]-2,boxsize[2]-2,1,tocolor(183,255,0,200))
                                end
                            end
                        end

                        if selected > 0 then
                            local vehicle = companyVehicles[selected]
                            if not vehicle then selected = 0 end

                            dxDrawText("Jármű ID: #dedede" .. format(getElementData(vehicle,"company.vehicleID")),pos[1]+335,pos[2]+100,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                            local driver = getVehicleController(vehicle)
                            local dim = getElementDimension(vehicle)
                            local x,y,z = getElementPosition(vehicle)
                            if getElementDimension(vehicle) < 30000 then
                                if driver then
                                    dxDrawText("Jelenlegi sofőr: #dedede" .. getElementData(driver,"char.Name"):gsub("_"," "),pos[1]+335,pos[2]+140,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                else
                                    dxDrawText("Jelenlegi sofőr: #dededeHasználatban!",pos[1]+335,pos[2]+140,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                end
                                dxDrawText("Jelenlegi tartózkodási helye: #dedede" .. getZoneName(x,y,z) .. " (" .. getZoneName(x,y,z,true) .. ")",pos[1]+335,pos[2]+180,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)

                                if getElementData(vehicle,"company.stuffName") then
                                    dxDrawText("Szállítmány típúsa: #dedede" .. getElementData(vehicle,"company.stuffName"),pos[1]+335,pos[2]+220,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                else
                                    dxDrawText("Szállítmány típúsa: #e43232Ismeretlen!",pos[1]+335,pos[2]+220,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                end
                                dxDrawText("Napi adó: " .. math.floor(getModelPriceFromShop(vehicle)*getVehicleTax()),pos[1]+335,pos[2]+260,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                if getElementData(vehicle,"company.rent") >= 0 then 
                                    rent = "Igen (Még " .. getElementData(vehicle,"company.rent") .. " fuvar)" 
                                else
                                    rent = "Nem"
                                end
                                dxDrawText("Bérelt: #dedede" .. rent,pos[1]+335,pos[2]+300,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                            else
                                dxDrawText("Jelenlegi sofőr: #e43232Nincs használatban!",pos[1]+335,pos[2]+140,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                dxDrawText("Jelenlegi tartózkodási helye: #e43232Ismeretlen!",pos[1]+335,pos[2]+180,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                dxDrawText("Szállítmány típúsa: #e43232Ismeretlen!",pos[1]+335,pos[2]+220,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                dxDrawText("Napi adó: #dedede" .. format(math.floor(getModelPriceFromShop(vehicle)*getVehicleTax())) .. " Ft",pos[1]+335,pos[2]+260,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                                local rent = "Nem"
                                if getElementData(vehicle,"company.rent") >= 0 then rent = "Igen (Még " .. getElementData(vehicle,"company.rent") .. " fuvar)" end
                                dxDrawText("Bérelt: #dedede" .. rent,pos[1]+335,pos[2]+300,nil,nil,tocolor(183,255,0,222),1,fonts[12],"left","top",false,false,false,true)
                            end

                            if playerHavePermission() then
                                dxDrawRectangle(pos[1]+335,pos[2]+size[2]-40-15,300,40,tocolor(228,58,58,200))
                                if isCursorOnBox(pos[1]+335,pos[2]+size[2]-40-15,300,40) then
                                    dxDrawRectangle(pos[1]+335,pos[2]+size[2]-40-15,300,40,tocolor(255,255,255,25))
                                end
                                dxDrawText("Eladás kereskedőnek (" .. format(math.floor(getModelPriceFromShop(vehicle)*0.35)) .. " Ft)",pos[1]+335+300/2,pos[2]+size[2]-40-15+40/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center")
                                dxDrawBorder(pos[1]+335,pos[2]+size[2]-40-15,300,40,1,tocolor(10,10,10,200))

                                dxDrawRectangle(pos[1]+size[1]-300-15,pos[2]+size[2]-40-15,300,40,tocolor(228,58,58,200))
                                if isCursorOnBox(pos[1]+size[1]-300-15,pos[2]+size[2]-40-15,300,40) then
                                    dxDrawRectangle(pos[1]+size[1]-300-15,pos[2]+size[2]-40-15,300,40,tocolor(255,255,255,25))
                                end
                                dxDrawText("Eladás vállalkozásnak",pos[1]+size[1]-300-15+300/2,pos[2]+size[2]-40-15+40/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center")
                                dxDrawBorder(pos[1]+size[1]-300-15,pos[2]+size[2]-40-15,300,40,1,tocolor(10,10,10,200))
                            end
                        end
                    end
                end
            elseif panel == "newCompany" then
                dxDrawText("Cég alapítás",pos[1]+size[1]/2,pos[2]+60,nil,nil,tocolor(222,222,222,222),1,fonts[20],"center","top",false,false,false,true)
                dxDrawText("Válaszd ki a vállakozás típusát",pos[1]+size[1]/2,pos[2]+120,nil,nil,tocolor(222,222,222,222),1,fonts[18],"center","top",false,false,false,true)
            
                dxDrawRectangle(pos[1]+size[1]/2-250,pos[2]+size[2]-200,500,50,tocolor(70,70,70,250))

                dxDrawRectangle(pos[1]+size[1]/2-125,pos[2]+size[2]-55,250,40,tocolor(183,255,0,200))
                if isCursorOnBox(pos[1]+size[1]/2-125,pos[2]+size[2]-55,250,40) then
                    dxDrawRectangle(pos[1]+size[1]/2-125,pos[2]+size[2]-55,250,40,tocolor(255,255,255,50))
                end
                dxDrawBorder(pos[1]+size[1]/2-125,pos[2]+size[2]-55,250,40,1,tocolor(10,10,10,200))
                dxDrawText("Létrehozás",pos[1]+size[1]/2-125+250/2,pos[2]+size[2]-55+40/2,nil,nil,tocolor(10,10,10,200),1,fonts[17],"center","center",false,false,false,true)
            end
            if buySlot then
                dxDrawRectangle(0,0,s[1],s[2],tocolor(0,0,0,50),true)
                local size = {350,175}
                local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

                dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(40,40,40,250),true)
                dxDrawRectangle(pos[1],pos[2],size[1],35,tocolor(35,35,35,250),true)

                dxDrawText("X",pos[1]+size[1]-5,pos[2]+2,nil,nil,tocolor(228,50,50,200),1,fonts[12],"right","top",false,false,true)

                if buySlot == "member" or buySlot == "vehicle" then
                    dxDrawText("Slot vásárlás",pos[1]+size[1]/2,pos[2]+35/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,true)
                else
                    dxDrawText("Szint vásárlás",pos[1]+size[1]/2,pos[2]+35/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,true)
                end
                dxDrawText("Biztos meg kivánod vásárolni?",pos[1]+size[1]/2,pos[2]+40,nil,nil,tocolor(222,222,222,222),1,fonts[11],"center","top",false,false,true)
            
                dxDrawRectangle(pos[1]+5,pos[2]+60,size[1]-90,35,tocolor(35,35,35,250),true)

                dxDrawRectangle(pos[1]+size[1]-5-35,pos[2]+60,35,35,tocolor(228,50,50,200),true)
                dxDrawText("-",pos[1]+size[1]-5-35/2,pos[2]+60+35/2,nil,nil,tocolor(0,0,0,200),1,fonts[12],"center","center",false,false,true)
                dxDrawRectangle(pos[1]+size[1]-5-35-5-35,pos[2]+60,35,35,tocolor(183,255,0,200),true)
                dxDrawText("+",pos[1]+size[1]-5-35-5-35/2,pos[2]+60+35/2,nil,nil,tocolor(0,0,0,200),1,fonts[12],"center","center",false,false,true)
            
                if buySlot == "member" or buySlot == "vehicle" then
                    dxDrawText(format(selectedSlot) .. " slot = " .. format(selectedSlot*slotPrice) .. "NL Coin",pos[1]+5+(size[1]-90)/2,pos[2]+60+35/2,nil,nil,tocolor(222,222,222,222),1,fonts[13],"center","center",false,false,true)
                else
                    dxDrawText(format(selectedSlot) .. " szint = " .. format(selectedSlot*slotPrice) .. "NL Coin",pos[1]+5+(size[1]-90)/2,pos[2]+60+35/2,nil,nil,tocolor(222,222,222,222),1,fonts[13],"center","center",false,false,true)
                end

                dxDrawRectangle(pos[1]+20,pos[2]+size[2]-40-5,size[1]-40,40,tocolor(183,255,0,200),true)
                dxDrawBorder(pos[1]+20,pos[2]+size[2]-40-5,size[1]-40,40,1,tocolor(0,0,0,200),true)
                dxDrawText("Vásárlás",pos[1]+size[1]/2,pos[2]+size[2]-40-5+40/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"center","center",false,false,true)
            end
        end
    end
)

addEventHandler("onClientKey",root,
    function(k,p)
        if k == "mouse1" and p then
            if sellToPlayer then
                if isCursorOnBox(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10-45,sellsize[1]-20,35) then
                    local id = dxGetEditText("sellTo_player")
                    local price = dxGetEditText("sellTo_price")
                    local newOwner = exports.nlrp_core:findPlayer(id)
                    if newOwner then
                        if tonumber(price) then
                            price = tonumber(price)
                            if price > 0 then
                                if getElementData(newOwner,"char.CompanyID") > 0 then
                                    if getElementData(newOwner,"char.CompanyRank") == "5" then
                                        triggerServerEvent("sellVehicleToPlayer",resourceRoot,localPlayer,id,price,sellToPlayer)
                                        sellToPlayer = false
                                        dxDestroyEdit("sellTo_price")
                                        dxDestroyEdit("sellTo_player")
                                    else
                                        exports.nlrp_hud:showInfobox("error","A kiválasztott játékos nem a tulajdonosa egy vállalkozásnak sem!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","A kiválasztott játékos nem tagja egy vállalkozásnak sem!")
                                end
                            else
                                exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva!")
                            end
                        else
                            exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva!")
                        end
                    else
                        exports.nlrp_hud:showInfobox("error","Nem található játékos!")
                    end
                elseif isCursorOnBox(sellpos[1]+10,sellpos[2]+sellsize[2]-35-10,sellsize[1]-20,35) then
                    sellToPlayer = false
                    dxDestroyEdit("sellTo_price")
                    dxDestroyEdit("sellTo_player")
                end
            end
            if panel and buySlot then
                local size = {350,175}
                local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

                if isCursorOnBox(pos[1]+size[1]-20,pos[2],20,20) then
                    buySlot = false
                    selectedSlot = 1
                elseif isCursorOnBox(pos[1]+size[1]-5-35-5-35,pos[2]+60,35,35) then
                    selectedSlot = selectedSlot + 1
                elseif isCursorOnBox(pos[1]+size[1]-5-35,pos[2]+60,35,35) then
                    if selectedSlot > 1 then selectedSlot = selectedSlot - 1 end
                elseif isCursorOnBox(pos[1]+20,pos[2]+size[2]-40-5,size[1]-40,40) then
                    triggerServerEvent("tryBuySlot",resourceRoot,localPlayer,loaded_company["id"],buySlot,selectedSlot) 
                    buySlot = false
                    triggerServerEvent("getCompanyDatas",resourceRoot,localPlayer,loaded_company["id"],false)
                end
            elseif panel and not buySlot then
                local charID = getElementData(localPlayer,"char.ID")
                if panel == "company" and loaded then
                    for i = 1,#panels do
                        if isCursorOnBox(pos[1]+(i-1)*(size[1]/#panels),pos[2]+40,size[1]/#panels,35) then
                            if page ~= i then
                                page = i
                                triggerServerEvent("getCompanyDatas",resourceRoot,localPlayer,loaded_company["id"],false)
                                loaded = false
                                scroll = 0
                                selected = 0
                                dxDestroyEdit("newPlayer")
                                dxDestroyEdit("companyBalance")
                                dxDestroyEdit("payTax")
                                dxDestroyEdit("renameRank")
                                dxDestroyEdit("reprecentRank")
                                dxDestroyEdit("rewriteMessage")
                                payTaxes = false
                                size = {1000,600}
                                pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
                                if page == 1 then                           
                                    if playerHavePermission() then
                                        dxCreateEdit("newPlayer","","Játékos ID/Név",pos[1]+size[1]-300-100,pos[2]+350,200-30,30,13)
                                        dxCreateEdit("companyBalance","","Írd be a kivánt összeget..",pos[1]+300,pos[2]+size[2]-160,size[1]-680,40,14)
                                    end
                                elseif page == 3 then
                                    selected = 1
                                    if playerHavePermission() then
                                        dxCreateEdit("renameRank","","Írd be a rang új nevét..",pos[1]+size[1]-20-310-45,pos[2]+230,310,45,13)
                                        dxCreateEdit("reprecentRank","","Írd be a rang új részesedését..",pos[1]+size[1]-20-310-45,pos[2]+280,310,45,13)
                                        dxCreateEdit("rewriteMessage","","Írd be az új vállalkozás üzenetet..",pos[1]+20,pos[2]+size[2]-65,size[1]-40-45,45,13)
                                    end
                                end                 
                            end
                        end
                    end
                    if page == 4 then
                        local companyVehicles = getCompanyVehicles(loaded_company["id"])
                        for i = 1,maxLine do
                            local boxpos = {pos[1]+1,pos[2]+76+(i-1)*(rowSize+1)}
                            local boxsize = {310,rowSize}
                            local vehicle = companyVehicles[i+scroll]
                            if vehicle then
                                if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
                                    if selected ~= i+scroll then
                                        selected = i+scroll
                                    end
                                end
                            end
                        end
                        if companyVehicles[selected] then
                            if isCursorOnBox(pos[1]+335,pos[2]+size[2]-40-15,300,40) then
                                if playerHavePermission() then
                                    if getElementData(companyVehicles[selected],"company.rent") <= 0 then
                                        triggerServerEvent("sellVehicleToShop",resourceRoot,localPlayer,getElementData(companyVehicles[selected],"company.vehicleID"))
                                        scroll = 0
                                        selected = 0

                                        exports.nlrp_hud:showInfobox("info","Sikeresen eladtad a kiválasztott járművet!")
                                    else
                                        exports.nlrp_hud:showInfobox("error","Bérelt járművet nem adhatsz el!")
                                    end
                                end
                            elseif isCursorOnBox(pos[1]+size[1]-300-15,pos[2]+size[2]-40-15,300,40) then
                                if playerHavePermission() then --// ELADÁS VÁLLALKOZÁSNAK
                                    if getElementData(companyVehicles[selected],"company.rent") <= 0 then
                                        buySlot = false
                                        selectedSlot = 1
                                        panel = false
                                        dxDestroyEdit("companyName")
                                        dxDestroyEdit("newPlayer")
                                        dxDestroyEdit("companyBalance")
                                        dxDestroyEdit("payTax")
                                        dxDestroyEdit("renameRank")
                                        dxDestroyEdit("reprecentRank")
                                        dxDestroyEdit("rewriteMessage")
                                        payTaxes = false

                                        showChat(true)
                                        exports.nlrp_hud:toggleHUD(true)
                                        exports.nlrp_dashboard:removeBlur("company")

                                        sellToPlayer = getElementData(companyVehicles[selected],"company.vehicleID")
                                        dxCreateEdit("sellTo_player","","Játékos ID..",sellpos[1]+10,sellpos[2]+50,sellsize[1]-20,35,11)
                                        dxCreateEdit("sellTo_price","","Ár (Forint)..",sellpos[1]+10,sellpos[2]+50+45,sellsize[1]-20,35,11)
                                    else
                                        exports.nlrp_hud:showInfobox("error","Bérelt járművet nem adhatsz el!")
                                    end
                                end
                            end
                        end
                    elseif page == 3 then
                        for i = 1,maxLine do
                            local boxpos = {pos[1]+1,pos[2]+76+(i-1)*(rowSize+1)}
                            local boxsize = {250,rowSize}
                            if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
                                local rank = loaded_company["ranks"][tostring(i+scroll)]
                                if rank then
                                    if selected ~= i+scroll then
                                        selected = i+scroll
                                    end
                                end
                            end
                        end
                        if playerHavePermission() then
                            if isCursorOnBox(pos[1]+size[1]-20-45,pos[2]+230,45,45) then --// Rang név szerkesztése
                                local text = dxGetEditText("renameRank")
                                if #text > 0 then
                                    if #text <= 20 then
                                        triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " átnevezett egy rangot! (" .. loaded_company["ranks"][tostring(selected)].name .. " -> " .. text .. ")")

                                        loaded_company["ranks"][tostring(selected)].name = text
                                        dxEditSetText("renameRank","")
                                        exports.nlrp_hud:showInfobox("info","Sikeresen átírtad a kiválasztott rang nevét!")
                                        triggerServerEvent("editRanks",resourceRoot,loaded_company["id"],loaded_company["ranks"])
                                    else
                                        exports.nlrp_hud:showInfobox("error","A rang nem lehet több 12 karakternél!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","A rang nevének legalább 1 karakterből kell állnia!")
                                end
                            elseif isCursorOnBox(pos[1]+size[1]-20-45,pos[2]+280,45,45) then --// Rang részesedése
                                local text = dxGetEditText("reprecentRank")
                                if tonumber(text) then
                                    text = tonumber(text)
                                    if text >= 0 then
                                        if text <= 100 then
                                            triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " átírta a '" .. loaded_company["ranks"][tostring(selected)].name .. "' nevű rang részesedését! (" .. loaded_company["ranks"][tostring(selected)].precent .. "% -> " .. text .. "%)")

                                            loaded_company["ranks"][tostring(selected)].precent = text
                                            dxEditSetText("reprecentRank","")
                                            exports.nlrp_hud:showInfobox("info","Sikeresen átírtad a kiválasztott rang részesedését!")
                                            triggerServerEvent("editRanks",resourceRoot,loaded_company["id"],loaded_company["ranks"])
                                        else
                                            exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva.")
                                        end
                                    else
                                        exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva.")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva.")
                                end
                            elseif isCursorOnBox(pos[1]+20+(size[1]-40)-45,pos[2]+size[2]-65,45,45) then --// Üzenet mentése
                                local text = dxGetEditText("rewriteMessage")
                                loaded_company["message"] = text
                                triggerServerEvent("changeCompanyText",resourceRoot,loaded_company["id"],text)
                                dxEditSetText("rewriteMessage","")
                                exports.nlrp_hud:showInfobox("info","Sikeresen átállítottad a vállalkozás üzenetet!")
                                triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " átírta a vállalkozás üzenetét!")
                            end
                        end
                    elseif page == 2 then
                        for i = 1,maxLine do
                            local boxpos = {pos[1]+1,pos[2]+76+(i-1)*(rowSize+1)}
                            local boxsize = {250,rowSize}
                            if isCursorOnBox(boxpos[1],boxpos[2],boxsize[1],boxsize[2]) then
                                local player = loaded_company["membersCount"][i+scroll]
                                if player then
                                    if selected ~= i+scroll then
                                        selected = i+scroll
                                        dxDestroyEdit("payTax")
                                        payTaxes = false
                                    end
                                end
                            end
                        end

                        if playerHavePermission() then
                            if selected ~= 0 then
                                local player = loaded_company["membersCount"][selected]
                                local online_player = findPlayerByName(player.name)
                                local xsize = ((size[1]-252)/2)-2

                                if isCursorOnBox(pos[1]+253+xsize+1,pos[2]+size[2]-46-46,xsize,45) then --// Járulék befizetés
                                    if not payTaxes then
                                        dxCreateEdit("payTax","","Írd be hány napig fizeted be..",pos[1]+253+xsize+1,pos[2]+size[2]-46-46,xsize-45-46-5,45,11)
                                        payTaxes = true
                                    end
                                elseif isCursorOnBox(pos[1]+253+xsize+1,pos[2]+size[2]-46,xsize,45) then --// Kirúgás
                                    if online_player then
                                        if online_player == localPlayer then
                                            exports.nlrp_hud:showInfobox("error","Saját magadat nem rúghatod ki!")
                                        else
                                            triggerServerEvent("kickPlayerFromCompany",resourceRoot,online_player)
                                        end
                                    else
                                        if loaded_company["leader"] == player.dbid then
                                            exports.nlrp_hud:showInfobox("error","A leadert nem rúghatod ki!")
                                        else
                                            triggerServerEvent("kickPlayerFromCompany",resourceRoot,player.dbid)
                                        end
                                    end
                                    table.remove(loaded_company["membersCount"],selected)
                                    selected = 0
                                    exports.nlrp_hud:showInfobox("info","Sikeresen kirugtad '" .. player.name:gsub("_"," ") .. "' nevű játékost a vállalkozásodból!")
                                    triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " kirúgta '" .. player.name:gsub("_"," ") .. "' nevű tagot a vállalkozásból!")
                                elseif isCursorOnBox(pos[1]+253,pos[2]+size[2]-46,xsize,45) then --// Lefokozás
                                    if player.rank > 1 then
                                        if online_player then
                                            triggerServerEvent("decratePlayer",resourceRoot,localPlayer,loaded_company["id"],online_player,getElementData(online_player,"char.CompanyRank"),player.name)
                                        else
                                            triggerServerEvent("decratePlayer",resourceRoot,localPlayer,loaded_company["id"],player.dbid,player.rank,player.name)
                                        end
                                        player.rank = player.rank - 1
                                        exports.nlrp_hud:showInfobox("info","Sikeresen lefokoztad a kiválasztott játékost.")
                                    else
                                        exports.nlrp_hud:showInfobox("error","A játékos már a legkissebb rangon van")
                                    end
                                elseif isCursorOnBox(pos[1]+253,pos[2]+size[2]-46-46,xsize,45) then --// Előléptetés
                                    if player.rank < 5 then
                                        if online_player then
                                            triggerServerEvent("promotePlayer",resourceRoot,localPlayer,loaded_company["id"],online_player,getElementData(online_player,"char.CompanyRank"),player.name)
                                        else
                                            triggerServerEvent("promotePlayer",resourceRoot,localPlayer,loaded_company["id"],player.dbid,player.rank,player.name)
                                        end
                                        player.rank = player.rank + 1
                                        exports.nlrp_hud:showInfobox("info","Sikeresen előléptetted a kiválasztott játékost.")
                                    else
                                        exports.nlrp_hud:showInfobox("error","A játékos már a legmagasabb rangon van")
                                    end
                                end
                                if payTaxes then
                                    if isCursorOnBox(pos[1]+253+xsize+1+xsize-45,pos[2]+size[2]-46-46,45,45) then --// Mégse
                                        dxDestroyEdit("payTax")
                                        payTaxes = false
                                    elseif isCursorOnBox(pos[1]+253+xsize+1+xsize-45-46,pos[2]+size[2]-46-46,45,45) then -- Fizetés
                                        local text = dxGetEditText("payTax")
                                        if tonumber(text) then
                                            text = tonumber(text)
                                            if text <= 365 then
                                                local price = taxesByRank[player.rank]*text
                                                if loaded_company["balance"] >= price then
                                                    --if player.taxPayed < getTimestamp() then
                                                        loaded_company["balance"] = loaded_company["balance"] - price
                                                        triggerServerEvent("editBalance",resourceRoot,loaded_company["id"],loaded_company["balance"])
                                                        exports.nlrp_hud:showInfobox("info","Sikeresen befizetted a járulékot '" .. player.name:gsub("_"," ") .. "' nevű játékos után " .. text .. " napra!")
                                                    
                                                        if online_player then
                                                            triggerServerEvent("payTaxesForPlayer",resourceRoot,localPlayer,online_player,text,getElementData(online_player,"char.CompanyTaxPayed"))
                                                        else
                                                            triggerServerEvent("payTaxesForPlayer",resourceRoot,localPlayer,player.dbid,text)
                                                        end

                                                        triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " befizette a járulékokat '" .. player.name:gsub("_"," ") .. "' nevű tag után, " .. text .. " napra!")
                                                    --else
                                                        --exports.nlrp_hud:showInfobox("error","Ennél a tagnál már be van fizetve a járulék. Ameddig nem jár le nem fizethetsz be újat!")
                                                    --end

                                                    payTaxes = false
                                                    dxDestroyEdit("payTax")
                                                else
                                                    exports.nlrp_hud:showInfobox("error","Nincs elegendő egyenleg a vállalkozás számláján!")
                                                end
                                            else
                                                exports.nlrp_hud:showInfobox("error","Egy évnél többet előre nem fizethetsz!")
                                            end
                                        else
                                            exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva.")
                                        end
                                    end
                                end
                            end
                        end
                    elseif page == 1 then
                        if playerHavePermission() then
                            if isCursorOnBox(pos[1]+size[1]-230,pos[2]+245,30,30) then --// Jármű slot vásárlás
                                buySlot = "vehicle"
                                selectedSlot = 1
                            elseif isCursorOnBox(pos[1]+350,pos[2]+245,30,30) then --// Tag slot vásárlás
                                buySlot = "member"
                                selectedSlot = 1
                            elseif isCursorOnBox(pos[1]+size[1]-195,pos[2]+size[2]-80,30,30) then --// Szint vásárlás
                                buySlot = "level"
                                selectedSlot = 1
                            elseif isCursorOnBox(pos[1]+size[1]-300-100+200-30,pos[2]+350,30,30) then
                                local text = dxGetEditText("newPlayer")
                                local player = exports.nlrp_core:findPlayer(text)
                                if player then
                                    if tonumber(getElementData(player,"char.CompanyID")) > 0 then
                                        exports.nlrp_hud:showInfobox("error","A játékos már egy vállalkozás tagja.")
                                    else
                                        if #loaded_company["membersCount"] < loaded_company["memberSlot"] then
                                            exports.nlrp_hud:showInfobox("info","Sikeresen felvetted '" .. getElementData(player,"char.Name"):gsub("_"," ") .. "' nevű játékost a vállalkozásodba!")
                                            triggerServerEvent("inviteToCompany",resourceRoot,localPlayer,player,loaded_company["id"],loaded_company["name"])
                                            triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " felvette '" .. getElementData(player,"char.Name"):gsub("_"," ") .. "' nevű tagot a vállalkozásba!")
                                        else
                                            exports.nlrp_hud:showInfobox("error","Nincs több hely a vállalkozásodban!")
                                        end
                                    end
                                end
                            elseif isCursorOnBox(pos[1]+665,pos[2]+size[2]-160+5,30,30) then --// Pénz kivétel
                                local text = dxGetEditText("companyBalance")
                                if tonumber(text) then
                                    text = tonumber(text)
                                    if text > 0 then
                                        if loaded_company["balance"] >= text then
                                            triggerServerEvent("updateBalance",resourceRoot,localPlayer,loaded_company["id"],loaded_company["balance"],text,"-")
                                            triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " kivett " .. format(text) .. " forint összeget a vállalkozás számlájáról!")
                                            loaded_company["balance"] = loaded_company["balance"] - text
                                            dxEditSetText("companyBalance","")
                                        else
                                            exports.nlrp_hud:showInfobox("error","Nincs elegendő összeg a vállalkozás számláján!")
                                        end
                                    else
                                        exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva!")
                                end
                            elseif isCursorOnBox(pos[1]+665-35,pos[2]+size[2]-160+5,30,30) then --// Pénz berakás ikszdé
                                local text = dxGetEditText("companyBalance")
                                if tonumber(text) then
                                    text = tonumber(text)
                                    if text > 0 then
                                        if getElementData(localPlayer,"char.Money") >= text then
                                            triggerServerEvent("updateBalance",resourceRoot,localPlayer,loaded_company["id"],loaded_company["balance"],text,"+")
                                            triggerServerEvent("insertTransaction",resourceRoot,loaded_company["id"],getElementData(localPlayer,"char.Name"):gsub("_"," ") .. " befizetett " .. format(text) .. " forint összeget a vállalkozás számlájára!")
                                            loaded_company["balance"] = loaded_company["balance"] + text
                                            dxEditSetText("companyBalance","")
                                        else
                                            exports.nlrp_hud:showInfobox("error","Nincs elegendő készpénzed!")
                                        end
                                    else
                                        exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Hibás összeg lett megadva!")
                                end
                            end
                        end
                    end
                elseif panel == "newCompany" then
                    if isCursorOnBox(pos[1]+size[1]/2-125,pos[2]+size[2]-55,250,40) then --// Létrehozás
                        local entered_name = dxGetEditText("companyName")
                        if #entered_name >= 5 then
                            if #entered_name > 40 then
                                exports.nlrp_hud:showInfobox("error","Vállalkozásod neve maxmimum 40 karakterből állhat.")
                            else
                                exports.nlrp_dashboard:removeBlur("company")
                                panel = false
                                dxDestroyEdit("companyName")
                                triggerServerEvent("setUpCompany",resourceRoot,localPlayer,selected_type,entered_name)
                                exports.nlrp_hud:toggleHUD(true)
                                exports.nlrp_hud:showInfobox("info","Sikeresen létrehoztad a vállalkozásodat!")
                            end
                        else
                            exports.nlrp_hud:showInfobox("error","Vállalkozásod nevének minimum 5 karakterből kell állnia.")
                        end
                    end
                end
            end
        elseif k == "F1" and p then
            if getElementData(localPlayer,"loggedIn") then
                if sellToPlayer then return end
                buySlot = false
                selectedSlot = 1
                if panel then
                    panel = false
                    dxDestroyEdit("companyName")
                    dxDestroyEdit("newPlayer")
                    dxDestroyEdit("companyBalance")
                    dxDestroyEdit("payTax")
                    dxDestroyEdit("renameRank")
                    dxDestroyEdit("reprecentRank")
                    dxDestroyEdit("rewriteMessage")
                    payTaxes = false

                    showChat(true)
                    exports.nlrp_hud:toggleHUD(true)
                    exports.nlrp_dashboard:removeBlur("company")
                else
                    size = {1000,600}
                    pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
                    if tonumber(getElementData(localPlayer,"char.CompanyID")) > 0 then
                        triggerServerEvent("getCompanyDatas",resourceRoot,localPlayer,tonumber(getElementData(localPlayer,"char.CompanyID")),true)
                        loaded = false
                        panel = "company"
                    else
                        panel = "noCompany"
                    end

                    showChat(false)
                    exports.nlrp_hud:toggleHUD(false)
                    exports.nlrp_dashboard:createBlur("company",10)
                end
            end
        elseif k == "mouse_wheel_down" and p then
            if panel then
                if page == 2 then
                    if scroll < #loaded_company["membersCount"]-maxLine then
                        scroll = scroll + 1
                    end
                elseif page == 4 then
                    if scroll < #getCompanyVehicles(loaded_company["id"])-maxLine then
                        scroll = scroll + 1
                    end
                elseif page == 5 then
                    if scroll < #loaded_company["transactions"]-maxLine then
                        scroll = scroll + 1
                    end
                end
            end
        elseif k == "mouse_wheel_up" and p then
            if panel then
                if scroll > 0 then
                    scroll = scroll - 1
                end
            end
        end
    end
)

addEvent("returnCompany",true)
addEventHandler("returnCompany",localPlayer,
    function(data,transactions,vehicles,firstOpen)
        if data then
            for k,v in ipairs(data) do
                for row,value in pairs(v) do
                    loaded_company[row] = value
                end
                if loaded_company["ranks"] then
                    loaded_company["ranks"] = fromJSON(loaded_company["ranks"])
                end
                loaded_company["membersCount"] = {}
                loadCompanyMembers(loaded_company["id"])
                loaded_company["vehiclesCount"] = 1

                loaded_company["transactions"] = {}
                for id,row in pairs(transactions) do
                    loaded_company["transactions"][id] = {time=row.time,text=row.text}
                end
                table.sort(loaded_company["transactions"], function(a,b) return a.time > b.time end )

                loaded_company["vehicles"] = vehicles

                if firstOpen then
                    if loaded_company["type"] > 0 then --// Ha már egy beállított vállalkozás
                        panel = "company"
                        loaded = true
                        page = 1
                        local charID = getElementData(localPlayer,"char.ID")
                        if playerHavePermission() then
                            dxCreateEdit("newPlayer","","Játékos ID/Név",pos[1]+size[1]-300-100,pos[2]+350,200-30,30,13)
                            dxCreateEdit("companyBalance","","Írd be a kivánt összeget..",pos[1]+300,pos[2]+size[2]-160,size[1]-680,40,14)
                        end
                    else --// Hogyha új vállalkozásról beszélünk
                        panel = "newCompany"
                        dxCreateEdit("companyName","","Írd be a vállalkozásd nevét..",pos[1]+size[1]/2-250,pos[2]+size[2]-200,500,50,17)
                        selected_type = 1
                    end
                else
                    loaded = true
                end
            end
        end
    end
)

function loadCompanyMembers(id)
    triggerServerEvent("loadCompanyMembers",resourceRoot,localPlayer,id)
end

addEvent("returnCompanyMembers",true)
addEventHandler("returnCompanyMembers",localPlayer,
    function(table)
        loaded_company["membersCount"] = table
    end
)

function playerHavePermission()
    local perm = false
    if loaded_company["leader"] == getElementData(localPlayer,"char.ID") then perm = true end
    if getElementData(localPlayer,"char.CompanyRank") == "5" then perm = true end
    return perm
end

function findPlayerByName(name)
    local player = false
    for k,v in ipairs(getElementsByType("player")) do
        if getElementData(v,"char.Name") == name then
            player = v
        end
    end
    return player
end

function findPlayerByID(name)
    local player = false
    for k,v in ipairs(getElementsByType("player")) do
        if getElementData(v,"char.Name") == name then
            player = v
        end
    end
    return player
end

function getPlayersWithThatRank(rank)
    local count = 0
    for k,v in ipairs(loaded_company["membersCount"]) do
        if v.rank == rank then
            count = count + 1
        end
    end
    return count
end


--// Munka elkezdés
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local spawn = {
    state = false,
    scroll = 0,
    maxLine = 7,
    rowSize = 50,
}

addEventHandler("onClientRender",root,
    function()
        if spawn.state then
            local size = {900,500}
            local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

            dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(40,40,40,200))
            dxDrawRectangle(pos[1],pos[2],size[1],60,tocolor(40,40,40,200))

            dxDrawText("X",pos[1]+size[1]-5,pos[2]+2,nil,nil,tocolor(228,50,50,222),1,fonts[15],"right","top")
            dxDrawText("Jármű lehívás",pos[1]+size[1]/2,pos[2]+60/2,nil,nil,tocolor(222,222,222,222),1,fonts[16],"center","center")

            dxDrawImage(pos[1]+5,pos[2]+5,400/12,259/12,logo_texture)

            dxDrawRectangle(pos[1]+10,pos[2]+70,size[1]-20,25,tocolor(65,65,65,235))
            dxDrawText("Jármű neve:",pos[1]+15,pos[2]+70+25/2,nil,nil,tocolor(222,222,222,222),1,fonts[11],"left","center")
            dxDrawText("Használatban:",pos[1]+270,pos[2]+70+25/2,nil,nil,tocolor(222,222,222,222),1,fonts[11],"left","center")

            local companyVehicles = getCompanyVehicles(getElementData(localPlayer,"char.CompanyID"))
            for i = 1,spawn.maxLine do
                dxDrawRectangle(pos[1]+10,pos[2]+100+(i-1)*(spawn.rowSize+5),size[1]-20,spawn.rowSize,tocolor(30,30,30,240))
                local vehicle = companyVehicles[i+spawn.scroll]
                if vehicle then
                    dxDrawText(getVehicleNameFromShop(vehicle),pos[1]+20,pos[2]+100+(i-1)*(spawn.rowSize+5)+spawn.rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"left","center")
                    if getElementDimension(vehicle) >= 30000 then
                        dxDrawText("#b7ff00Nem",pos[1]+280,pos[2]+100+(i-1)*(spawn.rowSize+5)+spawn.rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"left","center",false,false,false,true)
                        dxDrawRectangle(pos[1]+size[1]-135,pos[2]+100+(i-1)*(spawn.rowSize+5)+8,110,spawn.rowSize-16,tocolor(183,255,0,200))
                    else
                        dxDrawText("#e43232Igen",pos[1]+280,pos[2]+100+(i-1)*(spawn.rowSize+5)+spawn.rowSize/2,nil,nil,tocolor(222,222,222,222),1,fonts[14],"left","center",false,false,false,true)
                        dxDrawRectangle(pos[1]+size[1]-135,pos[2]+100+(i-1)*(spawn.rowSize+5)+8,110,spawn.rowSize-16,tocolor(228,50,50,200))
                    end
                    dxDrawText("Lekérés",pos[1]+size[1]-135+110/2,pos[2]+100+(i-1)*(spawn.rowSize+5)+spawn.rowSize/2,nil,nil,tocolor(0,0,0,200),1,fonts[11],"center","center")
                end
            end
        end
    end
)

addEventHandler("onClientKey",root,
    function(k,p)
        if k == "mouse1" and p then
            if spawn.state then
                local size = {900,500}
                local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
                if isCursorOnBox(pos[1]+size[1]-30,pos[2],30,30) then
                    spawn.state = false
                end

                local companyVehicles = getCompanyVehicles(getElementData(localPlayer,"char.CompanyID"))
                for i = 1,spawn.maxLine do
                    local vehicle = companyVehicles[i+spawn.scroll]
                    if vehicle then
                        if isCursorOnBox(pos[1]+size[1]-135,pos[2]+100+(i-1)*(spawn.rowSize+5)+8,110,spawn.rowSize-16) then
                            if getElementDimension(vehicle) >= 30000 then
                                local haveVeh = false
                                for k,v in ipairs(getElementsByType("vehicle")) do
                                    if getElementData(v,"company.driver") == localPlayer then
                                        haveVeh = true
                                    end
                                end
                                if haveVeh then
                                    exports.nlrp_hud:showInfobox("error","Már van lehívva egy járműved!")
                                else
                                    triggerServerEvent("spawnVehicle",resourceRoot,localPlayer,getElementData(vehicle,"company.vehicleID"))
                                    spawn.state = false
                                end
                            else
                                exports.nlrp_hud:showInfobox("error","Ez a jármű jelenelg használatban van!")
                            end
                        end
                    end
                end
            end
        elseif k == "mouse_wheel_down" and p then
            local companyVehicles = getCompanyVehicles(getElementData(localPlayer,"char.CompanyID"))
            if spawn.state then
                if spawn.scroll < #companyVehicles-spawn.maxLine then
                    spawn.scroll = spawn.scroll + 1
                end
            end
        elseif k == "mouse_wheel_up" and p then
            if spawn.state then
                if spawn.scroll > 0 then
                    spawn.scroll = spawn.scroll - 1
                end
            end
        end
    end
)

addEventHandler("onClientClick",root,
    function(button,state,x,y,wx,wy,wz,element)
        if getElementData(localPlayer,"loggedIn") then
            if button == "left" and state == "down" then
                if element then
                    if getElementData(element,"nlrp->company->jobPed") then
                        local p = Vector3(getElementPosition(element))
                        local p2 = Vector3(getElementPosition(localPlayer))
                        if getDistanceBetweenPoints3D(p,p2) <= maxPedClick then
                            if not spawn.state then
                                if getElementData(localPlayer,"char.CompanyID") > 0 then
                                    spawn.state = true
                                    spawn.scroll = 0
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)

--// Munka kezdése, fuvar választó
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local jobs = {}
local job = {
    state = false,
    scroll = 0,
    selected = 0,
    maxLine = 5,
    rowSize = 100,
}
local precent = 0
addEvent("returnPrecent",true)
addEventHandler("returnPrecent",localPlayer,
    function(amount)
        precent = amount
    end
)


addEventHandler("onClientRender",root,
    function()
        if job.state then
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if not vehicle then
                job.state = false
            end
            local size = {500,600}
            local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
            dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(40,40,40,200))
            
            dxDrawText("Vállalkozói fuvar",pos[1]+size[1]/2,pos[2]+40/2,nil,nil,tocolor(222,222,222,255),1,fonts[13],"center","center")

            for i = 1,job.maxLine do
                local boxsize = {size[1]-10-job.rowSize,job.rowSize}
                local boxpos = {pos[1]+5+boxsize[2],pos[2]+40+(i-1)*(boxsize[2]+5)}
                dxDrawRectangle(boxpos[1],boxpos[2],boxsize[1],boxsize[2],tocolor(55,55,55,200))
                dxDrawRectangle(boxpos[1]-boxsize[2],boxpos[2],boxsize[2],boxsize[2],tocolor(60,60,60,200))
                local line = jobs[i+job.scroll]
                if line then
                    if line.trailer then
                        if fileExists("images/vehicles/" .. line.trailer .. ".png") then
                            dxDrawImage(boxpos[1]-boxsize[2]+2,boxpos[2]+2,boxsize[2]-4,boxsize[2]-4,"images/vehicles/" .. line.trailer .. ".png",0,0,0,tocolor(255,255,255,255))
                        end
                    else
                         if fileExists("images/vehicles/" .. getElementModel(vehicle) .. ".png") then
                            dxDrawImage(boxpos[1]-boxsize[2]+2,boxpos[2]+2,boxsize[2]-4,boxsize[2]-4,"images/vehicles/" .. getElementModel(vehicle) .. ".png",0,0,0,tocolor(255,255,255,255))
                        end
                    end

                    dxDrawText(line.name .. " (" .. format(tonumber(line.weight)) .. " kg)",boxpos[1]+boxsize[1]/2,boxpos[2]+5,nil,nil,tocolor(183,255,0,222),1,fonts[11],"center","top")
                    
                    local player_pos = Vector3(getElementPosition(localPlayer))

                    dxDrawText("Típus: " .. getVehicleTypeFromShop(getPedOccupiedVehicle(localPlayer)),boxpos[1]+5,boxpos[2]+boxsize[2]-20,nil,nil,tocolor(222,222,222,222),1,fonts[10],"left","top")
                    
                    dxDrawText("Bevétel: " .. format(line.payment) .. " Ft",boxpos[1]+boxsize[1]-10,boxpos[2]+boxsize[2]-40,nil,nil,tocolor(222,222,222,222),1,fonts[10],"right","top")
                    dxDrawText("Jutalék (" .. precent .. "%): " .. format((line.payment/100) * precent) .. " Ft",boxpos[1]+boxsize[1]-10,boxpos[2]+boxsize[2]-20,nil,nil,tocolor(222,222,222,222),1,fonts[10],"right","top")
                
                    if job.selected == i+job.scroll then
                        dxDrawBorder(pos[1]+5,pos[2]+40+(i-1)*(boxsize[2]+5),size[1]-10,boxsize[2],1.5,tocolor(183,255,0,200))
                    end
                end
            end

            dxDrawText("X",pos[1]+size[1]-3,pos[2]+1,nil,nil,tocolor(222,50,50,220),1,fonts[12],"right","top")

            dxDrawRectangle(pos[1]+5,pos[2]+size[2]-30-5,size[1]-10,30,tocolor(183,255,0,150))
            if isCursorOnBox(pos[1]+5,pos[2]+size[2]-30-5,size[1]-10,30) then
                dxDrawRectangle(pos[1]+5,pos[2]+size[2]-30-5,size[1]-10,30,tocolor(222,222,222,30))
            end
            dxDrawText("Fuvar elvállalása",pos[1]+size[1]/2,pos[2]+size[2]-30-5+30/2,nil,nil,tocolor(222,222,222,222),1,fonts[10],"center","center")
        end
    end
)

setElementData(localPlayer,"char.CurrentJob",false)
setElementData(localPlayer,"company.Jobstate","notStarted")
setElementData(localPlayer,"company.jobPackedDown",false)
setElementData(localPlayer,"company.trailer",false)

addEventHandler("onClientKey",root,
    function(k,p)
        if job.state then
            if k == "mouse1" and p then
                local size = {500,600}
                local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
                if isCursorOnBox(pos[1]+size[1]-20,pos[2],20,20) then
                    job.state = false
                elseif isCursorOnBox(pos[1]+5,pos[2]+size[2]-30-5,size[1]-10,30) then
                    if job.selected > 0 then
                        setElementData(localPlayer,"company.Jobstate","jobSelected")

                        setElementData(getPedOccupiedVehicle(localPlayer),"company.stuffName",jobs[job.selected].name)
                        
                        setElementData(localPlayer,"char.CurrentJob",jobs[job.selected])

                        exports.nlrp_hud:showInfobox("info","Sikeresen elvállatál egy fuvart!")
                        job.state = false

                        if getVehicleTypeFromShop(getPedOccupiedVehicle(localPlayer)) == "Nyerges Vontató" and jobs[job.selected].trailer then 
                            triggerServerEvent("createTrailer",resourceRoot,localPlayer,_r,jobs[job.selected].trailer)
                            outputChatBox("#b7ff00 >> NextLevel:#ffffff Ehhez a típúsú rakományhoz, fel kell akasztanod egy pótkocsit.",0,0,0,true)
                        end
                    else
                        exports.nlrp_hud:showInfobox("error","Nincs kiválasztott fuvar!")
                    end
                end

                for i = 1,job.maxLine do
                    local boxsize = {size[1]-10-job.rowSize,job.rowSize}
                    local boxpos = {pos[1]+5+boxsize[2],pos[2]+40+(i-1)*(boxsize[2]+5)}
                    if isCursorOnBox(pos[1]+5,pos[2]+40+(i-1)*(boxsize[2]+5),size[1]-10,boxsize[2]) then
                        if job.selected ~= i+job.scroll then
                            job.selected = i+job.scroll
                        end
                    end
                end
            elseif k == "mouse_wheel_down" and p then
                if job.scroll < #jobs-job.maxLine then
                    job.scroll = job.scroll + 1
                end
            elseif k == "mouse_wheel_up" and p then
                if job.scroll > 0 then job.scroll = job.scroll - 1 end
            end
        end
    end
)

addEventHandler("onClientMarkerHit",root,
    function(element,dim)
        if element == localPlayer and dim then
            if getElementData(source,"company.JobMarker") then
                local p,p2 = Vector3(getElementPosition(localPlayer)),Vector3(getElementPosition(source))
                if getDistanceBetweenPoints3D(p,p2) < 5 then
                    local vehicle = getPedOccupiedVehicle(localPlayer)
                    if vehicle then
                        if not job.state then
                            if getElementData(localPlayer,"company.Jobstate") ~= "notStarted" then
                                exports.nlrp_hud:showInfobox("error","Már folyamatban van egy fuvarod!")
                            else
                                if getElementData(vehicle,"company.vehicleID") then
                                    if getElementData(vehicle,"company.driver") == localPlayer then
                                        job.state = true
                                        job.scroll = 0
                                        job.selected = 1
                                        local _vehtype = getVehicleTypeFromShop(vehicle)
                                        if _vehtype == "Ismeretlen" then _vehtype = "Furgon" end
                                        jobs = getJobsByType(_vehtype)
                                        triggerServerEvent("getPlayerPrecent",resourceRoot,localPlayer)
                                    else
                                        exports.nlrp_hud:showInfobox("error","Kizárólag a saját munka járműveddel dolgozhatsz!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Kizárólag vállalkozói járművel dolgozhatsz!")
                                end
                            end
                        end
                    end
                end
            elseif getElementData(source,"company.PackMarker") then
                local trailer = getElementData(localPlayer,"company.trailer")
                if (getElementData(source,"companyMarker") == "berakodas_olaj") then --// HA OLAJ MARKER
                    if not trailer then return end
                    if trailer then
                        if getElementModel(trailer) == 584 then

                        else
                            exports.nlrp_hud:showInfobox("error","Ezt a pótkocsit itt nem tudod berakodni.")
                            return
                        end
                    end
                    local p,p2 = Vector3(getElementPosition(localPlayer)),Vector3(getElementPosition(source))
                    if getDistanceBetweenPoints3D(p,p2) < 5 then
                        local vehicle = getPedOccupiedVehicle(localPlayer)
                        if vehicle then
                            if not job.state then
                                if getElementData(localPlayer,"company.Jobstate") == "jobSelected" then
                                    if getElementData(vehicle,"company.vehicleID") then
                                        if getVehicleTypeFromShop(vehicle) == "Nyerges Vontató" then
                                            if getVehicleTowedByVehicle(vehicle) then
                                                if getVehicleTowedByVehicle(vehicle) ~= getElementData(localPlayer,"company.trailer") then
                                                    exports.nlrp_hud:showInfobox("error","Nem ezt a pótkocsit kaptad ehhez a fuvarhoz!")
                                                    return
                                                end
                                            else
                                                exports.nlrp_hud:showInfobox("error","Ehhez az árúhoz fel kell csatolnod egy pótkocsit!")
                                                return
                                            end
                                        end
                                        setElementFrozen(vehicle,true)
                                        setElementFrozen(localPlayer,true)
                                        toggleAllControls(false)
                                        exports.nlrp_hud:showInfobox("info","Várj ameddig felrakodják az árut!")
                                        addEventHandler("onClientRender",root,drawPacking)
                                        packTick = getTickCount()
                                        setTimer(function()
                                            setElementFrozen(vehicle,false)
                                            setElementFrozen(localPlayer,false)
                                            toggleAllControls(true)
                                            removeEventHandler("onClientRender",root,drawPacking)
                                            exports.nlrp_hud:showInfobox("info","Sikeresen felvetted a rakományt.")

                                            local _r = 1
                                            local trailer = getElementData(localPlayer,"company.trailer")
                                            if trailer then
                                                if getElementModel(trailer) == 584 then
                                                    --// Random leadási pont generálása (Olaj cuccos)
                                                    _r = math.random(1,#finishJob_oil)
                                                    setElementData(localPlayer,"company.Jobstate",{
                                                        marker = createMarker(finishJob_oil[_r].marker.pos[1],finishJob_oil[_r].marker.pos[2],finishJob_oil[_r].marker.pos[3]-1,"cylinder",finishJob_oil[_r].marker.size,finishJob_oil[_r].marker.color[1],finishJob_oil[_r].marker.color[2],finishJob_oil[_r].marker.color[3],finishJob_oil[_r].marker.color[4]),
                                                        ped = createPed(finishJob_oil[_r].ped.skin,finishJob_oil[_r].ped.pos[1],finishJob_oil[_r].ped.pos[2],finishJob_oil[_r].ped.pos[3],finishJob_oil[_r].ped.rot),
                                                        blip = createBlip(finishJob_oil[_r].ped.pos[1],finishJob_oil[_r].ped.pos[2],finishJob_oil[_r].ped.pos[3],14),
                                                    })
                                                else
                                                     --// Random leadási pont generálása
                                                    _r = math.random(1,#finishJob)
                                                    setElementData(localPlayer,"company.Jobstate",{
                                                        marker = createMarker(finishJob[_r].marker.pos[1],finishJob[_r].marker.pos[2],finishJob[_r].marker.pos[3]-1,"cylinder",finishJob[_r].marker.size,finishJob[_r].marker.color[1],finishJob[_r].marker.color[2],finishJob[_r].marker.color[3],finishJob[_r].marker.color[4]),
                                                        ped = createPed(finishJob[_r].ped.skin,finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],finishJob[_r].ped.rot),
                                                        blip = createBlip(finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],14),
                                                    })
                                                end
                                            else
                                                 --// Random leadási pont generálása
                                                _r = math.random(1,#finishJob)
                                                setElementData(localPlayer,"company.Jobstate",{
                                                    marker = createMarker(finishJob[_r].marker.pos[1],finishJob[_r].marker.pos[2],finishJob[_r].marker.pos[3]-1,"cylinder",finishJob[_r].marker.size,finishJob[_r].marker.color[1],finishJob[_r].marker.color[2],finishJob[_r].marker.color[3],finishJob[_r].marker.color[4]),
                                                    ped = createPed(finishJob[_r].ped.skin,finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],finishJob[_r].ped.rot),
                                                    blip = createBlip(finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],14),
                                                })
                                            end

                                            
                                            setElementData(getElementData(localPlayer,"company.Jobstate").marker,"companyMarker","kirakodas")

                                            setElementData(getElementData(localPlayer,"company.Jobstate").blip,"blipIcon","kirakodas")
                                            setElementData(getElementData(localPlayer,"company.Jobstate").blip,"blipTooltipText","Leadási pont")
                                            setElementData(getElementData(localPlayer,"company.Jobstate").blip,"blipColor",tocolor(255,255,255,255))


                                            local job = getElementData(localPlayer,"char.CurrentJob")
                                            if job then
                                                local x,y,z = getElementPosition(getElementData(localPlayer,"company.Jobstate").blip)
                                                triggerServerEvent("giveLetter",resourceRoot,localPlayer,job,x,y,z)
                                            else
                                                outputChatBox(" >> Egy hiba folytán nem kaptál fuvarlevelet! Jelentsd egy tulajdonosnak!",228,58,58,true)
                                            end

                                            if trailer and getElementModel(trailer) == 584 then
                                                setElementData(getElementData(localPlayer,"company.Jobstate").ped,"ped.name",finishJob_oil[_r].ped.name)
                                            else
                                                setElementData(getElementData(localPlayer,"company.Jobstate").ped,"ped.name",finishJob[_r].ped.name)
                                            end
                                            setElementData(getElementData(localPlayer,"company.Jobstate").ped,"pedNameType","Telepvezető")
                                        end,packUpTime*1000,1)
                                    else
                                        exports.nlrp_hud:showInfobox("error","Kizárólag vállalkozói járművel dolgozhatsz!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Nincs elvállalt munkád vagy már fel vagy rakodva!")
                                end
                            end
                        end
                    end
                else --// HA SIMA MARKER
                    if trailer then
                        if getElementModel(trailer) == 584 then
                            exports.nlrp_hud:showInfobox("error","Ezt a pótkocsit itt nem tudod berakodni.")
                            return
                        end
                    end
                    local p,p2 = Vector3(getElementPosition(localPlayer)),Vector3(getElementPosition(source))
                    if getDistanceBetweenPoints3D(p,p2) < 5 then
                        local vehicle = getPedOccupiedVehicle(localPlayer)
                        if vehicle then
                            if not job.state then
                                if getElementData(localPlayer,"company.Jobstate") == "jobSelected" then
                                    if getElementData(vehicle,"company.vehicleID") then
                                        if getVehicleTypeFromShop(vehicle) == "Nyerges Vontató" then
                                            if getVehicleTowedByVehicle(vehicle) then
                                                if getVehicleTowedByVehicle(vehicle) ~= getElementData(localPlayer,"company.trailer") then
                                                    exports.nlrp_hud:showInfobox("error","Nem ezt a pótkocsit kaptad ehhez a fuvarhoz!")
                                                    return
                                                end
                                            else
                                                exports.nlrp_hud:showInfobox("error","Ehhez az árúhoz fel kell csatolnod egy pótkocsit!")
                                                return
                                            end
                                        end
                                        setElementFrozen(vehicle,true)
                                        setElementFrozen(localPlayer,true)
                                        toggleAllControls(false)
                                        exports.nlrp_hud:showInfobox("info","Várj ameddig felrakodják az árut!")
                                        addEventHandler("onClientRender",root,drawPacking)
                                        packTick = getTickCount()
                                        setTimer(function()
                                            setElementFrozen(vehicle,false)
                                            setElementFrozen(localPlayer,false)
                                            toggleAllControls(true)
                                            removeEventHandler("onClientRender",root,drawPacking)
                                            exports.nlrp_hud:showInfobox("info","Sikeresen felvetted a rakományt.")

                                            local _r = 1
                                            local trailer = getElementData(localPlayer,"company.trailer")
                                            if trailer then
                                                if getElementModel(trailer) == 584 then
                                                    --// Random leadási pont generálása
                                                    _r = math.random(1,#finishJob_oil)
                                                    setElementData(localPlayer,"company.Jobstate",{
                                                        marker = createMarker(finishJob_oil[_r].marker.pos[1],finishJob_oil[_r].marker.pos[2],finishJob_oil[_r].marker.pos[3]-1,"cylinder",finishJob_oil[_r].marker.size,finishJob_oil[_r].marker.color[1],finishJob_oil[_r].marker.color[2],finishJob_oil[_r].marker.color[3],finishJob_oil[_r].marker.color[4]),
                                                        ped = createPed(finishJob_oil[_r].ped.skin,finishJob_oil[_r].ped.pos[1],finishJob_oil[_r].ped.pos[2],finishJob_oil[_r].ped.pos[3],finishJob_oil[_r].ped.rot),
                                                        blip = createBlip(finishJob_oil[_r].ped.pos[1],finishJob_oil[_r].ped.pos[2],finishJob_oil[_r].ped.pos[3],14),
                                                    })
                                                else
                                                    --// Random leadási pont generálása
                                                    _r = math.random(1,#finishJob)
                                                    setElementData(localPlayer,"company.Jobstate",{
                                                        marker = createMarker(finishJob[_r].marker.pos[1],finishJob[_r].marker.pos[2],finishJob[_r].marker.pos[3]-1,"cylinder",finishJob[_r].marker.size,finishJob[_r].marker.color[1],finishJob[_r].marker.color[2],finishJob[_r].marker.color[3],finishJob[_r].marker.color[4]),
                                                        ped = createPed(finishJob[_r].ped.skin,finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],finishJob[_r].ped.rot),
                                                        blip = createBlip(finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],14),
                                                    })
                                                end
                                            else
                                                 --// Random leadási pont generálása
                                                _r = math.random(1,#finishJob)
                                                setElementData(localPlayer,"company.Jobstate",{
                                                    marker = createMarker(finishJob[_r].marker.pos[1],finishJob[_r].marker.pos[2],finishJob[_r].marker.pos[3]-1,"cylinder",finishJob[_r].marker.size,finishJob[_r].marker.color[1],finishJob[_r].marker.color[2],finishJob[_r].marker.color[3],finishJob[_r].marker.color[4]),
                                                    ped = createPed(finishJob[_r].ped.skin,finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],finishJob[_r].ped.rot),
                                                    blip = createBlip(finishJob[_r].ped.pos[1],finishJob[_r].ped.pos[2],finishJob[_r].ped.pos[3],14),
                                                })
                                            end

                                            setElementData(getElementData(localPlayer,"company.Jobstate").marker,"companyMarker","kirakodas")

                                            setElementData(getElementData(localPlayer,"company.Jobstate").blip,"blipIcon","kirakodas")
                                            setElementData(getElementData(localPlayer,"company.Jobstate").blip,"blipTooltipText","Leadási pont")
                                            setElementData(getElementData(localPlayer,"company.Jobstate").blip,"blipColor",tocolor(255,255,255,255))

                                            local job = getElementData(localPlayer,"char.CurrentJob")
                                            if job then
                                                local x,y,z = getElementPosition(getElementData(localPlayer,"company.Jobstate").blip)
                                                triggerServerEvent("giveLetter",resourceRoot,localPlayer,job,x,y,z)
                                            else
                                                outputChatBox(" >> Egy hiba folytán nem kaptál fuvarlevelet! Jelentsd egy tulajdonosnak!",228,58,58,true)
                                            end

                                            if trailer and getElementModel(trailer) == 584 then
                                                setElementData(getElementData(localPlayer,"company.Jobstate").ped,"ped.name",finishJob_oil[_r].ped.name)
                                            else
                                                setElementData(getElementData(localPlayer,"company.Jobstate").ped,"ped.name",finishJob[_r].ped.name)
                                            end
                                            setElementData(getElementData(localPlayer,"company.Jobstate").ped,"pedNameType","Telepvezető")
                                        end,packUpTime*1000,1)
                                    else
                                        exports.nlrp_hud:showInfobox("error","Kizárólag vállalkozói járművel dolgozhatsz!")
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Nincs elvállalt munkád vagy már fel vagy rakodva!")
                                end
                            end
                        end
                    end
                end
            end
            if source == getElementData(localPlayer,"company.Jobstate").marker then
                local vehicle = getPedOccupiedVehicle(localPlayer)
                if vehicle then
                    if not job.state then
                        if getElementData(localPlayer,"company.jobPackedDown") then 
                            exports.nlrp_hud:showInfobox("error","Már kirakodták az árut. Menj és add át a fuvar levelet!")
                            return 
                        end
                        if getElementData(vehicle,"company.vehicleID") then
                            if getVehicleTypeFromShop(vehicle) == "Nyerges Vontató" then
                                if getVehicleTowedByVehicle(vehicle) then
                                    if getVehicleTowedByVehicle(vehicle) ~= getElementData(localPlayer,"company.trailer") then
                                        exports.nlrp_hud:showInfobox("error","Nem ezt a pótkocsit kaptad ehhez a fuvarhoz!")
                                        return
                                    end
                                else
                                    exports.nlrp_hud:showInfobox("error","Nincs felakasztva a megadott pótkocsid!")
                                    return
                                end
                            end
                            setElementFrozen(vehicle,true)
                            setElementFrozen(localPlayer,true)
                            toggleAllControls(false)
                            exports.nlrp_hud:showInfobox("info","Várj ameddig kirakodják az árut!")
                            addEventHandler("onClientRender",root,draw_Packing)
                            packTick = getTickCount()
                            setTimer(function()
                                setElementFrozen(vehicle,false)
                                setElementFrozen(localPlayer,false)
                                toggleAllControls(true)
                                removeEventHandler("onClientRender",root,draw_Packing)
                                --setElementData(localPlayer,"company.Jobstate","packedDown")
                                setElementData(localPlayer,"company.jobPackedDown",true)
                                outputChatBox("#b7ff00 >> NextLevel: #ffffffKirakodták a rakományt. Menj és add át a fuvar levelet, hogy megkapd a fizetséged!",0,0,0,true)
                            end,packUpTime*1000,1)
                        else
                            exports.nlrp_hud:showInfobox("error","Kizárólag vállalkozói járművel dolgozhatsz!")
                        end
                    end
                end
            end
            if getElementData(source,"vehicleDropdown") then
                local vehicle = getPedOccupiedVehicle(localPlayer)
                if vehicle then
                    if getElementData(vehicle,"company.vehicleID") then
                        triggerServerEvent("dropDownvehicle",resourceRoot,localPlayer,vehicle)
                        exports.nlrp_hud:showInfobox("info","Sikeresen leadtad a munkajárműved!")
                    end
                end
            end
        end
    end
)

addEvent("completeJobClient",true)
addEventHandler("completeJobClient",localPlayer,
    function()
        if isElement(getElementData(localPlayer,"company.Jobstate").marker) then destroyElement(getElementData(localPlayer,"company.Jobstate").marker) end
        if isElement(getElementData(localPlayer,"company.Jobstate").ped) then destroyElement(getElementData(localPlayer,"company.Jobstate").ped) end
        if isElement(getElementData(localPlayer,"company.Jobstate").blip) then destroyElement(getElementData(localPlayer,"company.Jobstate").blip) end
    
        setElementData(localPlayer,"company.Jobstate","notStarted")
    end
)

function drawPacking()
    local size = {400,40}
    local pos = {s[1]/2-size[1]/2,s[2]-125}

    dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(41,41,41,200))
    dxDrawBorder(pos[1],pos[2],size[1],size[2],1,tocolor(31,31,31,200))

    local anim = interpolateBetween(0,0,0,1,0,0,getProgress(packUpTime*1000,packTick),"Linear")
    dxDrawRectangle(pos[1],pos[2],size[1]*anim,size[2],tocolor(183,255,0,200))

    dxDrawText("Berakodás folyamatban..",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[12],"center","center")
end

function draw_Packing()
    local size = {400,40}
    local pos = {s[1]/2-size[1]/2,s[2]-125}

    dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(41,41,41,200))
    dxDrawBorder(pos[1],pos[2],size[1],size[2],1,tocolor(31,31,31,200))

    local anim = interpolateBetween(0,0,0,1,0,0,getProgress(packUpTime*1000,packTick),"Linear")
    dxDrawRectangle(pos[1],pos[2],size[1]*anim,size[2],tocolor(183,255,0,200))

    dxDrawText("Kirakodás folyamatban..",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(222,222,222,222),1,fonts[12],"center","center")
end


addEventHandler("onClientRender",root,
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if vehicle then
            if getElementData(vehicle,"company.vehicleID") then
                if getElementData(vehicle,"company.driver") then
                    local size =  {300,40}
                    local pos = {s[1]-size[1]-300,s[2]-size[2]-10}
                    local margin = 4

                    local hp = getElementHealth(vehicle)

                    dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(41,41,41,200))
                    dxDrawRectangle(pos[1]+margin,pos[2]+margin,size[1]-margin*2,size[2]-margin*2,tocolor(32,32,32,200))
                    dxDrawRectangle(pos[1]+margin+1,pos[2]+margin+1,(size[1]-margin*2-2)*(hp/1000),size[2]-margin*2-2,tocolor(183,255,0,165))

                    dxDrawText("Jármű állapota: " .. math.floor(hp/10) .. "%",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(255,255,255,200),1,fonts[12],"center","center")
                end
            end
        end
    end
)














--// 3D marker images

getPositionFromElementOffset = function(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end

local m_textures = {}

addEventHandler("onClientRender",root,
    function()
        for k,v in ipairs(getElementsByType("marker")) do
            if getElementData(v,"companyMarker") then
                setElementAlpha(v,0)
                local x,y,z = getElementPosition(v)
                local x2,y2,z2 = getElementPosition(localPlayer)
                z = z+1.4
                if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 55 then
                    if not m_textures[getElementData(v,"companyMarker")] then   
                        m_textures[getElementData(v,"companyMarker")] = dxCreateTexture("images/" .. getElementData(v,"companyMarker") .. ".png")
                    end
                    local size = 2
                    dxDrawMaterialLine3D(x,y,z+size/2,x,y,z-size/2,m_textures[getElementData(v,"companyMarker")],size)

                    z = z-1.3

                    local width = 3
                    local w = 2
                    local nx,ny,nz = getPositionFromElementOffset(v,w,w,0)
                    dxDrawLine3D(nx-w,ny,z,x-w,y,z,tocolor(255,255,255,255),width)
                    dxDrawLine3D(nx-w,ny,z,x+w,y,z,tocolor(255,255,255,255),width)

                    local nx,ny,nz = getPositionFromElementOffset(v,-w,-w,0)
                    dxDrawLine3D(nx+w,ny,z,x-w,y,z,tocolor(255,255,255,255),width)
                    dxDrawLine3D(x+w,y,z,nx+w,ny,z,tocolor(255,255,255,255),width)
                end
            end
        end
    end
)