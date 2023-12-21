
local rawShader = [[
	texture newTexture : TEXTURE;

	technique replaceTexture
	{
	    pass P0
		{
	        Texture[0] = newTexture;
	    }
	}
]]

local created_textures = {}

local weaponSkins = {}

addEvent("createWeaponSkinPlayer",true)
addEventHandler("createWeaponSkinPlayer",localPlayer,
	function(player,texture,image)
		if weaponSkins[player] then
			weaponSkins[player] = nil
		end

		if not created_textures[image] then
			created_textures[image] = dxCreateTexture(image)
		end
		weaponSkins[player] = {
			shader=dxCreateShader(rawShader,0,100,false,"ped"),
			weapon_texture=texture,
			image=created_textures[image]
		}
		if isElementStreamedIn(player) then
			addWeaponSkin(player)
		end
	end
)

addEvent("removeWeaponSkinPlayer",true)
addEventHandler("removeWeaponSkinPlayer",localPlayer,
	function(player)
		if weaponSkins[player] then
			destroyElement(weaponSkins[player].shader)
			weaponSkins[player] = nil
		end
	end
)

function addWeaponSkin(player)
	if weaponSkins[player] then
		dxSetShaderValue(weaponSkins[player].shader, "TEXTURE", weaponSkins[player].image)
		engineApplyShaderToWorldTexture(weaponSkins[player].shader, "*" .. weaponSkins[player].weapon_texture .. "*", player)
	end
end

function removeWeaponSkin(player)
	if weaponSkins[player] then
		engineRemoveShaderFromWorldTexture(weaponSkins[player].shader, "*" .. weaponSkins[player].weapon_texture .. "*", player)
	end
end

addEventHandler("onClientElementStreamIn",root,
	function()
		if getElementType(source) == "player" then
			if weaponSkins[source] then
				addWeaponSkin(source)
			end
			attachWeaponsToPlayers(source)
		end
	end
)

addEventHandler("onClientElementStreamOut",root,
	function()
		if getElementType(source) == "player" then
			if weaponSkins[source] then
				removeWeaponSkin(source)
			end
			destroyWeaponsFromPlayer(source)
		end
	end
)

addEventHandler("onClientPlayerQuit",root,
	function()
		if getElementType(source) == "player" then
			if weaponSkins[source] then
				removeWeaponSkin(source)
			end
			destroyWeaponsFromPlayer(source)
		end
	end
)



--// Weapon attach

local attachedWeapons = {}

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		setTimer(function()
			for _,player in ipairs(getElementsByType("player")) do
				attachWeaponsToPlayers(player)
			end
		end,1500,1)
	end
)

addEventHandler("onClientRender",root,
	function()
		for player,_ in pairs(attachedWeapons) do
			if player then
				local i,d = getElementInterior(player),getElementDimension(player)
				for dbid,v in pairs(attachedWeapons[player]) do
					if getElementInterior(v.obj) ~= i then setElementInterior(v.obj,i) end
					if getElementDimension(v.obj) ~= d then setElementDimension(v.obj,d) end
					if v.inUse or getElementData(player,"weaponHided" .. dbid) then
						setElementAlpha(v.obj,0)
					else
						if getElementAlpha(player) == 255 then
							setElementAlpha(v.obj,255)
						else
							setElementAlpha(v.obj,0)
						end
					end
	 			end
	 		else
	 			attachedWeapons[player] = nil
	 		end
		end
	end
)


function destroyWeaponsFromPlayer(player)
	if isElement(player) then
		if attachedWeapons[player] then
			for dbid,v in pairs(attachedWeapons[player]) do
				if v.shader then destroyElement(v.shader) end
				if v.obj then destroyElement(v.obj) end
			end
			attachedWeapons[player] = nil
		end
	end 
end

