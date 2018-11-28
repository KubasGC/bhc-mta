local pickup = {}
local vehicles = {}
vehicles.Samochody = {}
vehicles.Pancerne = {}
vehicles.Smiglowce = {}
vehicles.Samoloty = {}
vehicles.Pozostale = {}

pickup.usa = createPickup(2955, -924, 11, 3, 1239, 0)
pickup.ros = createPickup(-58, -1577, 2.5, 3, 1239, 0)

function loadVehicles()
	local querySamochody = exports.DB:getArray("SELECT * FROM `bhc_vehicles` WHERE `type` = '1'")
	local queryPancerne = exports.DB:getArray("SELECT * FROM `bhc_vehicles` WHERE `type` = '2'")
	local querySmiglowce = exports.DB:getArray("SELECT * FROM `bhc_vehicles` WHERE `type` = '3'") 
	local querySamoloty = exports.DB:getArray("SELECT * FROM `bhc_vehicles` WHERE `type` = '4'")
	local queryPozostale = exports.DB:getArray("SELECT * FROM `bhc_vehicles` WHERE `type` = '5'")

	if(querySamochody ~= nil) then
		local i = 0
		for k, v in ipairs(querySamochody) do
			i = i + 1
			vehicles.Samochody[i] = {}
			vehicles.Samochody[i].id = v.id
			vehicles.Samochody[i].name = v.name
			vehicles.Samochody[i].vehID = v.vehicleID
			vehicles.Samochody[i].HP = v.HP
			vehicles.Samochody[i].perm = v.perm
			vehicles.Samochody[i].nation = v.nation
			vehicles.Samochody[i].division = v.division
			vehicles.Samochody[i].price = v.price
		end
	end

	if(queryPancerne ~= nil) then 
		local i = 0
		for k, v in ipairs(queryPancerne) do
			i = i + 1
			vehicles.Pancerne[i] = {}
			vehicles.Pancerne[i].id = v.id
			vehicles.Pancerne[i].name = v.name
			vehicles.Pancerne[i].vehID = v.vehicleID
			vehicles.Pancerne[i].HP = v.HP
			vehicles.Pancerne[i].perm = v.perm
			vehicles.Pancerne[i].nation = v.nation
			vehicles.Pancerne[i].division = v.division
			vehicles.Pancerne[i].price = v.price
		end
	end

	if(querySmiglowce ~= nil) then
		local i = 0
		for k, v in ipairs(querySmiglowce) do
			i = i + 1
			vehicles.Smiglowce[i] = {}
			vehicles.Smiglowce[i].id = v.id
			vehicles.Smiglowce[i].name = v.name
			vehicles.Smiglowce[i].vehID = v.vehicleID
			vehicles.Smiglowce[i].HP = v.HP
			vehicles.Smiglowce[i].perm = v.perm
			vehicles.Smiglowce[i].nation = v.nation
			vehicles.Smiglowce[i].division = v.division
			vehicles.Smiglowce[i].price = v.price
		end
	end

	if(querySamoloty ~= nil) then
		local i = 0
		for k, v in ipairs(querySamoloty) do
			i = i + 1
			vehicles.Samoloty[i] = {}
			vehicles.Samoloty[i].id = v.id
			vehicles.Samoloty[i].name = v.name
			vehicles.Samoloty[i].vehID = v.vehicleID
			vehicles.Samoloty[i].HP = v.HP
			vehicles.Samoloty[i].perm = v.perm
			vehicles.Samoloty[i].nation = v.nation
			vehicles.Samoloty[i].division = v.division
			vehicles.Samoloty[i].price = v.price
		end
	end

	if(queryPozostale ~= nil) then
		local i = 0
		for k, v in ipairs(queryPozostale) do
			i = i + 1
			vehicles.Pozostale[i] = {}
			vehicles.Pozostale[i].id = v.id
			vehicles.Pozostale[i].name = v.name
			vehicles.Pozostale[i].vehID = v.vehicleID
			vehicles.Pozostale[i].HP = v.HP
			vehicles.Pozostale[i].perm = v.perm
			vehicles.Pozostale[i].nation = v.nation
			vehicles.Pozostale[i].division = v.division
			vehicles.Pozostale[i].price = v.price
		end
	end

end
addEventHandler("onResourceStart", getResourceRootElement(), loadVehicles)

