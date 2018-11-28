local czcionka = dxCreateFont("font.ttf")
local screenWidth, screenHeight = guiGetScreenSize()
local localPlayer = getLocalPlayer()
local GUI = {}
local allowFire = false
local guiArtillerySlider = {}

function createGUI()
	local czcionka1 = guiCreateFont("font.ttf")

	GUI.okno = guiCreateWindow(0.40, 0.31, 0.21, 0.31, "Kalibracja artylerii", true)
    guiWindowSetMovable(GUI.okno, false)
    guiWindowSetSizable(GUI.okno, false)
   
    GUI.label1 = guiCreateLabel(0.13, 0.20, 0.33, 0.13, "Pozycja Alpha", true, GUI.okno)
    guiSetFont(GUI.label1, czcionka1)
    guiLabelSetHorizontalAlign(GUI.label1, "center", false)
    guiLabelSetVerticalAlign(GUI.label1, "center")

    GUI.editAlpha = guiCreateEdit(0.53, 0.20, 0.40, 0.13, "", true, GUI.okno)
   
    GUI.label2 = guiCreateLabel(0.13, 0.42, 0.33, 0.13, "Pozycja Bravo", true, GUI.okno)
    guiSetFont(GUI.label2, czcionka1)
    guiLabelSetHorizontalAlign(GUI.label2, "center", false)
    guiLabelSetVerticalAlign(GUI.label2, "center")
    
    GUI.editBravo = guiCreateEdit(0.53, 0.42, 0.40, 0.13, "", true, GUI.okno)
    
    GUI.buttonZapisz = guiCreateButton(0.33, 0.78, 0.34, 0.16, "Kalibruj", true, GUI.okno)
    GUI.buttonAnuluj = guiCreateButton(0.69, 0.87, 0.26, 0.08, "Anuluj", true, GUI.okno)    

    addEventHandler("onClientGUIClick", GUI.buttonZapisz, onClickSaveButton, false)
    addEventHandler("onClientGUIClick", GUI.buttonAnuluj, onClickCancelButton, false)

    guiSetVisible(GUI.okno, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), createGUI)

function isCursorGetPole(minX, minY, maxX, maxY)
	local cursorX, cursorY = getCursorPosition()
	cursorX, cursorY = cursorX * screenWidth, cursorY * screenHeight

	if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
		return true
	end
	return false
end

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end


function toggleGUI()
	if(guiGetVisible(GUI.okno) == false) then
		guiArtillerySlider.czasRozpoczecia = getTickCount()
		guiArtillerySlider.show = false
		guiSetVisible(GUI.okno, true)
		guiSetPosition(GUI.okno, 0.40, -0.31, true)
		addEventHandler("onClientRender", getRootElement(), slideDownArtilleryCalibrate)
	end
end

function slideDownArtilleryCalibrate()
	local progress = (getTickCount() - guiArtillerySlider.czasRozpoczecia) / 800
	local animated = interpolateBetween(-0.31, 0, 0, 0.31, 0, 0, progress, "OutBounce")

	guiSetPosition(GUI.okno, 0.40, animated, true)

	if(progress >= 1) then
		guiArtillerySlider.show = true
		removeEventHandler("onClientRender", getRootElement(), slideDownArtilleryCalibrate)
	end
end

function slideUpArtilleryCalibrate()
	local progress = (getTickCount() - guiArtillerySlider.czasRozpoczecia) / 500
	local animated = interpolateBetween(0.31, 0, 0, -0.31, 0, 0, progress, "Linear")

	guiSetPosition(GUI.okno, 0.40, animated, true)

	if(progress >= 1) then
		removeEventHandler("onClientRender", getRootElement(), slideUpArtilleryCalibrate)
		guiSetVisible(GUI.okno, false)
	end
end

function onClickSaveButton(button, state)
	if(button == "left" and state == "up" and guiArtillerySlider.show == true) then
		local posAlpha = tonumber(guiGetText(GUI.editAlpha))
		local posBravo = tonumber(guiGetText(GUI.editBravo))

		if(posAlpha and posBravo) then
			setElementData(getPedOccupiedVehicle(localPlayer), "artyleria:positionX", posAlpha)
			setElementData(getPedOccupiedVehicle(localPlayer), "artyleria:positionY", posBravo)
			setElementData(getPedOccupiedVehicle(localPlayer), "artyleria:positionZ", getGroundPosition(posAlpha, posBravo, 0))
			exports.bhc_noti:showBox("Artyleria została poprawnie skalibrowana!")
			onClickCancelButton("left", "up")
		else
			exports.bhc_noti:showBox("Wprowadziłeś niepoprawne dane!")
		end
	end
end

function onClickCancelButton(button, state)
	if(button == "left" and state == "up" and guiArtillerySlider.show == true) then
		guiArtillerySlider.czasRozpoczecia = getTickCount()
		guiArtillerySlider.show = false
		addEventHandler("onClientRender", getRootElement(), slideUpArtilleryCalibrate)
	end
end

