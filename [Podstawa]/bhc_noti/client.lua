local czasRozpoczecia, czas2, state, tekst, dzwiek, nextTekst, tekstInfo, nextTekstInfo = nil, nil, nil, nil, nil, nil, nil, nil
local sW, sH = guiGetScreenSize()
local font1 = dxCreateFont("font1.ttf", 15)
local font2 = dxCreateFont("font2.ttf", 9)

function render()
	if(state ~= nil) then
		if(dzwiek == nil) then
			local sound = playSound ("bip.mp3")
   			setSoundVolume (sound, 0.8)
   			dzwiek = true
		end
		local animateY = 30
		if(getTickCount() - czasRozpoczecia > 5000 and state == "showing") then
			czas2 = getTickCount()
			state = "hiding"
		end
		if(state == "starting") then
			local progress = (getTickCount() - czas2) / 1000
			animateY = interpolateBetween(-123, 0, 0, 30, 0, 0, progress, "OutElastic")

			if(progress >= 1) then
				state = "showing"
				czas2 = nil
			end
		end
		if(state == "hiding") then
			local progress = (getTickCount() - czas2) / 500
			animateY = interpolateBetween(30, 0, 0, -123, 0, 0, progress, "Linear")

			if(progress >= 1) then
				if(nextTekst ~= nil) then
					state = "starting"
					czasRozpoczecia = getTickCount()
					czas2 = getTickCount()
					tekst = nextTekst
					tekstInfo = nextTekstInfo
					nextTekst = nil
					dzwiek = nil
				else
					state = nil
					czasRozpoczecia = nil
					czas2 = nil
					tekst = nil
					dzwiek = nil
				end
				return
			end
		end
		dxDrawImage(sW / 2 - 258, animateY, 516, 123, "noti.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText(tekstInfo == nil and "Informacja" or tekstInfo, sW / 2 - 135 + 2, animateY + 13, sW / 2 + 220 + 4, animateY + 13 + 25, tocolor(0, 0, 0, 180), 1.00, font1, "left", "top", true, false, true, false, false)
		dxDrawText(tekstInfo == nil and "Informacja" or tekstInfo, sW / 2 - 135, animateY + 13, sW / 2 + 220, animateY + 13 + 25, tocolor(255, 255, 255, 255), 1.00, font1, "left", "top", true, false, true, false, false)

		dxDrawText(tekst, sW / 2 - 135, animateY + 50, sW / 2 + 220, animateY + 55 + 57, tocolor(255, 255, 255, 150), 1.00, font2, "left", "top", true, true, true, false, false)
	end
end
addEventHandler("onClientRender", getRootElement(), render)

function showBox(str, infoHeader)
	if(state == nil) then
		tekst = str
		tekstInfo = infoHeader
		czasRozpoczecia = getTickCount()
		czas2 = getTickCount()
		state = "starting"
	elseif(nextTekst == nil) then
		nextTekst = str
		nextTekstInfo = infoHeader
	end
end
addEvent("showBox", true)
addEventHandler("showBox", getRootElement(), showBox)