
local s = {guiGetScreenSize()}
fonts = {}
fonts["fontawsome_11"] = dxCreateFont(":nlrp_dashboard/fonts/fontawsome.ttf",11)
fonts["signature"] = dxCreateFont("fonts/signature.ttf",16)

local createPanel = false

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		for i = 9,25 do
			fonts[i] = dxCreateFont(":nlrp_dashboard/fonts/nextlevelfont.ttf",i)
		end

		for k,v in ipairs(jobMarkers) do
			local a = createMarker(v[1],v[2],v[3]-1,"cylinder",3.0,183,255,0,100)
			setElementData(a,"companyMarker","fuvarvalaszto")
			setElementData(a,"company.JobMarker",true)
		end

		for k,v in ipairs(packMarkers) do
			local a = createMarker(v[1],v[2],v[3]-1,"cylinder",3.0,183,255,0,100)
			if v[4] then
				setElementData(a,"companyMarker","berakodas_olaj")
			else
				setElementData(a,"companyMarker","berakodas")
			end
			setElementData(a,"company.PackMarker",true)
		end
	end
)

addEventHandler("onClientRender",root,
	function()
		if createPanel then
			local size = {400,200}
			local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

			dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(40,40,40,150))
			dxDrawRectangle(pos[1],pos[2],size[1],40,tocolor(40,40,40,150))

			dxDrawText("Vállalkozás igénylése",pos[1]+size[1]/2,pos[2]+40/2,nil,nil,tocolor(183,255,0,200),1,fonts[14],"center","center",false,false,false,true)
			
			dxDrawText("Új vállalkozás összege:\n" .. format(newCompanyPrice) .. "Ft",pos[1]+size[1]/2,pos[2]+size[2]/2,nil,nil,tocolor(255,255,255,200),1,fonts[14],"center","center",false,false,false,true)
		
			dxDrawRectangle(pos[1]+50,pos[2]+size[2]-55,90,30,tocolor(253,80,70,200))
			if isCursorOnBox(pos[1]+50,pos[2]+size[2]-55,90,30) then
				dxDrawRectangle(pos[1]+50,pos[2]+size[2]-55,90,30,tocolor(255,255,255,10))
			end
			dxDrawBorder(pos[1]+50,pos[2]+size[2]-55,90,30,1,tocolor(10,10,10,200))
			dxDrawText("Kilépés",pos[1]+50+90/2,pos[2]+size[2]-55+30/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center",false,false,false,true)

			dxDrawRectangle(pos[1]+size[1]-90-50,pos[2]+size[2]-55,90,30,tocolor(183,255,0,200))
			if isCursorOnBox(pos[1]+size[1]-90-50,pos[2]+size[2]-55,90,30) then
				dxDrawRectangle(pos[1]+size[1]-90-50,pos[2]+size[2]-55,90,30,tocolor(255,255,255,10))
			end
			dxDrawBorder(pos[1]+size[1]-90-50,pos[2]+size[2]-55,90,30,1,tocolor(10,10,10,200))
			dxDrawText("Igénylés",pos[1]+size[1]-90-50+90/2,pos[2]+size[2]-55+30/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center",false,false,false,true)
		end
	end
)

addEventHandler("onClientKey",root,
	function(k,p)
		if k == "mouse1" and p then
			if createPanel then
				local size = {400,200}
				local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

				if isCursorOnBox(pos[1]+size[1]-90-50,pos[2]+size[2]-55,90,30) then --// Igénylés
					if getElementData(localPlayer,"char.CompanyID") > 0 then 
						exports.nlrp_hud:showInfobox("error","Neked már van vállalkozásod.")
					else
						if getElementData(localPlayer,"char.Money") >= newCompanyPrice then
							createPanel = false
							exports.nlrp_hud:showInfobox("info","Sikeresen igényeltél egy vállakozást ((Használd az F1 billentyűt!))!")
							triggerServerEvent("createNewCompany",resourceRoot,localPlayer)
						else
							exports.nlrp_hud:showInfobox("error","Nincs elegendő pénzed új vállalkozás igényléséhez!")
						end
					end
				elseif isCursorOnBox(pos[1]+50,pos[2]+size[2]-55,90,30) then
					createPanel = false
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
					if getElementData(element,"nlrp->company->ped") then
						local p = Vector3(getElementPosition(element))
						local p2 = Vector3(getElementPosition(localPlayer))
						if getDistanceBetweenPoints3D(p,p2) <= maxPedClick then
							if not createPanel then
								createPanel = true
							end
						end
					end
				end
			end
		end
	end
)


--// Usefull functions
function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end
function getProgress(addtick, lastTick) 
    local now = getTickCount() 
    local elapsedTime = now - lastTick 
    local duration = lastTick+addtick - lastTick 
    local progress = elapsedTime / duration 
    return progress 
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

addEventHandler("onClientPedDamage",root,
	function()
		if getElementData(source,"nlrp->company->ped") then
			cancelEvent()
		end
	end
)