local czcionka = dxCreateFont("font.ttf", 15)
local screenWidth, screenHeight = guiGetScreenSize()
function loadPunkty()
	if(getElementData(getLocalPlayer(), "loggedIn") == 1) then
		addEventHandler("onClientRender", getRootElement(),
		    function()
		    	local punkty = getElementData(getLocalPlayer(), "punkty")
		    	local color
		    	if(getElementData(getLocalPlayer(), "nation") == 0) then
		    		color = "#FF0000"
		    	else
		    		color = "#347C2C"
		    	end
		        dxDrawText(color.."Punkty: #FFFFFF"..punkty, 0.86310395314788 * screenWidth, 0.91927083333333 * screenHeight, 0.96266471449488 * screenWidth, 0.96223958333333 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, false, true, false)
		    end
		)
	else
		setTimer(loadPunkty, 1000, 1)
	end
end

addEventHandler("onClientResourceStart", getResourceRootElement(), loadPunkty)