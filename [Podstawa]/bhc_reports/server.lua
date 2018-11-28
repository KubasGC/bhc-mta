local reports = {}

function handleReport(text)
	local tablica = {}
	tablica.gracz = source
	tablica.graczName = string.gsub(getPlayerName(source), "_", " ")
	tablica.graczID = getElementData(source, "id")
	tablica.text = text

	table.insert(reports, tablica)

	for k, v in ipairs(getElementsByType("player")) do
		if(getElementData(v, "loggedIn") == 1 and getElementData(v, "admin") > 0) then
			exports.bhc_noti:showBox(v, "Nowe zgłoszenie od gracza "..tablica.graczName.." ("..tablica.graczID.."). Aby przejrzeć raporty wpisz /areport.")
		end
	end
end
addEvent("handleReport", true)
addEventHandler("handleReport", root, handleReport)

function cmdAreport(player)
	if(getElementData(player, "loggedIn") == 1) then
		if(getElementData(player, "admin") > 0) then
			triggerClientEvent(player, "showGUIAdmin1", player, reports)
		end
	end
end
addCommandHandler("areport", cmdAreport)

function trashReport(key)
	table.remove(reports, key)
	exports.bhc_noti:showBox(source, "Zgłoszenie zostało pomyślnie skasowane.")
	triggerClientEvent(source, "showGUIAdmin1", source, reports)
end
addEvent("trashReport", true)
addEventHandler("trashReport", root, trashReport)