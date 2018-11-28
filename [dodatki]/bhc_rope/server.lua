function prepareToSlide()
	local veh = getPedOccupiedVehicle(source)
	if(isElement(veh)) then
		local gracz = getVehicleOccupant(veh)
		if(gracz ~= source) then
			removePedFromVehicle(source)
			local x, y, z = getElementPosition(source)
			setElementPosition(source, x, y, z - 1)
			setPedAnimation(source,"ped","abseil",-1,false,false, false)
			setElementFrozen(veh, true)
			setTimer(setElementFrozen, 5000, 1, veh, false)
			triggerClientEvent(source, "zacznijZjezdzanie", root)
		else
			outputChatBox("Pilot nie może zjechać po linie!", source, 255, 0, 0)
		end
	end
end
addEvent("prepareToSlide", true)
addEventHandler("prepareToSlide", getRootElement(), prepareToSlide)

function doneSlide()
	setPedAnimation(source)
end
addEvent("doneSlide", true)
addEventHandler("doneSlide", getRootElement(), doneSlide)