setDevelopmentMode(true)
local czcionka = dxCreateFont("font.ttf", 14)
local wybor = nil
local data = {}
local sbState = false
local screenWidth, screenHeight = guiGetScreenSize()

function loadData()
	data.ids = {}
	data.players = {}
	local players = getElementsByType ("player")
	for k,v in ipairs(players) do
		if v ~= getLocalPlayer() then
			local ID = getElementData (v,"id")
			table.insert(data.players,ID)
			data.ids[ID] = v
		end
	end
	table.sort (data.players)
	local ID = getElementData(getLocalPlayer(),"id")
	data.ids[ID] = getLocalPlayer()
	table.insert(data.players,1,ID)
	data.length = #data.players
end

function onStart()
	bindKey("tab", "down", show)
	bindKey("tab", "up", hide)
	loadData()
	setTimer(loadData, 1000, 0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), onStart)

function nowyGenerate()
	if(wybor == nil) then
		wybor = 1
	end
	local players = getElementsByType("player")

	dxDrawImage(0.2891654465593 * screenWidth, 0.12890625 * screenHeight, 0.39385065885798 * screenWidth, 0.68489583333333 * screenHeight, "tlo.png", 0, 0, 526, tocolor(255, 255, 255, 255), false)
	dxDrawText("Graczy online: "..#players.."/200", 0.49780380673499 * screenWidth, 0.17708333333333 * screenHeight, 0.66032210834553 * screenWidth, 0.2109375 * screenHeight, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, true, false, false)
	
	local n = 0
	for k,v in ipairs(data.players) do
		if(k >= wybor) then
			if(k <= wybor + 10) then
				n = n + 1
				local player = data.ids[v]
				if(player and isElement(player)) then
					local ping = getPlayerPing(player)

					local name = getPlayerName(player)
					name = name:gsub("_", " ")

					if(getElementData(player, "adminDuty") == 1) then
						name = getElementData(player, "global:name")
					end

					local nation = getElementData(player, "nation")
					if(nation == 0) then
						nation = "ZSRR"
					elseif(nation == 1) then
						nation = "USA"
					else
						nation = ""
					end

					if(getElementData(player, "loggedIn") ~= 1) then
						name = "Loguje się..."
					end

					-- koniec zmiennych
					if(k == wybor) then
						dxDrawText(tonumber(v), 0.29941434846266 * screenWidth, 0.37239583333333 * screenHeight, 0.33601756954612 * screenWidth, 0.40755208333333 * screenHeight, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					    dxDrawText(name, 0.35431918008785 * screenWidth, 0.37239583333333 * screenHeight, 0.50366032210835 * screenWidth, 0.40755208333333 * screenHeight, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					    dxDrawText(nation, 0.5212298682284 * screenWidth, 0.37239583333333 * screenHeight, 0.59370424597365 * screenWidth, 0.40755208333333 * screenHeight, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					    dxDrawText(ping, 0.6090775988287 * screenWidth, 0.37239583333333 * screenHeight, 0.66764275256223 * screenWidth, 0.40755208333333 * screenHeight, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					else
						local y = 0.37239583333333 * screenHeight + (0.019765739385066 * screenWidth * (n - 1))
						local height = 0.40755208333333 * screenHeight + (0.019765739385066 * screenWidth * (n - 1))
						dxDrawText(tonumber(v), 0.29941434846266 * screenWidth, y, 0.33601756954612 * screenWidth, height, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					    dxDrawText(name, 0.35431918008785 * screenWidth, y, 0.50366032210835 * screenWidth, height, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					    dxDrawText(nation, 0.5212298682284 * screenWidth, y, 0.59370424597365 * screenWidth, height, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					    dxDrawText(ping, 0.6090775988287 * screenWidth, y, 0.66764275256223 * screenWidth, height, tocolor(255, 255, 255, 150), 1.00, czcionka, "center", "center", false, false, false, false, false)
					end

				end
			end
		end
	end
end

function onPlayerPressedKey(key, state)
	if(sbState == true) then
		if(key == "mouse_wheel_up") then
			if(wybor > 1) then
				wybor = wybor - 3
				if(wybor < 1) then
					wybor = 1
				end
			end
		elseif(key == "mouse_wheel_down") then
			local maxWybor = data.length

			if(wybor < maxWybor) then
				wybor = wybor + 3
				if(wybor > maxWybor) then
					wybor = maxWybor
				end
			end
		end
	end
end
addEventHandler("onClientKey", getRootElement(), onPlayerPressedKey)


function show()
	if(sbState == false) then
		addEventHandler("onClientRender", getRootElement(), nowyGenerate)
		sbState = true
	end
end

function hide()
	if(sbState == true) then
		removeEventHandler("onClientRender", getRootElement(), nowyGenerate)
		sbState = false
		wybor = nil
	end
end