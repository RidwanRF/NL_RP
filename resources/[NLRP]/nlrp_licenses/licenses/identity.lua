
local font = dxCreateFont("font.otf",12)
local ntext
local sx,sy = guiGetScreenSize()
local screenSize = {guiGetScreenSize()}
screenSize.x, screenSize.y = screenSize[1], screenSize[2]
local width, height = 800, 450
local startX, startY = (screenSize.x - width) / 2, (screenSize.y - height) / 2
local spacer = 2
local font =dxCreateFont("font.otf",16)
local spacerBig = 5
local show = false
local draw = false
local getmoney = false
local click = false
local elem
local forY = startY + 2 * spacerBig + 30 + spacer + (1 - 1) * 22
local vehicleTuningDatas = {{"engine", "Motor"}, {"turbo", "Turbó"}, {"gearbox", "Váltó"}, {"ecu", "Ecu"}, {"tires", "Gumi"}, {"brakes", "Fék"}}
local vehicleTunings = {"#999999nincs", "#acd737utcai", "#ffcc00profi", "#ff6600verseny", "#ff1a1agear" , "#ff1a1agear"}
vehicleTunings[0] = "#999999nincs"
Documents["Identity"] = function(data)
    local date = getRealTime(data["expire"])
    dxDrawImage(docX, docY, docW, docH, "files/identity.png")   
    dxDrawText(data["name"], docX + 220, docY + 53, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 83, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText("Magyar", docX + 340, docY + 117, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 1) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 275, docY + 152, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 

    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(190, 190, 190, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end



Documents["gun"] = function(data)
    local date = getRealTime(data["expire2"])
    dxDrawImage(docX, docY, docW, docH, "files/identity.png")   
    dxDrawText(data["name"], docX + 220, docY + 57, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 87, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText("Amerikai", docX + 345, docY + 122, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 1) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 275, docY + 156, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 

    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(190, 190, 190, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end

Documents["hunt"] = function(data)
    local date = getRealTime(data["expire3"])
    dxDrawImage(docX, docY, docW, docH, "files/hunter.png")   
    dxDrawText(data["name"], docX + 220, docY + 57, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 87, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    --dxDrawText("Amerikai", docX + 345, docY + 122, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    --dxDrawText("Nem jár le.", docX + 275, docY + 156, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 

    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(190, 190, 190, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end

Documents["weapon"] = function(data)
    local date = getRealTime(data["expire2"])
    dxDrawImage(docX, docY, docW, docH, "files/weapon.png")   
    dxDrawText(data["name"], docX + 220, docY + 57, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 87, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText("Vadászpuska", docX + 345, docY + 122, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 1) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 275, docY + 156, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 

    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(190, 190, 190, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end

Documents["weapon2"] = function(data)
    local date = getRealTime(data["expire2"])
    dxDrawImage(docX, docY, docW, docH, "files/weapon.png")   
    dxDrawText(data["name"], docX + 220, docY + 57, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 87, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText("Glock,P250,Deagle", docX + 345, docY + 122, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 1) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 275, docY + 156, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 

    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(190, 190, 190, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end

Documents["weapon3"] = function(data)
    local date = getRealTime(data["expire2"])
    dxDrawImage(docX, docY, docW, docH, "files/weapon.png")   
    dxDrawText(data["name"], docX + 220, docY + 57, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 87, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText("MPX", docX + 345, docY + 122, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 1) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 275, docY + 156, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(190, 190, 190, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end
Documents["traffic"] = function(data)
    local date = getRealTime(data["expire2"])
    dxDrawImage(docX, docY, docW, docH+300, "files/forgalmi.png")   
    dxDrawText(data["name"], docX + 200, docY + 79, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText("", docX + 345, docY + 122, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 1) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 185, docY +170, docW + docX - 10, docH + docY, tocolor(255, 255, 255, 255), 1, fonts.Roboto13, "left", "top") 
    local signW, signH = 210, 30
    local signX, signY = docX + 33, docY + 195
    dxDrawText(data["model"], signX+200, signY + 8, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top")
    local text = "#AAAAAAGyári"
if data["motor"] == 1 then
    text = "#FF2828Alap csomag"
elseif data["motor"] == 2 then
    text = "#00FF64Utcai Csomag"
elseif data["motor"] == 3 then
    text = "#FF00C1Profi Csomag"
elseif data["motor"] == 4 then
    text = "#00FFFFVerseny Csomag"
elseif data["motor"] == 5 then
    text = "#FFD700Gear Csomag"
end
if data["turbo"] == 1 then
    text2 = "#FF2828Alap csomag"
elseif data["turbo"] == 2 then
    text2 = "#00FF64Utcai Csomag"
elseif data["turbo"] == 3 then
    text2 = "#FF00C1Profi Csomag"
elseif data["turbo"] == 4 then
    text2 = "#00FFFFVerseny Csomag"
elseif data["turbo"] == 5 then
    text2 = "#FFD700Gear Csomag"
end
if data["gearbox"] == 1 then
    text3 = "#FF2828Alap csomag"
elseif data["gearbox"] == 2 then
    text3 = "#00FF64Utcai Csomag"
elseif data["gearbox"] == 3 then
    text3 = "#FF00C1Profi Csomag"
elseif data["gearbox"] == 4 then
    text3 = "#00FFFFVerseny Csomag"
elseif data["gearbox"] == 5 then
    text3 = "#FFD700Gear Csomag"
end
if data["ecu"] == 1 then
    text4 = "#FF2828Alap csomag"
elseif data["ecu"] == 2 then
    text4 = "#00FF64Utcai Csomag"
elseif data["ecu"] == 3 then
    text4 = "#FF00C1Profi Csomag"
elseif data["ecu"] == 4 then
    text4 = "#00FFFFVerseny Csomag"
elseif data["ecu"] == 5 then
    text4 = "#FFD700Gear Csomag"
end
if data["tires"] == 1 then
    text5 = "#FF2828Alap csomag"
elseif data["tires"] == 2 then
    text5 = "#00FF64Utcai Csomag"
elseif data["tires"] == 3 then
    text5 = "#FF00C1Profi Csomag"
elseif data["tires"] == 4 then
    text5 = "#00FFFFVerseny Csomag"
elseif data["tires"] == 5 then
    text5 = "#FFD700Gear Csomag"
end
if data["brake"] == 0 then
    text6 = "#FF2828Gyári"
elseif data["brake"] == 1 then
    text6 = "#FF2828Alap csomag"
elseif data["brake"] == 2 then
    text6 = "#00FF64Utcai Csomag"
elseif data["brake"] == 3 then
    text6 = "#FF00C1Profi Csomag"
elseif data["brake"] == 4 then
    text6 = "#00FFFFVerseny Csomag"
elseif data["brake"] == 5 then
    text6 = "#FFD700Gear Csomag"
end
if data["airride"] == 0 then
    text7 = "#FF2828Nincs"
elseif data["airride"] == 1 then
    text7 = "#FF2828Van"

end
    dxDrawText(text, signX+150, signY + 220, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText("Motor: ", signX-70, signY + 220, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText(text2, signX+150, signY + 95, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText("Turbó: ", signX-70, signY + 95, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText(text3, signX+150, signY + 125, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText("Váltó: ", signX-70, signY + 125, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText(text4, signX+150, signY + 155, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText("ECU:  ", signX-70, signY + 155, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText(text5, signX+200, signY + 190, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText("Kerekek:", signX-50, signY + 190, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText(text6, signX+100, signY + 250, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText("Fék:", signX-100, signY + 250, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1,font, "center", "top",false,false,false,true)
    dxDrawText(data["rendszam"], signX+200, signY - 87, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1, font, "center", "top") 
    dxDrawText(data["vehtype"], signX+100, signY - 57, signX + signW, signY + signH, tocolor(255, 255, 255, 255), 1, font, "center", "top") 


    local picW, picH = 110, 123
    local picX, picY = docX + 32, docY + 57


end