outputDebugString("OK")
local GUI = {}

function loadGUI(zmienna1, zmienna2, zmienna3)

	GUI.okno = guiCreateWindow(0.25, 0.19, 0.49, 0.54, "Pomoc", true)
	guiWindowSetMovable(GUI.okno, false)
	guiWindowSetSizable(GUI.okno, false)

	GUI.panel = guiCreateTabPanel(0.01, 0.06, 0.97, 0.92, true, GUI.okno)

	GUI.tabOgolne = guiCreateTab("Ogólne", GUI.panel)
	GUI.ogolnaPomoc = guiCreateMemo(-0.01, 0.00, 1.01, 1.00, tostring(zmienna1), true, GUI.tabOgolne)
	guiMemoSetReadOnly(GUI.ogolnaPomoc, true)

	GUI.tabKomendy = guiCreateTab("Komendy", GUI.panel)
	GUI.ogolneKomendy = guiCreateMemo(-0.01, 0.00, 1.01, 1.00, tostring(zmienna2), true, GUI.tabKomendy)
	guiMemoSetReadOnly(GUI.ogolneKomendy, true)

	GUI.tabArta = guiCreateTab("Korzystanie z artylerii", GUI.panel)
	GUI.ogolneArta = guiCreateMemo(-0.01, 0.00, 1.01, 1.00, tostring(zmienna3), true, GUI.tabArta)
	guiMemoSetReadOnly(GUI.ogolneArta, true)  

	guiSetVisible(GUI.okno, false)

	bindKey("f1", "down", toggleGUI)
end
addEvent("loadGUI", true)
addEventHandler("loadGUI", root, loadGUI)


function closeGUI()
	guiSetVisible(GUI.okno, false)
	showCursor(false)
end

function showGUI()
	guiSetVisible(GUI.okno, true)
	showCursor(true)
end

function toggleGUI()
	if(guiGetVisible(GUI.okno) == false) then
		showGUI()
	else
		closeGUI()
	end
end

addCommandHandler("pomoc", toggleGUI)
addCommandHandler("help", toggleGUI)