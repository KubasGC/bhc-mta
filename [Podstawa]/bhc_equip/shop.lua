local step = 0
local sW, sH = guiGetScreenSize()
local data = {}

data.yTla = 515
data.alphaTla = 150

data.alphaNawigacji = 255
data.daneTekstuY = sH / 2 - 290
data.daneTekstuAlpha = 255
data.ResztaAlpha = 255
data.toggle = false

data.select1 = nil
data.select2 = nil

data.toggleClick = false

data.tablica = {}
local alphaData = {}

function getTable(typ)
	local tablica = {}

	for k, v in ipairs(data.tablica) do
		if(typ == 3) then
			if(v.nation == getElementData(localPlayer, "nation") and v.type == 5) then
				table.insert(tablica, v)
			end
		else
			if(v.nation == getElementData(localPlayer, "nation") and v.type == typ) then
				table.insert(tablica, v)
			end
		end
	end

	if(#tablica <= 0) then return false end
	return tablica
end




function isCursorGet(minX, maxX, minY, maxY)
	if(isCursorShowing() == false) then return end
	local cursorX, cursorY = getCursorPosition()
	cursorX = cursorX * sW
	cursorY = cursorY * sH
		if(cursorX > minX and cursorX < maxX and cursorY > minY and cursorY < maxY) then
			return true
		end
	return false
end



function renderSklep()
	if(step == 0) then
		removeEventHandler("onClientRender", root, renderSklep)
		data.czasRozpoczecia = nil
		return
	elseif(step == 1) then
		if(data.czasRozpoczecia == nil) then
			data.czasRozpoczecia = getTickCount()
		end
		local progress = (getTickCount() - data.czasRozpoczecia) / 500
		data.yTla = interpolateBetween(0, 0, 0, 515, 0, 0, progress, "OutBounce")
		data.alphaTla = interpolateBetween(0, 0, 0, 150, 0, 0, progress, "Linear")

		if(progress >= 1) then
			data.czasRozpoczecia = nil
			step = step + 1
			data.alphaNawigacji = 0
		end
	elseif(step == 2) then
		if(data.czasRozpoczecia == nil) then
			data.czasRozpoczecia = getTickCount()
		end
		local progress = (getTickCount() - data.czasRozpoczecia) / 300
		data.alphaNawigacji = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")


		if(progress >= 1) then
			data.czasRozpoczecia = nil
			data.daneTekstuY = sH / 2 - 290 + 40
			data.daneTekstuAlpha = 0
			step = step + 1
		end
	elseif(step == 3) then
		if(data.czasRozpoczecia == nil) then
			data.czasRozpoczecia = getTickCount()
		end

		local progress = (getTickCount() - data.czasRozpoczecia) / 200
		data.daneTekstuY, data.daneTekstuAlpha = interpolateBetween(sH / 2 - 290 + 40, 0, 0, sH / 2 - 290, 255, 0, progress, "Linear")

		if(progress >= 1) then
			data.czasRozpoczecia = nil
			data.ResztaAlpha = 0
			step = step + 1
		end

	elseif(step == 4) then
		if(data.czasRozpoczecia == nil) then
			data.czasRozpoczecia = getTickCount()
		end

		local progress = (getTickCount() - data.czasRozpoczecia) / 500
		data.ResztaAlpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")

		if(progress >= 1) then
			data.czasRozpoczecia = nil
			step = step + 1
		end
	end

	dxDrawRectangle(0, 0, sW, sH, tocolor(255, 255, 255, data.alphaTla), true) -- białe tło

	if(step > 2) then
		dxDrawText("SKLEP", sW / 2 - 250, data.daneTekstuY, sW / 2 - 142, sH / 2 - 261, tocolor(255, 255, 255, data.daneTekstuAlpha), 1.00, "bankgothic", "left", "top", false, false, true, false, false) -- górny napis sklep
	end

	if(step > 0) then
		dxDrawRectangle(sW / 2 - 250, sH / 2 - 250, 553, data.yTla, tocolor(0, 0, 0, 200), true) -- Czarne tło sklepu
	end

	if(step > 1) then
		-- Nawigacja --
		local r, g, b
		if(isCursorGet(sW / 2 - 250 - 105, sW / 2 - 250, sH / 2 - 250, sH / 2 - 250 + 36)) then
			r, g, b = 205, 55, 0
		else
			r, g, b = 110, 197, 57
		end

		if(data.select2 == 1) then
			r, g, b = 100, 40, 50
		end
		dxDrawRectangle(sW / 2 - 250 - 105, sH / 2 - 250, 105, 36, tocolor(r, g, b, data.alphaNawigacji), true)

		if(isCursorGet(sW / 2 - 250 - 105, sW / 2 - 250, sH / 2 - 214, sH / 2 - 214 + 36)) then
			r, g, b = 205, 55, 0
		else 
			r, g, b = 110, 197, 57
		end
		if(data.select2 == 2) then
			r, g, b = 100, 40, 50
		end
		dxDrawRectangle(sW / 2 - 250 - 105, sH / 2 - 214, 105, 36, tocolor(r, g, b, data.alphaNawigacji), true)

		if(isCursorGet(sW / 2 - 250 - 105, sW / 2 - 250, sH / 2 - 178, sH / 2 - 178 + 36)) then
			r, g, b = 205, 55, 0
		else
			r, g, b = 110, 197, 57
		end
		if(data.select2 == 3) then
			r, g, b = 100, 40, 50
		end
		dxDrawRectangle(sW / 2 - 250 - 105, sH / 2 - 178, 105, 36, tocolor(r, g, b, data.alphaNawigacji), true)
		dxDrawLine(sW / 2 - 250 - 105, sH / 2 - 214, sW / 2 - 252, sH / 2 - 214, tocolor(255, 255, 255, data.alphaNawigacji), 1, true)
		dxDrawLine(sW / 2 - 250 - 105, sH / 2 - 178, sW / 2 - 252, sH / 2 - 178, tocolor(255, 255, 255, data.alphaNawigacji), 1, true)
		dxDrawText("Broń", sW / 2 - 250 - 105, sH / 2 - 250, sW / 2 - 250 - 1, sH / 2 - 250 + 36, tocolor(255, 255, 255, data.alphaNawigacji), 1.00, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("Amunicja", sW / 2 - 250 - 105, sH / 2 - 250 + 36, sW / 2 - 250 - 1, sH / 2 - 250 + 72, tocolor(255, 255, 255, data.alphaNawigacji), 1.00, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("Wyposażenie", sW / 2 - 250 - 105, sH / 2 - 250 + 72, sW / 2 - 250 - 1, sH / 2 - 250 + 36 + 72, tocolor(255, 255, 255, data.alphaNawigacji), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	end

	if(step > 3) then


		-- powitanie --
		dxDrawText("Witamy w sklepie!\n\nAby coś kupić wybierz odpowiednią kategorię po lewej stronie, zaznacz produkt i kup!", sW / 2 - 185, sH / 2 - 200, sW / 2 + 250, sH / 2 + 100, tocolor(255, 255, 255, data.ResztaAlpha), 1.00, "default-bold", "center", "top", false, false, true, false, false)

		-- legenda --
		dxDrawText("NAZWA", sW / 2 - 197, sH / 2 - 134, sW / 2 + 34, 271, tocolor(255, 255, 255, data.ResztaAlpha), 1.00, "default-bold", "left", "center", false, false, true, false, false)
		dxDrawText("CENA", sW / 2 + 86, sH / 2 - 134, sW / 2 + 212, 271, tocolor(255, 255, 255, data.ResztaAlpha), 1.00, "default-bold", "left", "center", false, false, true, false, false)


		local name_x1 = sW / 2 - 197
		local name_x2 = sW / 2 + 34
		local pkt_x1 = sW / 2 + 86
		local pkt_x2 = sW / 2 + 212

		if(getTable(data.select2) ~= false) then
			for k, v in ipairs(getTable(data.select2)) do
				local y1 = sH / 2 - 86 + (17 * (k - 1))
				local y2 = sH / 2 - 64 + (17 * (k - 1))

				local r, g, b = 255, 255, 255

				if(isCursorGet(name_x1, pkt_x2, y1 + 3, y2 - 3) and data.select1 ~= k) then
					alphaData[k] = alphaData[k] + 10
					if(alphaData[k] >= 255) then alphaData[k] = 255 end
				else
					alphaData[k] = alphaData[k] - 10
					if(alphaData[k] <= 80) then alphaData[k] = 80 end
				end

				if(data.select1 == k) then
					r, g, b = 0, 255, 0
					alphaData[k] = 255
				end

				local al
				if(data.ResztaAlpha >= 80) then
					al = alphaData[k]
				else
					al = data.ResztaAlpha
				end

				-- zawartość --
				dxDrawText(v.name, name_x1, y1, name_x2, y2, tocolor(r, g, b, al), 1.00, "default-bold", "left", "center", false, false, true, false, false)
				dxDrawText(v.price.." punktów", pkt_x1, y1, pkt_x2, y2, tocolor(r, g, b, al), 1.00, "default-bold", "left", "center", false, false, true, false, false)
			end
		else
			local y1 = sH / 2 - 86
			local y2 = sH / 2 - 64
			dxDrawText("Nie znaleziono żadnych przedmiotów tego typu.", name_x1, y1, name_x2, y2, tocolor(255, 255, 255, data.ResztaAlpha), 1.00, "default-bold", "left", "center", false, false, true, false, false)
		end

		local r, g, b
		if(isCursorGet(sW / 2 + 303 - 105, sW / 2 + 303, sH / 2 + 300 - 36, sH / 2 + 300)) then
			r, g, b = 205, 55, 0
		else
			r, g, b = 110, 197, 57
		end
		-- button zakupu --
		dxDrawRectangle(sW / 2 + 303 - 105, sH / 2 + 300 - 35, 105, 36, tocolor(r, g, b, data.ResztaAlpha), true)
		dxDrawText("Zakup", sW / 2 + 303 - 105, sH / 2 + 300 - 36, sW / 2 + 303, sH / 2 + 300, tocolor(255, 255, 255, data.ResztaAlpha), 1.00, "default-bold", "center", "center", false, false, true, false, false)


		if(isCursorGet(sW / 2 + 303 - 105, sW / 2 + 303, sH / 2 - 250 - 36, sH / 2 - 250)) then
			r, g, b = 205, 55, 0
		else
			r, g, b = 110, 197, 57
		end
		-- button anulowania --
		dxDrawRectangle(sW / 2 + 303 - 105, sH / 2 - 250 - 36, 105, 36, tocolor(r, g, b, data.ResztaAlpha), true)
		dxDrawText("Zamknij", sW / 2 + 303 - 105, sH / 2 - 250 - 36, sW / 2 + 303, sH / 2 - 250, tocolor(255, 255, 255, data.ResztaAlpha), 1.00, "default-bold", "center", "center", false, false, true, false, false)

	end
end

function onClick(button, state, absoluteX, absoluteY)
	if(data.toggle == false) then return end
	if(button == "left" and state == "up") then
		
		--[[ PRZEDMIOTY ]]--
		for k, v in ipairs(data.tablica) do
			local name_x1 = sW / 2 - 197
			local pkt_x2 = sW / 2 + 212

			local y1 = sH / 2 - 86 + (17 * (k - 1))
			local y2 = sH / 2 - 64 + (17 * (k - 1))

			if(isCursorGet(name_x1, pkt_x2, y1 + 3, y2 - 3) and data.select1 ~= k) then
				if(tonumber(data.select1)) then
					alphaData[data.select1] = 80
				end
				data.select1 = k
			end
		end

		--[[Buttony: nawigacja]]--

		-- Pierwszy:
		if(isCursorGet(sW / 2 - 250 - 105, sW / 2 - 250, sH / 2 - 250, sH / 2 - 250 + 36)) then
			data.select2 = 1
			data.select1 = nil
		end

		-- Drugi:
		if(isCursorGet(sW / 2 - 250 - 105, sW / 2 - 250, sH / 2 - 214, sH / 2 - 214 + 36)) then
			data.select2 = 2
			data.select1 = nil
		end

		-- Trzeci:
		if(isCursorGet(sW / 2 - 250 - 105, sW / 2 - 250, sH / 2 - 178, sH / 2 - 178 + 36)) then
			data.select2 = 3
			data.select1 = nil
		end

		--[[ Button: zamknij ]]--
		if(isCursorGet(sW / 2 + 303 - 105, sW / 2 + 303, sH / 2 - 250 - 36, sH / 2 - 250)) then toggleOff() end

		--[[ Button: zakup ]]--
		
		if(isCursorGet(sW / 2 + 303 - 105, sW / 2 + 303, sH / 2 + 300 - 36, sH / 2 + 300)) then
			if(data.toggleClick == true or data.select1 == nil) then return end
			local table = getTable(data.select2)
			triggerServerEvent("buyHandler", localPlayer, table[data.select1].id)
			data.toggleClick = true
		end
	end
end
addEventHandler("onClientClick", root, onClick)

function toggleOn()
	step = 1
	data.select2 = 1
	addEventHandler("onClientRender", root, renderSklep)
	data.toggle = true
	showCursor(true)
	setElementData(localPlayer, "toggleShop", true)
end

function toggleOff()
	step, data.select1, data.select2 = nil, nil, nil
	removeEventHandler("onClientRender", root, renderSklep)
	data.toggle = false
	showCursor(false)
	setElementData(localPlayer, "toggleShop", false)
end

function serverHandler(array)
	data.tablica = array

	for k, v in ipairs(data.tablica) do
		alphaData[k] = 80
	end

	if(data.toggle == false) then toggleOn()
	else toggleOff() end

end
addEvent("shopServerHandler", true)
addEventHandler("shopServerHandler", root, serverHandler)

function wylaczToggle()
	data.toggleClick = false
end
addEvent("wylaczToggle", true)
addEventHandler("wylaczToggle", root, wylaczToggle)