function attachWeaponsToPlayers(player)
	if isElement(player) then
		if isElementStreamedIn(player) then
			if not attachedWeapons[player] then
				attachedWeapons[player] = {}
				if getElementData(player,"loggedIn") then
					local syncedWeapons = getElementData(player,"syncedWeapons")
					if syncedWeapons then
						if #syncedWeapons > 0 then
							local p,i,d = Vector3(getElementPosition(player)),getElementInterior(player),getElementDimension(player)
							for k,v in ipairs(syncedWeapons) do
								local weaponID = availableItems[v.itemID][5]
								if weaponID then
									if weapon_positions[weaponID] then
										attachedWeapons[player][v.dbid] = {}
										attachedWeapons[player][v.dbid].obj = createObject(weapon_positions[weaponID].object_id,p.x,p.y,p.z)
										attachedWeapons[player][v.dbid].inUse = v.inUse
										setElementCollisionsEnabled(attachedWeapons[player][v.dbid].obj,false)
										setElementInterior(attachedWeapons[player][v.dbid].obj,i)
										setElementDimension(attachedWeapons[player][v.dbid].obj,d)

										exports.nlrp_boneattach:attachElementToBone(attachedWeapons[player][v.dbid].obj,player,weapon_positions[weaponID].bone,weapon_positions[weaponID].offset[1],weapon_positions[weaponID].offset[2],weapon_positions[weaponID].offset[3],weapon_positions[weaponID].rot[1],weapon_positions[weaponID].rot[2],weapon_positions[weaponID].rot[3])
										local skin = availableItems[v.itemID].skin
										if skin then
											attachedWeapons[player][v.dbid].shader = dxCreateShader(rawShader,0,100,false,"object")
											attachedWeapons[player][v.dbid].texture = skin.texture
											if not created_textures[skin.skinImage] then
												created_textures[skin.skinImage] = dxCreateTexture(skin.skinImage)
											end
											attachedWeapons[player][v.dbid].image = created_textures[skin.skinImage]

											dxSetShaderValue(attachedWeapons[player][v.dbid].shader, "TEXTURE", attachedWeapons[player][v.dbid].image)
											engineApplyShaderToWorldTexture(attachedWeapons[player][v.dbid].shader, "*" .. attachedWeapons[player][v.dbid].texture .. "*",attachedWeapons[player][v.dbid].obj)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

addEventHandler("onClientElementDataChange",root,
	function(data,old,new)
		if getElementType(source) == "player" then
			if data == "syncedWeapons" then
				destroyWeaponsFromPlayer(source)
				attachWeaponsToPlayers(source)
			end
		end
	end
)

--// Fegyver elrejtés

local panel = false
local s = {guiGetScreenSize()}
local size = {500,310}
local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}
local slotSize = 50
local checkSize = {90/1.2,40/1.2}

local font_30 = dxCreateFont("files/fonts/Roboto.ttf", 30, false, "antialiased")
local font_11 = dxCreateFont("files/fonts/Roboto.ttf", 11, false, "antialiased")
local fontawsome_12 = dxCreateFont("files/fonts/fontawsome.ttf", 12)

local scroll = 0
local maxLine = 4

local playerWeapons = {}

addCommandHandler("hideweapons",
	function()
		if getElementData(localPlayer,"loggedIn") then
			panel = not panel
		end
	end
)

