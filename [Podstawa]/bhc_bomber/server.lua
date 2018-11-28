local Rocket = {}
local rocketUID = 1

function createRocket(player)
	local tablica = {}

	local x, y, z 		= getElementPosition(getPedOccupiedVehicle(player))
	local rx, ry, rz 	= getElementRotation(getPedOccupiedVehicle(player))
	local lx, ly, lz 	= getElementVelocity(getPedOccupiedVehicle(player))

	tablica.uid 		= rocketUID
	tablica.player 		= player
	tablica.object		= createObject(3786, x, y, z - 1, rx, ry, rz)
	tablica.veh			= createVehicle(520, x, y, z - 1, rx, ry, rz)
	tablica.timer 		= setTimer(checkRocket, 200, 0, tablica.uid)

	setElementAlpha(tablica.veh, 0)
	setElementVelocity(tablica.veh, lx, ly, lz - 0.1)
	attachElements(tablica.object, tablica.veh, 0, 0, 0, 0, 0, 270)

	table.insert(Rocket, tablica)

	rocketUID = rocketUID + 1

end
addCommandHandler("witamdupa", createRocket)

function getRocketTable(rocketUID)
	for k, v in ipairs(Rocket) do
		if(v.uid == rocketUID) then return k end
	end
	return false
end

function checkRocket(rocketUID)
	local rocketKey = getRocketTable(rocketUID)

	local lx, ly, lz = getElementVelocity(Rocket[rocketKey].veh)

	local px, py, pz = getElementPosition(Rocket[rocketKey].player)
	local ox, oy, oz = getElementPosition(Rocket[rocketKey].veh)

	-- local dist = getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz)

	-- outputChatBox(lz)

	if(tonumber(lz) > 0 --[[and dist > 20]]) then
		if(isTimer(Rocket[rocketKey].timer)) then
			killTimer(Rocket[rocketKey].timer)
		end
		destroyRocket(rocketUID)
	end
end


function destroyRocket(rocketUID)
	local rocketKey = getRocketTable(rocketUID)

	local x, y, z = getElementPosition(Rocket[rocketKey].object)

	destroyElement(Rocket[rocketKey].object)
	destroyElement(Rocket[rocketKey].veh)

	createExplosion(x, y, z, 2, Rocket[rocketKey].player)
	createExplosion(x-2, y-2, z, 2, Rocket[rocketKey].player)
	createExplosion(x+2, y-2, z, 2, Rocket[rocketKey].player)
	createExplosion(x+2, y+2, z, 2, Rocket[rocketKey].player)
	createExplosion(x-2, y+2, z, 2, Rocket[rocketKey].player)
	createExplosion(x+3, y+5, z, 2, Rocket[rocketKey].player)

	table.remove(Rocket, rocketKey)
end
