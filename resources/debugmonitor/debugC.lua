local screenW, screenH = guiGetScreenSize()



local chatData = getChatboxLayout()

local lines = chatData["chat_lines"]

local debugLines = {}



local debugTypes = {"[ERROR]: ", "[WARNING]: ", "[INFO]: "}

debugTypes[0] = "[CUSTOM]: "



addCommandHandler("cleardebugs", function()

    debugLines = {}

end)



local positions = {screenW/2 - screenW/4, screenH - 40}



addEvent("debug->ChangeState", true)

addEventHandler("debug->ChangeState", root, function()

	debugShow = not debugShow



	if debugShow then

		outputChatBox("#d7ff00[NextLevel]: #FFFFFFDebug mode #0094ffbekapcsolva#ffffff.", 0, 255, 0,true)

	else

		outputChatBox("#d7ff00[NextLevel]: #FFFFFFDebug mode #d75959kikapcsolva#ffffff.", 255, 0, 0,true)

	end

end)



addEvent("debug->Add", true)

addEventHandler("debug->Add", root, function(message, level, file, line)

	addDebugMessage(message, level, file, line)

end)



addEventHandler("onClientDebugMessage", root, function(message, level, file, line)

    addDebugMessage(message, level, file, line)

end)



function addDebugMessage(message, level, file, line)

    local file = file or ""

    local line = line or 1

    local level = level or 1

    local message = message or ""

    

    local result = 0

    

    for index, value in pairs(debugLines) do

        if value.text == "#d7ff00" .. debugTypes[level] .. file .. ":" .. line .. ": #ffffff" .. message then

            result = index

        end

    end



    if type(result) == "number" and result > 0 and getTickCount() - debugLines[result].time < 60000 then

        debugLines[result].amount = debugLines[result].amount + 1

        debugLines[result].time = getTickCount()

    else

        local msg = "#d7ff00" .. debugTypes[level] .. file .. ":" .. line .. ": #ffffff" .. message

        table.insert(debugLines, {text = msg, amount = 1, time = getTickCount()})

    end

        

    if #debugLines > lines then

        table.remove(debugLines, 1)

    end 

end



local font = dxCreateFont("Roboto.ttf", 10)



local y = positions[2]



addEventHandler("onClientRender", root, function()

    if debugShow then

        for index = 1, lines do

            local value = debugLines[index]

            if value then

                local text = value.text or ""

                local level = value.level or 1

                local amount = value.amount or 1

                

                if amount > 1 then

                	dxDrawText("["..amount.."x]" .. text:gsub("#%x%x%x%x%x%x", ""), positions[1] + 1, y + 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                	dxDrawText("["..amount.."x]" .. text:gsub("#%x%x%x%x%x%x", ""), positions[1] + 1, y - 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                	dxDrawText("["..amount.."x]" .. text:gsub("#%x%x%x%x%x%x", ""), positions[1] - 1, y + 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                	dxDrawText("["..amount.."x]" .. text:gsub("#%x%x%x%x%x%x", ""), positions[1] - 1, y - 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                   

                    dxDrawText("#ffffff["..amount.."x]" .. text, positions[1], y, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                else

                	dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), positions[1] + 1, y + 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                	dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), positions[1] + 1, y - 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                	dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), positions[1] - 1, y + 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                	dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), positions[1] - 1, y - 1, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)



                    dxDrawText(text, positions[1], y, 0, 0, tocolor(0, 0, 0), 1, font, "left", "top", false, false, false, true)

                end



                y = y - 15

            end

        end



        y = positions[2]

    end

end)