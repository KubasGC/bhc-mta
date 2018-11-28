local ClientGUI1 = {}
function loadGUI()
	ClientGUI1.okno = guiCreateWindow(0.32, 0.15, 0.38, 0.60, "Zgłoszenie", true)
	guiWindowSetSizable(ClientGUI1.okno, false)

	ClientGUI1.info = guiCreateLabel(0.03, 0.08, 0.95, 0.16, "Witamy w systemie raportów!\n\nW białe pole wpisz treść raportu. Uwzględnij ID gracza którego raportujesz!", true, ClientGUI1.okno)
	guiLabelSetHorizontalAlign(ClientGUI1.info, "center", false)
	guiLabelSetVerticalAlign(ClientGUI1.info, "center")

	ClientGUI1.tresc = guiCreateMemo(0.02, 0.26, 0.96, 0.57, "", true, ClientGUI1.okno)
	
	ClientGUI1.send = guiCreateButton(0.74, 0.85, 0.21, 0.10, "Wyślij", true, ClientGUI1.okno)
	ClientGUI1.cancel = guiCreateButton(0.51, 0.85, 0.21, 0.10, "Anuluj", true, ClientGUI1.okno)

	addEventHandler("onClientGUIClick", ClientGUI1.cancel, hideClientGUI, false)
	addEventHandler("onClientGUIClick", ClientGUI1.send, sendReport, false)

	guiSetVisible(ClientGUI1.okno, false)
end
addEventHandler("onClientResourceStart", resourceRoot, loadGUI)

function showClientGUI()
	guiSetVisible(ClientGUI1.okno, true)
	showCursor(true)
	guiSetText(ClientGUI1.tresc, "")
end

function hideClientGUI()
	guiSetVisible(ClientGUI1.okno, false)
	showCursor(false)
end

function sendReport()
	if(string.len(guiGetText(ClientGUI1.tresc)) < 3) then return outputChatBox("Musisz wpisać przynajmniej 3 znaki!", 255, 0, 0) end
	outputChatBox("Raport wysłany!")
	hideClientGUI()
	triggerServerEvent("handleReport", localPlayer, guiGetText(ClientGUI1.tresc))
end

function cmdReport()
	if(guiGetVisible(ClientGUI1.okno) == true) then return end
	showClientGUI()
end
addCommandHandler("report", cmdReport)