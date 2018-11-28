
--============================== EVENTY

function loadAreas()
	local areas = exports.DB:getArray("SELECT * FROM `bhc_spheres`")
	for k, v in ipairs(areas) do
		local r, g, b
		 if(v.nation == 0) then
			r, g, b = 255, 0, 0
		elseif(v.nation == 1) then
			r, g, b = 0, 255, 0
		else
			r, g, b = 255, 255, 255
		end

		local elem = createRadarArea(v.x, v.y, 200, 200, r, g, b, 80)

		setElementData(elem, "id", tonumber(v.id))
		setElementData(elem, "name", tostring(v.name))
		setElementData(elem, "nation", tonumber(v.nation))
		setElementData(elem, "value", tonumber(v.value))

		setElementData(elem, "posX", math.floor(v.x))
		setElementData(elem, "posY", math.floor(v.y))
	end
	outputServerLog("[SEKTORY] Zaladowano pomyslnie (Ilosc: "..#areas..")")
end
addEventHandler("onResourceStart", getResourceRootElement(), loadAreas)

function scoreOnPlayerWasted(totalAmmo, killer, killerWeapon, bodyPart)
	local area = getPlayerArea(source)
	if(isElement(area)) then
		if(getElementData(area, "capture") == true) then
			local nation = getElementData(source, "nation")
			if(nation == 0) then
				setElementData(area, "rosPkt", tonumber(getElementData(area, "rosPkt")) - 20)
			elseif(nation == 1) then
				setElementData(area, "usaPkt", tonumber(getElementData(area, "usaPkt")) - 20)
			end
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), scoreOnPlayerWasted)

--============================== KOMENDY

function cmdGPS(player, command, sektorName)
	if(isElement(getElementData(player, "gpsBlip"))) then
		destroyElement(getElementData(player, "gpsBlip"))
		exports.bhc_noti:showBox(player, "Zaznaczony sektor został usunięty.")
	else
		if(tostring(sektorName) == "nil" or tostring(sektorName) == "false" or sektorName == "") then
			exports.bhc_noti:showBox(player, "Użycie: /gps [nazwa sektoru]")
			return
		end
		sektorName = tostring(sektorName)
		sektorName = sektorName:lower()
		local areas = getElementsByType("radararea")

		for k,v in ipairs(areas) do

			local name = getElementData(v, "name")
			name = tostring(name)
			name = name:lower()

			if(sektorName == name) then
				local elem = createBlip(getElementData(v, "posX") + 100, getElementData(v, "posY") + 100, 0, 19, 2, 255, 0, 0, 255, 0, 999999999, player)
				setElementData(player, "gpsBlip", elem)

				exports.bhc_noti:showBox(player, "Sektor został zaznaczony na mapie.")
				return
			end
		end
		exports.bhc_noti:showBox(player, "Nie znaleziono podanego sektoru!")
		return
	end
end
addCommandHandler("gps", cmdGPS)

function cmdSektorInfo(player)
	local adminLevel = exports.bhc_admin:getAdminLevel(player)
	if(adminLevel > 2) then
		local area = getPlayerArea(player)
		if(isElement(area)) then
			outputChatBox("----------------------", player)
			outputChatBox("Jesteś na sektorze o nazwie "..getElementData(area, "name"), player)
			outputChatBox("Jego ID to "..getElementData(area, "id"), player)
			outputChatBox("a jego wartosc to "..getElementData(area, "value"), player)
			outputChatBox("----------------------", player)
		else
			outputChatBox("Nie znajdujesz się na żadnym sektorze.", player, 255, 0, 0)
		end
	else
		outputChatBox("Nie posiadasz odpowiednich uprawnień do użycia tej komendy.", player, 255, 0, 0)
	end
end
addCommandHandler("sektorInfo", cmdSektorInfo)

function cmdUstawWartosc(player, command, wartosc)
	local adminLevel = exports.bhc_admin:getAdminLevel(player)
	if(adminLevel > 2) then
		if(wartosc == nil or wartosc == "") then
			outputChatBox("SYNTAX: /ustawWartosc [wartość]", player)
			return
		end

		local area = getPlayerArea(player)
		if(isElement(area)) then
			setElementData(area, "value", tonumber(wartosc))
			saveAreaNation(area)
			outputChatBox("Pomyślnie edytowano strefę.", player, 0, 255, 0)
		else
			outputChatBox("Nie znajdujesz się na żadnym sektorze.", player, 255, 0, 0)
		end

	else
		outputChatBox("Nie posiadasz odpowiednich uprawnień do użycia tej komendy.", player, 255, 0, 0)
	end
