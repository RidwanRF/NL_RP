local Panel = {}
local widgets = {}
local ntext
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
local screenWidth, screenHeight = guiGetScreenSize()

local isVisible = false
local activeItem = false
local docButtons = {}

local UI = exports.nlrp_ui
local responsiveMultipler = UI:getResponsiveMultiplier()

function resp(value)
    return value * responsiveMultipler
end

function respc(value)
    return math.ceil(value * responsiveMultipler)
end

function loadFonts()
    fonts = {
		Roboto11 = exports.nlrp_assets:loadFont("Roboto-Regular.ttf", respc(11), false, "antialiased"),
		Roboto12 = exports.nlrp_assets:loadFont("Roboto-Regular.ttf", respc(12), false, "antialiased"),
		Roboto13 = exports.nlrp_assets:loadFont("Roboto-Regular.ttf", respc(13), false, "antialiased"),
        Roboto14 = exports.nlrp_assets:loadFont("Roboto-Regular.ttf", respc(14), false, "antialiased"),
        Roboto16 = exports.nlrp_assets:loadFont("Roboto-Regular.ttf", respc(16), false, "cleartype"),
        Roboto18 = exports.nlrp_assets:loadFont("Roboto-Regular.ttf", respc(18), false, "cleartype"),
        RobotoL = exports.nlrp_assets:loadFont("Roboto-Light.ttf", respc(18), false, "cleartype"),
        RobotoL14 = exports.nlrp_assets:loadFont("Roboto-Light.ttf", respc(14), false, "cleartype"),
        RobotoL16 = exports.nlrp_assets:loadFont("Roboto-Light.ttf", respc(16), false, "cleartype"),
        RobotoL18 = exports.nlrp_assets:loadFont("Roboto-Light.ttf", respc(18), false, "cleartype"),
        RobotoL24 = exports.nlrp_assets:loadFont("Roboto-Light.ttf", respc(24), false, "cleartype"),
        RobotoLI16 = exports.nlrp_assets:loadFont("Roboto-Light-Italic.ttf", respc(16), false, "cleartype"),
        RobotoLI24 = exports.nlrp_assets:loadFont("Roboto-Light-Italic.ttf", respc(24), false, "cleartype"),
        RobotoB18 = exports.nlrp_assets:loadFont("Roboto-Bold.ttf", respc(18), false, "antialiased"),
    
        SignPainter = exports.nlrp_assets:loadFont("SignPainter-HouseScript-Regular.ttf", respc(24), false, "cleartype"),
        lunabar = exports.nlrp_assets:loadFont("lunabar.ttf", respc(26), false, "antialiased"),
    }
end

local panelWidth = respc(400)
local panelHeight = respc(500)

addEventHandler("onClientResourceStart", resourceRoot, function()       
    loadFonts()
   
end)

addEventHandler("onAssetsLoaded", root, function ()
	loadFonts()
end)

local currentDocuments = {
    {
        name = "Személyi igazolvány",
        price = 30,
        itemID = 112,
	},
	{
        name = "Jogosítvány",
        price = 30,
        itemID = 111,
	},
	{
        name = "Fegyverengedély[Vadászpuska]",
        price = 5000000,
        itemID = 372,
    },
    {
        name = "Fegyverengedély[P250,Deagle]",
        price = 4000000,
        itemID = 373,
	},
	{
        name = "Fegyverengedély[MPX]",
        price = 7500000,
        itemID = 374,
	},
	{
        name = "Vadászengedély",
        price = 5000000,
        itemID = 375,
	},
}

local function processDocumentList(id, newData)
	if not isVisible then
		return
	end

	local list = {}

	for i = 1, #currentDocuments do
		local data = currentDocuments[i]

		if i == id then
			data = newData
		end

		table.insert(list, {
			data.name,
			data.price,
			data = data
		})
	end

	UI:setItems(widgets.documentList, list)
	list = nil
end

function Panel.show()
	if isVisible then
		return
	end

	isVisible = true

	widgets.panel = UI:createCustomPanel({
		x = (screenWidth - panelWidth) / 2,
		y = (screenHeight - panelHeight) / 2,
		width = panelWidth,
		height = panelHeight,
		rounded = true,
		moveable = {
			x = 0,
			y = 0,
			width = panelWidth,
			height = UI:respc(34.425)
		},
		enableAnimation = true
	})
	UI:addChild(widgets.panel)

	widgets.logo = UI:createImage({
		x = 5,
		y = 5,
		width = UI:respc(403 * 0.075),
		height = UI:respc(459 * 0.075),
		--texture = ":nlrp_assets/images/sarplogo_big.png",
		color = tocolor(183, 255, 0),
		floorMode = true
	})
	UI:addChild(widgets.panel, widgets.logo)

	widgets.headerTitle = UI:createCustomLabel({
		x = 10 + UI:respc(30.225),
		y = 5,
		width = 0,
		height = UI:respc(34.425),
		color = tocolor(255, 255, 255),
		font = fonts.Roboto16,
		alignX = "left",
		alignY = "center",
		text = "Okmányok"
	})
	UI:addChild(widgets.panel, widgets.headerTitle)

	widgets.closeButton = UI:createCustomImageButton({
		x = panelWidth - UI:respc(24) - 10,
		y = 5 + (UI:respc(34.425) - UI:respc(24)) / 2,
		width = UI:respc(24),
		height = UI:respc(24),
		hoverColor = tocolor(215, 89, 89),
		texture = ":nlrp_assets/images/cross_x.png"
	})
	UI:addChild(widgets.panel, widgets.closeButton)

	widgets.documentList = UI:createCustomList({
		x = 10,
		y = 15 + UI:respc(34.425) + UI:respc(35),
		width = panelWidth - 20,
		height = UI:respc(35) * 7,
		columnFont = fonts.Roboto16,
		columnFontScale = 0.9,
		itemFontScale = 0.75,
		columns = {
			{text = "Okmány", size = 0.7, itemAlign = "left", columnAlign = "left"},
			{text = "Ár (Ft)", size = 0.3, itemAlign = "right", columnAlign = "right"},
		},
		items = {},
		itemHeight = UI:respc(35),
		visibleItems = 8,
		scrollOffset = 2,
		enableScrollbar = true
	})
	UI:addChild(widgets.panel, widgets.documentList)

	processDocumentList()

	showCursor(true)
