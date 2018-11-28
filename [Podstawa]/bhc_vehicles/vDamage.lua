function receiveDamageVeh(attacker, weapon, loss, x, y, z, tyre)
	if(tyre == nil and weapon) then
		if(weapon ~= 51 and weapon ~= 35 and (getElementModel(source) == 447 and weapon ~= 30 and weapon ~= 31)) then
			cancelEvent()
		end
	end
end
addEventHandler("onClientVehicleDamage", root, receiveDamageVeh)