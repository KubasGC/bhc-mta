local GUI = {}

function loadGUIs()
	GUI.okno = guiCreateWindow(0.31, 0.24, 0.39, 0.29, "Informacje o graczu: Jeremy Simons (ID: 0)", true)
	guiWindowSetSizable(GUI.okno, false)

	GUI.nickIC = guiCreateLabel(0.04, 0.14, 0.90, 0.11, "Nick IC: Jeremy Simons (2)", true, GUI.okno)
	guiSetFont(GUI.nickIC, "default-bold-small")
	guiLabelSetVerticalAlign(GUI.nickIC, "center")

	GUI.nickOOC = guiCreateLabel(0.04, 0.25, 0.90, 0.11, "Nick OOC: Kubas (1)", true, GUI.okno)
	guiSetFont(GUI.nickOOC, "default-bold-small")
	guiLabelSetVerticalAlign(GUI.nickOOC, "center")

	GUI.dywizja = guiCreateLabel(0.04, 0.35, 0.90, 0.11, "Dywizja: Piechota", true, GUI.okno)
	guiSetFont(GUI.dywizja, "default-bold-small")
	guiLabelSetVerticalAlign(GUI.dywizja, "center")

	GUI.nacja = guiCreateLabel(0.04, 0.46, 0.90, 0.11, "Nacja: USA", true, GUI.okno)
	guiSetFont(GUI.nacja, "default-bold-small")
	guiLabelSetVerticalAlign(GUI.nacja, "center")

	GUI.punkty = guiCreateLabel(0.04, 0.57, 0.90, 0.11, "Punkty: 161", true, GUI.okno)
	guiSetFont(GUI.punkty, "default-bold-small")
	guiLabelSetVerticalAlign(GUI.punkty, "center")

	GUI.zamknij = guiCreateButton(0.04, 0.76, 0.91, 0.16, "Zamknij", true, GUI.okno)

	guiSetVisible(GUI.okno, false)

	addEventHandler("onClientGUIClick", GUI.zamknij, hideGUI, false)
end
addEventHandler("onClientResourceStart", resourceRoot, loadGUIs)

function hideGUI()
	guiSetVisible(GUI.okno, false)
	showCursor(false)
end

function isAdmin(player)
	if(isElement(player)) then
		if(getElementData(player, "loggedIn") == 1) then
			if(getAdminLevel(player) ~= 0) then
				return true
			else
				return false
			end
		else return false end
	else return false end
end

function getAdminLevel(player)
	if(isElement(player)) then
		local adminLevel = tonumber(getElementData(player, "global:mgi"))
		local number = 0
		if(adminLevel == 14) then
			number = 1
		end

		if(adminLevel == 11) then
			number = 2
		end

		if(adminLevel == 7) then
			number = 3
		end

		if(adminLevel == 4) then
			number = 4
		end

		return number
	end
	return 0
end

function getDivName(div)
	local dname = "Brak"
	if(div == 0) then
		dname = "Piechota"
	elseif(div == 1) then
		dname = "Pancerna"
	elseif(div == 2) then
		dname = "Lotnicza"
	elseif(div == 3) then
		dname = "Transportowa"
	end
	return dname
end

function getNationName(nation)
	local nname = ""
	if(nation == 0) then
		nname = "ZSRR"
	else
		nname = "USA"
	end
	return nname
end

function cmdStats(command, val1)
	if(tostring(val1) == "" or tostring(val1) == "nil") then
		guiSetText(GUI.okno, "Informacje o graczu: "..string.gsub(getPlayerName(localPlayer), "_", " ").." (ID: "..getElementData(localPlayer, "id")..")")
		guiSetText(GUI.nickIC, "Nick IC: "..string.gsub(getPlayerName(localPlayer), "_", " ").." (UID: "..getElementData(localPlayer, "charid")..")")
		guiSetText(GUI.nickOOC, "Nick OOC: "..getElementData(localPlayer, "global:name").." (GUID: "..getElementData(localPlayer, "global:id")..")")
		guiSetText(GUI.dywizja, "Dywizja: "..getDivName(getElementData(localPlayer, "division:id")))
		guiSetText(GUI.nacja, "Nacja: "..getNationName(getElementData(localPlayer, "nation")))
		guiSetText(GUI.punkty, "Punkty: "..getElementData(localPlayer, "punkty"))
	else
		if(not isAdmin(localPlayer)) then return end
		local elem = getElementByID("p"..(tostring(val1)))
		if(isElement(elem)) then
			guiSetText(GUI.okno, "Informacje o graczu: "..string.gsub(getPlayerName(elem), "_", " ").." (ID: "..getElementData(elem, "id")..")")
			guiSetText(GUI.nickIC, "Nick IC: "..string.gsub(getPlayerName(elem), "_", " ").." (UID: "..getElementData(elem, "charid")..")")
			guiSetText(GUI.nickOOC, "Nick OOC: "..getElementData(elem, "global:name").." (GUID: "..getElementData(elem, "global:id")..")")
			guiSetText(GUI.dywizja, "Dywizja: "..getDivName(getElementData(elem, "division:id")))
			guiSetText(GUI.nacja, "Nacja: "..getNationName(getElementData(elem, "nation")))
			guiSetText(GUI.punkty, "Punkty: "..getElementData(elem, "punkty"))
		else
			outputChatBox("Nie znaleziono gracza o podanym ID.")
			return
		end
	end
	guiSetVisible(GUI.okno, true)
	showCursor(true)
end
addCommandHandler("stats", cmdStats)