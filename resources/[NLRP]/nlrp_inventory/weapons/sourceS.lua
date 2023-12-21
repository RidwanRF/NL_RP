

function addWeaponSkinToPlayer(player,texture,image)
	triggerClientEvent(root,"createWeaponSkinPlayer",root,player,texture,image)
end

function removeWeaponSkinPlayerS(player)
	triggerClientEvent(root,"removeWeaponSkinPlayer",root,player)
end