end
addCommandHandler("ustawWartosc", cmdSektorInfo)

function cmdUstawNacjeStrefy(player, command, wartosc)
	local adminLevel = exports.bhc_admin:getAdminLevel(player)
	if(adminLevel > 2) then
		if(wartosc == nil or wartosc == "") then
			outputChatBox("SYNTAX: /ustawNacjeStrefy [wartość]", player)
			return
		end

		local area = getPlayerArea(player)
		if(isElement(area)) then
			setElementData(area, "nation", tonumber(wartosc))
			local r, g, b = getNationColor(tonumber(getElementData(area, "nation")))
			setRadarAreaColor(area, r, g, b, 80)
			saveAreaNation(area)
			outputChatBox("Pomyślnie edytowano strefę.", player, 0, 255, 0)
		else
			outputChatBox("Nie znajdujesz się na żadnym sektorze.", player, 255, 0, 0)
		end

	else
		outputChatBox("Nie posiadasz odpowiednich uprawnień do użycia tej komendy.", player, 255, 0, 0)
	end
end
addCommandHandler("ustawNacjeStrefy", cmdUstawNacjeStrefy)

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function cmdPrzejmijSektor(player)
	local czas = getRealTime()
	if(czas.hour == 18 and czas.minute <= 20) then
		exports.bhc_noti:showBox(player, "Okres zdemilitaryzowany trwa od 18:00 do 18:20. Przez ten czas nie można przejmować sektorów!")
		return
	end

	local area = getPlayerArea(player)
	if(isElement(area)) then

		if(getElementData(area, "timeStamp") ~= false) then
			if(getTimestamp() - getElementData(area, "timeStamp") <= 60 * 20) then
				exports.bhc_noti:showBox(player, "Sektor był przejmowany w ciągu ostatnich 20 minut!")
				return
			end
		end



		if(tonumber(getElementData(area, "id")) == 16 or tonumber(getElementData(area, "id")) == 15 or tonumber(getElementData(area, "id")) == 31 or tonumber(getElementData(area, "id")) == 32) then
			exports.bhc_noti:showBox(player, "Strefa bazowa nacji USA. Nie można przejąć.", "Błąd")
			return
		end

		if(tonumber(getElementData(area, "id")) == 49 or tonumber(getElementData(area, "id")) == 50 or tonumber(getElementData(area, "id")) == 65 or tonumber(getElementData(area, "id")) == 66) then
			exports.bhc_noti:showBox(player, "Strefa bazowa nacji ZSRR. Nie można przejąć.", "Błąd")
			return
		end

		if(tonumber(getElementData(area, "nation")) == tonumber(getElementData(player, "nation"))) then
			exports.bhc_noti:showBox(player, "Ten sektor należy już do Twojej nacji.")
			return
		end

		if(getElementData(area, "capture") == true) then
			exports.bhc_noti:showBox(player, "Ta strefa jest już aktualnie przejmowana.")
			return
		end

		if(getPlayersInNation(0) < 1 or getPlayersInNation(1) < 1) then
			exports.bhc_noti:showBox(player, "Brak odpowiedniej ilości osób w obu nacjach, aby rozpocząć walkę.")
			return
		end

		if(getPlayersInArea(area, getElementData(player, "nation")) < 1) then
			exports.bhc_noti:showBox(player, "Na sektorze muszą znajdować się przynajmniej 3 osoby z Twojej nacji.")
			return
		end

		if(tonumber(getCapturedZones()) >= 3) then
			exports.bhc_noti:showBox(player, "Nie można wywołać więcej niż 3 konflikty!")
			return
		end

		--[[if(isSectorAdjacent(area, getElementData(player, "nation")) == false) then
			exports.bhc_noti:showBox(player, "Strefa musi sąsiadować z przejętą już strefą.")
			return
		end]]--

		setElementData(area, "timeStamp", getTimestamp())

		if(getElementData(area, "nation") == -1) then
			setElementData(area, "nation", tonumber(getElementData(player, "nation")))
			local r, g, b = getNationColor(tonumber(getElementData(player, "nation")))
			exports.bhc_noti:showBox(player, "Strefa zostala pomyslnie przejeta.")
			setRadarAreaColor(area, r, g, b, 80)
			saveAreaNation(area)

			for k, v in ipairs(getElementsByType("player")) do
				if(getElementData(v, "loggedIn") == 1) then
					if(getPlayerArea(v) == area) then
						setElementData(v, "punkty", getElementData(v, "punkty") + 2)
					end
				end
			end
		else
			setElementData(area, "capture", true)

			setElementData(area, "rosPkt", 200)
			setElementData(area, "usaPkt", 200)

			local timer = setTimer(mainCaptureZone, 1000, 0, area)
			setElementData(area, "globalTimer", timer)

			local timer2 = setTimer(flashArea, 1000, 0, area)
			setElementData(area, "flashingTimer", timer2)

			for k, v in ipairs(getElementsByType("player")) do
				if(getElementData(v, "loggedIn") == 1 and getElementData(v, "nation") ~= getElementData(player, "nation")) then
					exports.bhc_noti:showBox(v, "Przeciwna nacja zainicjowała bitwę o sektor "..getElementData(area, "name")..".")
				end
				if(getElementData(v, "loggedIn") == 1 and getElementData(v, "nation") == getElementData(player, "nation")) then
					exports.bhc_noti:showBox(v, "Zainicjowano bitwę o sektor "..getElementData(area, "name").."...")
				end
			end
		end

	else
		exports.bhc_noti:showBox(player, "Nie jesteś na żadnym sektorze!")
		return
	end