end

function Panel.hide()
	if not isVisible then
		return
	end
	isVisible = false

	UI:removeChild(widgets.panel)
	showCursor(false)
end

local function showBuyButton(data)
	if not isVisible then
		return
	end

	for i = 1, #docButtons do
		if widgets[docButtons[i]] then
			UI:removeChild(widgets.panel, widgets[docButtons[i]])
		end
	end

	local buttons = {}
	docButtons = {}

    table.insert(buttons, {"Kiváltás (" .. data.price .. "$)", "buyDocument", {183, 255, 0, 175}})

	local x = 10

	for i = 1, #buttons do
		local button = buttons[i]
		local buttonName = button[2]
		--local width = FontManager.loadedFonts.RobotoL:getTextWidth(button[1], 1) + 20

		table.insert(docButtons, buttonName)

		widgets[buttonName] = UI:createCustomButton({
			x = x,
			y = panelHeight - UI:respc(40) - 10,
			width = panelWidth - (2 * x),
			height = UI:respc(40),
			color = button[3],
			text = button[1],
			font = fonts.RobotoL16,
			rounded = true
		})
		UI:addChild(widgets.panel, widgets[buttonName])

		--x = x + width + 5
	end

	return true
end

addEvent("sarpUI.click", false)
addEventHandler("sarpUI.click", resourceRoot, function (widget, button)
	if button == "left" then
		if widget == widgets.closeButton then
			Panel.hide()
		elseif widget == widgets.documentList then
			local hoveredItem = UI:getHoveredItem(widget)

			if hoveredItem then
				local items = UI:getItems(widget)

				UI:setActiveItem(widget, hoveredItem)
				activeItem = hoveredItem

				if items[hoveredItem] then
                    showBuyButton(items[hoveredItem].data)
				end
			end
		elseif widget == widgets.buyDocument then
			local items = UI:getItems(widgets.documentList)
			local data = items[activeItem].data
			local veh = getPedOccupiedVehicle(localPlayer)
			local model = getElementModel(veh)
            -- Alap form
            local docData = {
                ["name"] = getPlayerName(localPlayer):gsub("_", " "),
                ["birth"] = (getRealTime().year + 1900) - getElementData(localPlayer, "char.Age"),
				["expire"] = getRealTime().timestamp + (3600 * 24) * 30,
				["expire2"] = getRealTime().timestamp + 1209600,
				["expire3"] = never,
				["created"] = getRealTime().timestamp,
				["category"] = "B",
				["model"] = getElementData(veh,"vehicle.dbID"),
				["rendszam"] = getVehiclePlateText(veh),
				["vehtype"] = exports.nlrp_mods_veh:getVehicleNameFromModel(model),
				["motor"] = getElementData(veh,"veh:performance_engine"),
				["turbo"] = getElementData(veh,"veh:performance_turbo"),
				["gearbox"] = getElementData(veh,"veh:performance_gearbox"),
				["ecu"] = getElementData(veh,"veh:performance_ecu"),
				["tires"] = getElementData(veh,"veh:performance_tires"),
				["brake"] = getElementData(veh,"veh:performance_brakes"),

            }
			triggerServerEvent("nlrp_licensesS:giveDocument", localPlayer, data.itemID, docData, data.price)
		end
	end
end)

addEventHandler("onClientClick", root, function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if button == "left" and state == "down" then
        if clickedElement then
            if exports.nlrp_core:inDistance3D(getLocalPlayer(), clickedElement, 5) then
                if tonumber(getElementData(clickedElement, "ped.type")) == 4 then
                    Panel.show()
                elseif tonumber(getElementData(clickedElement, "ped.type")) == 5 and tonumber(getElementData(clickedElement, "ped.subtype")) == 1 then
                    showExamPanel("main")
                elseif tonumber(getElementData(clickedElement, "ped.type")) == 5 and tonumber(getElementData(clickedElement, "ped.subtype")) == 2 then
                    local itemData = exports.nlrp_inventory:hasItemWithData(113, "data2", "vezetés-elmélet")
                    if itemData and (tonumber(itemData.data1) == 1 or itemData.data1) and itemData.data2 == "vezetés-elmélet" and tonumber(itemData.data3) == getElementData(localPlayer, "char.ID") then
                        showDrivePanel("main")
					else
						print(inspect(itemData))
                        exports.nlrp_alert:showAlert("error", "Névre szóló vizsga papírok", "nélkül nem kezdheted meg a vizsgát")
                    end
                end
            end
        end
    end
end)