addEventHandler("onClientRender",root,
	function()
		if panel then
			playerWeapons = {}
			for k,v in ipairs(getElementData(localPlayer,"syncedWeapons")) do
				if hideableWeaponIDs[v.itemID] then
					table.insert(playerWeapons,v)
				end
			end

			dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(41,41,41,210))
			dxDrawText("Fegyver Elrejtés",pos[1]+size[1]/2,pos[2]+5,nil,nil,tocolor(183,255,0,255),1,font_30,"center","top",false,false,false,true)

			if #playerWeapons > 0 then
				if playerWeapons[1+scroll] then 
					local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[1+scroll].dbid) or false
					dxDrawImage(pos[1]+60,pos[2]+90,slotSize,slotSize,"files/items/" .. playerWeapons[1+scroll].itemID .. ".png",0,0,0,tocolor(255,255,255,255))
					dxDrawBorder(pos[1]+60+3,pos[2]+90+3,slotSize-6,slotSize-6,2,tocolor(0,0,0,150))
					if hided then
						dxDrawImage(pos[1]+60+slotSize+10,pos[2]+90+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/hided.png",0,0,0,tocolor(255,255,255,255))
					else
						dxDrawImage(pos[1]+60+slotSize+10,pos[2]+90+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/visible.png",0,0,0,tocolor(255,255,255,255))
					end
				end

				if playerWeapons[2+scroll] then
					local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[2+scroll].dbid) or false
					dxDrawImage(pos[1]+size[1]-60-slotSize,pos[2]+90,slotSize,slotSize,"files/items/" .. playerWeapons[2+scroll].itemID .. ".png",0,0,0,tocolor(255,255,255,255))
					dxDrawBorder(pos[1]+size[1]-60-slotSize+3,pos[2]+90+3,slotSize-6,slotSize-6,2,tocolor(0,0,0,150))
					if hided then
						dxDrawImage(pos[1]+size[1]-60-slotSize-10-checkSize[1],pos[2]+90+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/hided.png",0,0,0,tocolor(255,255,255,255))
					else
						dxDrawImage(pos[1]+size[1]-60-slotSize-10-checkSize[1],pos[2]+90+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/visible.png",0,0,0,tocolor(255,255,255,255))
					end
				end

				if playerWeapons[3+scroll] then
					local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[3+scroll].dbid) or false
					dxDrawImage(pos[1]+60,pos[2]+200,slotSize,slotSize,"files/items/" .. playerWeapons[3+scroll].itemID .. ".png",0,0,0,tocolor(255,255,255,255))
					dxDrawBorder(pos[1]+60+3,pos[2]+200+3,slotSize-6,slotSize-6,2,tocolor(0,0,0,150))
					if hided then
						dxDrawImage(pos[1]+60+slotSize+10,pos[2]+200+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/hided.png",0,0,0,tocolor(255,255,255,255))
					else
						dxDrawImage(pos[1]+60+slotSize+10,pos[2]+200+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/visible.png",0,0,0,tocolor(255,255,255,255))
					end
				end

				if playerWeapons[4+scroll] then
					local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[4+scroll].dbid) or false
					dxDrawImage(pos[1]+size[1]-60-slotSize,pos[2]+200,slotSize,slotSize,"files/items/" .. playerWeapons[4+scroll].itemID .. ".png",0,0,0,tocolor(255,255,255,255))
					dxDrawBorder(pos[1]+size[1]-60-slotSize+3,pos[2]+200+3,slotSize-6,slotSize-6,2,tocolor(0,0,0,150))
					if hided then
						dxDrawImage(pos[1]+size[1]-60-slotSize-10-checkSize[1],pos[2]+200+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/hided.png",0,0,0,tocolor(255,255,255,255))
					else
						dxDrawImage(pos[1]+size[1]-60-slotSize-10-checkSize[1],pos[2]+200+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2],"files/visible.png",0,0,0,tocolor(255,255,255,255))
					end
				end
			else
				dxDrawText("Nincs nálad elrejthető fegyver.",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(222,222,222,222),1,font_11,"center","center")
			end

			dxDrawText("",pos[1]+size[1]-8,pos[2]+5,nil,nil,tocolor(222,222,222,222),1,fontawsome_12,"right","top")
		end
	end
)

addEventHandler("onClientKey",root,
	function(k,p)
		if panel then
			if k == "mouse1" and p then
				if playerWeapons[1+scroll] then 
					if isCursorOnBox(pos[1]+60+slotSize+10,pos[2]+90+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2]) then
						local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[1+scroll].dbid) or false
						if hided then
							setElementData(localPlayer,"weaponHided" .. playerWeapons[1+scroll].dbid,false)
						else
							if getHidedItemIDCount(playerWeapons[1+scroll].itemID) >= 2 then
								outputChatBox(exports.nlrp_core:getServerTag("error") .. "Ebből a típúsú fegyverből nem rejthetsz el többet mint 2!",0,0,0,true)
							else
								setElementData(localPlayer,"weaponHided" .. playerWeapons[1+scroll].dbid,playerWeapons[1+scroll].itemID)
							end
						end
					end
				end
				if playerWeapons[2+scroll] then 
					if isCursorOnBox(pos[1]+size[1]-60-slotSize-10-checkSize[1],pos[2]+90+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2]) then
						local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[2+scroll].dbid) or false
						if hided then
							setElementData(localPlayer,"weaponHided" .. playerWeapons[2+scroll].dbid,false)
						else
							if getHidedItemIDCount(playerWeapons[2+scroll].itemID) >= 2 then
								outputChatBox(exports.nlrp_core:getServerTag("error") .. "Ebből a típúsú fegyverből nem rejthetsz el többet mint 2!",0,0,0,true)
							else
								setElementData(localPlayer,"weaponHided" .. playerWeapons[2+scroll].dbid,playerWeapons[2+scroll].itemID)
							end
						end
					end
				end
				if playerWeapons[3+scroll] then 
					if isCursorOnBox(pos[1]+60+slotSize+10,pos[2]+200+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2]) then
						local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[3+scroll].dbid) or false
						if hided then
							setElementData(localPlayer,"weaponHided" .. playerWeapons[3+scroll].dbid,false)
						else
							if getHidedItemIDCount(playerWeapons[3+scroll].itemID) >= 2 then
								outputChatBox(exports.nlrp_core:getServerTag("error") .. "Ebből a típúsú fegyverből nem rejthetsz el többet mint 2!",0,0,0,true)
							else
								setElementData(localPlayer,"weaponHided" .. playerWeapons[3+scroll].dbid,playerWeapons[3+scroll].itemID)
							end
						end
					end
				end
				if playerWeapons[4+scroll] then 
					if isCursorOnBox(pos[1]+size[1]-60-slotSize-10-checkSize[1],pos[2]+200+slotSize/2-checkSize[2]/2,checkSize[1],checkSize[2]) then
						local hided = getElementData(localPlayer,"weaponHided" .. playerWeapons[4+scroll].dbid) or false
						if hided then
							setElementData(localPlayer,"weaponHided" .. playerWeapons[4+scroll].dbid,false)
						else
							if getHidedItemIDCount(playerWeapons[4+scroll].itemID) >= 2 then
								outputChatBox(exports.nlrp_core:getServerTag("error") .. "Ebből a típúsú fegyverből nem rejthetsz el többet mint 2!",0,0,0,true)
							else
								setElementData(localPlayer,"weaponHided" .. playerWeapons[4+scroll].dbid,playerWeapons[4+scroll].itemID)
							end
						end
					end
				end
				if isCursorOnBox(pos[1]+size[1]-20,pos[2],20,20) then
					panel = not panel
				end
			elseif k == "mouse_wheel_down" and p then
				if scroll < #playerWeapons-maxLine then
					scroll = scroll + 2
				end
			elseif k == "mouse_wheel_up" and p then
				if scroll > 0 then scroll = scroll-2 end
			end
		end
	end
)

function getHidedItemIDCount(id)
	if id then
		local count = 0
		for k,v in ipairs(getElementData(localPlayer,"syncedWeapons")) do
			if v.itemID == id then
				if getElementData(localPlayer,"weaponHided" .. v.dbid) then
					count = count + 1
				end
			end
		end
		return count
	end
end



function isCursorOnBox(x, y, width, height)
	if isCursorShowing() then
		local sx, sy = guiGetScreenSize ( )
		local cx, cy = getCursorPosition ( )
		local cx, cy = ( cx * sx ), ( cy * sy )
	  	if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
   			return true
	  	else
  	   		return false
		end
	else
		return false
	end	
end
function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end