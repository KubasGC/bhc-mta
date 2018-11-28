local data = {}
data.shopItems = {}

function onResourceStart()
	for k, v in ipairs(getElementsByType("player")) do
		bindKey(v, "o", "down", cmdSklep)
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStart)

function playerJoinServer()
	bindKey(source, "o", "down", cmdSklep)
end
addEventHandler("onPlayerJoin", root, playerJoinServer)

function getShopItems()
	local query = exports.DB:getArray("SELECT * FROM `bhc_shop`")
	for k, v in ipairs(query) do
		local tablica = {}
		tablica.id = v.id
		tablica.name = v.name
		tablica.type = v.typ
		tablica.value1 = v.value1
		tablica.value2 = v.value2
		tablica.subtype = v.subtype
		tablica.price = v.price
		tablica.nation = v.nation

		table.insert(data.shopItems, tablica)
	end
	outputServerLog("[ITEM] Zaladowano "..#data.shopItems.." pozycji w sklepie.")
end
addEventHandler("onResourceStart", resourceRoot, getShopItems)

function cmdSklep(player)
	if(getElementData(player, "toggleEquip") == true or getElementData(player, "loggedIn") ~= 1) then return end
	local area = exports.bhc_areas:getPlayerArea(player)
	-- if((getElementData(player, "nation") == 0 and getElementData(area, "id") ~= 49) or (getElementData(player, "nation") == 1 and getElementData(area, "id") ~= 16) and getElementData(player, "toggleShop") == false) then return exports.bhc_noti:showBox(player, "Możesz kupować rzeczy tylko w bazie.", "Błąd") end
	triggerClientEvent(player, "shopServerHandler", player, data.shopItems)
end
addCommandHandler("sklep", cmdSklep)

function getShopItemKey(uid)
	for k, v in ipairs(data.shopItems) do
		if(v.id == tonumber(uid)) then return k end
	end
	return false
end

function buyHandler(uid)
	local itemKey = getShopItemKey(uid)

	local koszt 		= tonumber(data.shopItems[itemKey].price)
	local punktyGracza 	= tonumber(getElementData(source, "punkty"))

	if(punktyGracza >= koszt) then
		if(getPlayerItems(source) < 12) then
			setElementData(source, "punkty", punktyGracza - koszt)
			createItem(source, data.shopItems[itemKey].value1, data.shopItems[itemKey].value2, data.shopItems[itemKey].type, data.shopItems[itemKey].subtype, data.shopItems[itemKey].name)
			outputChatBox("Zakupiono przedmiot: "..data.shopItems[itemKey].name..". Został on dodany do Twojego ekwipunku.", source)
		else
			outputChatBox("Nie posiadasz miejsca w ekwipunku!", source)
		end
	else
		outputChatBox("Nie posiadasz wystarczającej ilości punktów, aby zakupić ten przedmiot!", source)
	end

	triggerClientEvent(source, "wylaczToggle", source)
end
addEvent("buyHandler", true)
addEventHandler("buyHandler", root, buyHandler)
