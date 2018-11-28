local czcionka = dxCreateFont("font.ttf")
local wyborTyp, wyborPojazd, wyborLiczba  = nil, nil, 0
local screenWidth, screenHeight = guiGetScreenSize()
local pojazdy = {}
local pojazdyAll = {}
local block = false

function localAllPojazdy(Samochody, Pancerne, Smiglowce, Samoloty, Pozostale)
	pojazdyAll["Samochody"] = Samochody
	pojazdyAll["Pancerne"] = Pancerne
	pojazdyAll["Smiglowce"] = Smiglowce
	pojazdyAll["Samoloty"] = Samoloty
	pojazdyAll["Pozostale"] = Pozostale
end
addEvent("getAllVehicles", true)
addEventHandler("getAllVehicles", getRootElement(), localAllPojazdy)

function loadPojazdy(typ)
	local zmienna
	if(typ == 1) then
		zmienna = pojazdyAll["Samochody"]
	end

	if(typ == 2) then
		zmienna = pojazdyAll["Pancerne"]
	end

	if(typ == 3) then
		zmienna = pojazdyAll["Smiglowce"]
	end

	if(typ == 4) then
		zmienna = pojazdyAll["Samoloty"]
	end

	if(typ == 5) then
		zmienna = pojazdyAll["Pozostale"]
	end

	return zmienna
end

function toggleShow(toggle)
	if(toggle == 1) then
		addEventHandler("onClientRender", getRootElement(), renderDX)
		addEventHandler("onClientClick", getRootElement(), onClick)
		showCursor(true)
	else
		removeEventHandler("onClientRender", getRootElement(), renderDX)
		removeEventHandler("onClientClick", getRootElement(), onClick)
		wyborTyp, wyborPojazd, wyborLiczba  = nil, nil, 0
		showCursor(false)
	end
end
addEvent("toggleShow", true)
addEventHandler("toggleShow", getRootElement(), toggleShow)

