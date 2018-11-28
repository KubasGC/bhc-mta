local screenWidth, screenHeight = guiGetScreenSize()
local GUI = {}
local data = {}
local kasaElement
data.czcionka1 = dxCreateFont("font.ttf")
data.czcionka2 = dxCreateFont("font.ttf", 13)
data.visible = false
data.wiadomosc = ""
data.GUIvisible = false
data.Division = nil

function createGUIThings()

	GUI.piechota = guiCreateEdit(0.12, 0.44, 0.14, 0.06, "", true)
	GUI.pancerna = guiCreateEdit(0.12, 0.79, 0.14, 0.06, "", true)
	GUI.transportowa = guiCreateEdit(0.38, 0.79, 0.14, 0.06, "", true)
	GUI.lotnicza = guiCreateEdit(0.38, 0.44, 0.14, 0.06, "", true) 

	guiSetVisible(GUI.piechota, false)
	guiSetVisible(GUI.pancerna, false)
	guiSetVisible(GUI.transportowa, false)
	guiSetVisible(GUI.lotnicza, false)

	bindKey("insert", "down", toggleVisible)


	----------------------------------------------------------------------


	GUI.okno2 = guiCreateWindow(0.40, 0.21, 0.17, 0.15, "Wpisz ID gracza", true)
	guiWindowSetMovable(GUI.okno2, false)
	guiWindowSetSizable(GUI.okno2, false)

	GUI.editID = guiCreateEdit(0.41, 0.23, 0.21, 0.36, "", true, GUI.okno2)

	GUI.buttonZapisz = guiCreateButton(0.11, 0.70, 0.30, 0.22, "Ustaw", true, GUI.okno2)
	GUI.buttonAnuluj = guiCreateButton(0.56, 0.70, 0.30, 0.22, "Anuluj", true, GUI.okno2) 

	addEventHandler("onClientGUIClick", GUI.buttonAnuluj, onClickAnuluj, false)
	addEventHandler("onClientGUIClick", GUI.buttonZapisz, onClickWybierz, false)

	guiSetVisible(GUI.okno2, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), createGUIThings)

function isCursorCatch(minX, minY, maxX, maxY)
	if(isCursorShowing()) then
		local cursorX, cursorY = getCursorPosition()
		cursorX = cursorX * screenWidth
		cursorY = cursorY * screenHeight

		if(cursorX >= minX and cursorX <= maxX and cursorY >= minY and cursorY <= maxY) then
			return true
		else
			return false
		end
	end
end

function toggleGUIVisible()
	if(data.GUIstate == nil) then
		if(guiGetVisible(GUI.okno2) == false) then
			guiSetText(GUI.editID, "")
			data.GUIczasRozpoczecia = getTickCount()
			data.GUIstate = "starting"
			data.GUIvisible = true
			guiSetPosition(GUI.okno2, 0.40, -0.15, true)
			guiSetVisible(GUI.okno2, true)
			addEventHandler("onClientRender", getRootElement(), renderGUI)
		else
			data.GUIczasRozpoczecia = getTickCount()
			data.GUIstate = "hiding"
			data.Division = nil
			addEventHandler("onClientRender", getRootElement(), renderGUI)
		end
	end
end

function onClickAnuluj()
	toggleGUIVisible()
end

function onClickWybierz()
	local id = tonumber(guiGetText(GUI.editID))
	if(id) then
		triggerServerEvent("onClientTrigger", root, getLocalPlayer(), data.Division, id)
	end
end

function renderGUI()
	if(data.GUIstate == "starting") then
		local progress = (getTickCount() - data.GUIczasRozpoczecia) / 800
		local animateY = interpolateBetween(-0.15, 0, 0, 0.21, 0, 0, progress, "OutBounce")

		guiSetPosition(GUI.okno2, 0.40, animateY, true)

		if(progress >= 1) then
			data.GUIstate = nil
			removeEventHandler("onClientRender", getRootElement(), renderGUI)
		end
	end

	if(data.GUIstate == "hiding") then
		local progress = (getTickCount() - data.GUIczasRozpoczecia) / 800
		local animateY = interpolateBetween(0.21, 0, 0, -0.52, 0, 0, progress, "Linear")

		guiSetPosition(GUI.okno2, 0.40, animateY, true)

		if(progress >= 1) then
			data.GUIstate = nil
			data.GUIvisible = false
			guiSetVisible(GUI.okno2, false)
			removeEventHandler("onClientRender", getRootElement(), renderGUI)
		end
	end
end

