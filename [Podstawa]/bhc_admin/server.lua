function isAdmin(player)
	if(isElement(player)) then
		if(getElementData(player, "loggedIn") == 1) then
			if(getAdminLevel(player) ~= 0) then
				return true
			else
				return false
			end
		else return false end
	else return false end
end

function getAdminLevel(player)
	if(isElement(player)) then
		return getElementData(player, "admin")
	end
end

function cmdAdmins(player)
	local admins = {}
	for k, v in ipairs(getElementsByType("player")) do
		if(getElementData(v, "loggedIn") == 1) then
			if(getElementData(v, "adminDuty") == 1 and getAdminLevel(v) > 0) then
				local nazwa, r, g, b
				if(getAdminLevel(v) == 1) then
					nazwa = "Supporter"
					r, g, b = 102, 153, 255
				elseif(getAdminLevel(v) == 2) then
					nazwa = "GameMaster"
					r, g, b = 0, 128, 48
				elseif(getAdminLevel(v) == 3) then
					nazwa = "Administrator"
					r, g, b = 255, 0, 0
				elseif(getAdminLevel(v) == 4) then
					nazwa = "Główny Administrator"
					r, g, b = 139, 26, 26
				end

				local tablica = {}
				tablica.nick = getElementData(v, "global:name")
				tablica.ranga = nazwa
				tablica.id = getElementData(v, "id")
				tablica.r = r
				tablica.g = g
				tablica.b = b
				table.insert(admins, tablica)
			end
		end
	end
	if(#admins > 0) then
		triggerClientEvent(player, "toggleGUIAdmins", root, 1, admins)
	else
		outputChatBox("Nie ma żadnych administratorów przebywających aktualnie na duty.", player, 255, 0, 0)
	end
end
addCommandHandler("admins", cmdAdmins)

function cmdDuty(player)
	if(getAdminLevel(player) > 0) then
		if(getElementData(player, "adminDuty") == 1) then
			setElementData(player, "adminDuty", 0)
			outputChatBox("Opuściłeś duty administratora.", player, 0, 255, 0)
		else
			setElementData(player, "adminDuty", 1)
			outputChatBox("Wszedłeś na duty administratora.", player, 0, 255, 0)
		end
	else
		outputChatBox("Nie masz odpowiednich uprawnień, aby wejść na duty administratora.", player, 255, 0, 0)
	end
end
addCommandHandler("aduty", cmdDuty)

function cmdSpec(player, command, id)
	if(isAdmin(player) ~= false) then
		if(getElementData(player, "spec") == true) then
			setElementData(player, "spec", false)
			setCameraTarget(player, player)
			detachElements(player)
			setElementFrozen(player, false)
			setElementAlpha(player, 255)
			setElementCollisionsEnabled (player, true)
			local x = getElementData(player, "specLastX")
			local y = getElementData(player, "specLastY")
			local z = getElementData(player, "specLastZ")

			setElementPosition(player, x, y, z)
		else
			if(id == "" or id == nil) then
				outputChatBox("SYNTAX: /spec [id gracza]", player)
			else
				local gracz = getElementByID("p"..id)
				if(isElement(gracz)) then
					if(gracz == player) then
						outputChatBox("Nie możesz specować samego siebie.", player, 255, 0, 0)
					else
						local x, y, z = getElementPosition(player)

						setElementData(player, "specLastX", x)
						setElementData(player, "specLastY", y)
						setElementData(player, "specLastZ", z)

						setElementAlpha(player, 0)
						setElementCollisionsEnabled (player, false)

						attachElements(player, gracz, 0, 0, -2)

						setElementData(player, "spec", true)
						setElementData(player, "specPlayer", gracz)
						setElementFrozen(player, true)
						setCameraTarget(player, gracz)
					end
				else
					outputChatBox("Nie znaleziono gracza o podanym ID", player, 255, 0, 0)
				end
			end
		end
	else
		outputChatBox("Nie masz odpowiednich uprawnień do użycia tej komendy.", player, 255, 0, 0)
	end
end
addCommandHandler("spec", cmdSpec)


function cmdKick(player, command, id, ...)
	if(getAdminLevel(player) < 1) then outputChatBox("Nie posiadasz odpowiednich uprawnień do użycia tej komendy.", player, 255, 0, 0) return end
	local reason = table.concat({...}, " ")

	if(tostring(id) == "nil" or tostring(reason) == "nil") then
		outputChatBox("SYNTAX: /wyrzuc [id] [powód]", player)
		return
	end

	local owner = getElementByID("p"..tonumber(id))
	if(isElement(owner) and getElementData(owner, "loggedIn") == 1) then
		triggerClientEvent("showPenalty", root, owner, 1, player, reason)
		kickPlayer(owner, reason)
	else
		outputChatBox("Nie znaleziono gracza o podanym ID, bądź gracz nie jest zalogowany.", player, 255, 0, 0)
	end
end
addCommandHandler("wyrzuc", cmdKick)

function cmdBlock(player, command, id, ...)
	if(getAdminLevel(player) < 2) then outputChatBox("Nie posiadasz odpowiednich uprawnień do użycia tej komendy.", player, 255, 0, 0) return end
	local reason = table.concat({...}, " ")

	if(tostring(id) == "nil" or tostring(reason) == "nil") then
		outputChatBox("SYNTAX: /blokuj [id] [powód]", player)
		return
	end

	local owner = getElementByID("p"..tonumber(id))
	if(isElement(owner) and getElementData(owner, "loggedIn") == 1) then
		triggerClientEvent("showPenalty", root, owner, 2, player, reason)
		setElementData(owner, "Block", 1)
		kickPlayer(owner, reason)
	else
		outputChatBox("Nie znaleziono gracza o podanym ID, bądź gracz nie jest zalogowany.", player, 255, 0, 0)
	end
end
addCommandHandler("blokuj", cmdBlock)