addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		setElementData(root, "donePackages", math.random(1, 344))
	end
)

addEvent("crateCarryAnimation", true)
addEventHandler("crateCarryAnimation", getRootElement(),
	function ()
		if isElement(source) then
			setPedAnimation(source, "carry", "crry_prtial", 0, true, true, false, true)
		end
	end
)

addEvent("cratePutDownAnimation", true)
addEventHandler("cratePutDownAnimation", getRootElement(),
	function (transportedCrate)
		if isElement(source) then
			setPedAnimation(source, "carry", "putdwn", 1000, true, true, false, false)

			if transportedCrate then
				local donePackages = getElementData(root, "donePackages")
				setElementData(root, "donePackages", donePackages + 1)
			end
		end
	end
)




addEvent("giveStorekeeperJobCash", true)
addEventHandler("giveStorekeeperJobCash", getRootElement(),
	function (player,payment)
		if isElement(player) and tonumber(payment) then
			setElementData(player, "char.Money", getElementData(player, "char.Money") + payment)		
		end
	end
)
