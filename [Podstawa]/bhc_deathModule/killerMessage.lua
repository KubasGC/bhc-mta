local state, tick, time = nil, nil, 3500
local screenWidth, screenHeight = guiGetScreenSize()

function dxRenderKiller()
	local y  = 0.20442708333333 * screenHeight
	if(state == "starting") then
		local progress = (getTickCount() - tick) / 1000
		y, _, _ = interpolateBetween(0, 0, 0, y, 0, 0, progress, "OutElastic")

		if(progress >= 1) then
			state = "showing"
			tick = getTickCount()
		end
	end
	if(state == "showing") then
		if(getTickCount() - tick >= time) then
			tick = getTickCount()
			state = "hiding"
		end
	end

	if(state == "hiding") then
		local progress = (getTickCount() - tick) / 200
		y, _, _ = interpolateBetween(y, 0, 0, -10, 0, 0, progress, "Linear")

		if(progress >= 1) then
			state = nil
			tick = nil
			removeEventHandler("onClientRender", getRootElement(), dxRenderKiller)
		end
	end
	dxDrawImage(0.24743777452416 * screenWidth, y, 0.46632503660322 * screenWidth, 0.063802083333333 * screenHeight, "images/kill.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

function toggleKillPlayer(toggle)
	if(toggle == 0) then
		if(state ~= nil) then
			
		end
	else
		if(state == nil) then
			tick = getTickCount()
			state = "starting"
			addEventHandler("onClientRender", getRootElement(), dxRenderKiller)
		else
			if(state ~= "starting") then
				tick = getTickCount()
			end
		end
	end
end
addEvent("toggleKillPlayer", true)
addEventHandler("toggleKillPlayer", getRootElement(), toggleKillPlayer)
