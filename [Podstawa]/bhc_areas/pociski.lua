--[[
*
*	Autor: Kubas
*	Skrypt: BrotherHoodCombat.pl
*	Moduł: bhc_areas
*
*
*	Funkcje odpowiadające za ładowanie pojazdów pociskami
*			All Rights Reserverd
]]--


function zaladuj(player, veh)
	exports.bhc_noti:showBox(player, "Pomyślnie załadowano pociski")
	setElementData(veh, "pociski", 5)
	setElementFrozen(veh, false)
end


function cmdZaladuj(player, command)
	if(isPedInVehicle(player)) then
		local nation = getElementData(player, "nation")
		local vehicle = getPedOccupiedVehicle(player)
		if(getPedOccupiedVehicleSeat(player) == 0) then
			local area = exports.bhc_areas:getPlayerArea(player)
			if(isElement(area)) then
				if(nation == 0) then
					--if(getElementData(area, "id") == 49) then
						exports.bhc_noti:showBox(player, "Ładowanie pocisków...")
						setElementFrozen(vehicle, true)
						setTimer(zaladuj, 7000, 1, player, vehicle)
					--else
					--	exports.bhc_noti:showBox(player, "Możesz załadować pociski tylko w bazie!")
					--end
				elseif(nation == 1) then
					--if(getElementData(area, "id") == 16) then
						exports.bhc_noti:showBox(player, "Ładowanie pocisków...")
						setElementFrozen(vehicle, true)
						setTimer(zaladuj, 7000, 1, player, vehicle)
					--else
					--	exports.bhc_noti:showBox(player, "Możesz załadować pociski tylko w bazie!")
					--end
				end
			else
				exports.bhc_noti:showBox(player, "Możesz załadować pociski tylko w bazie!")
			end
		else
			exports.bhc_noti:showBox(player, "Musisz siedzieć jako kierowca, aby móc załadować pojazd")
		end
	end
end
addCommandHandler("zaladuj", cmdZaladuj)
