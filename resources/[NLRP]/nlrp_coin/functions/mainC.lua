serverColor = "#b7ff00"
serverRgbColor = {183,255,0}
whiteColor = "#ffffff"
serverName = serverColor.."NextLevel"..whiteColor.."Roleplay"
serverFont = dxCreateFont("functions/robotoFont.ttf",10)
tipFont = dxCreateFont("functions/robotoFont.ttf",8)
coinValue = 1000
moneyData = "char.Money"
coinData = "char.slotCoins"
moneyValute = "Ft"

function shadowedText(text,x,y,w,h,color,fontsize,font,aligX,alignY)
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x,y+1,w,h+1,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x,y-1,w,h-1,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true)
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x-1,y,w-1,h,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x+1,y,w+1,h,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text,x,y,w,h,color,fontsize,font,aligX,alignY, false, false, false, true)
end

function centeredText(text,x,y,w,h,color,size,font,shadow,leftcentered,rightcentered,top)
    if leftcentered then
        if shadow then
            shadowedText(text,x+20,y+h/2,x+20,y+h/2,color,size,font,"left","center",false,false,false,true)
        else
            dxDrawText(text,x+20,y+h/2,x+20,y+h/2,color,size,font,"left","center",false,false,false,true)
        end
	elseif rightcentered then
        if shadow then
            if top then
                shadowedText(text,x+w,y+h/2,x+w-20,y+h/2,color,size,font,"right","top",false,false,false,true)
            else
                shadowedText(text,x+w,y+h/2,x+w-20,y+h/2,color,size,font,"right","center",false,false,false,true)
            end
        else
            dxDrawText(text,x+20-20,y+h/2,x+20,y+h/2,color,size,font,"right","center",false,false,false,true)
        end
	else
        if shadow then 
            shadowedText(text,x+w/2,y+h/2,x+w/2,y+h/2,color,size,font,"center","center",false,false,false,true)
        else
            dxDrawText(text,x+w/2,y+h/2,x+w/2,y+h/2,color,size,font,"center","center",false,false,false,true)
        end
    end
end

function isMouseInPosition(x,y,width,height)
	if (not isCursorShowing()) then
		return false
	end
	local sx,sy = guiGetScreenSize()
	local cx,cy = getCursorPosition()
	local cx,cy = (cx*sx),(cy*sy)	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function hexToRGB(hex) 
    hex = hex:gsub("#","") 
    return tonumber("0x"..hex:sub(1,2)),tonumber("0x"..hex:sub(3,4)),tonumber("0x"..hex:sub(5,6))
end

function formatMoney(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1 '):reverse())..right 
end 

local s = Vector2(guiGetScreenSize())

function createTooltip(text)
	local cx,cy = getCursorPosition()
	cx,cy = cx*s.x,cy*s.y
	if text then
		local textWidth = dxGetTextWidth(text,1)
		local height = 55
        dxDrawRectangle(cx-textWidth/2,cy-(height/2)-50,textWidth+10,height,tocolor(25,25,25,210),true)
        dxDrawText(text,cx-textWidth/2,cy-(height/2)-100,textWidth+cx-textWidth/2+10,height+cy-(height/2),tocolor(255,255,255,200),1,tipFont,"center","center",false,false,true,true)	
	end
end