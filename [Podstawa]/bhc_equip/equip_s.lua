local item = {}

ITEM_TYPE_WEAPON 	= 1
ITEM_TYPE_CLIP		= 2
ITEM_TYPE_PARACHUTE	= 3
ITEM_TYPE_KEVLAR	= 4
ITEM_TYPE_APTECZKA 	= 5

function onJoin()
	bindKey(source, "i", "down", cmdItem)
end
addEventHandler("onPlayerJoin", root, onJoin)

function loadItems()
	local query = exports.DB:getArray("SELECT * FROM `bhc_items`")
	for k, v in ipairs(query) do
		local tablica = {}

		tablica.uid 		= v.id
		tablica.name		= v.name
		tablica.v1			= v.value1
		tablica.v2			= v.value2
		tablica.type		= v.type
		tablica.subtype 	= v.subtype
		tablica.owner		= v.owner
		tablica.ownerSlot	= v.ownerSlot

		table.insert(item, tablica)
	end
	outputServerLog("[ITEM] Zaladowano "..#query.." itemow graczy")

	for k, v in ipairs(getElementsByType("player")) do
		bindKey(v, "i", "down", cmdItem)
	end

end
addEventHandler("onResourceStart", resourceRoot, loadItems)

function onClientRequestDeleteItem(uid)
	local itemKey = getItemKey(uid)
	if(itemKey == false) then return end

	destroyItem(itemKey)
	updateItems(source)
end
addEvent("onClientRequestDeleteItem", true)
addEventHandler("onClientRequestDeleteItem", root, onClientRequestDeleteItem)

function isPlayerInAreaVictim(player)
	local x, y, z = getElementPosition(player)
	local elem = nil
	local areas = getElementsByType("radararea")
	for k, v in ipairs(areas) do
		if(isInsideRadarArea(v, x, y)) then 
			elem = v
			break
		end
	end
	if(elem == nil) then return false end

	local nation = getElementData(player, "nation")
	local areaUID = getElementData(elem, "id")

	if(nation == 0) then
		if(areaUID == 16 or areaUID == 15 or areaUID == 31 or areaUID == 32) then return true end
	else
		if(areaUID == 49 or areaUID == 50 or areaUID == 65 or areaUID == 66) then return true end
	end
	return false
end

function getPlayerItemBySlot(player, slot)
	for k, v in ipairs(item) do
		if(v.ownerSlot == slot and v.owner == getElementData(player, "charid")) then
			return v.uid
		end
	end
	return false
end

function createItem(player, val1, val2, type, subtype, ...)
	local name = table.concat({...}, " ")
	local tabliczka = {}

	tabliczka.name		= name
	tabliczka.v1 		= tonumber(val1)
	tabliczka.v2		= tonumber(val2)
	tabliczka.type 		= tonumber(type)
	tabliczka.subtype	= tonumber(subtype)
	tabliczka.owner 	= tonumber(getElementData(player, "charid"))
	tabliczka.ownerSlot = tonumber(getClosestPlayerSlot(player))

	local _, uid = exports.DB:zapytanie("INSERT INTO `bhc_items` SET `name`= '"..tabliczka.name.."', `value1` = '"..tabliczka.v1.."', `value2` = '"..tabliczka.v2.."', `type` = '"..tabliczka.type.."', `subtype` = '"..tabliczka.subtype.."', `owner` = '"..tabliczka.owner.."', `ownerSlot` = '"..tabliczka.ownerSlot.."'")

	tabliczka.uid = uid

	table.insert(item, tabliczka)

	updateItems(player)
end

function saveItem(key)
	if(type(item[key]) ~= "table") then return end
	exports.DB:zapytanie("UPDATE `bhc_items` SET `name` = '"..item[key].name.."', `value1` = '"..item[key].v1.."', `value2` = '"..item[key].v2.."', `type` = '"..item[key].type.."', `owner` = '"..item[key].owner.."', `ownerSlot` = '"..item[key].ownerSlot.."' WHERE `id` = '"..item[key].uid.."'")
end

function destroyItem(key)
	if(type(item[key]) ~= "table") then return end
	exports.DB:zapytanie("DELETE FROM `bhc_items` WHERE id = "..tonumber(item[key].uid))
	table.remove(item, key)
end


function getPlayerItems(player)
	local i = 0
	for k, v in ipairs(item) do
		if(v.owner == getElementData(player, "charid") and v.ownerSlot > 0) then
			i = i + 1
		end
	end
	return i
end

function getPlayerSlotItem(player, slot)
	for k, v in ipairs(item) do
		if(v.owner == getElementData(player, "charid") and v.ownerSlot == slot) then
			return v.uid
		end
	end
	return false
end

function getClosestPlayerSlot(player)
	for i=1,12 do
		if(getPlayerItemBySlot(player, i) == false) then
			return i
		end
	end
	return false
end

function createPlayerArray(player)
	local tabelka = {}
	for k, v in ipairs(item) do
		if(v.owner == getElementData(player, "charid") and v.ownerSlot > 0) then
			table.insert(tabelka, v)
		end
	end
	return tabelka
end

function getItemKey(uid)
	for k, v in ipairs(item) do
		if(v.uid == uid) then
			return k
		end
	end
	return false
end

function itemCombine(player, uid)
	local itemKey = getItemKey(tonumber(uid))

	if(item[itemKey].type == ITEM_TYPE_WEAPON and item[itemKey].subtype == 1) then
		if(item[itemKey].ownerSlot == 13) then
			giveWeapon(player, item[itemKey].v1, item[itemKey].v2, true)
		else
			takeWeapon(player, item[itemKey].v1)
		end
	end

	if(item[itemKey].type == ITEM_TYPE_WEAPON and item[itemKey].subtype == 2) then
		if(item[itemKey].ownerSlot == 14) then
			giveWeapon(player, item[itemKey].v1, item[itemKey].v2, true)
		else
			takeWeapon(player, item[itemKey].v1)
		end
	end
end

function clip(clipUID, weaponUID)
	local itemKeyClip = getItemKey(tonumber(clipUID))
	local itemKeyWeapon = getItemKey(tonumber(weaponUID))

	item[itemKeyWeapon].v2 = item[itemKeyWeapon].v2 + item[itemKeyClip].v2

	if(item[itemKeyWeapon].ownerSlot > 12) then
		setWeaponAmmo(source, item[itemKeyWeapon].v1, item[itemKeyWeapon].v2)
	end

	destroyItem(itemKeyClip)

	triggerClientEvent(source, "setDataTable", source, createPlayerArray(source))
	triggerClientEvent(source, "setToggleFalse", source)
	saveItem(itemKeyWeapon)

end
addEvent("clipEvent", true)
addEventHandler("clipEvent", root, clip)

function updateItems(player)
	if(getElementData(player, "toggleEquip") == true) then
		triggerClientEvent(source, "setDataTable", source, createPlayerArray(player))
	end
end

function useItem(uid)
	local itemKey = getItemKey(tonumber(uid))

	if(item[itemKey].type == ITEM_TYPE_APTECZKA) then
		setElementHealth(source, getElementHealth(source) + tonumber(item[itemKey].v1))
		destroyItem(itemKey)
		outputChatBox("Użyłeś apteczki!", source)
	end

	updateItems(source)
	triggerClientEvent(source, "setToggleFalse", source)
end
addEvent("useItem", true)
addEventHandler("useItem", root, useItem)

function setItemSlot(uid, slot)
	local itemKey = getItemKey(tonumber(uid))
	if((item[itemKey].type == ITEM_TYPE_WEAPON and slot == 13 and item[itemKey].subtype == 1) or (item[itemKey].type == ITEM_TYPE_WEAPON and slot == 14 and item[itemKey].subtype == 2) or (item[itemKey].type == 3 and slot == 15)) then
		if(((tonumber(item[itemKey].type) == ITEM_TYPE_WEAPON) or (tonumber(item[itemKey].type) == 2)) and (tonumber(item[itemKey].v2) > 0)) then
			if(isPlayerInAreaVictim(source)) then
				outputChatBox("Nie możesz używać broni w sektozre wroga!", source)
			else
				item[itemKey].ownerSlot = tonumber(slot)
			end
		else
			outputChatBox("Ta broń nie posiada amunicji!", source)
		end
	elseif(slot < 13) then
		item[itemKey].ownerSlot = tonumber(slot)
	else
		outputChatBox("Nie ma takiej opcji...", source)
	end

	itemCombine(source, uid)

	triggerClientEvent(source, "setDataTable", source, createPlayerArray(source))
	triggerClientEvent(source, "setToggleFalse", source)
	saveItem(itemKey)
end
addEvent("setItemSlot", true)
addEventHandler("setItemSlot", root, setItemSlot)

function cmdItem(player)
	if(getElementData(player, "toggleShop") == true) then return end
	
	if(getElementData(player, "toggleEquip") == false) then
		setElementData(player, "toggleEquip", true)
		triggerClientEvent(player, "setDataTable", player, createPlayerArray(player))
		triggerClientEvent(player, "toggleEquip", player, true)
	else
		setElementData(player, "toggleEquip", false)
		triggerClientEvent(player, "toggleEquip", player, false)
	end
	
end
addCommandHandler("i", cmdItem)
addCommandHandler("p", cmdItem)

function onPlayerShoot(weapon)
	if(weapon > 15) then
		local primWeapon = getPlayerItemBySlot(source, 13)
		if(primWeapon ~= false) then
			local itemKey = getItemKey(primWeapon)
			if(item[itemKey].v1 == weapon) then
				if(item[itemKey].v2 <= 1) then
					takeWeapon(source, weapon)
					outputChatBox("AMMO!", source)
					item[itemKey].v2 = 0

					local fS = getClosestPlayerSlot(source)

					item[itemKey].ownerSlot = fS
					saveItem(itemKey)
					return
				end
				item[itemKey].v2 = item[itemKey].v2 - 1
				setWeaponAmmo(source, weapon, item[itemKey].v2)

				return
			end
		end

		local secWeapon = getPlayerItemBySlot(source, 14)
		if(secWeapon ~= false) then
			local itemKey = getItemKey(secWeapon)
			if(item[itemKey].v1 == weapon) then

				if(item[itemKey].v2 <= 1) then
					takeWeapon(source, weapon)
					outputChatBox("AMMO!", source)
					item[itemKey].v2 = 0

					local fS = getClosestPlayerSlot(source)

					item[itemKey].ownerSlot = fS
					saveItem(itemKey)
					return
				end

				item[itemKey].v2 = item[itemKey].v2 - 1
				setWeaponAmmo(source, weapon, item[itemKey].v2)
				return
			end
		end
	end
	takeWeapon(source, weapon)
end

addEvent("playerShoot", true)
addEventHandler("playerShoot", root, onPlayerShoot)

function onDeath()
	local itemek = getPlayerSlotItem(source, 13)
	if(itemek ~= false) then
		local fS = getClosestPlayerSlot(source)
		local itemKey = getItemKey(itemek)

		item[itemKey].ownerSlot = fS
		saveItem(itemKey)
	end

	itemek = getPlayerSlotItem(source, 14)
	if(itemek ~= false) then
		local fS = getClosestPlayerSlot(source)
		local itemKey = getItemKey(itemek)

		item[itemKey].ownerSlot = fS
		saveItem(itemKey)
	end

	itemek = getPlayerSlotItem(source, 15)
	if(itemek ~= false) then
		local fS = getClosestPlayerSlot(v)
		local itemKey = getItemKey(itemek)

		item[itemKey].ownerSlot = fS
		saveItem(itemKey)
	end
	takeAllWeapons(source)
end
addEventHandler("onPlayerWasted", root, onDeath)
addEventHandler("onPlayerQuit", root, onDeath)

function takeWeap(player)
	local itemek = getPlayerSlotItem(player, 13)
	if(itemek ~= false) then
		local fS = getClosestPlayerSlot(player)
		local itemKey = getItemKey(itemek)

		item[itemKey].ownerSlot = fS
		saveItem(itemKey)
	end

	itemek = getPlayerSlotItem(player, 14)
	if(itemek ~= false) then
		local fS = getClosestPlayerSlot(player)
		local itemKey = getItemKey(itemek)

		item[itemKey].ownerSlot = fS
		saveItem(itemKey)
	end

	itemek = getPlayerSlotItem(player, 15)
	if(itemek ~= false) then
		local fS = getClosestPlayerSlot(v)
		local itemKey = getItemKey(itemek)

		item[itemKey].ownerSlot = fS
		saveItem(itemKey)
	end
	takeAllWeapons(player)
end

function checkTimer()
	for k, v in ipairs(getElementsByType("player")) do
		if(getElementData(v, "loggedIn") == 1) then
			if(isPlayerInAreaVictim(v)) then
				takeWeap(v)

				if(isPedInVehicle(v)) then
					if(getElementModel(getPedOccupiedVehicle(v)) == 447) then
						blowVehicle(getPedOccupiedVehicle(v))
					end
				end
			end
		end
	end
end
setTimer(checkTimer, 2000, 0)

function onResourceStop()
	for k, v in ipairs(getElementsByType("player")) do
		if(getElementData(v, "loggedIn") ~= false) then
			local itemek = getPlayerSlotItem(v, 13)
			if(itemek ~= false) then
				local fS = getClosestPlayerSlot(v)
				local itemKey = getItemKey(itemek)

				item[itemKey].ownerSlot = fS
				saveItem(itemKey)
			end

			itemek = getPlayerSlotItem(v, 14)
			if(itemek ~= false) then
				local fS = getClosestPlayerSlot(v)
				local itemKey = getItemKey(itemek)

				item[itemKey].ownerSlot = fS
				saveItem(itemKey)
			end

			itemek = getPlayerSlotItem(v, 15)
			if(itemek ~= false) then
				local fS = getClosestPlayerSlot(v)
				local itemKey = getItemKey(itemek)

				item[itemKey].ownerSlot = fS
				saveItem(itemKey)
			end
		end

		for i = 1,18 do
			takeWeapon(v, i)
		end

		for i = 22,46 do
			takeWeapon(v, i)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, onResourceStop)