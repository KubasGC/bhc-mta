local GUI = {}
local screenWidth, screenHeight = guiGetScreenSize()
function loadGUI()
    GUI.okno = guiCreateWindow(0.33, 0.09, 0.30, 0.68, "Administracja", true)
    guiWindowSetSizable(GUI.okno, false)
    guiWindowSetMovable(GUI.okno, false)

    GUI.lista = guiCreateGridList(0.05, 0.06, 0.91, 0.81, true, GUI.okno)
    GUI.id = guiGridListAddColumn(GUI.lista, "ID", 0.2)
    GUI.nazwa = guiGridListAddColumn(GUI.lista, "Nazwa", 0.3)
    GUI.funkcja = guiGridListAddColumn(GUI.lista, "Ranga", 0.4)

    GUI.button = guiCreateButton(141, 476, 128, 35, "Zamknij", false, GUI.okno)   

    guiSetVisible(GUI.okno, false)

    addEventHandler("onClientGUIClick", GUI.button, function()
        toggleGUI(0, false)
        end, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadGUI)

function toggleGUI(toggle, data)
    if(toggle == 1 and guiGetVisible(GUI.okno) == false) then
        guiGridListClear(GUI.lista)
        for k, v in ipairs(data) do
            local row = guiGridListAddRow (GUI.lista)
            guiGridListSetItemText (GUI.lista, row, GUI.id, v.id, false, false)
            guiGridListSetItemText (GUI.lista, row, GUI.nazwa, v.nick, false, false)
            guiGridListSetItemText (GUI.lista, row, GUI.funkcja, v.ranga, false, false)

            guiGridListSetItemColor(GUI.lista, row, GUI.funkcja, v.r, v.g, v.b)
        end
        guiSetVisible(GUI.okno, true)
        showCursor(true)
    else
        guiSetVisible(GUI.okno, false)
        showCursor(false)
    end
end
addEvent("toggleGUIAdmins", true)
addEventHandler("toggleGUIAdmins", getResourceRootElement(), toggleGUI)


function generateDX()
	if(getElementData(getLocalPlayer(), "adminDuty") == 1) then
		dxDrawText("ADMIN", 0.85431918008785 * screenWidth, 0.13932291666667 * screenHeight, 0.94729136163982 * screenWidth, 0.18098958333333 * screenHeight, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("ADMIN", 0.85358711566618 * screenWidth, 0.13802083333333 * screenHeight, 0.94655929721816 * screenWidth, 0.1796875 * screenHeight, tocolor(255, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	end
end
addEventHandler("onClientRender", getRootElement(), generateDX)