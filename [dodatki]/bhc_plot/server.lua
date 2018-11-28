function cmdCV(player, command)
	local x, y, z = getElementPosition(player)
	local veh = createVehicle(601, x, y, z)
	warpPedIntoVehicle(player, veh)
	triggerClientEvent("createGun", veh)


end
addCommandHandler("cv", cmdCV)

function setWeaponPosy(veh, x, y, z)
	triggerClientEvent("setWeaponPosy", veh, x, y, z)
end
addEvent("setWeap", true)
addEventHandler("setWeap", getRootElement(), setWeaponPosy)
