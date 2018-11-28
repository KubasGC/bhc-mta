local gun = {}
local screenWidth, screenHeight = guiGetScreenSize()
function createGun()
	gun[source] = createWeapon("minigun", 0, 0, 0)
	attachElements(gun[source], source, 0, 0, 2.5)
	setWeaponState(gun[source], "firing")
	setWeaponProperty(gun[source], "weapon_range", 5000.0)
	setWeaponProperty(gun[source], "target_range", 5000.0)
	setWeaponProperty(gun[source], "weapon_range", 5000.0)
	setWeaponProperty(gun[source], "damage", 45)
	setWeaponFlags(gun[source], "shoot_if_out_of_range", true)
	setElementAlpha(gun[source], 0)
end
addEvent("createGun", true)
addEventHandler("createGun", getRootElement(), createGun)


function weapFire(veh)

end

function wepStopFire(veh)

end

function setWeaponPosy(x, y, z)
	setWeaponTarget(gun[source], x, y, z)
end
addEvent("setWeaponPosy", true)
addEventHandler("setWeaponPosy", getRootElement(), setWeaponPosy)

function getPointFromDistanceRotation(x, y, dist, angle) --credits to robhol from wiki snippets
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end


function renderImage()
	if(getPedOccupiedVehicle(getLocalPlayer()) ~= false) then
		local seat = getVehicleOccupants(getPedOccupiedVehicle(getLocalPlayer()))
		if(getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 601 and seat[0] == getLocalPlayer()) then
			dxDrawImage(0.43 * screenWidth, 0.415364583 * screenHeight, 0.12890625 * screenWidth, 0.201822916 * screenHeight, ":bhc_plot/celownik.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
	end
end
addEventHandler("onClientRender", getRootElement(), renderImage)


function timer()
	if(getPedOccupiedVehicle(getLocalPlayer()) ~= false) then
		local seat = getVehicleOccupants(getPedOccupiedVehicle(getLocalPlayer()))
		if(getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 601 and seat[0] == getLocalPlayer()) then
			local x, y, z = getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 200)
			local x1, y1, z1 = getElementPosition(getPedOccupiedVehicle(getLocalPlayer()))
			local dist = getDistanceBetweenPoints3D (x, y, z, x1, y1, z1)
			if(dist > 3) then
				triggerServerEvent("setWeap", root, getPedOccupiedVehicle(getLocalPlayer()), x, y, z)
			end
		end
	end
end
setTimer(timer, 100, 0)