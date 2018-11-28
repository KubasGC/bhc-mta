function onResStart()
	local realtime = getRealTime()
	setWaveHeight(1.5)
	setGameType ("S-Gaming.pl BHC")
	setTime(realtime.hour + 2, realtime.minute)
	setMinuteDuration(60000)

	outputServerLog("[USTAWIENIA] Zaladowano pomyslnie.")
end
addEventHandler("onResourceStart", resourceRoot, onResStart)