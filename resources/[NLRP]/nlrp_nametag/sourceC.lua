
local font = dxCreateFont("files/nextlevelfont.ttf",12)

local nametag = {
	["show"] = true, -- Megjelenítve (true vagy false)
	["distance"] = 15, -- Betöltési távolság
	["anamesDistance"] = 150, -- Anames Betöltési távolság
	["afkTimeout"] = 5*60, -- Hány másodperc után dobjon AFK-ba
	["lastActive"] = getTickCount(),
	["showOwnName"] = true,
}

local anames = false

addCommandHandler("togtag",
	function()
		nametag.showOwnName = not nametag.showOwnName
	end
)

addCommandHandler("anames",
	function()
		if getElementData(localPlayer,"acc.adminLevel") then
			if getElementData(localPlayer,"acc.adminLevel") >= 1 then
				if getElementData(localPlayer,"adminDuty") or getElementData(localPlayer,"acc.adminLevel") >= 9 then
					anames = not anames
				end
			end
		end
	end
)

addEventHandler("onClientElementDataChange",root,
	function(data,old,new)
		if data == "adminDuty" then
			if not new then
				anames = false
			end
		end
	end
)

addEventHandler("onClientRender",root,
	function()
		if isChatBoxInputActive() then
			if not getElementData(localPlayer,"typing") then setElementData(localPlayer,"typing",true) end
		else
			if getElementData(localPlayer,"typing") then setElementData(localPlayer,"typing",false) end
		end
		if isConsoleActive() then
			if not getElementData(localPlayer,"consoling") then setElementData(localPlayer,"consoling",true) end
		else
			if getElementData(localPlayer,"consoling") then setElementData(localPlayer,"consoling",false) end
		end

		if nametag.show and getElementData(localPlayer,"loggedIn") then
			if getTickCount() - nametag.lastActive >= nametag.afkTimeout*1000 then
				if not getElementData(localPlayer,"afk") then
					setElementData(localPlayer,"afk",true)
					setElementData(localPlayer,"afk.time",{0,0,0})
				end
			end
			for _,player in ipairs(getElementsByType("player",root,true)) do
				if player ~= localPlayer or nametag.showOwnName then
					if anames then
						local x,y,z = getCameraMatrix()
						local x2,y2,z2 = getPedBonePosition(player,6)
						z2 = z2 + 0.3

						local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
						if distance <= nametag.anamesDistance then
							local sx,sy = getScreenFromWorldPosition(x2,y2,z2)
							if sx and sy then
								local font_scale = 1 - (0.4/nametag.anamesDistance*distance)
								local r,g,b = 175,63,63
								local text = "[ " .. (getElementData(player,"visibleName") or 0) .. " / ".. (getElementData(player,"playerID") or 0) .." ]"

								if getElementData(player,"afk") then
									local h,m,s = unpack(getElementData(player,"afk.time"))
									if s < 10 then s = "0" .. s end
									if m < 10 then m = "0" .. m end
									if h < 10 then h = "0" .. h end

									text = "[AFK " .. h .. ":" .. m .. ":" .. s .. "]\n" .. text
								end

								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx-1,sy-1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx+1,sy-1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx-1,sy+1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx+1,sy+1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text,sx,sy,nil,nil,tocolor(r,g,b,alpha),font_scale,font,"center","center",false,false,false,true,true)
							end
						end
					else
						if getElementData(player,"loggedIn") then
							local x,y,z = getCameraMatrix()
							local x2,y2,z2 = getPedBonePosition(player,6)
							z2 = z2 + 0.3

							local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
							if distance <= nametag.distance then
								local cameraX, cameraY, cameraZ = getCameraMatrix()

								if isLineOfSightClear(cameraX, cameraY, cameraZ, x2,y2,z2, true, false, false, true, false, true, false) then
									if getElementAlpha(player) == 255 then
										local sx,sy = getScreenFromWorldPosition(x2,y2,z2)
										if sx and sy then
											local alpha = 1 - (255/nametag.distance*distance)
											local font_scale = 1 - (0.4/nametag.distance*distance)

											local text = "[ " .. (getElementData(player,"playerID") or 0) .. " ]"
											local r,g,b = 255,255,255
											if getElementData(player, "voicing") then
												r,g,b = 183,255,0
											end

											if getElementData(player,"adminDuty") then
												text = exports.nlrp_core:getAdminLevelColor(getElementData(player,"acc.adminLevel")) .. "" .. "[" .. exports.nlrp_core:getPlayerAdminTitle(player) .. "]#ffffff " .. (getElementData(player,"acc.adminNick") or "Admin") .. " [ " .. (getElementData(player,"playerID") or 0) .. " ]"
												if getElementData(player, "voicing") then
													text = exports.nlrp_core:getAdminLevelColor(getElementData(player,"acc.adminLevel")) .. "" .. "[" .. exports.nlrp_core:getPlayerAdminTitle(player) .. "]#ffffff " .. (getElementData(player,"acc.adminNick") or "Admin") .. " #b7ff00[ " .. (getElementData(player,"playerID") or 0) .. " ]"
												end
											end

											local size = 32*font_scale
											if (getElementData(player,"bloodLevel") or 100) < 100 and getElementHealth(player) > 0 then
												dxDrawImage(sx-size/2,sy-size-10,size,size,":nlrp_hud/files/icons2/drop.png",0,0,0,tocolor(215,89,89,alpha))
											end
											if getElementHealth(player) > 0 and getElementHealth(player) <= 20 then
												local timeLeft = (600000 - (getElementData(player,"inAnimTime") or 0)[1]) / 1000
												if getElementData(player, "voicing") then
													text = "#d75959* Eszméletlen (" .. string.format("%.2d:%.2d", timeLeft / 60, timeLeft % 60) .. ") *#b7ff00 [ " .. (getElementData(player,"playerID") or 0) .. " ]"
												else
													text = "#d75959* Eszméletlen (" .. string.format("%.2d:%.2d", timeLeft / 60, timeLeft % 60) .. ") *#ffffff [ " .. (getElementData(player,"playerID") or 0) .. " ]"
												end
											end

											local deathReason = getElementData(player,"deathReason")
											if isPedDead(player) and deathReason then
												if getElementData(player, "voicing") then
													text = "#d75959*" .. deathReason .. "*#ffffff #b7ff00" .. text
												else
													text = "#d75959*" .. deathReason .. "*#ffffff " .. text
												end
											end

											if getElementData(player,"badgeData") then
												if getElementData(player,"paintedFace") then
													text = text .. "\n" .. "#ccff02*Festékes*"
												else
													text = text .. "\n" .. "#dca300# " .. getElementData(player,"badgeData") .. " #"
												end 
											else
												if getElementData(player,"paintedFace") then
													text = text .. "\n" .. "#ccff02*Festékes*"
												end
											end

											if getElementData(player,"afk") then
												local h,m,s = unpack(getElementData(player,"afk.time"))
												if s < 10 then s = "0" .. s end
												if m < 10 then m = "0" .. m end
												if h < 10 then h = "0" .. h end

												if getElementData(player, "voicing") then
													text = "#ffffff[AFK " .. h ..":" .. m .. ":" .. s .."]\n#b7ff00" .. text
												else
													text = "#ffffff[AFK " .. h ..":" .. m .. ":" .. s .."]\n" .. text
												end
											end

											if getElementData(player,"typing") then
												dxDrawImage(sx-size/2,sy-size-10,size,size,"files/typing.png",0,0,0,tocolor(222,222,222,alpha))
											end

											if getElementData(player,"consoling") then
												dxDrawImage(sx-size/2,sy-size-10,size,size,"files/consoling.png",0,0,0,tocolor(222,222,222,alpha))
											end

											dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx-1,sy-1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
											dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx+1,sy-1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
											dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx-1,sy+1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
											dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx+1,sy+1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
											dxDrawText(text,sx,sy,nil,nil,tocolor(r,g,b,alpha),font_scale,font,"center","center",false,false,false,true,true)
										end
									end
								end
							end
						end
					end
				end
			end
			for _,ped in ipairs(getElementsByType("ped")) do
				local x,y,z = getCameraMatrix()
				local x2,y2,z2 = getPedBonePosition(ped,6)
				z2 = z2 + 0.3

				local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
				if distance <= nametag.distance then
					local cameraX, cameraY, cameraZ = getCameraMatrix()

					if isLineOfSightClear(cameraX, cameraY, cameraZ, x2,y2,z2, true, false, false, true, false, true, false) then
						if getElementAlpha(ped) == 255 then
							local sx,sy = getScreenFromWorldPosition(x2,y2,z2)
							if sx and sy then
								local alpha = 1 - (255/nametag.distance*distance)
								local font_scale = 1 - (0.4/nametag.distance*distance)

								local name = "Ismeretlen"
								if getElementData(ped,"ped.name") then name = getElementData(ped,"ped.name") end
								if getElementData(ped,"dog.name") then name = getElementData(ped,"dog.name") end
								if getElementData(ped,"visibleName") then name = getElementData(ped,"visibleName") end

								local tag = getElementData(ped,"pedNameType")
								if tag then
									text = "#b7ff00[NPC]#ffffff " .. name .. " #b7ff00(" .. tag .. ")"
								else
									text = "#b7ff00[NPC]#ffffff " .. name
								end

								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx-1,sy-1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx+1,sy-1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx-1,sy+1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sx+1,sy+1,nil,nil,tocolor(0,0,0,alpha),font_scale,font,"center","center",false,false,false,true,true)
								dxDrawText(text,sx,sy,nil,nil,tocolor(255,255,255,alpha),font_scale,font,"center","center",false,false,false,true,true)
							end
						end
					end
				end
			end
		end
	end
)




setElementData(localPlayer,"afk",false)
setElementData(localPlayer,"afk.time",{0,0,0})

addEventHandler("onClientMinimize",root,
	function()
		setElementData(localPlayer,"afk",true)
		setElementData(localPlayer,"afk.time",{0,0,0})
	end
)

addEventHandler("onClientRestore",root,
	function()
		setElementData(localPlayer,"afk",false)
	end
)

setTimer( function()
	if getElementData(localPlayer,"afk") then
		local h,m,s = unpack(getElementData(localPlayer,"afk.time"))
		s = s + 1
		if s >= 60 then
			s = 0
			m = m + 1
		end
		if m >= 60 then
			m = 0
			h = h + 1
		end
		setElementData(localPlayer,"afk.time",{h,m,s})
	end
end,1000,0)

addEventHandler("onClientCursorMove",root,
	function()
		if getElementData(localPlayer,"afk") then
			setElementData(localPlayer,"afk",false)
			nametag.lastActive = getTickCount()
		end
	end
)

addEventHandler("onClientKey",root,
	function(k,p)
		if getElementData(localPlayer,"afk") then
			setElementData(localPlayer,"afk",false)
			nametag.lastActive = getTickCount()
		end
	end
)