end
addCommandHandler("przejmijsektor", cmdPrzejmijSektor)


--============================== FUNKCJE

function getNationColor(nation)
	local r, g, b
	if(nation == 0) then
		r, g, b = 255, 0, 0
	elseif(nation == 1) then
		r, g, b = 0, 255, 0
	else
		r, g, b = 255, 255, 255
	end
	return r, g, b
end

function getPlayerArea(player)
	local x, y, z = getElementPosition(player)
	local areas = getElementsByType("radararea")
	for k, v in ipairs(areas) do
		if(isInsideRadarArea(v, x, y)) then
			return v
		end
	end
	return false
end

function getPlayersInNation(nation)
	local players = getElementsByType("player")
	local i = 0
	for k, v in ipairs(players) do
		if(tonumber(getElementData(v, "nation")) == nation) then
			i = i + 1
		end
	end
	return i
end

function getPlayersInArea(area, nation)
	if(isElement(area)) then
		local players = getElementsByType("player")
		local i = 0
		for k, v in ipairs(players) do
			if(getElementData(v, "loggedIn") == 1 and getElementData(v, "nation") == tonumber(nation) and getElementData(v, "playerSpawned") ~= false) then
				local x, y, z = getElementPosition(v)
				if(isInsideRadarArea(area, x, y)) then
					i = i + 1
				end
			end
		end
		return i
	else
		return false
	end
end

function getAreaNationByPositions(x, y)
	for k, v in ipairs(getElementsByType("radararea")) do
		if(tonumber(getElementData(v, "posX")) == tonumber(x) and tonumber(getElementData(v, "posY")) == tonumber(y)) then
			return tonumber(getElementData(v, "nation"))
		end
	end
	return false
end

function isSectorAdjacent(area, nation)
	local x, y = tonumber(getElementData(area, "posX")), tonumber(getElementData(area, "posY"))
	local sektor = getAreaNationByPositions(x - 200, y)
	if(sektor ~= false) then
		if(tonumber(sektor) == tonumber(nation)) then return true end
	end

	local sektor = getAreaNationByPositions(x + 200, y)
	if(sektor ~= false) then
		if(tonumber(sektor) == tonumber(nation)) then return true end
	end

	local sektor = getAreaNationByPositions(x, y - 200)
	if(sektor ~= false) then
		if(tonumber(sektor) == tonumber(nation)) then return true end
	end

	local sektor = getAreaNationByPositions(x, y + 200)
	if(sektor ~= false) then
		if(tonumber(sektor) == tonumber(nation)) then return true end
	end
	return false
end

function flashArea(area)
	local r, g, b, a = getRadarAreaColor(area)
	if(r == 255) then
		setRadarAreaColor(area, 0, 255, 0, 80)
	else
		setRadarAreaColor(area, 255, 0, 0, 80)
	end
end

