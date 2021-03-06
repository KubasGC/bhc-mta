-- Smooth Move Camera
-- Author: Noneatme(Me)

local cameraPos = {}
cameraPos.czasRozpoczecia = nil
cameraPos.choose = 1
cameraPos.toggle = true
cameraPos.cameraFade = false

cameraPos[1] = {-226, -1673, 43, 54, -1687, 66, -75, -1575, 4}
cameraPos[2] = {2849, -1232, 55, 2905, -748, 83, 2934, -908, 25}
cameraPos[3] = {2230, -1197, 78, 2102, -1450, 70, 2209, -1358, 30}
cameraPos[4] = {1941, -1092, 61, 1934, -1299, 76, 1936, -1274, 43}
cameraPos[5] = {1604, -1184, 74, 1693, -1361, 62, 1610, -1312, 38}

function renderCamera()
	if(cameraPos.toggle == false) then return end

	local progress = (getTickCount() - cameraPos.czasRozpoczecia) / (math.floor(getDistanceBetweenPoints3D(cameraPos[cameraPos.choose][1], cameraPos[cameraPos.choose][2], cameraPos[cameraPos.choose][3], cameraPos[cameraPos.choose][4], cameraPos[cameraPos.choose][5], cameraPos[cameraPos.choose][6])) * 55)
	local camX, camY, camZ = interpolateBetween(cameraPos[cameraPos.choose][1], cameraPos[cameraPos.choose][2], cameraPos[cameraPos.choose][3], cameraPos[cameraPos.choose][4], cameraPos[cameraPos.choose][5], cameraPos[cameraPos.choose][6], progress, "Linear")
	setCameraMatrix(camX, camY, camZ, cameraPos[cameraPos.choose][7], cameraPos[cameraPos.choose][8], cameraPos[cameraPos.choose][9])

	if(progress >= 0.92) then
		if(cameraPos.cameraFade == false) then
			cameraPos.cameraFade = true
			fadeCamera(false)
		end
	end
	if(progress >= 1) then
		removeEventHandler("onClientRender", root, renderCamera)
		if(type(cameraPos[cameraPos.choose + 1]) ~= "table") then cameraPos.choose = 1 else cameraPos.choose = cameraPos.choose + 1 end
		setTimer(timerRender, 500, 1)
	end
end

function timerRender()
	cameraPos.czasRozpoczecia = getTickCount()
	addEventHandler("onClientRender", root, renderCamera)
	setTimer(fadeCamera, 500, 1, true)
	cameraPos.cameraFade = false
end




local timer = {}

function getMiesiac(month)
	local miesiac
	if(month == 0) then
		miesiac = "stycznia"
	elseif(month == 1) then
		miesiac = "lutego"
	elseif(month == 2) then
		miesiac = "marca"
	elseif(month == 3) then
		miesiac = "kwietnia"
	elseif(month == 4) then
		miesiac = "maja"
	elseif(month == 5) then
		miesiac = "czerwca"
	elseif(month == 6) then
		miesiac = "lipca"
	elseif(month == 7) then
		miesiac = "sierpnia"
	elseif(month == 8) then
		miesiac = "września"
	elseif(month == 9) then
		miesiac = "października"
	elseif(month == 10) then
		miesiac = "listopada"
	elseif(month == 11) then
		miesiac = "grudnia"
	end
	return miesiac
end

local muzyka = nil
local tick2 = nil
local wybor = nil
local guiLogin = {}
local guiPostacie = {}
local screenWidth, screenHeight = guiGetScreenSize()
local postacie = {}
czcionka = dxCreateFont("font.ttf")

function onLogin()
	if(guiGetProperty(guiLogin.button, "Disabled") == "True") then return end
	blockButtons()
	local user = guiGetText(guiLogin.nick)
	local pass = guiGetText(guiLogin.password)
			
	if(user == '' or pass == '') then
		exports.bhc_noti:showBox("Uzupełnij wymagane pola")  
	else
		triggerServerEvent("checkAccount", getLocalPlayer(), user, pass)
	end	
end

function onClick(button, press)
	if(button == "enter" and press == true) then
		onLogin()
	end
end

