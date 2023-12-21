local allSkins = getValidPedModels()
local availableSkins = {}
local replacedSkins = {}

for k,v in ipairs(allSkins) do
	availableSkins[v] = true
end

addCommandHandler("getskins", function()
	local str = ""
	outputChatBox("[NextLevel] #FFFFFFA szabad skinek kiírva a konzolba!", 0,255,0,true)
	for k,v in pairs(availableSkins) do
		if v then
			str = str..", "..k
		end
	end
	outputConsole("Szabad skinek: "..str)
end)

function loadSkin(a,b)
	if not replacedSkins[b] then
		engineImportTXD(engineLoadTXD(a..".txd"), b)
		engineReplaceModel(engineLoadDFF(a..".dff", b), b)
		
		availableSkins[b] = false
		replacedSkins[b] = true
	else
		outputDebugString("DUPLIKÁLT SKIN: ".. a .. " ["..b.."]")
	end
end

function setSkinAviable(skin, state)
    availableSkins[skin] = not state
    replacedSkins[skin] = state
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for k,v in pairs(allReplacedSkins) do
		loadSkin(k,v)
	end
end)