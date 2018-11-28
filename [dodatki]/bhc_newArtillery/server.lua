local timer = {}

function getPositionInFront(veh,meters)
	local x, y, z = getElementPosition (veh)
	local a,b,r = getVehicleRotation (veh)
	x = x - math.sin(math.rad(r)) * meters
	y = y + math.cos(math.rad(r)) * meters
	return x,y,z
end

function isObjectFire(object, x, y, z)
	local x1, y1, z1 = getElementPosition(object)
	if(x1 == x and y1 == y and z1 == z) then
		createExplosion (x, y, z, 10, getElementData(object, "owner"))
		killTimer(timer[object])
		destroyElement(object)
	end
end

function setArtilleryFire(object, x, y, z, dist)
	moveObject(object, 5 * math.floor(dist), x, y, z)
	timer[object] = setTimer(isObjectFire, 200, 0, object, x, y, z)
end

function artilleryFire(player)
	local veh = getPedOccupiedVehicle(player)
	if(not veh) then return end

	if(getElementData(veh, "artyleria:reload") == 0) then
		setElementData(veh, "artyleria:reload", 1)
		setTimer(setElementData, 10000, 1, veh, "artyleria:reload", 0)

		local x, y, z  = getElementData(veh, "artyleria:positionX"), getElementData(veh, "artyleria:positionY"), getElementData(veh, "artyleria:positionZ")
		setElementData(veh, "pociski", getElementData(veh, "pociski") - 1)

		local vehX, vehY, vehZ = getElementPosition(veh)
		triggerClientEvent("playSoundArtillery", root, vehX, vehY, vehZ)
		local dist = getDistanceBetweenPoints2D(x, y, vehX, vehY)
		local x1, y1, z1 = getPositionInFront(veh, dist / 2)
		local object = createObject(354, vehX, vehY, vehZ)
		setElementData(object, "owner", player)
		setElementVelocity(veh, -0.08, -0.08, -0.05)

		local dist = math.floor(getDistanceBetweenPoints3D(vehX, vehY, vehZ, x, y, z))
		local odchylenie = math.random(math.floor(-60 * (dist / 1000)), math.floor(60 * (dist / 1000)))

		x = x + odchylenie
		y = y + odchylenie

		moveObject(object, 5 * math.floor(dist), x1, y1, z1 + (math.floor(dist) / 2))
		setTimer(setArtilleryFire, math.floor(5 * dist), 1, object, x, y, z, dist)
		
	end

end
addEvent("fireArtillery", true)
addEventHandler("fireArtillery", getRootElement(), artilleryFire)