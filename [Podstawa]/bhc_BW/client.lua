local screenWidth, screenHeight = guiGetScreenSize()
local data = {}
data.bw = false
data.czasRozpoczecia = 0
data.GUI = {}
data.player = false

function createGUI()
	data.GUI.okno = guiCreateWindow(0.38, 0.36, 0.24, 0.20, "Potwierdzenie", true)
	guiWindowSetMovable(data.GUI.okno, false)
	guiWindowSetSizable(data.GUI.okno, false)

	data.GUI.label = guiCreateLabel(0.03, 0.20, 0.94, 0.38, "Chcesz zreanimować tą osobę?", true, data.GUI.okno)
	guiSetFont(data.GUI.label, "default-bold-small")
	guiLabelSetHorizontalAlign(data.GUI.label, "center", false)
	guiLabelSetVerticalAlign(data.GUI.label, "center")

	data.GUI.potwierdz = guiCreateButton(0.19, 0.73, 0.28, 0.18, "Potwierdź", true, data.GUI.okno)
	data.GUI.anuluj = guiCreateButton(0.50, 0.73, 0.28, 0.18, "Anuluj", true, data.GUI.okno)

	guiSetVisible(data.GUI.okno, false)
end
addEventHandler("onClientResourceStart", resourceRoot, createGUI)

function render()
	
	if(data.bw == true and getElementData(localPlayer, "BW") == true) then

		local progress = (getTickCount() - data.czasRozpoczecia) / (1000 * 60)
		local x = interpolateBetween(470, 0, 0, 0, 0, 0, progress, "Linear")

		local sekundy = math.floor(((1000 * 60) - (progress * (1000 * 60))) / 1000)

		local minuty = math.floor(sekundy / 60)
		sekundy = math.floor(sekundy - (minuty * 60))

		if(sekundy < 10) then
			sekundy = "0"..sekundy
		end

		dxDrawRectangle((screenWidth / 2) - 273, (screenHeight / 2) - 159, 490, 35, tocolor(0, 0, 0, 150), false)
		dxDrawRectangle((screenWidth / 2) - 263, (screenHeight / 2) - 152, x, 22, tocolor(6, 6, 169, 255), false)
		dxDrawText("Czas do końca BW", (screenWidth / 2) - 273, (screenHeight / 2) - 180, (screenWidth / 2) + 217, (screenHeight / 2) - 159, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText(minuty..":"..sekundy, (screenWidth / 2) - 263, (screenHeight / 2) - 152, (screenWidth / 2) + 207, (screenHeight / 2) - 131, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)

		if(progress >= 1) then
			data.bw = false
			triggerServerEvent("playerSpawnBW", localPlayer, localPlayer)
		end

	elseif(getElementData(localPlayer, "BW") == true) then
		data.bw = false
	end
end
addEventHandler("onClientRender", root, render)

function setPlayerBW()
	data.czasRozpoczecia = getTickCount()
	data.bw = true
end
addEvent("setPlayerBW", true)
addEventHandler("setPlayerBW", root, setPlayerBW)

function onClientClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)

	if(isElement(clickedElement) and getElementType(clickedElement) == "player" and state == "down") then
		if(getElementData(localPlayer, "division:id") == 3) then
			if(getElementData(clickedElement, "BW") == true) then
				guiSetVisible(data.GUI.okno, true)
				showCursor(true)
			end
		end
	end

end
addEventHandler("onClientClick", root, onClientClick)