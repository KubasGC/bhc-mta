local czcionka = dxCreateFont("font.ttf", 15)
local screenWidth, screenHeight = guiGetScreenSize()
local localPlayer = getLocalPlayer()

function createDXElement()
	if(isPedInVehicle(localPlayer)) then
		local veh = getPedOccupiedVehicle(localPlayer)
		if(isElement(veh)) then
			if(getElementModel(veh) == 443) then
					local pociski = getElementData(veh, "pociski")
					if(pociski == nil or pociski == false) then
						setElementData(veh, "pociski", 0)
						pociski = 0
					end
					local color
			    	if(getElementData(localPlayer, "nation") == 0) then
			    		color = "#FF0000"
			    	else
			    		color = "#347C2C"
			    	end
			    	dxDrawText(color.."Pociski: #FFFFFF"..pociski, 0.86310395314788 * screenWidth, 0.828125 * screenHeight, 0.93557833089312 * screenWidth, 0.8671875 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, false, true, false)
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), createDXElement)