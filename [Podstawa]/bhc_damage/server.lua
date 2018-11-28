function onPDMG(attacker, weapon, bodypart, loss)
	if(isElement(attacker)) then
		if(getElementType(attacker) == "player") then
			if(bodypart == 3) then
				local fire = getElementData(attacker, "dmg_torso")
				setElementData(attacker, "dmg_torso", fire + 1)
			elseif(bodypart == 4) then
				local fire = getElementData(attacker, "dmg_ass")
				setElementData(attacker, "dmg_ass", fire + 1)
			elseif(bodypart == 5) then
				local fire = getElementData(attacker, "dmg_larm")
				setElementData(attacker, "dmg_larm", fire + 1)
			elseif(bodypart == 6) then
				local fire = getElementData(attacker, "dmg_rarm")
				setElementData(attacker, "dmg_rarm", fire + 1)
			elseif(bodypart == 7) then
				local fire = getElementData(attacker, "dmg_lleg")
				setElementData(attacker, "dmg_lleg", fire + 1)
			elseif(bodypart == 8) then
				local fire = getElementData(attacker, "dmg_rleg")
				setElementData(attacker, "dmg_rleg", fire + 1)
			elseif(bodypart == 9) then
				local fire = getElementData(attacker, "dmg_head")
				setElementData(attacker, "dmg_head", fire + 1)
			end

			local fulldmg = getElementData(attacker, "dmg")
			setElementData(attacker, "dmg", fulldmg + math.floor(loss))
		end
	end
end
addEventHandler("onPlayerDamage", root, onPDMG)