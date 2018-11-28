function isPlayerGeneral(player)
	local i = 0
	local elem = getElementByID("divisionLeaders")
	local prefix
	if(getElementData(player, "nation") == 0) then
		prefix = "ZSRR"
	else
		prefix = "USA"
	end

	if(getElementData(elem, prefix..":PIECHOTA.guid") == getElementData(player, "charid")) then
		i = i + 1
	end

	if(getElementData(elem, prefix..":PANCERNA.guid") == getElementData(player, "charid")) then
		i = i + 1
	end

	if(getElementData(elem, prefix..":LOTNICZA.guid") == getElementData(player, "charid")) then
		i = i + 1
	end

	if(getElementData(elem, prefix..":TRANSPORTOWA.guid") == getElementData(player, "charid")) then
		i = i + 1
	end

	if(i == 0) then
		return false
	else
		return true
	end
end

function getDivisionName(dywizja)
	local name = "brak"
	if(dywizja == 0) then
		name = "piechota"
	elseif(dywizja == 1) then
		name = "pancerna"
	elseif(dywizja == 2) then
		name = "lotnicza"
	elseif(dywizja == 3) then
		name = "transportowa"
	end
	return name
end

function onClientTrigger(player, division, playerID)
	if(isElement(player)) then
		local playerID = getElementByID("p"..playerID)
		if(isElement(playerID)) then
			if(getElementData(playerID, "nation") == getElementData(player, "nation")) then
				if(isPlayerGeneral(playerID)) then
					exports.bhc_noti:showBox(player, "Ten gracz jest już generałem innej dywizji.")
				else
					if(division >= 0 and division < 4) then
						setElementData(playerID, "division", division)
						local elem = getElementByID("divisionLeaders")
						local prefix
						local name = getPlayerName(playerID)
						name = name:gsub("_", " ")
						if(getElementData(player, "nation") == 0) then
							prefix = "ZSRR"
						else
							prefix = "USA"
						end

						if(division == 0) then
							setElementData(elem, prefix..":PIECHOTA.guid", getElementData(playerID, "charid"))
							setElementData(elem, prefix..":PIECHOTA.name", name)
						elseif(division == 1) then
							setElementData(elem, prefix..":PANCERNA.guid", getElementData(playerID, "charid"))
							setElementData(elem, prefix..":PANCERNA.name", name)
						elseif(division == 2) then
							setElementData(elem, prefix..":LOTNICZA.guid", getElementData(playerID, "charid"))
							setElementData(elem, prefix..":LOTNICZA.name", name)
						elseif(division == 3) then
							setElementData(elem, prefix..":TRANSPORTOWA.guid", getElementData(playerID, "charid"))
							setElementData(elem, prefix..":TRANSPORTOWA.name", name)
						end

						exports.bhc_noti:showBox(player, "Nadałeś generała dywizji graczowi.")
						exports.bhc_noti:showBox(playerID, "Zostałeś mianowany generałem dywizji ("..getDivisionName(division)..") przez generała nacji.")
					else
						exports.bhc_noti:showBox(player, "Błąd wewnętrzny. Sorry.")
					end
				end
			else
				exports.bhc_noti:showBox(player, "Gracz należy do innej nacji.")
			end
		else
			exports.bhc_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
		end
	end
end
addEvent("onClientTrigger", true)
addEventHandler("onClientTrigger", getRootElement(), onClientTrigger)