
local s = {guiGetScreenSize()}
local letter = {}
local rejected = false

local size = {1674/2.5,1400/2.5}
local pos = {s[1]/2-size[1]/2,s[2]/2-size[2]/2}

addEventHandler("onClientRender",root,
	function()
		if letter.driver then
			dxDrawImage(pos[1],pos[2],size[1],size[2],"images/fuvarlevel.png")
			dxDrawBorder(pos[1],pos[2],size[1],size[2],1,tocolor(0,0,0,200))

			dxDrawText(letter.plate,pos[1]+15,pos[2]+60,nil,nil,tocolor(0,0,0,255),1,fonts[11],"left","top")
			dxDrawText(letter.vehicle_model,pos[1]+155,pos[2]+60,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")
			dxDrawText(letter.max_weight .. " kg",pos[1]+310,pos[2]+60,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(letter.driver,pos[1]+15,pos[2]+105,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(letter.company_name,pos[1]+size[1]-210,pos[2]+82.5,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(formatDate("Y","'",letter.date),pos[1]+215,pos[2]+112,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")
			dxDrawText(gMonthNames[tonumber(formatDate("m","'",letter.date))],pos[1]+288,pos[2]+112,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")
			dxDrawText(formatDate("d","'",letter.date),pos[1]+395,pos[2]+112,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(formatDate("h","'",letter.date),pos[1]+225,pos[2]+148,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")
			dxDrawText(formatDate("i","'",letter.date),pos[1]+310,pos[2]+148,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(letter.start .. " - " .. letter.destination,pos[1]+5,pos[2]+202,pos[1]+5+200,pos[2]+202+30,tocolor(0,0,0,255),1,fonts[9],"left","top",true,true,false,false)
			
			dxDrawText(letter.product_name,pos[1]+285,pos[2]+207,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(format(letter.product_weight)  .. " kg",pos[1]+400,pos[2]+207,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")
			dxDrawText(letter.product_id,pos[1]+570,pos[2]+207,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(letter.product_name .. "  -  " .. format(letter.product_weight) .. " kg",pos[1]+15,pos[2]+335,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")
			
			dxDrawText(letter.destination,pos[1]+30,pos[2]+385,nil,nil,tocolor(0,0,0,255),1,fonts[10],"left","top")

			dxDrawText(format(letter.payment) .. " FT",pos[1]+222,pos[2]+474,nil,nil,tocolor(0,0,0,255),1,fonts[10],"center","top")

			dxDrawText(letter.driver,pos[1]+360,pos[2]+335,nil,nil,tocolor(0,0,0,255),1,fonts["signature"],"left","top")

			dxDrawImage(pos[1]+520,pos[2]+310,294/4,300/4,"images/signature.png")

			if exports.nlrp_groups:isPlayerInGroup(localPlayer,factionIds[1]) or exports.nlrp_groups:isPlayerInGroup(localPlayer,factionIds[2]) then
				if isCursorOnBox(pos[1]+size[1]/2-300/2,pos[2]+size[2]+10,300,35) then
					dxDrawRectangle(pos[1]+size[1]/2-300/2,pos[2]+size[2]+10,300,35,tocolor(228,58,58,200))
				else
					dxDrawRectangle(pos[1]+size[1]/2-300/2,pos[2]+size[2]+10,300,35,tocolor(228,58,58,150))
				end
				dxDrawBorder(pos[1]+size[1]/2-300/2,pos[2]+size[2]+10,300,35,1.5,tocolor(10,10,10,150))

				dxDrawText("Fuvar lefoglalása",pos[1]+size[1]/2,pos[2]+size[2]+10+35/2,nil,nil,tocolor(10,10,10,200),1,fonts[12],"center","center",false,false)
			end
		end
	end
)

addEventHandler("onClientKey",root,
	function(k,p)
		if k == "mouse1" and p then
			if letter.driver then
				if exports.nlrp_groups:isPlayerInGroup(localPlayer,factionIds[1]) or exports.nlrp_groups:isPlayerInGroup(localPlayer,factionIds[2]) then
					if isCursorOnBox(pos[1]+size[1]/2-300/2,pos[2]+size[2]+10,300,35) then
						triggerServerEvent("_takeJob",resourceRoot,localPlayer,letter.driver)
					end
				end
			end
		end
	end
)

function showProductLetter(data1,data2)
	if data1 and data2 then
		letter = data1
		rejected = data2
	else
		letter = {}
		rejected = false
	end
end