function createDxElements()
	dxDrawRectangle(0.5849194729136164 * screenWidth, 0, 0.2452415812591508 * screenWidth, 1 * screenHeight, tocolor(0, 0, 0, 100), false)
	dxDrawText("LOGOWANIE", 0.5849194729136164 * screenWidth, 0.1731770833333333 * screenHeight, 0.8301610541727672 * screenWidth, 0.2122395833333333 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawImage(0.182 * screenWidth, 0.044 * screenHeight, 0.365 * screenWidth, 0.223 * screenHeight, "newLogo.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    dxDrawRectangle(0.227 * screenWidth, 0.28 * screenHeight, 0.258 * screenWidth, 0.255 * screenHeight, tocolor(0, 0, 0, 200), false)
    dxDrawRectangle(0.165 * screenWidth, 0.279 * screenHeight, 0.382 * screenWidth, 0.036 * screenHeight, tocolor(255, 255, 255, 150), false)
    dxDrawText("Witamy na serwerze S-Gaming.pl BHC!", 0.227 * screenWidth, 0.28 * screenHeight, 0.484 * screenWidth, 0.314 * screenHeight, tocolor(0, 0, 0, 150), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Aby wejść do gry należy zalogować się danymi z forum. Po pomyślnym zalogowaniu i wybraniu postaci zostaniesz zespawnowany w bazie nacji. \n\nW razie znalezienia błędów prosimy o zgłoszenie ich na forum.\n\nPozdrawiamy,\nekipa projektu BrotherHoodCombat,\nadministracja S-Gaming.pl", 0.234 * screenWidth, 0.327 * screenHeight, 0.477 * screenWidth, 0.522 * screenHeight, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, true, false, false, false)

end

function createDxPostacie()
	dxDrawRectangle(0.212298682284041 * screenWidth, 0.2291666666666667 * screenHeight, 0.5541727672035139 * screenWidth, 0.5703125 * screenHeight, tocolor(0, 0, 0, 150), false)
	dxDrawImage(0.4948755490483163 * screenWidth, 0.27 * screenHeight, 0.0124450951683748 * screenWidth, 0.5442708333333333 * screenHeight, "line.png", 0, 0, 0, tocolor(0, 0, 0, 150), true)
	for k, v in ipairs(postacie) do
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX * screenWidth, cursorY * screenHeight
		if(k == 1) then
			local minX = 0.2781844802342606 * screenWidth
			local minY = 0.2695312 * screenHeight
			local maxX = minX + (0.0878477306002928 * screenWidth)
			local maxY = minY + (0.0911458333333333 * screenHeight)
			if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY or wybor == k) then
				local r, g, b
				if(wybor == k) then
					r, g, b = 154, 205, 50
				else
					r, g, b = 16, 78, 139
				end
				dxDrawText(v.username, 0.2781844802342606 * screenWidth, 0.2695312 * screenHeight, 0.3931185944363104 * screenWidth, 0.3580729166666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, false, false, false)
			
			else
				dxDrawText(v.username, 0.2781844802342606 * screenWidth, 0.2695312 * screenHeight, 0.3931185944363104 * screenWidth, 0.3580729166666667 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "top", false, false, false, false, false)
			end
			local nat
			if(v.nation == 0) then
				nat = "zsrr"
			else
				nat = "usa"
			end
			dxDrawImage(0.3045387994143485 * screenWidth, 0.2942708333333333 * screenHeight, 0.0592972181551977 * screenWidth, 0.0638020833333333 * screenHeight, nat..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		elseif(k == 2) then
			local minX = 0.2781844802342606 * screenWidth
			local minY = 0.4453125 * screenHeight
			local maxX = minX + (0.0878477306002928 * screenWidth)
			local maxY = minY + (0.0911458333333333 * screenHeight)
			if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY or wybor == k) then
				local r, g, b
				if(wybor == k) then
					r, g, b = 154, 205, 50
				else
					r, g, b = 16, 78, 139
				end
				dxDrawText(v.username, 0.2781844802342606 * screenWidth, 0.4453125 * screenHeight, 0.3931185944363104 * screenWidth, 0.5338541666666667 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, false, false, false)
			else
				dxDrawText(v.username, 0.2781844802342606 * screenWidth, 0.4453125 * screenHeight, 0.3931185944363104 * screenWidth, 0.5338541666666667 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "top", false, false, false, false, false)
			end
			local nat
			if(v.nation == 0) then
				nat = "zsrr"
			else
				nat = "usa"
			end
			dxDrawImage(0.3045387994143485 * screenWidth, 0.4700520833333333 * screenHeight, 0.0592972181551977 * screenWidth, 0.0638020833333333 * screenHeight, nat..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		elseif(k == 3) then
			local minX = 0.2781844802342606 * screenWidth
			local minY = 0.5989583 * screenHeight
			local maxX = minX + (0.0878477306002928 * screenWidth)
			local maxY = minY + (0.0911458333333333 * screenHeight)
			if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY or wybor == k) then
				local r, g, b
				if(wybor == k) then
					r, g, b = 154, 205, 50
				else
					r, g, b = 16, 78, 139
				end
				 dxDrawText(v.username, 0.2781844802342606 * screenWidth, 0.5989583 * screenHeight, 0.3931185944363104 * screenWidth, 0.6875 * screenHeight, tocolor(r, g, b, 255), 1.00, czcionka, "center", "top", false, false, false, false, false)
			else
				 dxDrawText(v.username, 0.2781844802342606 * screenWidth, 0.5989583 * screenHeight, 0.3931185944363104 * screenWidth, 0.6875 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "top", false, false, false, false, false)
			end
			local nat
			if(v.nation == 0) then
				nat = "zsrr"
			else
				nat = "usa"
			end
			dxDrawImage(0.3045387994143485 * screenWidth, 0.6236979166666667 * screenHeight, 0.0592972181551977 * screenWidth, 0.0638020833333333 * screenHeight, nat..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if(wybor ~= nil) then
			local minX = 0.6522693997071742 * screenWidth
			local minY = 0.7994791666666667 * screenHeight
			local maxX = minX + (0.1142020497803807 * screenWidth)
			local maxY = minY + (0.0481770833333333 * screenHeight)
			local r, g, b
			if(cursorX >= minX and cursorY >= minY and cursorX <= maxX and cursorY <= maxY) then
				r, g, b = 205, 55, 0
			else
				r, g, b = 41, 7, 247
			end
			dxDrawRectangle(0.6522693997071742 * screenWidth, 0.7994791666666667 * screenHeight, 0.1142020497803807 * screenWidth, 0.0481770833333333 * screenHeight, tocolor(r, g, b, 150), true)
			dxDrawText("Wejdź do gry", 0.6515373352855051 * screenWidth, 0.7981770833333333 * screenHeight, 0.7664714494875549 * screenWidth, 0.84765625 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
		end
		if(wybor ~= nil and wybor == k) then
			local nacja
			if(v.nation == 0) then
				nacja = "ZSRR"
			else
				nacja = "USA"
			end

			local godziny = math.floor(v.Online / 60 / 60)
			local minuty = math.floor(v.Online / 60 - (godziny * 60))

			local dname = "Brak"
			if(v.dywizja == 0) then
				dname = "Piechota"
			elseif(v.dywizja == 1) then
				dname = "Pancerna"
			elseif(v.dywizja == 2) then
				dname = "Lotnicza"
			elseif(v.dywizja == 3) then
				dname = "Transportowa"
			end

			local lastLogInGame = v.lastlog

			if(lastLogInGame == 0) then
				lastLogInGame = "nigdy"
			else
				local datawejscia = getRealTime(lastLogInGame)
				local datateraz = getRealTime()
				if(datawejscia["year"] == datateraz["year"] and datawejscia["month"] == datateraz["month"] and datawejscia["monthday"] == datateraz["monthday"]) then
					if(datawejscia["hour"] < 10) then datawejscia["hour"] = "0"..datawejscia["hour"] end
					if(datawejscia["minute"] < 10) then datawejscia["minute"] = "0"..datawejscia["minute"] end
					lastLogInGame = "dzisiaj, "..datawejscia["hour"]..":"..datawejscia["minute"]
				else
					if(datawejscia["hour"] < 10) then datawejscia["hour"] = "0"..datawejscia["hour"] end
					if(datawejscia["minute"] < 10) then datawejscia["minute"] = "0"..datawejscia["minute"] end
					lastLogInGame = datawejscia["monthday"].." "..getMiesiac(datawejscia["month"]).." "..1900 + datawejscia["year"].." "..datawejscia["hour"]..":"..datawejscia["minute"]
				end
			end

			dxDrawText("Nacja: "..nacja.."\nDywizja: "..dname.."\nCzas online: "..godziny.."h "..minuty.."m\nOstatnio w grze: "..lastLogInGame, 0.5146412884333821 * screenWidth, 0.3098958333333333 * screenHeight, 0.7584187408491947 * screenWidth, 0.4322916666666667 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
			dxDrawText("Postać: "..v.username, 0.5146412884333821 * screenWidth, 0.2526041666666667 * screenHeight, 0.7584187408491947 * screenWidth, 0.296875 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
			dxDrawText("Statystyki postaci", 0.5322108345534407 * screenWidth, 0.50390625 * screenHeight, 0.7510980966325037 * screenWidth, 0.54296875 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, true, false, false)
			dxDrawText("Ogólnie zadane obrażenia:\n\nStrzały w lewe ramię:\nStrzały w prawe ramię:\nStrzały w lewą nogę:\nStrzały w prawą nogę:\nStrzały w tors:\nStrzały w głowę:\nStrzały w tyłek:", 0.5436896046852123 * screenWidth, 0.55078125 * screenHeight, 0.6683748169838946 * screenWidth, 0.7630208333333333 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "top", false, false, true, false, false)
			dxDrawText(v.dmg.."\n\n"..v.dmg_larm.."\n"..v.dmg_rarm.."\n"..v.dmg_lleg.."\n"..v.dmg_rleg.."\n"..v.dmg_torso.."\n"..v.dmg_head.."\n"..v.dmg_ass, 0.6683748169838946 * screenWidth, 0.5520833333333333 * screenHeight, 0.6961932650073206 * screenWidth, 0.7630208333333333 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "top", false, false, true, false, false)
		end
	end
end

function findClickedChar(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if(button == "left" and state == "up") then
		local id = nil
		for k, v in ipairs(postacie) do
			if(k == 1) then
				local minX = 0.2781844802342606 * screenWidth
				local minY = 0.2695312 * screenHeight
				local maxX = minX + (0.0878477306002928 * screenWidth)
				local maxY = minY + (0.0911458333333333 * screenHeight)

				if(absoluteX >= minX and absoluteY >= minY and absoluteX <= maxX and absoluteY <= maxY) then
					id = k
					break
				end
			elseif(k == 2) then
				local minX = 0.2781844802342606 * screenWidth
				local minY = 0.4453125 * screenHeight
				local maxX = minX + (0.0878477306002928 * screenWidth)
				local maxY = minY + (0.0911458333333333 * screenHeight)

				if(absoluteX >= minX and absoluteY >= minY and absoluteX <= maxX and absoluteY <= maxY) then
					id = k
					break
				end
			elseif(k == 3) then
				local minX = 0.2781844802342606 * screenWidth
				local minY = 0.5989583 * screenHeight
				local maxX = minX + (0.0878477306002928 * screenWidth)
				local maxY = minY + (0.0911458333333333 * screenHeight)

				if(absoluteX >= minX and absoluteY >= minY and absoluteX <= maxX and absoluteY <= maxY) then
					id = k
					break
				end
			end
		end

		if(id ~= nil) then
			wybor = id
		end
		if(wybor ~= nil) then
			local minX = 0.6522693997071742 * screenWidth
			local minY = 0.7994791666666667 * screenHeight
			local maxX = minX + (0.1142020497803807 * screenWidth)
			local maxY = minY + (0.0481770833333333 * screenHeight)
			if(absoluteX >= minX and absoluteY >= minY and absoluteX <= maxX and absoluteY <= maxY) then
					if(tonumber(postacie[wybor].block) == 1) then
						exports.bhc_noti:showBox("Ta postać jest zablokowana!")  
						return
					end

					cameraPos.toggle = false
					removeEventHandler("onClientRender", root, renderCamera)
					showCursor(false)
					tick2 = getTickCount()
					removeEventHandler("onClientRender", getRootElement(), createDxPostacie)
					removeEventHandler("onClientClick", getRootElement(), findClickedChar)
					addEventHandler("onClientRender", getRootElement(), muzyczka)
					triggerServerEvent("onPlayerSelectChar", getLocalPlayer(), postacie[wybor].id)
			end
		end
	end
end

function showGUI()
	addEventHandler("onClientRender", getRootElement(), createDxElements)
	cameraPos.czasRozpoczecia = getTickCount()
	addEventHandler("onClientRender", root, renderCamera)
	guiSetVisible(guiLogin.nick, true)
	guiSetVisible(guiLogin.password, true)
	guiSetVisible(guiLogin.button, true)
	showCursor(true)
	fadeCamera(true)
	muzyka = playSound("sound.mp3", true)
	setSoundVolume (muzyka, 0.8)
	addEventHandler("onClientKey", getRootElement(), onClick)
	setPlayerHudComponentVisible("radar", false)
	showChat(false)

end

function blockButtons()
	guiSetProperty(guiLogin.button, "Disabled", "True")
	setTimer(function()
		guiSetProperty(guiLogin.button, "Disabled", "False")
		end, 5000, 1)
end

function isClientDownload()
	if isTransferBoxActive() == true then
		setTimer(isClientDownload, 2000, 1)
	else 
		showGUI() 
	end
end

function muzyczka()
	local tick = getTickCount()
	local progress = (tick - tick2) / 1500
	local glosnosc, _, _ = interpolateBetween ( 
		0.8,0,0,
		0,0,0, 
		progress, "Linear")
	setSoundVolume(muzyka, glosnosc)
	if(glosnosc <= 0) then
		removeEventHandler("onClientRender", getRootElement(), muzyczka)
		destroyElement(muzyka)
	end
end

addEventHandler("onClientResourceStart", getResourceRootElement(), function()

		
		guiLogin.nick = guiCreateEdit(0.65, 0.25, 0.11, 0.03, getPlayerName(getLocalPlayer()), true)
		guiLogin.password = guiCreateEdit(0.65, 0.29, 0.11, 0.03, "", true)
		guiEditSetMasked(guiLogin.password, true)
		
		guiLogin.button = guiCreateButton(0.67, 0.34, 0.08, 0.03, "Zaloguj się", true)
		
		guiSetVisible(guiLogin.nick, false)
		guiSetVisible(guiLogin.password, false)
		guiSetVisible(guiLogin.button, false)
		
		
		addEventHandler("onClientGUIClick", guiLogin.button, onLogin, false)
		
		isClientDownload()
end)

function chars(ctable)
	local i = 1
	for k, v in ipairs(ctable) do
		postacie[i] = {}
		postacie[i].nation = v.nation
		postacie[i].username = v.username:gsub("_", " ")
		postacie[i].id = v.id
		postacie[i].Online = v.Online
		postacie[i].dywizja = v.dywizja
		postacie[i].lastlog = v.lastlog

		postacie[i].block = v.block

		postacie[i].dmg = tonumber(v.dmg)
		postacie[i].dmg_head = tonumber(v.dmg_head)
		postacie[i].dmg_torso = tonumber(v.dmg_torso)
		postacie[i].dmg_larm = tonumber(v.dmg_larm)
		postacie[i].dmg_rarm = tonumber(v.dmg_rarm)
		postacie[i].dmg_lleg = tonumber(v.dmg_lleg)
		postacie[i].dmg_rleg = tonumber(v.dmg_rleg)
		postacie[i].dmg_ass = tonumber(v.dmg_ass)
		i = i + 1
	end
	addEventHandler("onClientRender", getRootElement(), createDxPostacie)
	addEventHandler("onClientClick", getRootElement(), findClickedChar)
end
addEvent("showChars", true)
addEventHandler("showChars", getRootElement(), chars)

addEvent("hideGUI", true)
addEventHandler("hideGUI", getRootElement(), function()
	if(source == root) then
		removeEventHandler("onClientRender", getRootElement(), createDxElements)
		removeEventHandler("onClientKey", getRootElement(), onClick)
		guiSetVisible(guiLogin.nick, false)
		guiSetVisible(guiLogin.password, false)
		guiSetVisible(guiLogin.button, false)
	end
end)

function cur()
	if(isCursorShowing()) then
		showCursor(false)
	else
		showCursor(true)
	end
end
bindKey("f3", "down", cur)