local font = dxCreateFont("font.ttf", 15)
local screenWidth, screenHeight = guiGetScreenSize()
function onRender()
	if(tonumber(getElementData(localPlayer, "nation"))) then

		local nation = tonumber(getElementData(localPlayer, "nation"))

		if(nation == 0) then
			local elem = getElementByID("economyROS")
			dxDrawText("#ff0000Punkty nacji: #ffffff"..getElementData(elem, "budzet"), 0.047 * screenWidth, 0.939 * screenHeight, 0.254 * screenWidth, 0.977 * screenHeight, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, true, false)
		else
			local elem = getElementByID("economyUSA")
			dxDrawText("#347C2CPunkty nacji: #ffffff"..getElementData(elem, "budzet"), 0.047 * screenWidth, 0.939 * screenHeight, 0.254 * screenWidth, 0.977 * screenHeight, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, true, false)
		end

	end
end
addEventHandler("onClientRender", root, onRender)