function stopFlashArea(area)
	killTimer(getElementData(area, "flashingTimer"))
	local r, g, b = getNationColor(getElementData(area, "nation"))
	setRadarAreaColor(area, r, g, b, 80)
end

function getAreaByID(id)
	local areas = getElementsByType("radararea")
	for k, v in ipairs(areas) do
		if(getElementData(v, "id") == tonumber(id)) then
			return v
		end
	end
	return false
end

function saveAreaNation(area)
	if(isElement(area)) then
		exports.DB:zapytanie("UPDATE `bhc_spheres` SET `nation` = '"..getElementData(area, "nation").."', `value` = '"..getElementData(area, "value").."' WHERE `ID` = '"..getElementData(area, "id").."'")
	end
end

function getCapturedZones()
	local areas = getElementsByType("radararea")
	local i = 0

	for k, v in ipairs(areas) do
		if(getElementData(v, "capture") == true) then
			i = i + 1
		end
	end
	return i
end


--============================== Główna funkcja

function mainCaptureZone(area)
	if(isElement(area)) then
		if(getElementData(area, "capture") == true) then

			--===== CZY KTÓRAŚ Z NACJI MA 0 PUNKTÓW ====--
			if(getElementData(area, "usaPkt") <= 0) then
				if(getElementData(area, "nation") == 0) then -- Jeśli Rosja broniła i wygrała
					local players = getElementsByType("player")
					for k, v in ipairs(players) do
						if(getElementData(v, "nation") == 0) then
							if(getPlayerArea(v) == area) then
								exports.bhc_noti:showBox(v, "Sektor został obroniony. Na Twoje konto dodane zostało 80 punktów.")
								setElementData(v, "punkty", tonumber(getElementData(v, "punkty")) + 80)
							else
								exports.bhc_noti:showBox(v, "Sektor "..getElementData(area, "name").." został obroniony.")
							end
						end
						if(getElementData(v, "nation") == 1) then
							exports.bhc_noti:showBox(v, "Atak na sektor "..getElementData(area, "name").." nie powiódł się.")
						end
					end
				else										 -- Jeśli Rosja atakowała i wygrała
					local players = getElementsByType("player")
					for k, v in ipairs(players) do
						if(getElementData(v, "nation") == 0) then
							if(getPlayerArea(v) == area) then
								exports.bhc_noti:showBox(v, "Sektor został przejety. Na Twoje konto dodane zostalo 90 punktow.")
								setElementData(v, "punkty", tonumber(getElementData(v, "punkty")) + 90)
							else
								exports.bhc_noti:showBox(v, "Sektor "..getElementData(area, "name").." został przejęty.")
							end
						end
						if(getElementData(v, "nation") == 1) then
							exports.bhc_noti:showBox(v, "Sektor "..getElementData(area, "name").." został stracony.")
						end
					end
					setElementData(area, "nation", 0)
				end

				killTimer(getElementData(area, "globalTimer"))
				setElementData(area, "capture", false)
				saveAreaNation(area)
				stopFlashArea(area)
				return

			end

			if(getElementData(area, "rosPkt") <= 0) then

				if(getElementData(area, "nation") == 1) then -- Jeśli USA broniło i wygrało
					local players = getElementsByType("player")
					for k, v in ipairs(players) do
						if(getElementData(v, "nation") == 1) then
							if(getPlayerArea(v) == area) then
								exports.bhc_noti:showBox(v, "Sektor został obroniony. Na Twoje konto dodane zostalo 80 punktow.")
								setElementData(v, "punkty", tonumber(getElementData(v, "punkty")) + 80)
							else
								exports.bhc_noti:showBox(v, "Sektor "..getElementData(area, "name").." został obroniony.")
							end
						end
						if(getElementData(v, "nation") == 0) then
							exports.bhc_noti:showBox(v, "Atak na sektor "..getElementData(area, "name").." nie powiódł się.")
						end
					end
				else										 -- Jeśli USA atakowało i wygrało
					local players = getElementsByType("player")
					for k, v in ipairs(players) do
						if(getElementData(v, "nation") == 1) then
							if(getPlayerArea(v) == area) then
								exports.bhc_noti:showBox(v, "Sektor został przejety. Na Twoje konto dodane zostalo 90 punktow.")
								setElementData(v, "punkty", tonumber(getElementData(v, "punkty")) + 90)
							else
								exports.bhc_noti:showBox(v, "Sektor "..getElementData(area, "name").." został przejęty.")
							end
						end
						if(getElementData(v, "nation") == 0) then
							exports.bhc_noti:showBox(v, "Sektor "..getElementData(area, "name").." został stracony.")
						end
					end
					setElementData(area, "nation", 1)
				end

				killTimer(getElementData(area, "globalTimer"))
				setElementData(area, "capture", false)
				saveAreaNation(area)
				stopFlashArea(area)
				return

			end

			--==== CZY NA SEKTORZE SĄ GRACZE ====--

			if(getElementData(area, "usaIdle") ~= false and tonumber(getElementData(area, "usaIdle")) >= 11) then
				setElementData(area, "usaPkt", tonumber(getElementData(area, "usaPkt") - 10))
				setElementData(area, "usaIdle", 1)
			end

			if(getElementData(area, "rosIdle") ~= false and tonumber(getElementData(area, "rosIdle")) >= 11) then
				setElementData(area, "rosPkt", tonumber(getElementData(area, "rosPkt") - 10))
				setElementData(area, "rosIdle", 1)
			end


			local ZSRRinZone = getPlayersInArea(area, 0)
			local USAinZone = getPlayersInArea(area, 1)

			if(USAinZone <= 0) then
				if(getElementData(area, "usaIdle") == false) then
					setElementData(area, "usaIdle", 1)
				else
					setElementData(area, "usaIdle", tonumber(getElementData(area, "usaIdle")) + 1)
				end
			else
				setElementData(area, "usaIdle", false)
			end


			if(ZSRRinZone <= 0) then
				if(getElementData(area, "rosIdle") == false) then
					setElementData(area, "rosIdle", 1)
				else
					setElementData(area, "rosIdle", tonumber(getElementData(area, "rosIdle")) + 1)
				end
			else
				setElementData(area, "rosIdle", false)
			end


		else
			killTimer(getElementData(area, "globalTimer"))
		end
	end
