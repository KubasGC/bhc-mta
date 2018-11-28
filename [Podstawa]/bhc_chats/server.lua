--[[
*
*	Autor: Kubas
*	Skrypt: BrotherHoodCombat.pl
*	Moduł: bhc_chats
*	
*
*	Funkcje odpowiadające za czat
*			All Rights Reserverd
]]--

local anims = {}
function loadAnims()
	local data = exports.DB:getArray("SELECT * FROM `bhc_anims`")
	for k, v in ipairs(data) do
		local tablica = {}

		tablica.uid 			= v.uid
		tablica.name 			= v.name
		tablica.animlib		 	= v.animlib
		tablica.animname 		= v.animname
		tablica.loop 			= v.loop
		tablica.freeze 			= v.freeze

		table.insert(anims, tablica)
	end
end
addEventHandler("onResourceStart", resourceRoot, loadAnims)

function getAnimKey(animName)
	for k, v in ipairs(anims) do
		if(string.lower(animName) == string.lower(v.name)) then return k end
	end
	return false
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function onCommand(command)
	if(getElementData(source, "loggedIn") ~= 1) then cancelEvent() return end
	if(command == "grab") then return end

	local nazwa = string.gsub(getPlayerName(source), "_", " ")
	outputServerLog(string.format("[cmd] %s: /%s", nazwa, command))
end
addEventHandler("onPlayerCommand", root, onCommand)

function onPlayerChat(message, messageType)
	cancelEvent()
	if(getElementData(source, "loggedIn") ~= 1) then return end
	if(messageType == 0 and string.byte(message) == 46) then
		if(isPedInVehicle(source)) then return end
		message = string.sub(message, 2)

		if(string.lower(message) == "stopani") then
			setPedAnimation (source, "BSKTBALL", "BBALL_idle_O", 0, false)
		else
			local animKey = getAnimKey(message)
			if(animKey == false) then return end
			local loop = false
			local position = true
			if(anims[animKey].loop == 1) then loop = true end
			if(anims[animKey].freeze == 0) then position = false end
			setPedAnimation(source, anims[animKey].animlib, anims[animKey].animname, 0, loop, position)
		end
		
		return
	end
	local x, y, z = getElementPosition(source)
	local sphere = createColSphere(x, y, z, 10)
	local players = getElementsWithinColShape(sphere, "player")
	local nazwa = getPlayerName(source)
	nazwa = nazwa:gsub("_", " ")
	if(getElementData(source, "adminDuty") == 1) then
		nazwa = getElementData(source, "global:name")
	end
	destroyElement(sphere)

	
	if(messageType == 0) then
		message = firstToUpper(message)
		for k, v in ipairs(players) do
			if(getElementData(v, "nation") == getElementData(source, "nation")) then
				outputChatBox(nazwa.. " mówi: "..message, v)
			else
				outputChatBox(nazwa.. " mówi: *NIEZNANY JĘZYK* "..message, v)
			end			
		end
		outputServerLog(string.format("[chat] %s: %s", nazwa, message))
	end

	if(messageType == 1) then
		for k, v in ipairs(players) do
			outputChatBox("* "..nazwa.. " "..message, v, 194, 162, 218)
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), onPlayerChat)

function cmdDO(player, command, ...)
		local mess = table.concat({...}, " ")
		if(mess ~= "") then
			mess = firstToUpper(mess)
			local x, y, z = getElementPosition(player)
			local sphere = createColSphere(x, y, z, 10)
			local players = getElementsWithinColShape(sphere)
			local nazwa = getPlayerName(player)
			nazwa = nazwa:gsub("_", " ")
			if(getElementData(player, "adminDuty") == 1) then
				nazwa = getElementData(player, "global:name")
			end
			destroyElement(sphere)
			for k, v in ipairs(players) do
				outputChatBox("*  "..mess.." (( "..nazwa.." ))", v, 154, 156, 205)
			end
		else
			outputChatBox("SYNTAX: /do [tresc]", player, 20, 155 , 80)
		end
end
addCommandHandler("do", cmdDO)

