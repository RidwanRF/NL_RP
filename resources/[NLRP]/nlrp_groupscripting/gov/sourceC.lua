function playGovSound()

	local sound = playSound("files/gov.mp3")
	setSoundVolume(sound, 0.5)

end
addEvent("playGovSound", true)
addEventHandler("playGovSound", getRootElement(), playGovSound)