function renderDX()
	local lenght, minX, minY, maxX, maxY, r, g, b
	local cursorX, cursorY = getCursorPosition()
    cursorX, cursorY = cursorX * screenWidth, cursorY * screenHeight
    local rrec, grec, brec = 110, 197, 57
    minX = 0.59516837481698 * screenWidth
    minY = 0.16536458333333 * screenHeight
    maxX = minX + (0.086383601756955 * screenWidth)
    maxY = minY + (0.048177083333333 * screenHeight)
    if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
    	rrec, grec, brec = 205, 55, 0
    end
    dxDrawRectangle(0.2642752562225476 * screenWidth, 0.2135416666666667 * screenHeight, 0.4172767203513909 * screenWidth, 0.05859375 * screenHeight, tocolor(0, 0, 0, 130), false)
    dxDrawRectangle(0.59516837481698 * screenWidth, 0.16536458333333 * screenHeight, 0.086383601756955 * screenWidth, 0.048177083333333 * screenHeight, tocolor(rrec, grec, brec, 150), true)
    dxDrawText("Zamknij", 0.59443631039531 * screenWidth, 0.16276041666667 * screenHeight, 0.68155197657394 * screenWidth, 0.21354166666667 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
    -- samochody
    r, g, b = 255, 255, 255
	
	lenght = dxGetTextWidth ("SAMOCHODY", 1, czcionka)
	minX = 0.285 * screenWidth
	minY = 0.23 * screenHeight
	maxX = minX + lenght
	maxY = minY + (0.020833333333333 * screenHeight)

	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		r, g, b = 16, 78, 139
	end
	if(wyborTyp == 1) then
		r, g, b = 154, 205, 50
	end
	dxDrawText("SAMOCHODY", 0.2715959004392387 * screenWidth, 0.2317708333333333 * screenHeight, 0.3521229868228404 * screenWidth, 0.2526041666666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, true, false, false)
	
	-- pancerne
	r, g, b = 255, 255, 255
	lenght = dxGetTextWidth ("PANCERNE", 1, czcionka)
	minX = 0.36552798682 * screenWidth
	minY = 0.23 * screenHeight
	maxX = minX + lenght
	maxY = minY + (0.020833333333333 * screenHeight)
	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		r, g, b = 16, 78, 139
	end
	if(wyborTyp == 2) then
		r, g, b = 154, 205, 50
	end
	dxDrawText("PANCERNE", 0.3521229868228404 * screenWidth, 0.2317708333333333 * screenHeight, 0.4326500732064422 * screenWidth, 0.2526041666666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, true, false, false)
	
	-- śmigłowce
	r, g, b = 255, 255, 255
	lenght = dxGetTextWidth ("ŚMIGŁOWCE", 1, czcionka)
	minX = 0.4460550732 * screenWidth
	minY = 0.23 * screenHeight
	maxX = minX + lenght
	maxY = minY + (0.020833333333333 * screenHeight)
	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		r, g, b = 16, 78, 139
	end
	if(wyborTyp == 3) then
		r, g, b = 154, 205, 50
	end	
	dxDrawText("ŚMIGŁOWCE", 0.4326500732064422 * screenWidth, 0.2317708333333333 * screenHeight, 0.5131771595900439 * screenWidth, 0.2526041666666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, true, false, false)
	
	-- samoloty
	r, g, b = 255, 255, 255
	lenght = dxGetTextWidth ("SAMOLOTY", 1, czcionka)
	minX = 0.52658215959 * screenWidth
	minY = 0.23 * screenHeight
	maxX = minX + lenght
	maxY = minY + (0.020833333333333 * screenHeight)
	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		r, g, b = 16, 78, 139
	end
	if(wyborTyp == 4) then
		r, g, b = 154, 205, 50
	end
	dxDrawText("SAMOLOTY", 0.5131771595900439 * screenWidth, 0.2317708333333333 * screenHeight, 0.5937042459736457 * screenWidth, 0.2526041666666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, true, false, false)
	
	-- pozostałe
	r, g, b = 255, 255, 255
	lenght = dxGetTextWidth ("POZOSTAŁE", 1, czcionka)
	minX = 0.60710924597 * screenWidth
	minY = 0.23 * screenHeight
	maxX = minX + lenght
	maxY = minY + (0.020833333333333 * screenHeight)
	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		r, g, b = 16, 78, 139
	end
	if(wyborTyp == 5) then
		r, g, b = 154, 205, 50
	end
	dxDrawText("POZOSTAŁE", 0.5937042459736457 * screenWidth, 0.2317708333333333 * screenHeight, 0.6742313323572474 * screenWidth, 0.2526041666666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, true, false, false)

	if(wyborTyp ~= nil) then
		dxDrawRectangle(0.26427525622255 * screenWidth, 0.27213541666667 * screenHeight, 0.41727672035139 * screenWidth, 0.2578125 * screenHeight, tocolor(0, 0, 0, 180), false)
        dxDrawRectangle(0.27159590043924 * screenWidth, 0.28515625 * screenHeight, 0.40263543191801 * screenWidth, 0.23177083333333 * screenHeight, tocolor(0, 0, 0, 180), false)
        dxDrawText("NAZWA POJAZDU", 0.28989751098097 * screenWidth, 0.29817708333333 * screenHeight, 0.59809663250366 * screenWidth, 0.31640625 * screenHeight , tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
        dxDrawText("CENA", 0.59809663250366 * screenWidth, 0.29817708333333 * screenHeight, 0.66691068814056 * screenWidth, 0.31640625 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
	

        local tablica = loadPojazdy(wyborTyp)
        local i = 0
        for k, v in ipairs(tablica) do
        	i = i + 1
        	if(k == 1) then
        		r, g, b = 255, 255, 255
        		lenght = dxGetTextWidth (tostring(v.name), 1, czcionka)
        		minX = 0.28989751098097 * screenWidth
	    		minY = 0.32942708333333 * screenHeight
	    		maxX = minX + lenght
	    		maxY = minY + (0.02 * screenHeight)
	    		if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
					r, g, b = 16, 78, 139
				end
				if(wyborPojazd == k) then
					r, g, b = 154, 205, 50
				end
	        	dxDrawText(tostring(v.name), 0.28989751098097 * screenWidth, 0.32942708333333 * screenHeight, 0.59809663250366 * screenWidth, 0.35416666666667 * screenHeight , tocolor(r, g, b, 255), 1.00, czcionka, "left", "center", false, false, true, false, false)
	        	dxDrawText("$"..tostring(v.price), 0.59809663250366 * screenWidth, 0.32942708333333 * screenHeight, 0.66691068814056 * screenWidth, 0.35416666666667 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
	        else
	        	r, g, b = 255, 255, 255
	        	lenght = dxGetTextWidth (tostring(v.name), 1, czcionka)
	        	minX = 0.28989751098097 * screenWidth
	    		minY = 0.32942708333333 * screenHeight + ((0.024739583333333 * screenHeight) * (k - 1))
	    		maxX = minX + lenght
	    		maxY = minY + (0.02 * screenHeight)
	    		if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
					r, g, b = 16, 78, 139
				end
				if(wyborPojazd == k) then
					r, g, b = 154, 205, 50
				end
	        	dxDrawText(tostring(v.name), 0.28989751098097 * screenWidth, 0.32942708333333 * screenHeight + ((0.024739583333333 * screenHeight) * (k - 1)), 0.59809663250366 * screenWidth, 0.35416666666667 * screenHeight + ((0.024739583333333 * screenHeight) * (k - 1)), tocolor(r, g, b, 255), 1.00, czcionka, "left", "center", false, false, true, false, false)
	        	dxDrawText("$"..tostring(v.price), 0.59809663250366 * screenWidth, 0.32942708333333 * screenHeight + ((0.024739583333333 * screenHeight) * (k - 1)), 0.66691068814056 * screenWidth, 0.35416666666667 * screenHeight + ((0.024739583333333 * screenHeight) * (k - 1)), tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
	        end

	        if(wyborPojazd ~= nil and wyborPojazd == k) then
	        	local r1, g1, b1 = 0, 11, 255
	        	minX = 0.56954612005857 * screenWidth
		    	minY = 0.52994791666667 * screenHeight
		    	maxX = minX + (0.11200585651537 * screenWidth)
		    	maxY = minY + (0.05078125 * screenHeight)
		    	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		    		r1, g1, b1 = 205, 55, 0
		    	end
	        	dxDrawRectangle(0.26427525622255 * screenWidth, 0.52994791666667 * screenHeight, 0.2108345534407 * screenWidth, 0.23567708333333 * screenHeight, tocolor(0, 0, 0, 180), false)
	        	dxDrawText("Nazwa pojazdu: "..tostring(v.name).."\nCena: $"..tostring(v.price), 0.28989751098097 * screenWidth, 0.54296875 * screenHeight, 0.45754026354319 * screenWidth, 0.7265625 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
       			dxDrawRectangle(0.56954612005857 * screenWidth, 0.52994791666667 * screenHeight, 0.11200585651537 * screenWidth, 0.05078125 * screenHeight, tocolor(r1, g1, b1, 150), true)
        		local text = "Wybierz pojazd"
        		if(block == true) then
        			text = "Poczekaj"
        		end
        		dxDrawText("Wybierz pojazd", 0.5688140556369 * screenWidth, 0.52864583333333 * screenHeight, 0.68155197657394 * screenWidth, 0.58072916666667 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
	        end

        end
        if(i == 0) then
        	dxDrawText("Dywizja, w której jesteś nie posiada pojazdów tego typu.", 0.28989751098097 * screenWidth, 0.32942708333333 * screenHeight, 0.59809663250366 * screenWidth, 0.35416666666667 * screenHeight , tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, true, false, false)
        end
        if(wyborLiczba ~= i) then
        	wyborLiczba = i
    	end
	end
end

function onClick(button, state, x, y, worldX, worldY, worldZ, clickedElement)
	if(button == "left" and state == "up") then
		local minX, minY, maxX, maxY, lenght
		-- samochody
		lenght = dxGetTextWidth ("SAMOCHODY", 1, czcionka)
		minX = 0.285 * screenWidth
		minY = 0.23 * screenHeight
		maxX = minX + lenght
		maxY = minY + (0.020833333333333 * screenHeight)
		if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
			wyborTyp = 1
			wyborPojazd = nil
			return
		end
		
		-- pancerne
		lenght = dxGetTextWidth ("PANCERNE", 1, czcionka)
		minX = 0.36552798682 * screenWidth
		minY = 0.23 * screenHeight
		maxX = minX + lenght
		maxY = minY + (0.020833333333333 * screenHeight)
		if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
			wyborTyp = 2
			wyborPojazd = nil
			return
		end
		--śmigłowce
		lenght = dxGetTextWidth ("ŚMIGŁOWCE", 1, czcionka)
		minX = 0.4460550732 * screenWidth
		minY = 0.23 * screenHeight
		maxX = minX + lenght
		maxY = minY + (0.020833333333333 * screenHeight)
		if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
			wyborTyp = 3
			wyborPojazd = nil
			return
		end
		-- samoloty
		lenght = dxGetTextWidth ("SAMOLOTY", 1, czcionka)
		minX = 0.52658215959 * screenWidth
		minY = 0.23 * screenHeight
		maxX = minX + lenght
		maxY = minY + (0.020833333333333 * screenHeight)
		if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
			wyborTyp = 4
			wyborPojazd = nil
			return
		end
		-- pozostale
		lenght = dxGetTextWidth ("POZOSTAŁE", 1, czcionka)
		minX = 0.60710924597 * screenWidth
		minY = 0.23 * screenHeight
		maxX = minX + lenght
		maxY = minY + (0.020833333333333 * screenHeight)
		if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
			wyborTyp = 5
			wyborPojazd = nil
			return
		end

		-- ten no zamykanie
		minX = 0.59516837481698 * screenWidth
	    minY = 0.16536458333333 * screenHeight
	    maxX = minX + (0.086383601756955 * screenWidth)
	    maxY = minY + (0.048177083333333 * screenHeight)
	    if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
	    	toggleShow(0)
	    	return
	    end

	    if(wyborTyp ~= nil) then
	    	if(wyborLiczba > 0) then
	    		local tablica = loadPojazdy(wyborTyp)
	    		for k, v in ipairs(tablica) do
	    			lenght = dxGetTextWidth (tostring(v.name), 1, czcionka)
	    			if(k == 1) then
	    				minX = 0.28989751098097 * screenWidth
	    				minY = 0.32942708333333 * screenHeight
	    				maxX = minX + lenght
	    				maxY = minY + (0.02 * screenHeight)
		        		if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
					    	wyborPojazd = k
					    	return
					    end
			        else
			        	minX = 0.28989751098097 * screenWidth
	    				minY = 0.32942708333333 * screenHeight + ((0.024739583333333 * screenHeight) * (k - 1))
	    				maxX = minX + lenght
	    				maxY = minY + (0.02 * screenHeight)
	    				if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
					    	wyborPojazd = k
					    	return
					    end
			        end
	    		end
	    	end
	    end

	    if(wyborPojazd ~= nil) then
	    	minX = 0.56954612005857 * screenWidth
	    	minY = 0.52994791666667 * screenHeight
	    	maxX = minX + (0.11200585651537 * screenWidth)
	    	maxY = minY + (0.05078125 * screenHeight)
	    	if(x >= minX and y >= minY and x <= maxX and y <= maxY) then
	    		if(block == true) then 
	    			outputChatBox("BŁĄD: Odczekaj chwilę, zanim nacisniesz przycisk.", 163, 163, 163)
	    			return 
	    		end
	    		blockPrzycisk()
	    		local tablica = loadPojazdy(wyborTyp)
				triggerServerEvent("takeVehicle", getLocalPlayer(), getLocalPlayer(), tablica[wyborPojazd].name, tonumber(wyborTyp))
				return
			end
	    end
	end
end

function blockPrzycisk()
	block = true
	setTimer(function()
		block = false
		
	end, 6000, 1)
end