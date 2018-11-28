function onPlayerIsDeath(ammo, killer, weapon, bodypart)
	if(isElement(killer) and getElementType(killer) == "player") then
		if(source ~= killer) then
			if(getElementData(source, "nation") ~= getElementData(killer, "nation")) then
			local pkts = getElementData(killer, "punkty")
			setElementData(killer, "punkty", pkts + 50)
			exports.bhc_noti:showBox(killer, "Zabiłeś gracza - dostałeś 50 punktów")
			else
				local pkts = getElementData(killer, "punkty")
				setElementData(killer, "punkty", pkts - 80)
				exports.bhc_noti:showBox(killer, "Zabiłeś gracza ze swojej nacji - dostałeś -80 punktów")
			end
		end
	end
	if(isElement(killer) and getElementType(killer) == "vehicle") then
		local player = getVehicleOccupant(killer)
		if(isElement(player) and getElementType(player) == "player") then
			local pkts = getElementData(player, "punkty")
			if(getElementData(source, "nation") == getElementData(player, "nation")) then
				setElementData(player, "punkty", pkts - 80)
				exports.bhc_noti:showBox(player, "Zabiłeś gracza ze swojej nacji - dostałeś -80 punktów")
			else
				setElementData(player, "punkty", pkts + 30)
				exports.bhc_noti:showBox(player, "Zabiłeś gracza przy użyciu pojazdu - dostałeś 30 punktów")
				if(getElementModel(getPedOccupiedVehicle(player)) == 447) then
					outputChatBox("Gracz "..string.gsub(getPlayerName(player), "_", " ").. "("..getElementData(player, "id")..") zabił gracza SeaSparrowem", root, 255, 0, 0)
				end
				
			end
			
		end
	end
	local items = getElementData(source, "items")
	if(type(items) == "table") then
		for k, v in ipairs(items) do
			if(v.use == 1) then v.use = 0 end
		end
		setElementData(source, "items", items)
	end
	setElementData(source, "iloscUzywanychBroni", 0)
end
addEventHandler("onPlayerWasted", root, onPlayerIsDeath)

function onResStart()
	setOcclusionsEnabled(false)	
end
addEventHandler("onResourceStart", resourceRoot, onResStart)

addEventHandler("onPlayerChangeNick", getRootElement(), function(oldNick, newNick)
    if(getElementData(source, "loggedIn") == 1) then
        exports.bhc_noti:showBox(source, "Nie możesz zmienić swojego nicku.", "Błąd")
    end
    cancelEvent()
end)

addEventHandler ("onPlayerQuit", getRootElement(), function(quitType, reason, elem)
	if(getElementData(source, "loggedIn") == 1) then
		destroyElement(getElementData(source, "blip"))
		local items = getElementData(source, "items")
		if(type(items) == "table") then
			for k, v in ipairs(items) do
				if(v.use == 1) then v.use = 0 end
			end
			setElementData(source, "items", items)
		end
		savePlayer(source, 1)
	end
end)

addEventHandler("onPlayerDamage", root, function(attacker, weapon, bodypart, loss)
	if(isElement(attacker)) then
		if(getElementType(attacker) == "player") then
			if(source ~= attacker) then
				if(weapon ~= 0) then
					triggerClientEvent(attacker, "onDMG", attacker)
				end
			end
		end
	end
	if(bodypart == 9) then
		killPed (source, attacker, weapon, bodypart) 
		triggerClientEvent(attacker, "onHeadshot", attacker)
	end
end)

function savePlayer(player, typ)
	if(isElement(player)) then
		if(getElementType(player) == "player" and getElementData(player, "loggedIn") == 1) then
			if(typ == 1) then --save przy wyjsciu

				local block

				if(getElementData(player, "Block") == 1) then
					block = 1
				else
					block = 0
				end
				
				exports.DB:zapytanie("UPDATE `bhc_players` SET `Online` = '0', `score` = '"..tonumber(getElementData(player, "punkty")).."', `CzasOnline` = '"..tonumber(getElementData(player, "onlineTime")).."', `dmg_head` = '"..tonumber(getElementData(player, "dmg_head")).."', `dmg_torso` = '"..tonumber(getElementData(player, "dmg_torso")).."', `dmg_larm` = '"..tonumber(getElementData(player, "dmg_larm")).."', `dmg_rarm` = '"..tonumber(getElementData(player, "dmg_rarm")).."', `dmg_lleg` = '"..tonumber(getElementData(player, "dmg_lleg")).."', `dmg_rleg` = '"..tonumber(getElementData(player, "dmg_rleg")).."', `dmg_ass` = '"..tonumber(getElementData(player, "dmg_ass")).."', `dmg` = '"..tonumber(getElementData(player, "dmg")).."', `Block` = '"..block.."' WHERE `id` = '"..getElementData(player, "charid").."'")
				exports.DB:zapytanie("DELETE FROM `all_online` WHERE`type` = '8' AND `player` = '"..getElementData(player, "charid").."'")
			end
			
			if(typ == 2) then -- save przy wejsciu
				exports.DB:zapytanie("UPDATE `bhc_players` SET `Online` = '1', `LastLog` = UNIX_TIMESTAMP() WHERE `id` = '"..getElementData(player, "charid").."'")
				exports.DB:zapytanie("INSERT INTO `all_online` SET `type` = '8', `player` = '"..getElementData(player, "charid").."', `time` = UNIX_TIMESTAMP()")
			end
		end
	end
end

function blockPM(msg,r)
	cancelEvent()
	outputChatBox("Aby wysłać prywatną wiadomość skorzystaj z komendy /w.", source)
end
addEventHandler("onPlayerPrivateMessage",getRootElement(),blockPM)