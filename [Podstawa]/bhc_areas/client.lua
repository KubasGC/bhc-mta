local data = {}
data.state = false
data.show = false
local localPlayer = getLocalPlayer()
local screenWidth, screenHeight = guiGetScreenSize()
local czcionka = dxCreateFont("font.ttf", 25)
local czcionka2 = dxCreateFont("font.ttf", 15)

function getPlayerSector()
	local areas = getElementsByType("radararea")
	local x, y, z = getElementPosition(localPlayer)
	for k,v in ipairs(areas) do
		if(isInsideRadarArea(v, x, y)) then
			return v
		end
	end
	return false
end

function onRender()
	if(getElementData(localPlayer, "loggedIn") == 1) then

		-- aktualne konfilkty (23)

		dxDrawRectangle(0.023 * screenWidth, 0.547 * screenHeight, 0.259 * screenWidth, 0.126 * screenHeight, tocolor(0, 0, 0, 150), false)
		dxDrawText("AKTUALNE KONFLIKTY", 0.023 * screenWidth, 0.534 * screenHeight, 0.122 * screenWidth, 0.553 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
		dxDrawRectangle(0.28 * screenWidth, 0.577 * screenHeight, 0.093 * screenWidth, 0, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(0.023 * screenWidth, 0.553 * screenHeight, 0.259 * screenWidth, 0.03 * screenHeight, tocolor(0, 0, 0, 150), false)
		dxDrawText("Sektor", 0.023 * screenWidth, 0.553 * screenHeight, 0.126 * screenWidth, 0.583 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("USA", 0.219 * screenWidth, 0.553 * screenHeight, 0.272 * screenWidth, 0.583 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
		dxDrawText("ZSRR", 0.165 * screenWidth, 0.553 * screenHeight, 0.219 * screenWidth, 0.583 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
		local i = 0
		for k, v in ipairs(getElementsByType("radararea")) do
			if(getElementData(v, "capture") == true) then
				i = i + 1
				dxDrawText(getElementData(v, "name"), 0.023 * screenWidth, (0.583 * screenHeight) + ((0.03 * screenHeight) * (i - 1)), 0.126 * screenWidth, (0.613 * screenHeight) + ((0.03 * screenHeight) * (i - 1)), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
				dxDrawText(tostring(getElementData(v, "rosPkt")), 0.165 * screenWidth, (0.583 * screenHeight) + ((0.03 * screenHeight) * (i - 1)), 0.219 * screenWidth, (0.613 * screenHeight) + ((0.03 * screenHeight) * (i - 1)), tocolor(133, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
				dxDrawText(tostring(getElementData(v, "usaPkt")), 0.219 * screenWidth, (0.583 * screenHeight) + ((0.03 * screenHeight) * (i - 1)), 0.272 * screenWidth, (0.613 * screenHeight) + ((0.03 * screenHeight) * (i - 1)), tocolor(22, 84, 3, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			end
		end
		if (i == 0) then
			dxDrawText("Aktualnie nie trwają żadne konflikty.", 0.023 * screenWidth, 0.583 * screenHeight, 0.283 * screenWidth, 0.618 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		end

		-- aktualne konflikty - koniec

		local area = getPlayerSector()

		local nazwaSektoru = "###"

		if(isElement(area)) then
			nazwaSektoru = getElementData(area, "name")
		end

		local color
		if(getElementData(getLocalPlayer(), "nation") == 0) then
			color = "#FF0000"
		else
			color = "#347C2C"
		end
		dxDrawText(color.."Sektor: #FFFFFF"..nazwaSektoru, 0.86310395314788 * screenWidth, 0.825 * screenHeight, 0.85 * screenWidth, 0.96223958333333 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka2, "left", "center", false, false, false, true, false)

		if(area == false) then 
			if(data.show == true) then
				data.czasRozpoczecia = getTickCount()
				data.state = "hiding"
			else 
				return
			end
		end

		if(getElementData(area, "capture") == true) then
			if(data.show ~= true) then
				data.czasRozpoczecia = getTickCount()
				data.state = "starting"
				data.show = true
			end
		else
			if(data.state == "starting" or data.state == "showing") then
				data.czasRozpoczecia = getTickCount()
				data.state = "hiding"
			end
		end

		if(data.show == true) then
			local staticHeight = 0.628 * screenHeight
			local alpha = 255
			if(data.state == "starting") then
				local progress = (getTickCount() - data.czasRozpoczecia) / 800
				alpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")

				if(progress >= 1) then
					data.state = "showing"
				end
			end

			if(data.state == "hiding") then
				local progress = (getTickCount() - data.czasRozpoczecia) / 400
				alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "Linear")

				if(progress >= 1) then
					data.state = false
					data.show = false
				end
			end

			local nazwa, pktROS, pktUSA = "##", "#ff0000###", "#00ff00###"

			if(getElementData(area, "capture") == true) then
				nazwa = getElementData(area, "name")
				pktROS = "#ff0000"..tostring(getElementData(area, "rosPkt"))
				pktUSA = "#00ff00"..tostring(getElementData(area, "usaPkt"))
			end
			dxDrawImage(0.277 * screenWidth, staticHeight, 0.408 * screenWidth, 0.353 * screenHeight, "back.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
			dxDrawText(pktROS, 0.306 * screenWidth, staticHeight + (0.169 * screenHeight), 0.37 * screenWidth, 0.871 * screenHeight, tocolor(255, 255, 255, alpha), 1.00, czcionka, "center", "center", false, false, false, true, false)
			dxDrawText(pktUSA, 0.579 * screenWidth, staticHeight + (0.169 * screenHeight), 0.643 * screenWidth, 0.871 * screenHeight, tocolor(255, 255, 255, alpha), 1.00, czcionka, "center", "center", false, false, false, true, false)
			dxDrawText(nazwa, 0.447 * screenWidth, staticHeight + (0.085 * screenHeight), 0.512 * screenWidth, 0.775 * screenHeight, tocolor(255, 255, 255, alpha), 1.00, czcionka, "center", "center", false, false, false, true, false)
		end
	end
end
addEventHandler("onClientRender", getRootElement(), onRender)