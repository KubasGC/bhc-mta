function isNull(zmienna)
	if(zmienna == nil or zmienna == "") then return true end
	return false
end




function cmdTo(player, command, val1)
	if(exports.bhc_admin:isAdmin(player) == false) then outputChatBox("Nie posiadasz odpowiednich uprawnień.", player) return end

	if(isNull(val1)) then
		exports.bhc_noti:showBox(player, "Użycie: /to [ID gracza]")
		return
	end

	local gracz = getElementByID("p"..tostring(val1))

	if(isElement(gracz)) then
		local x, y, z = getElementPosition(gracz)
		if(isPedInVehicle(player)) then
			setElementPosition(getPedOccupiedVehicle(player), x + 1, y + 1, z + 1)
		else
			setElementPosition(player, x + 1, y + 1, z + 1)
		end
	else
		exports.bhc_noti:showBox(player, "Nie znaleziono gracza o podanym ID.", "Błąd")
		return
	end
end
addCommandHandler("to", cmdTo)

function cmdSpawn(player, command, vehId)
	if (isNull(vehId)) then return end
	local x, y, z = getElementPosition(player);
	local vehicle = createVehicle(tonumber(vehId), x, y, z, 0, 0, 0)
	warpPedIntoVehicle(player, vehicle)
end
addCommandHandler("aveh", cmdSpawn)

function cmdTm(player, command, val1)
	if(exports.bhc_admin:isAdmin(player) == false) then outputChatBox("Nie posiadasz odpowiednich uprawnień.", player) return end

	if(isNull(val1)) then
		exports.bhc_noti:showBox(player, "Użycie: /tm [ID gracza]")
		return
	end

	local gracz = getElementByID("p"..tostring(val1))
	if(isElement(gracz)) then
		local x, y, z = getElementPosition(player)
		if(isPedInVehicle(gracz)) then
			setElementPosition(getPedOccupiedVehicle(gracz), x + 1, y + 1, z + 1)
		else
			setElementPosition(gracz, x + 1, y + 1, z + 1)
		end
	else
		outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
		return
	end
end
addCommandHandler("tm", cmdTm)

function cmdSet(player, command, val0, val1, val2)
	if(exports.bhc_admin:getAdminLevel(player) == 4 or exports.bhc_admin:getAdminLevel(player) == 3 or exports.bhc_admin:getAdminLevel(player) == 2) then
		if(isNull(val0)) then outputChatBox("SYNTAX: /set [hp | division | spawn | dLeader | punkty]", player, 163, 163, 163) return end
		if(val0 == "hp") then
			if(isNull(val1) or isNull(val2)) then
				exports.bhc_noti:showBox(player, "Użycie: /set hp [ID Gracza] [Ilość HP]")
				return
			end
			local elem = getElementByID("p"..tostring(val1))
			if(isElement(elem)) then
				setElementHealth(elem, tonumber(val2))
				outputChatBox("INFORMACJA: Ustawiłeś HP gracza na "..math.floor(tonumber(val2))..".", player, 163, 163, 163)
				outputChatBox("INFORMACJA: Administrator ustawił Ci HP na "..math.floor(tonumber(val2))..".", elem, 163, 163, 163)
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end
		elseif(val0 == "division") then
			if(isNull(val1) or isNull(val2)) then
				exports.bhc_noti:showBox(player, "Użycie: /set division [ID gracza] [dywizja]\n-1 - brak; 0 - piechota;\n1 - pancerna; 2 - lotnicza;\n3 - transportowa")
				return
			end
			local elem = getElementByID("p"..tostring(val1))
			if(isElement(elem)) then
				if(tonumber(val2) >= -1 and tonumber(val2) < 4) then
					setElementData(elem, "division:id", tonumber(val2))
					setElementData(elem, "division:leader", 0)
					setElementData(elem, "division:data", 0)
					exports.bhc_divisions:savePlayerDivision(elem)
					outputChatBox("Pomyślnie zmieniono nację graczowi.", player, 163, 163, 163)
					outputChatBox("Administrator zmienił Ci dywizję.", elem, 163, 163, 163)
				else
					outputChatBox("BŁĄD: Dywizja nie może być większa niż 3 i mniejsza niż -1!", player, 163, 163, 163)
					return
				end
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end
		elseif(val0 == "dLeader") then
			if(isNull(val1)) then
				exports.bhc_noti:showBox(player, "Użycie: /set dLeader [ID gracza]")
				return
			end
			local elem = getElementByID("p"..tostring(val1))
			if(isElement(elem)) then
				if(getElementData(elem, "division:id") == -1) then
					outputChatBox("BŁĄD: Gracz nie jest w żadnej dywizji.", player, 163, 163, 163)
					return
				end

				if(tonumber(getElementData(elem, "division:leader")) == 0) then
					setElementData(elem, "division:leader", 1)
					outputChatBox("INFORMACJA: Nadałeś graczowi lidera dywizji.", player, 163, 163, 163)
					outputChatBox("INFORMACJA: Administrator nadał Ci lidera dywizji.", elem, 163, 163, 163)
				else
					setElementData(elem, "division:leader", 0)
					outputChatBox("INFORMACJA: Odebrałeś graczowi lidera dywizji.", player, 163, 163, 163)
					outputChatBox("INFORMACJA: Administrator odebrał Ci lidera dywizji.", elem, 163, 163, 163)
				end
				exports.bhc_divisions:savePlayerDivision(elem)
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end
		elseif(val0 == "spawn") then
			if(isNull(val1) or isNull(val2)) then
				outputChatBox("SYNTAX: /set spawn [nacja] [typ] 4 - samochody; 3 - pancerne; 2 - samoloty; 5 - pozostale; 6 - smiglowce", player)
				return
			end

			local x, y, z = getElementPosition(player)
			z = z + 2
			local rotx, roty, rotz = getElementRotation(player)
			exports.DB:zapytanie("INSERT INTO `bhc_spawns` SET `nation` = '"..val1.."', `type` = '"..val2.."', `x` = '"..x.."', `y` = '"..y.."', `z` = '"..z.."', `rot` = '"..rotz.."'")
			outputChatBox("Pomyślnie.", player, 0, 255, 0)
			return
		elseif(val0 == "punkty") then
			if(isNull(val1) or isNull(val2)) then
				outputChatBox("SYNTAX: /set punkty [ID gracza] [punkty]", player, 163, 163, 163)
				return
			end
			local elem = getElementByID("p"..tonumber(val1))
			if(isElement(elem)) then
				setElementData(elem, "punkty", tonumber(val2))
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end
		end
	end
end
addCommandHandler("set", cmdSet)

function cmdToAll(player, command, ...)
	local mess = table.concat({...}, " ")
	if(mess == "") then
		exports.bhc_noti:showBox(player, "Użycie: /glob [treść]")
		return
	end
	outputChatBox("[[ "..getElementData(player, "global:name")..": "..mess.." ]]", root, 132, 34, 135)
end
addCommandHandler("glob", cmdToAll)
