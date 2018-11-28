function blockWeaponDamage(attacker, weapon)
	if(weapon == 35 or weapon == 19) then cancelEvent() end

	if(getElementType(attacker) == "vehicle") then
		if(getElementModel(attacker) == 447) then cancelEvent() end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, blockWeaponDamage)