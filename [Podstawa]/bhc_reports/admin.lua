local adminGUI1 = {}
local adminGUI2 = {}

local tablica = nil

local selectedReport = nil

function createAdminGUI()
	adminGUI1.okno 		= guiCreateWindow(0.30, 0.25, 0.42, 0.65, "Zgłoszenia", true)
	guiWindowSetMovable(adminGUI1.okno, false)
	guiWindowSetSizable(adminGUI1.okno, false)

	adminGUI1.lista 	= guiCreateGridList(0.02, 0.04, 0.96, 0.84, true, adminGUI1.okno)
	adminGUI1.columnID 	= guiGridListAddColumn(adminGUI1.lista, "ID", 0.3)
	adminGUI1.columnPla	= guiGridListAddColumn(adminGUI1.lista, "Gracz", 0.3)
	adminGUI1.columnDat	= guiGridListAddColumn(adminGUI1.lista, "Data", 0.3)
	adminGUI1.cancel 	= guiCreateButton(0.32, 0.90, 0.36, 0.08, "Anuluj", true, adminGUI1.okno)

	adminGUI2.okno 		= guiCreateWindow(0.31, 0.25, 0.42, 0.55, "Zgłoszenia", true)
	guiWindowSetMovable(adminGUI2.okno, false)
	guiWindowSetSizable(adminGUI2.okno, false)

	adminGUI2.trash		= guiCreateButton(0.63, 0.88, 0.36, 0.09, "Skasuj", true, adminGUI2.okno)
	adminGUI2.cancel	= guiCreateButton(0.02, 0.88, 0.36, 0.09, "Anuluj", true, adminGUI2.okno)
	adminGUI2.label1 	= guiCreateLabel(42, 57, 465, 23, "Gracz: Jeremy Simons (2)", false, adminGUI2.okno)
	guiLabelSetVerticalAlign(adminGUI2.label1, "center")
	adminGUI2.label2 	= guiCreateLabel(42, 80, 465, 23, "Data: 24.04 13:45", false, adminGUI2.okno)
	guiLabelSetVerticalAlign(adminGUI2.label2, "center")
	adminGUI2.tekst 	= guiCreateMemo(0.07, 0.30, 0.82, 0.50, "", true, adminGUI2.okno)
	guiMemoSetReadOnly(adminGUI2.tekst, true)

	guiSetVisible(adminGUI1.okno, false)
	guiSetVisible(adminGUI2.okno, false)

	addEventHandler("onClientGUIClick", adminGUI1.cancel, hideGUI1, false)
	addEventHandler("onClientGUIClick", adminGUI2.cancel, cancelInfo, false)
	addEventHandler("onClientGUIClick", adminGUI2.trash, trashReport, false)
	addEventHandler("onClientGUIDoubleClick", adminGUI1.lista, getInfo, false)
end
addEventHandler("onClientResourceStart", resourceRoot, createAdminGUI)

function hideGUI1()
	if(guiGetVisible(adminGUI2.okno) == true) then return end
	guiSetVisible(adminGUI1.okno, false)
	showCursor(false)
end

function hideGUI2()
	guiSetVisible(adminGUI2.okno, false)
	if(guiGetVisible(adminGUI1.okno) == false) then
		showCursor(false)
	end
end

function cancelInfo()
	guiSetVisible(adminGUI2.okno, false)
	guiSetVisible(adminGUI1.okno, true)
end

function trashReport()
	cancelInfo()
	triggerServerEvent("trashReport", localPlayer, selectedReport)
	selectedReport = nil
end

function getInfo()
	if(guiGetVisible(adminGUI2.okno) == true) then return end
	local selectedRow = guiGridListGetSelectedItem(adminGUI1.lista)
	if(selectedRow == -1) then return end

	local key = tonumber(guiGridListGetItemText(adminGUI1.lista, selectedRow, adminGUI1.columnID))

	guiSetText(adminGUI2.label1, "Gracz: "..tablica[key].graczName.." ("..tablica[key].graczID..")")
	guiSetText(adminGUI2.tekst, tablica[key].text)

	guiSetVisible(adminGUI1.okno, false)
	guiSetVisible(adminGUI2.okno, true)

	selectedReport = key
end

function showGUIAdmin1(array)
	guiGridListClear(adminGUI1.lista)

	for k, v in ipairs(array) do
		local row = guiGridListAddRow(adminGUI1.lista)
		guiGridListSetItemText (adminGUI1.lista, row, adminGUI1.columnID, k, false, false)
		guiGridListSetItemText (adminGUI1.lista, row, adminGUI1.columnPla, v.graczName, false, false)
		guiGridListSetItemText (adminGUI1.lista, row, adminGUI1.columnDat, "-", false, false)
	end

	if(#array > 0) then tablica = array end

	if(guiGetVisible(adminGUI1.okno) == false) then
		guiSetVisible(adminGUI1.okno, true)
		showCursor(true)
	end
	
end
addEvent("showGUIAdmin1", true)
addEventHandler("showGUIAdmin1", root, showGUIAdmin1)