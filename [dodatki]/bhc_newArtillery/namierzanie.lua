addCommandHandler("skan", function()
	if(isPedInVehicle(getLocalPlayer())) then exports.bhc_noti:showBox("Nie możesz być w pojeździe!") return end

	    if(getElementData(getLocalPlayer(), "skan") == false) then -- if false
	        setElementData(getLocalPlayer(), "skan", true)
	        local x, y, z = getElementPosition(getLocalPlayer())
	        setCameraMatrix(x, y, z + 15, x, y, z)
	        showCursor(true)
	    else -- if true
	        setElementData(getLocalPlayer(), "skan", false)
	        setCameraTarget(getLocalPlayer())
	        showCursor(false)
	    end
end)

function getPosition()
    if(getElementData(getLocalPlayer(), "skan") == true) then
        local x, y, z, rx, ry, rz = getCameraMatrix()
        if(not isChatBoxInputActive()) then
            if(getKeyState("d") == true) then
                x = x + 1
            end
            if(getKeyState("a") == true) then
                x = x - 1
            end
            if(getKeyState("s") == true) then
                y = y - 1
            end
            if(getKeyState("w") == true) then
                y = y + 1
            end
            if(getKeyState("lshift") == true) then
                z = z + 1
            end
            if(getKeyState("lctrl") == true) then
                z = z - 1
            end
        end
        setCameraMatrix(x, y, z, x, y, rz)
    end
end
addEventHandler("onClientRender", getRootElement(), getPosition)

addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if(getElementData(getLocalPlayer(), "skan") == true) then
        if(state == "up") then
	        outputChatBox("Pozycja Alpha: "..math.floor(worldX), 0, 255, 0)
	        outputChatBox("Pozycja Bravo: "..math.floor(worldY), 0, 255, 0)
        end
    end
end)