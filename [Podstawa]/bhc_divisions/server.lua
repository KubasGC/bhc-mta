

-- @NAZWA: Ładowanie pieniędzy z bazy danych.

local oldData = {}
function loadMoney()

	local kasaROS = exports.DB:fetchArray("SELECT `budzet` FROM `bhc_economy` WHERE `nation` = '1'")
	local kasaUSA = exports.DB:fetchArray("SELECT `budzet` FROM `bhc_economy` WHERE `nation` = '2'")

	local elemROS = createElement("economyROS", "economyROS")
	setElementData(elemROS, "budzet", kasaROS.budzet)

	local elemUSA = createElement("economyUSA", "economyUSA")
	setElementData(elemUSA, "budzet", kasaUSA.budzet)

	oldData["USA"] = kasaUSA.budzet
	oldData["ROS"] = kasaROS.budzet

	setTimer(checkData, 5000, 1)

	outputServerLog("[EKONOMIA] Punkty nacji ROSJA: "..kasaROS.budzet..", USA: "..kasaUSA.budzet)

end
addEventHandler("onResourceStart", resourceRoot, loadMoney)

-- @NAZWA: Sprawdzanie pieniążków co 5 sekund, zapis do bazy danych w razie zmiany.

function checkData()
	local elemRos = getElementByID("economyROS")
	local elemUsa = getElementByID("economyUSA")

	if(tonumber(oldData["USA"]) ~= tonumber(getElementData(elemUsa, "budzet")) or tonumber(oldData["ROS"]) ~= tonumber(getElementData(elemRos, "budzet"))) then
		exports.DB:zapytanie("UPDATE `bhc_economy` SET `budzet` = '"..tonumber(getElementData(elemRos, "budzet")).."' WHERE `nation` = '1'")
		exports.DB:zapytanie("UPDATE `bhc_economy` SET `budzet` = '"..tonumber(getElementData(elemUsa, "budzet")).."' WHERE `nation` = '2'")
		outputServerLog("[EKONOMIA] Aktualizacja punktów nacji.")
	end

	oldData["USA"] = tonumber(getElementData(elemUsa, "budzet"))
	oldData["ROS"] = tonumber(getElementData(elemRos, "budzet"))

	setTimer(checkData, 5000, 1)
end

-- @NAZWA: Ładowanie dywizji gracza po zalogowaniu.
function getPlayerDivision(player)

	local tablica = exports.DB:fetchArray("SELECT * FROM `bhc_divisions` WHERE `charid` = '"..getElementData(player, "charid").."' AND `nation` = '"..getElementData(player, "nation").."' ORDER BY `id` DESC LIMIT 1")

	setElementData(player, "division:id", tablica.division)
	setElementData(player, "division:leader", tablica.leader)
	setElementData(player, "division:data", tablica.data)
	setElementData(player, "division:rank", tablica.rank)

	outputServerLog("[DYWIZJA] Zaladowano dywizje gracza (GUID: "..getElementData(player, "charid")..") - ID dywizji: "..tablica.division.." (LIDER: "..tablica.leader..")")
end

function savePlayerDivision(player)
	exports.DB:zapytanie("UPDATE `bhc_divisions` SET `division` = '"..tostring(getElementData(player, "division:id")).."', `leader` = '"..tostring(getElementData(player, "division:leader")).."', `data` = '"..tostring(getElementData(player, "division:data")).."', `rank` = '"..tostring(getElementData(player, "division:rank")).."' WHERE `charid` = '"..tostring(getElementData(player, "charid")).."'")
end