function loadVehiclesList(player)
	local nation = getElementData(player, "nation")
	local division = getElementData(player, "division:id")
	local dane = {}
	dane.Samochody = {}
	dane.Pancerne = {}
	dane.Smiglowce = {}
	dane.Samoloty = {}
	dane.Pozostale = {}
			--[[ SAMOCHODY ]]--
			if(vehicles.Samochody ~= nil) then
				local i = 0
				for k, v in ipairs(vehicles.Samochody) do
					if(v.nation == nation and v.division == division) then
						i = i + 1
						dane.Samochody[i] = {}
						dane.Samochody[i].name = v.name
						dane.Samochody[i].vehID = v.vehID
						dane.Samochody[i].HP = v.HP
						dane.Samochody[i].perm = v.perm
						dane.Samochody[i].price = v.price
					end
				end
			end
		--[[ SAMOCHODY - KONIEC ]]--
		
		--[[ Pancerne ]] --
		
				if(vehicles.Pancerne ~= nil) then
					local i = 0 
					for k, v in ipairs(vehicles.Pancerne) do
						if(v.nation == nation and v.division == division) then
							i = i + 1
							dane.Pancerne[i] = {}
							dane.Pancerne[i].name = v.name
							dane.Pancerne[i].vehID = v.vehID
							dane.Pancerne[i].HP = v.HP
							dane.Pancerne[i].perm = v.perm
							dane.Pancerne[i].price = v.price
						end
					end
				end
			
		--[[ Pancerne - KONIEC ]] --
		
		--[[ ŚMIGLOWCE ]] --
		
				if(vehicles.Smiglowce ~= nil) then
						local i = 0 
						for k, v in ipairs(vehicles.Smiglowce) do
							if(v.nation == nation and v.division == division) then
							i = i + 1
							dane.Smiglowce[i] = {}
							dane.Smiglowce[i].name = v.name
							dane.Smiglowce[i].vehID = v.vehID
							dane.Smiglowce[i].HP = v.HP
							dane.Smiglowce[i].perm = v.perm
							dane.Smiglowce[i].price = v.price
						end
					end
				end
			
		--[[ SMIGLOWCE - KONIEC ]] --
		
		--[[ SAMOLOTY ]] --
		
				if(vehicles.Samoloty ~= nil) then
						local i = 0 
						for k, v in ipairs(vehicles.Samoloty) do
							if(v.nation == nation and v.division == division) then
								i = i + 1
								dane.Samoloty[i] = {}
								dane.Samoloty[i].name = v.name
								dane.Samoloty[i].vehID = v.vehID
								dane.Samoloty[i].HP = v.HP
								dane.Samoloty[i].perm = v.perm
								dane.Samoloty[i].price = v.price
							end
						end
				end
			
		--[[ Samoloty - KONIEC ]] --
		
		--[[ Pozostałe ]] --
		
				if(vehicles.Pozostale ~= nil) then
						local i = 0 
						for k, v in ipairs(vehicles.Pozostale) do
							if(v.nation == nation and v.division == division) then
								i = i + 1
								dane.Pozostale[i] = {}
								dane.Pozostale[i].name = v.name
								dane.Pozostale[i].vehID = v.vehID
								dane.Pozostale[i].HP = v.HP
								dane.Pozostale[i].perm = v.perm
								dane.Pozostale[i].price = v.price
						end
					end
				end
			
		--[[ Pozostałe - KONIEC ]] --

	--[[ CLIENT EVENT ]]--
	triggerClientEvent(player, "getAllVehicles", player, dane.Samochody, dane.Pancerne, dane.Smiglowce, dane.Samoloty, dane.Pozostale)
end

function hitUSAPickup(player)
	if(getElementData(player, "nation") == 1) then
		if(isPedInVehicle(player) == false) then
			loadVehiclesList(player)
			triggerClientEvent(player, "toggleShow", player, 1)
		end
	end
end
addEventHandler("onPickupHit", pickup.usa, hitUSAPickup)

function hitROSPickup(player)
	if(getElementData(player, "nation") == 0) then
		if(isPedInVehicle(player) == false) then
			loadVehiclesList(player)
			triggerClientEvent(player, "toggleShow", player, 1)
		end
	end
end
addEventHandler("onPickupHit", pickup.ros, hitROSPickup)

function getVehID(vName, typ, nation, division)
	if(typ == 1) then -- Samochody
		for k, v in ipairs(vehicles.Samochody) do
			if(vName == v.name and nation == v.nation and division == v.division) then
				return k
			end
		end
		return nil
	elseif(typ == 4) then -- Samoloty
		for k, v in ipairs(vehicles.Samoloty) do
			if(vName == v.name and nation == v.nation and division == v.division) then
				return k
			end
		end
		return nil
	elseif(typ == 2) then -- Pancerne
		for k, v in ipairs(vehicles.Pancerne) do
			if(vName == v.name and nation == v.nation and division == v.division) then
				return k
			end
		end
		return nil
	elseif(typ == 3) then -- Smiglowce
		for k, v in ipairs(vehicles.Smiglowce) do
			if(vName == v.name and nation == v.nation and division == v.division) then
				return k
			end
		end
		return nil
	elseif(typ == 5) then -- Pozostale
		for k, v in ipairs(vehicles.Pozostale) do
			if(vName == v.name and nation == v.nation and division == v.division) then
				return k
			end
		end
		return nil
	else                  -- A TU JAK SIE ZEPSUJE
		return nil
	end
end

function hasbit(x, p)
	return x % (p + p) >= p       
end

