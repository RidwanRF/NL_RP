local needtogive = 500 -- IDE ÍRD HOGY MENNYIT AKARSZ HOGY ADJON
local money = getElementData(localPlayer,"char.Money")
function pedClick (button,state,absoluteX,absoluteY,worldX,worldY,worldZ,huntman )
	if ( huntman ) then
		if button == "left" and state == "down" then
			if tostring(getElementType(huntman)) == "ped" then
			    if getElementData(huntman, "huntman") then
                    for k, v in pairs(hunts) do
                        local itemID = v[3]
                        if exports.nlrp_inventory:hasItem(itemID) then
                            triggerServerEvent("takeHuntingItems", localPlayer) 
                            break
                        end
                    end
				end
			end
		end
	end
end
addEventHandler ("onClientClick",getRootElement(),pedClick)

addEventHandler("onClientPlayerStealthKill", getLocalPlayer(),function(target) --Ide azt csináltam hogy ne tudják késelgetni
	if getElementData(target,"huntman") then
		cancelEvent() 
	end
end)