function dxRender()
	if(isPedInVehicle(localPlayer) and isElement(getPedOccupiedVehicle(localPlayer)) and getElementModel(getPedOccupiedVehicle(localPlayer)) == 443 and getVehicleOccupant(getPedOccupiedVehicle(localPlayer)) == localPlayer) then
		
		dxDrawRectangle(0.779 * screenWidth, 0.326 * screenHeight, 0.206 * screenWidth, 0.221 * screenHeight, tocolor(0, 0, 0, 150), false)
	    dxDrawText("Menu artylerii\n(aby użyć naciśnij f3)", 0.779 * screenWidth, 0.331 * screenHeight, 0.985 * screenWidth, 0.371 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
	    
	    local veh = getPedOccupiedVehicle(localPlayer)
	    local pociski = getElementData(veh, "pociski")
	    local stan, alpha, bravo = "#00ff00 Gotowy do strzału", "#ff0000 Nie ustalone", "#ff0000 Nie ustalone"
	    local positionX, positionY = getElementData(veh, "artyleria:positionX"), getElementData(veh, "artyleria:positionY")
	    local przeladowywanie = getElementData(veh, "artyleria:reload")
	    if(przeladowywanie == nil or przeladowywanie == false) then
	    	setElementData(veh, "artyleria:reload", 0)
	    end
	    if(positionX == false or positionX == nil) then
	    	stan = "#ff0000 Artyleria nie jest skalibrowana"
	    else
	    	alpha = "#00ff00 "..positionX
	    	bravo = "#00ff00 "..positionY
	    	local rx, ry, rz = getElementRotation(veh)
	    	local x, y = getElementPosition(veh)
	    	local rot = findRotation(x, y, positionX, positionY)
	    	rz = math.floor(rz)
	    	rot = math.floor(rot)
	    	if((rz > rot and rz - rot < 3) or (rz < rot and rot - rz < 3) or (rz == rot)) then else
	    		stan = "#ff0000 Zła rotacja artylerii: "..rz.." ("..rot..")"
	    	end

	    	local dist = getDistanceBetweenPoints2D(x, y,positionX, positionY)
			if(dist < 200) then
				stan = "#ff0000 Artyleria jest za blisko celu"
			end


			if(dist > 1000) then
				stan = "#ff0000 Artyleria jest za daleko celu"
			end
	    end

	    if(przeladowywanie == 1) then
	    	stan = "#ff0000 Trwa przeładowywanie..."
	    end

	    if(tonumber(pociski)) then
		    if(tonumber(pociski) <= 0) then
		    	stan = "#ff0000 Brak pocisków"
		    end
	    else return end

	    if(stan == "#00ff00 Gotowy do strzału") then
	    	allowFire = true	
	    else
	    	allowFire = false
	    end

	    dxDrawText("STAN: "..stan, 0.79 * screenWidth, 0.385 * screenHeight, 0.978 * screenWidth, 0.419 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, true, true, false)
	    dxDrawText("Pozycja Alpha: "..alpha, 0.79 * screenWidth, 0.419 * screenHeight, 0.978 * screenWidth, 0.453 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, true, true, false)
	    dxDrawText("Pozycja Bravo: "..bravo, 0.79 * screenWidth, 0.453 * screenHeight, 0.978 * screenWidth, 0.487 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, true, true, false)
	    if(isCursorShowing()) then
		    local r, g, b
		    if(isCursorGetPole(0.79 * screenWidth, 0.493 * screenHeight, (0.79 * screenWidth) + (0.089 * screenWidth), (0.493 * screenHeight) + (0.04 * screenHeight))) then
		    	r, g, b = 05, 55, 0
		    else
		    	r, g, b = 0, 0, 238
		    end
		    dxDrawRectangle(0.79 * screenWidth, 0.493 * screenHeight, 0.089 * screenWidth, 0.04 * screenHeight, tocolor(r, g, b, 80), false)
		    if(isCursorGetPole(0.889 * screenWidth, 0.493 * screenHeight, (0.889 * screenWidth) + (0.089 * screenWidth), (0.493 * screenHeight) + (0.04 * screenHeight))) then
		    	r, g, b = 05, 55, 0
		    else
		    	r, g, b = 0, 0, 238
		    end
		    dxDrawRectangle(0.889 * screenWidth, 0.493 * screenHeight, 0.089 * screenWidth, 0.04 * screenHeight, tocolor(r, g, b, 80), false)
		    
		    dxDrawText("Kalibruj artylerię", 0.79 * screenWidth, 0.493 * screenHeight, 0.878 * screenWidth, 0.534 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
		    dxDrawText("STRZAŁ", 0.889 * screenWidth, 0.493 * screenHeight, 0.978 * screenWidth, 0.534 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
		end
	end
end
addEventHandler("onClientRender", getRootElement(), dxRender)



function onClick(button, state)
	if(button == "left" and state == "up") then
		if(isPedInVehicle(localPlayer) and getElementModel(getPedOccupiedVehicle(localPlayer)) == 443 and getVehicleOccupant(getPedOccupiedVehicle(localPlayer)) == localPlayer) then
			if(isCursorGetPole(0.79 * screenWidth, 0.493 * screenHeight, (0.79 * screenWidth) + (0.089 * screenWidth), (0.493 * screenHeight) + (0.04 * screenHeight))) then
				toggleGUI()
		    end

		    if(isCursorGetPole(0.889 * screenWidth, 0.493 * screenHeight, (0.889 * screenWidth) + (0.089 * screenWidth), (0.493 * screenHeight) + (0.04 * screenHeight))) then
		    	if(allowFire == true) then
		    		local veh = getPedOccupiedVehicle(localPlayer)
		    		local x,y,z = getElementVelocity(veh)
		    		if(x ~= 0 or y ~= 0 or z ~= 0) then
		    			exports.bhc_noti:showBox("Nie możesz strzelać w trakcie jazdy!")
		    		else
		    			triggerServerEvent("fireArtillery", root, localPlayer)
		    		end
		    	end
		    end
		end	
	end
end
addEventHandler("onClientClick", getRootElement(), onClick)

function playSound(x, y, z)
	local sound = playSound3D("fire.mp3", x, y, z, false)
	setSoundMaxDistance(sound, 300)
	setSoundVolume(sound, 0.8)
end
addEvent("playSoundArtillery", true)
addEventHandler("playSoundArtillery", getRootElement(), playSound)