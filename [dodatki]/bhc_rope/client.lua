local czasRozpoczecia
local x, y, z, dist

function zjezdzanie()
	local zGround = getGroundPosition(x, y, z)
	setPedAnimationProgress (localPlayer, "abseil", 0.97)
	setElementVelocity(localPlayer, 0, 0, -0.1)
	dxDrawLine3D(x, y, z, x, y, zGround, tocolor(0, 0, 0, 255), 2, false)
	local px, py, pz = getElementPosition(localPlayer)
	local water = testLineAgainstWater(px, py, pz, px, py, pz - 1)
	if(isPedOnGround(localPlayer) or isElementInWater(localPlayer) or water) then
		setElementData(localPlayer, "zjezdzamy", false)
		triggerServerEvent("doneSlide", localPlayer)
		removeEventHandler("onClientRender", getRootElement(), zjezdzanie)
	end

end

function render()

	local players = getElementsByType("player")
	for k,v in ipairs(players) do
		if(getElementData(v, "zjezdzamy") == true and v ~= localPlayer) then
			local table = getElementData(v, "zjezdzamy:data")
			dxDrawLine3D(table.x, table.y, table.z1, table.x, table.y, table.z2, tocolor(0, 0, 0, 255), 2, false)
		end
	end
end
addEventHandler("onClientRender", getRootElement(), render)

function zacznijZjezdzanie()
	x, y, z = getElementPosition(localPlayer)
	czasRozpoczecia = getTickCount()
	local zGround = getGroundPosition(x, y, z)
	dist = getDistanceBetweenPoints3D (x, y, z, x, y, zGround)
	setElementData(localPlayer, "zjezdzamy", true)
	local table = {}
	table.x = x
	table.y = y
	table.z1 = z
	table.z2 = zGround
	setElementData(localPlayer, "zjezdzamy:data", table)
	addEventHandler("onClientRender", getRootElement(), zjezdzanie)
end
addEvent("zacznijZjezdzanie", true)
addEventHandler("zacznijZjezdzanie", getRootElement(), zacznijZjezdzanie)

function cmdZjezdzamy()
	if(isPedInVehicle(localPlayer)) then
		local x1, y1, z1 = getElementPosition(localPlayer)
		local zGround = getGroundPosition(x1, y1, z1)

		local testDist = getDistanceBetweenPoints3D(x1, y1, z1, x1, y1, zGround)

		if(testDist > 20 and testDist < 200) then
			triggerServerEvent("prepareToSlide", localPlayer)
		else
			outputChatBox("Nieprawidłowa wysokość.")
		end
	end
end
addCommandHandler("lina", cmdZjezdzamy)
