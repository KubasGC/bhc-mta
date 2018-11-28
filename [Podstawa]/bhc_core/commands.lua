local data = {}
function reloadWeapon(player)
	reloadPedWeapon(player)
end


function onPJoin()
	bindKey(source, "r", "down", reloadWeapon, source)
end
addEventHandler("onPlayerJoin", root, onPJoin)

function onResStart()
	for k, v in ipairs(getElementsByType("player")) do
		bindKey(v, "r", "down", reloadWeapon, v)
	end
end
addEventHandler("onResourceStart", resourceRoot, onResStart)

function isNull(zmienna)
	if(zmienna == nil or zmienna == "") then return true end
	return false
end


function cmdV(playerid, command, ...)
	if(getElementData(playerid, "global:id") ~= 1) then
		return
	end
	if(...) then
		id = table.concat({...}, " ")
		local x, y, z = getElementPosition(playerid)
		local id = getVehicleModelFromName(id)
		local veh = createVehicle ( id, x+3, y+3, z+2 ) 
		if(veh) then
			setElementData(playerid, "Vehicle", veh);
			warpPedIntoVehicle(playerid, veh)
		else
			outputChatBox("Błąd: mamy problem, coś poszło nie tak. upewnij się, że wpisałeś nazwę pojazdu, nie model.", playerid)
		end
	else
	outputChatBox("Blad: Pasowaloby podac model, skad mam wiedziec co spawnowac? Daj mi nazwe pojazdu.",playerid)
	end

end
addCommandHandler("v", cmdV)

function cmdW(player, command, id, ...)
	local message = table.concat({...}, " ") 
	if(not id or not message) then
		outputChatBox("Syntax: /w [id gracza] [wiadomość]", player)
	else
		local target = getElementByID("p"..id)
		if(isElement(target)) then
			if(target ~= player) then
				local playerName = getPlayerName(player)
				playerName = playerName:gsub("_", " ")
				
				local targetName = getPlayerName(target)
				targetName = targetName:gsub("_", " ")

				if(getElementData(target, "togw") == true) then
					exports.bhc_noti:showBox(player, "Gracz "..targetName.." ma zablokowane prywatne wiadomości.")
					return
				end
				
				outputChatBox("[Wiadomość od: ".. playerName .."("..getElementData(player, "id")..")] "..message, target, 255, 128, 64)
				outputChatBox("[Wiadomość do: ".. targetName .."("..getElementData(target, "id")..")] "..message, player, 255, 255, 0)
				triggerClientEvent(target, "onTextMess", target)
			else
				outputChatBox("Błąd: Nie możesz wysłać wiadomości do samego siebie.", player)
			end
		else
			outputChatBox("Błąd: Nie znaleziono takiego gracza. Być może nie jest podłączony.", player)
		end
	end
end
addCommandHandler("w", cmdW)

addCommandHandler("fix", function(player, command)
	local veh = getPedOccupiedVehicle(player)
	fixVehicle(veh)
end)

function cmdMeSys(player, command, ...)
	local message = table.concat({...}, " ")
	if(message) then
		local x, y, z = getElementPosition(player)
		local sphere = createColSphere(x, y, z, 10)
		local players = getElementsWithinColShape(sphere)
		local nazwa = getPlayerName(player)
		nazwa = nazwa:gsub("_", " ")
		destroyElement(sphere)
		for k, v in ipairs(players) do
			outputChatBox("* "..nazwa.. " "..message, v, 194, 162, 218)
		end
	end
end
addCommandHandler("mesystemowe", cmdMeSys)

function cmdOpis(player, command, ...)
	local desc = table.concat({...}, " ")
	if(desc == "") then
		outputChatBox("Syntax: /opis [treść opisu]. Aby usunąć opis wpisz /opis usun.", player)
		return
	end

	if(desc == "usun" or desc == "usuń") then
		setElementData(player, "desc", false)
		outputChatBox("Opis został poprawnie usunięty.", player)
		return
	end

	if(string.len(desc) >= 120) then
		outputChatBox("Treść opisu nie może przekraczać 120 znaków!", player)
		return
	end

	outputChatBox("Pomyślnie ustawiono opis: "..desc, player)
	setElementData(player, "desc", desc)


end
addCommandHandler("opis", cmdOpis)

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

function cmdPunkty(player)
	if(getElementData(player, "loggedIn") == 1) then
		local time = getTimestamp()

		if(data[getElementData(player, "charid")] == nil) then
			data[getElementData(player, "charid")] = time
			setElementData(player, "punkty", getElementData(player, "punkty") + 1000)
			local name = getPlayerName(player)
			name = string.gsub(name, "_", " ")
			outputChatBox("Gracz "..name.." własnie użył komendy /punkty i dostał 1000 punktów.", root, 0, 255, 0)
		else
			if(time - data[getElementData(player, "charid")] >= 60 * 30) then
				data[getElementData(player, "charid")] = time
				setElementData(player, "punkty", getElementData(player, "punkty") + 1000)
				local name = getPlayerName(player)
				name = string.gsub(name, "_", " ")
				outputChatBox("Gracz "..name.." własnie użył komendy /punkty i dostał 1000 punktów.", root, 0, 255, 0)
			else
				outputChatBox("Punkty można dostać tylko RAZ na pół godziny gry!", player, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("punkty", cmdPunkty)

function cmdTogw(player)
	setElementData(player, "togw", not getElementData(player, "togw"))
	local data = getElementData(player, "togw") == true and  "wyłączone" or "włączone"
	exports.bhc_noti:showBox(player, "Otrzymywanie wiadomości "..data..".")
end
addCommandHandler("togw", cmdTogw)