function takeVehicle(player, vName, typ)
	if(isElement(player) and getElementType(player) == "player") then
		local nation = getElementData(player, "nation")
		local division = getElementData(player, "division:id")
		local id = getVehID(vName, typ, nation, division)
		if(id ~= nil) then
			local name, vehID, perm, price, HP
			if(typ == 1) then -- Samochody
				name, vehID, perm, price, HP = vehicles.Samochody[id].name, vehicles.Samochody[id].vehID, vehicles.Samochody[id].perm, vehicles.Samochody[id].price, vehicles.Samochody[id].HP
			elseif(typ == 4) then -- Samoloty
				name, vehID, perm, price, HP = vehicles.Samoloty[id].name, vehicles.Samoloty[id].vehID, vehicles.Samoloty[id].perm, vehicles.Samoloty[id].price, vehicles.Samoloty[id].HP
			elseif(typ == 2) then -- Pancerne
				name, vehID, perm, price, HP = vehicles.Pancerne[id].name, vehicles.Pancerne[id].vehID, vehicles.Pancerne[id].perm, vehicles.Pancerne[id].price, vehicles.Pancerne[id].HP
			elseif(typ == 3) then -- Śmigłowce
				name, vehID, perm, price, HP = vehicles.Smiglowce[id].name, vehicles.Smiglowce[id].vehID, vehicles.Smiglowce[id].perm, vehicles.Smiglowce[id].price, vehicles.Smiglowce[id].HP
			elseif(typ == 5) then -- Pozostałe
				name, vehID, perm, price, HP = vehicles.Pozostale[id].name, vehicles.Pozostale[id].vehID, vehicles.Pozostale[id].perm, vehicles.Pozostale[id].price, vehicles.Pozostale[id].HP
			else
				outputChatBox("Wystąpił błąd (ERROR CODE: 1). Poinformuj administratora.", player)
				return
			end
			if(hasbit(tonumber(getElementData(player, "division:data")), perm) == false) then
				exports.bhc_noti:showBox(player, "Nie posiadasz uprawnień do użycia tego pojazdu.", "Błąd")
				return
			end
			if(nation == 0) then
				local elem = getElementByID("economyROS")
				local budzet = tonumber(getElementData(elem, "budzet"))
				if(budzet >= price) then
					local x, y, z, rot = getVehicleSpawn(nation, typ)
					if(x == false) then
						return exports.bhc_noti:showBox(player, "Wszystkie dostępne miejsca spawnu są zajęte.", "Błąd")
					end

					local veh = createVehicle(vehID, x, y, z)
					setElementRotation(veh, 0, 0, rot)
					warpPedIntoVehicle(player, veh)
					budzet = budzet - price
					setElementData(elem, "budzet", tonumber(budzet))

					outputChatBox("#FFFFFFNa ten pojazd Twoja nacja wydała #006400$"..price.."#FFFFFF. Dbaj o niego.", player, 255, 255, 255, true)
					triggerClientEvent(player, "toggleShow", player, 0)
				else
					exports.bhc_noti:showBox(player, "Nacja nie posiada tyle pieniędzy.", "Błąd")
				end
			elseif(nation == 1) then
				local elem = getElementByID("economyUSA")
				local budzet = tonumber(getElementData(elem, "budzet"))
				if(budzet >= price) then
					local x, y, z, rot = getVehicleSpawn(nation, typ)
					if(x == false) then
						return exports.bhc_noti:showBox(player, "Wszystkie dostępne miejsca spawnu są zajęte.", "Błąd")
					end
					local veh = createVehicle(vehID, x, y, z)
					setElementRotation(veh, 0, 0, rot)
					warpPedIntoVehicle(player, veh)
					budzet = budzet - price
					setElementData(elem, "budzet", tonumber(budzet))

					outputChatBox("#FFFFFFNa ten pojazd Twoja nacja wydała #006400$"..price.."#FFFFFF. Dbaj o niego.", player, 255, 255, 255, true)
					triggerClientEvent(player, "toggleShow", player, 0)
				else
					exports.bhc_noti:showBox(player, "Nacja nie posiada tyle pieniędzy.", "Błąd")
				end
			end

		else
			exports.bhc_noti:showBox(player, "Wystąpił błąd.", "Błąd")
		end
	end
end
addEvent("takeVehicle", true)
addEventHandler("takeVehicle", getRootElement(), takeVehicle)

function getVehicleSpawn(nation, typ)
	local elem
	if(nation == 0) then
		elem = getElementByID("ROSs")
	else
		elem = getElementByID("USAs")
	end

	local table = getElementData(elem, "vehicle"..typ)
	for k, v in ipairs(table) do
		local i = 0
		
		for _, veh in ipairs(getElementsByType("vehicle")) do
			local x, y, z = getElementPosition(veh)
			local dist = getDistanceBetweenPoints3D(x, y, z, v.x, v.y, v.z)
			if(dist < 10) then i = i + 1 end
		end

		if(i == 0) then
			return v.x, v.y, v.z, v.rot
		end
	end
	return false
end