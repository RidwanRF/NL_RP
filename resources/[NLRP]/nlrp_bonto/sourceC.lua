
local s = {guiGetScreenSize()}

local panel = false
local createdMarkers = {}

local size = {400,210}
local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        for k,v in ipairs(_markers) do
            local marker = createMarker(v[1],v[2],v[3]-1,"cylinder",2.5,255,255,255,50)
            createdMarkers[marker] = true
        end
    end
)

addEventHandler("onClientMarkerHit",root,
    function(element,dim)
        if element == localPlayer and dim then
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if vehicle then
                if exports.nlrp_vehs:getVehicleName(vehicle) and exports.nle_carshop:getVehicleOriginalPrice(vehicle) then
                    if createdMarkers[source] then
                        if getElementData(vehicle,"vehicle.owner") == getElementData(localPlayer,"char.ID") then
                            panel = true

                            setElementFrozen(vehicle,true)
                        else
                            exports.nlrp_hud:showInfobox("error","Ez nem te járműved!")
                        end
                    end
                end
            end
        end
    end
)

local fonts = {
    [13] = dxCreateFont(":nlrp_dashboard/fonts/nextlevelfont.ttf",13),
    [11] = dxCreateFont(":nlrp_dashboard/fonts/nextlevelfont.ttf",11),
}

addEventHandler("onClientRender",root,
    function()
        if panel then  
            dxDrawRectangle(pos[1],pos[2],size[1],size[2],tocolor(41,41,41,200))
            dxDrawRectangle(pos[1],pos[2],size[1],30,tocolor(31,31,31,200))

            dxDrawText("Roncstelep",pos[1]+size[1]/2,pos[2]+30/2,nil,nil,tocolor(222,222,222,222),1,fonts[13],"center","center")
            dxDrawText("Biztos szeretnéd bezúzatni a járművedet?",pos[1]+size[1]/2,pos[2]+40,nil,nil,tocolor(222,222,222,222),1,fonts[11],"center","top")
            
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if not vehicle then
                panel = false
            end
            local vehName = exports.nlrp_vehs:getVehicleName(vehicle)
            local price = exports.nle_carshop:getVehicleOriginalPrice(vehicle)*precent
            dxDrawText(vehName,pos[1]+size[1]/2,pos[2]+65,nil,nil,tocolor(222,222,222,222),1,fonts[11],"center","top")
            dxDrawText("Bezúzatási ára: #b7ff00" .. format(price) .. " Ft#dedede (" .. precent*100 .. "%)",pos[1]+size[1]/2,pos[2]+85,nil,nil,tocolor(222,222,222,222),1,fonts[11],"center","top",false,false,false,true)

            if isCursorOnBox(pos[1]+10,pos[2]+size[2]-35-10-45,size[1]-20,35) then
                dxDrawRectangle(pos[1]+10,pos[2]+size[2]-35-10-45,size[1]-20,35,tocolor(183,255,0,200))
            else
                dxDrawRectangle(pos[1]+10,pos[2]+size[2]-35-10-45,size[1]-20,35,tocolor(183,255,0,175))
            end
            dxDrawText("Bezuzás",pos[1]+size[1]/2,pos[2]+size[2]-35-10-45+35/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center")

            if isCursorOnBox(pos[1]+10,pos[2]+size[2]-35-10,size[1]-20,35) then
                dxDrawRectangle(pos[1]+10,pos[2]+size[2]-35-10,size[1]-20,35,tocolor(228,58,58,200))
            else
                dxDrawRectangle(pos[1]+10,pos[2]+size[2]-35-10,size[1]-20,35,tocolor(228,58,58,175))
            end
            dxDrawText("Mégse",pos[1]+size[1]/2,pos[2]+size[2]-35-10+35/2,nil,nil,tocolor(10,10,10,200),1,fonts[11],"center","center")
        end
    end
)

addEventHandler("onClientKey",root,
    function(k,p)
        if k == "mouse1" and p then
            if panel then
                if isCursorOnBox(pos[1]+10,pos[2]+size[2]-35-10,size[1]-20,35) then
                    panel = false
                    setElementFrozen(getPedOccupiedVehicle(localPlayer),false)
                elseif isCursorOnBox(pos[1]+10,pos[2]+size[2]-35-10-45,size[1]-20,35) then
                    panel = false

                    local vehicle = getPedOccupiedVehicle(localPlayer)
                    local price = exports.nle_carshop:getVehicleOriginalPrice(vehicle)*precent
                    triggerServerEvent("lótyiAdás",resourceRoot,localPlayer,price,vehicle)

                    exports.nlrp_hud:showInfobox("info","Sikeresen bezúzattad a járműved!")
                end
            end
        end
    end
)


isCursorOnBox = function(x,y,w,h)
    local boolean = false
    if isCursorShowing() and x and y and w and h then
        local cx,cy = getCursorPosition()
        cx,cy = cx*s[1],cy*s[2]
        if (cx >= x and cx <= x+w) and (cy >= y and cy <= y+h) then
            boolean = true
        end
    end
    return boolean
end