end

function getNationAreas(nation)
	local spheres = getElementsByType("radararea")
	local i = 0
	for k, v in ipairs(spheres) do
		if(getElementData(v, "nation") == nation) then i = i + 1 end
	end
	return i
end

function timerCo10Min()
	local spheres = getElementsByType("radararea")
	local data = {}
	data.USA = 0
	data.RUS = 0
	if(getPlayersInNation(0) >= 3) then
		for k, v in ipairs(spheres) do
			if(getElementData(v, "nation") == 0) then
				data.RUS = data.RUS + tonumber(getElementData(v, "value"))
			end
		end
		local elemRos = getElementByID("economyROS")
		setElementData(elemRos, "budzet", tonumber(getElementData(elemRos, "budzet")) + tonumber(data.RUS))
		outputServerLog("[ECONOMY] Dodano pieniadze do nacji: ZSRR. Ilosc dodanych pieniedzy: "..tostring(data.RUS)..". Nowy budzet: "..tostring(getElementData(elemRos, "budzet"))..".")

		local nationAreas = getNationAreas(0)

		for k, v in ipairs(getElementsByType("player")) do
			if(getElementData(v, "nation") == 0) then
				exports.bhc_noti:showBox(v, "Nacja została zasilona "..data.RUS.." punktami pochodzącymi z "..nationAreas.." sektorów")
			end
		end

	end

	if(getPlayersInNation(1) >= 3) then
		for k, v in ipairs(spheres) do
			if(getElementData(v, "nation") == 1) then
				data.USA = data.USA + tonumber(getElementData(v, "value"))
			end
		end
		local elemUsa = getElementByID("economyUSA")
		setElementData(elemUsa, "budzet", tonumber(getElementData(elemUsa, "budzet")) + tonumber(data.USA))
		outputServerLog("[ECONOMY] Dodano pieniadze do nacji: USA. Ilosc dodanych pieniedzy: "..tostring(data.USA)..". Nowy budzet: "..tostring(getElementData(elemUsa, "budzet"))..".")

		local nationAreas = getNationAreas(1)

		for k, v in ipairs(getElementsByType("player")) do
			if(getElementData(v, "nation") == 1) then
				exports.bhc_noti:showBox(v, "Nacja została zasilona "..data.USA.." punktami pochodzącymi z "..nationAreas.." sektorów")
			end
		end

	end
end
setTimer(timerCo10Min, 1000 * 60 * 10, 0)
