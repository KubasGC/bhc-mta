local czcionka = dxCreateFont("font.ttf")
local screenWidth, screenHeight = guiGetScreenSize()
local czasOdrodzenia, time = nil, nil
local state = nil

function dxRenderVictim()
	local czas = math.floor(getTickCount() - time)
	local tekst, r, g, b = nil, 19, 36, 161
	if(czas > 10000) then
		tekst = "Możesz się odrodzić."
		local minX = 0.38360175695461 * screenWidth
		local minY = 0.51041666666667 * screenHeight
		local maxX = minX + 0.23572474377745 * screenWidth
		local maxY = minY + 0.059895833333333 * screenHeight
		local cursorX, cursorY = getCursorPosition()
		cursorX = cursorX * screenWidth
		cursorY = cursorY * screenHeight

		if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
			r, g, b = 205, 55, 0
		end
	else
		tekst = "Czas do odrodzenia: "..math.floor(10 - (czas / 1000))
	end
	if(state == "starting") then
		
	end
	dxDrawRectangle(0.31478770131772 * screenWidth, 0.23177083333333 * screenHeight, 0.3696925329429 * screenWidth, 0.41536458333333 * screenHeight, tocolor(0, 0, 0, 200), false)
    dxDrawImage(0.38360175695461 * screenWidth, 0.30729166666667 * screenHeight, 0.23572474377745 * screenWidth, 0.076822916666667 * screenHeight, "images/murder.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    dxDrawRectangle(0.38360175695461 * screenWidth, 0.51041666666667 * screenHeight, 0.23572474377745 * screenWidth, 0.059895833333333 * screenHeight, tocolor(r, g, b, 200), false)
    dxDrawText(tekst, 0.38360175695461 * screenWidth, 0.51041666666667 * screenHeight, 0.62005856515373 * screenWidth, 0.5703125 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    --dxDrawText("Możesz zostać zreanimowany.", 0.40775988286969 * screenWidth, 0.42708333333333 * screenHeight, 0.60175695461201 * screenWidth, 0.45963541666667 * screenHeight, tocolor(6, 198, 15, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
end

function getPointFromRotation(x, y)
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * 10;
    local dy = math.sin(a) * 10;
    return x+dx, y+dy;
end

function rotateCamera()
	local x,y,z=getElementPosition(getLocalPlayer())
  	local camx,camy=getPointFromRotation(x, y)
   	setCameraMatrix(camx,camy,z+5,x,y,z)
   	angle=(angle+1)%360
end

function toggleVictimMessage(toggle)
	if(toggle == 1) then
		czasOdrodzenia = 10
		time = getTickCount()
		showCursor(true)
		state = "starting"
		addEventHandler("onClientRender", getRootElement(), dxRenderVictim)
		addEventHandler("onClientClick", getRootElement(), onClick)
	else
		showCursor(false)
		state = nil
		removeEventHandler("onClientRender", getRootElement(), dxRenderVictim)
		removeEventHandler("onClientClick", getRootElement(), onClick)
	end
end
addEvent("toggleVictimMessage", true)
addEventHandler("toggleVictimMessage", getRootElement(), toggleVictimMessage)

function onClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, element)
	if(button == "left" and state=="up") then
		local minX = 0.38360175695461 * screenWidth
		local minY = 0.51041666666667 * screenHeight
		local maxX = minX + 0.23572474377745 * screenWidth
		local maxY = minY + 0.059895833333333 * screenHeight

		if(absoluteX >= minX and absoluteY >= minY and absoluteX <= maxX and absoluteY <= maxY) then
			local czas = math.floor(getTickCount() - time)
			if(czas > 10000) then
				triggerServerEvent("playerSpawn", root, getLocalPlayer())
				toggleVictimMessage(0)
			end
		end
	end
end