function onServerTrigger()

end
addEvent("onServerTrigger", true)
addEventHandler("onServerTrigger", getRootElement(), onServerTrigger)

function createDXElements()
	local alpha = 1
	if(data.state == "starting") then
		local progress = (getTickCount() - data.czasRozpoczecia) / 800
		alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")

		guiSetAlpha(GUI.piechota, alpha)
		guiSetAlpha(GUI.pancerna, alpha)
		guiSetAlpha(GUI.transportowa, alpha)
		guiSetAlpha(GUI.lotnicza, alpha)

		if(progress >= 1) then
			data.state = "showing"
			data.visible = false
		end
	end

	if(data.state == "hiding") then
		local progress = (getTickCount() - data.czasRozpoczecia) / 800
		alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")

		guiSetAlpha(GUI.piechota, alpha)
		guiSetAlpha(GUI.pancerna, alpha)
		guiSetAlpha(GUI.transportowa, alpha)
		guiSetAlpha(GUI.lotnicza, alpha)

		if(progress >= 1) then
			data.state = nil
			guiSetVisible(GUI.piechota, false)
			guiSetVisible(GUI.pancerna, false)
			guiSetVisible(GUI.transportowa, false)
			guiSetVisible(GUI.lotnicza, false)
			removeEventHandler("onClientRender", getRootElement(), createDXElements)
			data.visible = false
		end
	end

	local budzet = getElementData(kasaElement, "budzet")
	local leadersElement = getElementByID("divisionLeaders")
	local staticBudzet = tonumber(budzet) + tonumber(getElementData(kasaElement, "bPiechota")) + tonumber(getElementData(kasaElement, "bPancerna")) + tonumber(getElementData(kasaElement, "bLotnicza")) + tonumber(getElementData(kasaElement, "bTransportowa"))

		local piechota, pancerna, lotnicza, transportowa = tonumber(guiGetText(GUI.piechota)), tonumber(guiGetText(GUI.pancerna)), tonumber(guiGetText(GUI.lotnicza)), tonumber(guiGetText(GUI.transportowa))

		if(piechota ~= nil) then
			if(string.find(piechota, "-") ~= nil) then
				guiSetText(GUI.piechota, "0")
			end
			local kasa = tonumber(getElementData(kasaElement, "bPiechota"))
			if(kasa ~= piechota) then
				budzet = budzet - (piechota - kasa)
			end
		else
			guiSetText(GUI.piechota, "0")
		end

		if(pancerna ~= nil) then
			if(string.find(pancerna, "-") ~= nil) then
				guiSetText(GUI.pancerna, "0")
			end
			local kasa = tonumber(getElementData(kasaElement, "bPancerna"))
			if(kasa ~= pancerna) then
				budzet = budzet - (pancerna - kasa)
			end
		else
			guiSetText(GUI.pancerna, "0")
		end

		if(lotnicza ~= nil) then
			if(string.find(lotnicza, "-") ~= nil) then
				guiSetText(GUI.lotnicza, "0")
			end
			local kasa = tonumber(getElementData(kasaElement, "bLotnicza"))
			if(kasa ~= lotnicza) then
				budzet = budzet - (lotnicza - kasa)
			end
		else
			guiSetText(GUI.lotnicza, "0")
		end

		if(transportowa ~= nil) then
			if(string.find(transportowa, "-") ~= nil) then
				guiSetText(GUI.transportowa, "0")
			end
			local kasa = tonumber(getElementData(kasaElement, "bTransportowa"))
			if(kasa ~= transportowa) then
				budzet = budzet - (transportowa - kasa)
			end
		else
			guiSetText(GUI.transportowa, "0")
		end

		if(budzet < 0) then
			data.ok = false
			budzet = "#ff0000 Za mało pieniędzy"
		else
			data.ok = true
			budzet = "#00ff00$ "..budzet
		end

		local nacja = getElementData(getLocalPlayer(), "nation")

		if(nacja == 0) then
			nacja = "#ff0000 ZSRR"
		else
			nacja = "#00ff00 USA"
		end

	local minX, minY, maxX, maxY
	local r, g, b
	local leaderName, leaderPrefix

	if(getElementData(getLocalPlayer(), "nation") == 0) then
		leaderPrefix = "ZSRR"
	else
		leaderPrefix = "USA"
	end

	dxDrawImage(0, 0, screenWidth, screenHeight, "images/generalbox.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), false)

	dxDrawText("BUDŻET", 0.067 * screenWidth, 0.436 * screenHeight, 0.114 * screenWidth, 0.495 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText("BUDŻET", 0.067 * screenWidth, 0.786 * screenHeight, 0.114 * screenWidth, 0.845 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText("BUDŻET", 0.327 * screenWidth, 0.436 * screenHeight, 0.374 * screenWidth, 0.495 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText("BUDŻET", 0.327 * screenWidth, 0.786 * screenHeight, 0.374 * screenWidth, 0.845 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)

	dxDrawText("GENERAŁ", 0.067 * screenWidth, 0.313 * screenHeight, 0.114 * screenWidth, 0.372 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText("GENERAŁ", 0.067 * screenWidth, 0.645 * screenHeight, 0.114 * screenWidth, 0.703 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText("GENERAŁ", 0.327 * screenWidth, 0.645 * screenHeight, 0.374 * screenWidth, 0.703 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText("GENERAŁ", 0.327 * screenWidth, 0.313 * screenHeight, 0.374 * screenWidth, 0.372 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)

	-- nacja
	dxDrawText(nacja, 0.781 * screenWidth, 0.086 * screenHeight, 0.827 * screenWidth, 0.112 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka2, "left", "top", false, false, false, true, false)
	
	-- dostepny calkowity budzet
	dxDrawText("$"..staticBudzet, 0.781 * screenWidth, 0.125 * screenHeight, 0.827 * screenWidth, 0.151 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka2, "left", "top", false, false, false, true, false)
	
	-- do rozdysponowania
	dxDrawText(budzet, 0.781 * screenWidth, 0.164 * screenHeight, 0.827 * screenWidth, 0.19 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka2, "left", "top", false, false, false, true, false)
	
	-- informacje
	dxDrawText(data.wiadomosc, 890, 278, 1187, 303, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "left", "center", false, false, false, true, false)

	-- GENERAŁY PANCERNA
	minX = 0.259 * screenWidth
	minY = 0.645 * screenHeight
	maxX = (0.046 * screenWidth) + minX
	maxY = (0.059 * screenHeight) + minY
	if(isCursorCatch(minX, minY, maxX, maxY)) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 8, 48, 246
	end

	leaderName = tostring(getElementData(leadersElement, leaderPrefix..":PANCERNA.name"))

	dxDrawRectangle(0.259 * screenWidth, 0.645 * screenHeight, 0.046 * screenWidth, 0.059 * screenHeight, tocolor(r, g, b, 150 * alpha), false)
	dxDrawText("ZMIEŃ", 0.259 * screenWidth, 0.645 * screenHeight, 0.305 * screenWidth, 0.703 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText(leaderName, 0.114 * screenWidth, 0.645 * screenHeight, 0.259 * screenWidth, 0.703 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)

	-- GENERAŁY PIECHOTA
	minX = 0.259 * screenWidth
	minY = 0.314 * screenHeight
	maxX = (0.046 * screenWidth) + minX
	maxY = (0.059 * screenHeight) + minY
	if(isCursorCatch(minX, minY, maxX, maxY)) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 8, 48, 246
	end

	leaderName = tostring(getElementData(leadersElement, leaderPrefix..":PIECHOTA.name"))

	dxDrawRectangle(0.259 * screenWidth, 0.314 * screenHeight, 0.046 * screenWidth, 0.059 * screenHeight, tocolor(r, g, b, 150 * alpha), false)
	dxDrawText("ZMIEŃ", 0.259 * screenWidth, 0.314 * screenHeight, 0.305 * screenWidth, 0.372 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText(leaderName, 0.114 * screenWidth, 0.314 * screenHeight, 0.259 * screenWidth, 0.372 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	
	-- GENERAŁY LOTNICZA
	minX = 0.519 * screenWidth
	minY = 0.314 * screenHeight
	maxX = (0.046 * screenWidth) + minX
	maxY = (0.059 * screenHeight) + minY
	if(isCursorCatch(minX, minY, maxX, maxY)) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 8, 48, 246
	end

	leaderName = tostring(getElementData(leadersElement, leaderPrefix..":LOTNICZA.name"))

	dxDrawRectangle(0.519 * screenWidth, 0.314 * screenHeight, 0.046 * screenWidth, 0.059 * screenHeight, tocolor(r, g, b, 150 * alpha), false)
	dxDrawText("ZMIEŃ", 0.519 * screenWidth, 0.314 * screenHeight, 0.565 * screenWidth, 0.371 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText(leaderName, 0.374 * screenWidth, 0.314 * screenHeight, 0.519 * screenWidth, 0.371 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)

	-- GENERAŁY TRANSPORTOWA
	minX = 0.519 * screenWidth
	minY = 0.645 * screenHeight
	maxX = (0.046 * screenWidth) + minX
	maxY = (0.059 * screenHeight) + minY
	if(isCursorCatch(minX, minY, maxX, maxY)) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 8, 48, 246
	end

	leaderName = tostring(getElementData(leadersElement, leaderPrefix..":TRANSPORTOWA.name"))

	dxDrawRectangle(0.519 * screenWidth, 0.645 * screenHeight, 0.046 * screenWidth, 0.059 * screenHeight, tocolor(r, g, b, 150 * alpha), false)
	dxDrawText("ZMIEŃ", 0.519 * screenWidth, 0.645 * screenHeight, 0.565 * screenWidth, 0.703 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)
	dxDrawText(leaderName, 0.374 * screenWidth, 0.645 * screenHeight, 0.519 * screenWidth, 0.703 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)

	
	-- ZAPISYWANIE
	minX = 0.81 * screenWidth
	minY = 0.734 * screenHeight
	maxX = (0.127 * screenWidth) + minX
	maxY = (0.065 * screenHeight) + minY
	if(isCursorCatch(minX, minY, maxX, maxY)) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 8, 48, 246
	end

	dxDrawRectangle(0.81 * screenWidth, 0.734 * screenHeight, 0.127 * screenWidth, 0.065 * screenHeight, tocolor(r, g, b, 150 * alpha), false)
	dxDrawText("ZAPISZ", 0.81 * screenWidth, 0.734 * screenHeight, 0.936 * screenWidth, 0.799 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, true, false)

	-- ANULOWANIE
	minX = 0.81 * screenWidth
	minY = 0.663 * screenHeight
	maxX = (0.127 * screenWidth) + minX
	maxY = (0.065 * screenHeight) + minY
	if(isCursorCatch(minX, minY, maxX, maxY)) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 8, 48, 246
	end

	dxDrawRectangle(0.81 * screenWidth, 0.663 * screenHeight, 0.127 * screenWidth, 0.065 * screenHeight, tocolor(r, g, b, 150 * alpha), false)
	dxDrawText("ANULUJ", 0.81 * screenWidth, 0.661 * screenHeight, 0.937 * screenWidth, 0.729 * screenHeight, tocolor(255, 255, 255, 255 * alpha), 1.00, data.czcionka1, "center", "center", false, false, false, false, false)
end

function onClick(button, state)
	if(button == "left" and state == "up") then
		if(data.visible == false) then
			-- ZAPISYWANIE
			minX = 0.81 * screenWidth
			minY = 0.734 * screenHeight
			maxX = (0.127 * screenWidth) + minX
			maxY = (0.065 * screenHeight) + minY
			if(isCursorCatch(minX, minY, maxX, maxY)) then
				if(data.ok == true) then
					local staryBudzetPiechota = tonumber(getElementData(kasaElement, "bPiechota"))
					local staryBudzetPancerna = tonumber(getElementData(kasaElement, "bPancerna"))
					local staryBudzetLotnicza = tonumber(getElementData(kasaElement, "bLotnicza"))
					local staryBudzetTransportowa = tonumber(getElementData(kasaElement, "bTransportowa"))

					local nowyBudzetPiechota = tonumber(guiGetText(GUI.piechota))
					local nowyBudzetPancerna = tonumber(guiGetText(GUI.pancerna))
					local nowyBudzetLotnicza = tonumber(guiGetText(GUI.lotnicza))
					local nowyBudzetTransportowa = tonumber(guiGetText(GUI.transportowa))

					local staryBudzetOgolem = tonumber(getElementData(kasaElement, "budzet"))

					local nowyBudzetOgolem = staryBudzetOgolem

					if(staryBudzetPiechota ~= nowyBudzetPiechota) then
						nowyBudzetOgolem = nowyBudzetOgolem - (nowyBudzetPiechota - staryBudzetPiechota)
					end

					if(staryBudzetPancerna ~= nowyBudzetPancerna) then
						nowyBudzetOgolem = nowyBudzetOgolem - (nowyBudzetPancerna - staryBudzetPancerna)
					end

					if(staryBudzetLotnicza ~= nowyBudzetLotnicza) then
						nowyBudzetOgolem = nowyBudzetOgolem - (nowyBudzetLotnicza - staryBudzetLotnicza)
					end

					if(staryBudzetTransportowa ~= nowyBudzetTransportowa) then
						nowyBudzetOgolem = nowyBudzetOgolem - (nowyBudzetTransportowa - staryBudzetTransportowa)
					end


					setElementData(kasaElement, "bPiechota", nowyBudzetPiechota)
					setElementData(kasaElement, "bPancerna", nowyBudzetPancerna)
					setElementData(kasaElement, "bLotnicza", nowyBudzetLotnicza)
					setElementData(kasaElement, "bTransportowa", nowyBudzetTransportowa)

					setElementData(kasaElement, "budzet", nowyBudzetOgolem)

					data.wiadomosc = "#00ff00Pomyślnie zmieniono ustawienia budżetu."
				else
					data.wiadomosc = "#ff0000Budżet jest ujemny. Popraw to i zapisz ponownie."
				end
			end

			-- ANULOWANIE
			minX = 0.81 * screenWidth
			minY = 0.663 * screenHeight
			maxX = (0.127 * screenWidth) + minX
			maxY = (0.065 * screenHeight) + minY
			if(isCursorCatch(minX, minY, maxX, maxY)) then
				showCursor(false)
				removeEventHandler("onClientClick", getRootElement(), onClick)
				data.czasRozpoczecia = getTickCount()
				data.state = "hiding"
				showChat(true)
				data.visible = true
			end

			-- GENERAŁY PANCERNA
			minX = 0.259 * screenWidth
			minY = 0.645 * screenHeight
			maxX = (0.046 * screenWidth) + minX
			maxY = (0.059 * screenHeight) + minY
			if(isCursorCatch(minX, minY, maxX, maxY)) then
				if(data.GUIvisible == false) then
					toggleGUIVisible()
					data.Division = 1
				end
			end

			-- GENERAŁY PIECHOTA
			minX = 0.259 * screenWidth
			minY = 0.314 * screenHeight
			maxX = (0.046 * screenWidth) + minX
			maxY = (0.059 * screenHeight) + minY
			if(isCursorCatch(minX, minY, maxX, maxY)) then
				if(data.GUIvisible == false) then
					toggleGUIVisible()
					data.Division = 0
				end
			end

			-- GENERAŁY LOTNICZA
			minX = 0.519 * screenWidth
			minY = 0.314 * screenHeight
			maxX = (0.046 * screenWidth) + minX
			maxY = (0.059 * screenHeight) + minY
			if(isCursorCatch(minX, minY, maxX, maxY)) then
				if(data.GUIvisible == false) then
					toggleGUIVisible()
					data.Division = 2
				end
			end

			-- GENERAŁY TRANSPORTOWA
			minX = 0.519 * screenWidth
			minY = 0.645 * screenHeight
			maxX = (0.046 * screenWidth) + minX
			maxY = (0.059 * screenHeight) + minY
			if(isCursorCatch(minX, minY, maxX, maxY)) then
				if(data.GUIvisible == false) then
					toggleGUIVisible()
					data.Division = 3
				end
			end

		end
	end
end

function toggleVisible()
	if(getElementData(getLocalPlayer(), "nationGeneral") ~= -1) then
		if(data.visible == false) then
			if(guiGetVisible(GUI.piechota) == false) then

				local nation = getElementData(getLocalPlayer(), "nation")
				if(nation == 0) then
					kasaElement = getElementByID("kasaROS")
				else
					kasaElement = getElementByID("kasaUSA")
				end

				guiSetText(GUI.piechota, tonumber(getElementData(kasaElement, "bPiechota")))
				guiSetText(GUI.pancerna, tonumber(getElementData(kasaElement, "bPancerna")))
				guiSetText(GUI.lotnicza, tonumber(getElementData(kasaElement, "bLotnicza")))
				guiSetText(GUI.transportowa, tonumber(getElementData(kasaElement, "bTransportowa")))


				guiSetVisible(GUI.piechota, true)
				guiSetVisible(GUI.pancerna, true)
				guiSetVisible(GUI.transportowa, true)
				guiSetVisible(GUI.lotnicza, true)
				showCursor(true)

				data.czasRozpoczecia = getTickCount()
				data.state = "starting"
				addEventHandler("onClientRender", getRootElement(), createDXElements)
				addEventHandler("onClientClick", getRootElement(), onClick)
				showChat(false)
				data.visible = true
				data.wiadomosc = ""
			else
				removeEventHandler("onClientClick", getRootElement(), onClick)
				showCursor(false)
				data.czasRozpoczecia = getTickCount()
				data.state = "hiding"
				showChat(true)
				data.visible = true
			end
		end
	end
end