function cmdB(player, command, ...)
		local mess = table.concat({...}, " ")
		if(mess ~= "") then
			mess = firstToUpper(mess)
			local x, y, z = getElementPosition(player)
			local sphere = createColSphere(x, y, z, 10)
			local players = getElementsWithinColShape(sphere)
			local nazwa = getPlayerName(player)
			nazwa = nazwa:gsub("_", " ")
			if(getElementData(player, "adminDuty") == 1) then
				nazwa = getElementData(player, "global:name")
			end
			destroyElement(sphere)
			for k, v in ipairs(players) do
				outputChatBox("(( "..nazwa..": "..mess.." ))", v)
			end
		else
			exports.bhc_noti:showBox(player, "Użycie: /b [treść]")
		end
end
addCommandHandler("b", cmdB)

function cmdK(player, command, ...)
		local mess = table.concat({...}, " ")
		if(mess ~= "") then
			mess = firstToUpper(mess)
			local x, y, z = getElementPosition(player)
			local sphere = createColSphere(x, y, z, 20)
			local players = getElementsWithinColShape(sphere)
			local nazwa = getPlayerName(player)
			nazwa = nazwa:gsub("_", " ")
			if(getElementData(player, "adminDuty") == 1) then
				nazwa = getElementData(player, "global:name")
			end
			destroyElement(sphere)
			for k, v in ipairs(players) do
				outputChatBox(nazwa.. " krzyczy: "..mess.."!", v)
			end
		else
			exports.bhc_noti:showBox(player, "Użycie: /k(rzyk) [treść]")
		end
end
addCommandHandler("k", cmdK)
addCommandHandler("krzyk", cmdK)

function cmdRadioKanal(player, command, kanal) 
	if(kanal == nil) then outputChatBox("SYNTAX: /radiokanal [kanal (0-9999)]", player, 20, 155 , 80) return end
	kanal = tonumber(kanal)
	if(kanal > 0 and kanal < 10000) then
		setElementData(player, "radioChannel", kanal)
		exports.bhc_noti:showBox(player, "Pomyślnie zmieniono kanał radiowy na "..kanal.."MHz")
	else
		exports.bhc_noti:showBox(player, "Radio nie posiada takiej frekwencji do ustawienia.", "Błąd")
	end
end
addCommandHandler("radiokanal", cmdRadioKanal)

function cmdR(player, command, ...)
	if(getElementData(player, "loggedIn") ~= 1) then return end

	if(getElementData(player, "radioChannel") == nil or getElementData(player, "radioChannel") == false or getElementData(player, "radioChannel") < 0) then
		outputChatBox("Musisz ustawić kanał radia! Aby to uczynić użyj komendy /radiokanal.", player, 255, 0, 0)
		return
	end

	local mess = table.concat({...}, " ")
	mess = firstToUpper(mess)
	local radioKanal = getElementData(player, "radioChannel")
	local nazwa = getPlayerName(player)
	nazwa = nazwa:gsub("_", " ")

	for k, v in ipairs(getElementsByType("player")) do
		if(getElementData(v, "loggedIn") == 1) then
			if(getElementData(v, "radioChannel") == radioKanal) then
				outputChatBox("* ["..radioKanal.."MHz] "..nazwa..": "..mess, v, 188, 212, 230)
			end
		end
	end

	local x, y, z = getElementPosition(player)
	local sphere = createColSphere(x, y, z, 10)

	for k, v in ipairs(getElementsWithinColShape(sphere)) do
		if(v ~= player) then
			outputChatBox(nazwa.. " mówi (radio): "..mess, v)
		end
	end

	destroyElement(sphere)
end
addCommandHandler("Radio", cmdR)



function adminChat(player, command, ...)
	if(getElementData(player, "admin") > 0) then
		local mess = table.concat({...}, " ")
		if(tostring(mess) == "") then
			outputChatBox("SYNTAX: /a [tresc]", player, 20, 155 , 80)
			return
		end
		mess = firstToUpper(mess)
		local players = getElementsByType("player")
		for k, v in ipairs(players) do
			if(getElementData(v, "admin") ~= false and getElementData(v, "admin") > 0) then	
				outputChatBox("* [ADMIN] "..getElementData(player, "global:name")..": "..mess, v, 108, 123, 139)
			end
		end
	else
		outputChatBox("Nie posiadasz uprawnień, aby korzystać z czatu dla administratorów!", player, 255, 0, 0)
	end
end
addCommandHandler("a", adminChat)