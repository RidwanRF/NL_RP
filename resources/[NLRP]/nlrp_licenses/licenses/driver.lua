

Documents["DriverLicense"] = function(data)
    local date = getRealTime(data["expire"])
    local created = getRealTime(data["created"])
    dxDrawImage(docX, docY, docW, docH, "files/driver.png")   
    dxDrawText(data["name"], docX + 225, docY + 55, docW + docX - 10, docH + docY, tocolor(186,255,0, 255), 1, fonts.Roboto11, "left", "top") 
    dxDrawText(data["birth"], docX + 315, docY + 86, docW + docX - 10, docH + docY, tocolor(186,255,0, 255), 1, fonts.Roboto11, "left", "top") 
    dxDrawText(data["category"], docX + 210, docY + 15, docW + docX - 10, docH + docY, tocolor(186,255,0, 255), 1, fonts.Roboto11, "left", "top") 
    dxDrawText(created.year + 1900 .. ". " .. string.format("%02d", created.month + 1) .. ". " .. string.format("%02d", created.monthday) .. ".", docX + 172, docY + 138, docW + docX - 10, docH + docY, tocolor(186,255,0, 255), 1, fonts.Roboto11, "left", "top") 
    dxDrawText(date.year + 1900 .. ". " .. string.format("%02d", date.month + 6) .. ". " .. string.format("%02d", date.monthday) .. ".", docX + 172, docY + 175, docW + docX - 10, docH + docY, tocolor(186,255,0, 255), 1, fonts.Roboto11, "left", "top") 
    local signW, signH = 213, 30
    local signX, signY = docX + 278, docY + 193

    dxDrawText(data["name"], signX, signY + 3, signX + signW, signY + signH, tocolor(0, 0, 0, 255), 1, fonts.lunabar, "center", "top") 

    local picW, picH = 110, 123
    local picX, picY = docX + 383, docY + 57

    dxDrawRectangle(picX, picY, picW, picH, tocolor(100, 100, 100, 100))
end