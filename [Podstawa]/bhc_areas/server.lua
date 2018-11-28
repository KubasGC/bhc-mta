--[[
*
*	Autor: Kubas
*	Skrypt: BrotherHoodCombat.pl
*	Moduł: bhc_areas
*	
*
*	Funkcje odpowiadające za sektory
*			All Rights Reserverd
]]--

local areas = {}
function getAreas()
    local query = exports.DB:getArray("SELECT * FROM `bhc_spheres`")
    for k, v in ipairs(query) do
        areas[k] = {}
        areas[k].id = v.id
        areas[k].name = v.name
        areas[k].x = v.x
        areas[k].y = v.y
        areas[k].nation = v.nation
        areas[k].value = v.value
        local r, g, b
        if(areas[k].nation == 0) then
            r, g, b = 255, 0, 0
        elseif(areas[k].nation == 1) then
            r, g, b = 0, 255, 0
        else
            r, g, b = 255, 255, 255
        end
        areas[k].sphere = createRadarArea(areas[k].x, areas[k].y, 200, 200, r, g, b, 80)
        areas[k].capture = false
        areas[k].timer = nil
		areas[k].rospkt = nil
		areas[k].usapkt = nil
		areas[k].rosidle = nil
		areas[k].usaidle = nil
		areas[k].flashtimer = nil
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), getAreas)

function getNationColor(nation)
    local r, g, b
    if(nation == 0) then
        r, g, b = 255, 0, 0
    elseif(nation == 1) then
        r, g, b = 0, 255, 0
    else 
        r, g, b = 255, 255, 255
    end
    return r, g, b
end

function saveAreaNation(id)
    local query = exports.DB:zapytanie("UPDATE `bhc_spheres` SET `nation` = '"..areas[id].nation.."', `value` = '"..areas[id].value.."' WHERE `ID` = '"..areas[id].id.."'")
end
function getPlayerArea(player)
    if(isElement(player)) then
        local x, y, z = getElementPosition(player)
        for k, v in ipairs(areas) do 
            if(isInsideRadarArea(v.sphere, x, y)) then
                return k
            end
        end
    end
    return nil
end

function getAreaPlayer(player)
	local area = getPlayerArea(player)
	if(area == nil) then
		return false
	end	
	return areas[area]
end

function getPlayersInNation(nation)
    local players = getElementsByType("player")
    local i = 0
    for k, v in ipairs(players) do
        if(getElementData(v, "nation") == nation) then
            i = i + 1
        end
    end 
    return i   
end

function getPlayersInArea(area, nation)
    local players = getElementsByType("player")
    local i = 0 
    for key, player in ipairs(players) do   
        if(isElement(player)) then
            if(getElementData(player, "nation") == nation) then
                local x, y, z = getElementPosition(player)
                if(isInsideRadarArea(areas[area].sphere, x, y)) then
                    i = i + 1
                end
            end
        end
    end
    return i
end

function isAnybodyIsZone(zone, nation)
	local i = 0
	local players = getElementsByType("player")
	for k, v in ipairs(players) do
		if(getElementData(v, "nation") == nation) then
			if(getPlayerArea(v) == zone) then
				i = i + 1
			end
		end
	end
	return i
end

function flashArea(id)
	local r, g, b, a = getRadarAreaColor(areas[id].sphere)
	if(r == 255) then
		setRadarAreaColor(areas[id].sphere, 0, 255, 0, 80)
	else
			setRadarAreaColor(areas[id].sphere, 255, 0, 0, 80)
	end
end

function stopFlashArea(id)
	killTimer(areas[id].flashtimer)
	local r, g, b = getNationColor(areas[id].nation)
	setRadarAreaColor(areas[id].sphere, r, g, b, 80)
end

function mainCaptureZoneTimer(id)
	if(areas[id].capture == true) then
	
		if(areas[id].usapkt <= 0) then
			if(areas[id].nation == 0) then 	-- Jeśli Rosja broniła i wygrała
				local players = getElementsByType("player")
				for k, v in ipairs(players) do
					if(getElementData(v, "nation") == 0) then
						if(getPlayerArea(v) == id) then
							exports.bhc_noti:showBox(v, "Sektor zostal obroniony. Na Twoje konto dodane zostalo 10 punktow.") 
						end
					end
				end
			else							-- Jeśli Rosja atakowała i wygrała
				local players = getElementsByType("player")
				for k, v in ipairs(players) do
					if(getElementData(v, "nation") == 0) then
						if(getPlayerArea(v) == id) then
							exports.bhc_noti:showBox(v, "Sektor zostal przejety. Na Twoje konto dodane zostalo 15 punktow.") 
						end
					end
				end
				areas[id].nation = 0
			end
			areas[id].capture = false
			stopFlashArea(id)
			saveAreaNation(id)
			killTimer(areas[id].timer)
			return
		end
		
		if(areas[id].rospkt <= 0) then
			if(areas[id].nation == 1) then	-- Jeśli USA broniło i wygrało
				local players = getElementsByType("player")
				for k, v in ipairs(players) do
					if(getElementData(v, "nation") == 1) then
						if(getPlayerArea(v) == id) then
							exports.bhc_noti:showBox(v, "Sektor zostal obroniony. Na Twoje konto dodane zostalo 10 punktow.")
						end
					end
				end
			else							-- Jeśli USA atakowało i wygrało
				local players = getElementsByType("player")
				for k, v in ipairs(players) do
					if(getElementData(v, "nation") == 1) then
						if(getPlayerArea(v) == id) then
							exports.bhc_noti:showBox(v, "Sektor zostal przejety. Na Twoje konto dodane zostalo 15 punktow.") 
						end
					end
				end
				areas[id].nation = 1
			end
			areas[id].capture = false
			stopFlashArea(id)
			killTimer(areas[id].timer)
			return
		end
	
		if(areas[id].usaidle ~= nil and areas[id].usaidle >= 11) then
			areas[id].usapkt = areas[id].usapkt - 10
			areas[id].usaidle = 1
		end
		
		if(areas[id].rosidle ~= nil and areas[id].rosidle >= 11) then
			areas[id].rospkt = areas[id].rospkt - 10
			areas[id].rosidle = 1
		end
		
		local playersUSAInZone = isAnybodyIsZone(id, 1)
		if(playersUSAInZone <= 0) then
			if(areas[id].usaidle == nil) then
				areas[id].usaidle = 1
			else
				areas[id].usaidle = areas[id].usaidle + 1
			end
		else
				areas[id].usaidle = nil
		end
		
		local playersZSRRInZone = isAnybodyIsZone(id, 0)
		if(playersZSRRInZone <= 0) then
			if(areas[id].rosidle == nil) then
				areas[id].rosidle = 1
			else
				areas[id].rosidle = areas[id].rosidle + 1
			end
		else
			areas[id].rosidle = nil
		end
		
	else
		if(isTimer(areas[id].timer)) then
			killTimer(areas[id].timer)
		end
	end
end

function cmdPrzejmijSektor(player, command)
    if(isElement(player)) then
    	local czas = getRealTime()
    	if(czas.hour == 17 and czas.minute <= 20) then
    		exports.bhc_noti:showBox(player, "Okres zdemilitaryzowany trwa od 18:00 do 18:20. Przez ten czas nie mozna przejmowac sektorow!")
    		return
    	end
        local strefa = getPlayerArea(player)
        if(strefa) then
        	if(getElementData(player, "nation") == 0) then
        		if(areas[strefa].id == 16 or areas[strefa].id == 15 or areas[strefa].id == 31 or areas[strefa].id == 32) then
        			exports.bhc_noti:showBox(player, "Strefa bazowa nacji USA. Nie mozna przejac.") 
        			return
        		end
        	end

        	if(getElementData(player, "nation") == 1) then
        		if(areas[strefa].id == 49 or areas[strefa].id == 50 or areas[strefa].id == 65 or areas[strefa].id == 66) then
        			exports.bhc_noti:showBox(player, "Strefa bazowa nacji ZSRR. Nie mozna przejac.") 
        			return
        		end
        	end

            if(areas[strefa].nation ~= getElementData(player, "nation")) then
                if(areas[strefa].capture == false) then
                if(getPlayersInNation(0) >= 3 and getPlayersInNation(1) >= 3) then
                        if(getPlayersInArea(strefa, getElementData(player, "nation")) >= 3) then
                            if(areas[strefa].nation == -1) then
                                areas[strefa].nation = getElementData(player, "nation")
                                saveAreaNation(strefa)
                                local r, g, b = getNationColor(getElementData(player, "nation"))
                                setRadarAreaColor(areas[strefa].sphere, r, g, b, 80)
								exports.bhc_noti:showBox(player, "Strefa zostala pomyslnie przejeta.") 
                            else
								areas[strefa].rospkt = 200
								areas[strefa].usapkt = 200
								areas[strefa].capture = true
								areas[strefa].timer = setTimer(mainCaptureZoneTimer, 1000, 0, strefa)
								exports.bhc_noti:showBox(player, "Zainicjowano bitwe o sektor...")
								local r, g, b = getNationColor(getElementData(player, "nation"))
								areas[strefa].flashtimer = setTimer(flashArea, 1000, 0, strefa)
                            end   
                        else
                            exports.bhc_noti:showBox(player, "Brak odpowiedniej ilosci osob na sektorze. Minimalna wymagana ilosc osob: 3. Wroc tu z kolegami.")
                        end
                    else
                        exports.bhc_noti:showBox(player, "Brak odpowiedniej ilosci osob w obu skladach, aby rozpoczac walke.")
                    end     
                else
                exports.bhc_noti:showBox(player, "Na tej sektorze aktualnie trwa juz walka.")
                end
            else
                exports.bhc_noti:showBox(player, "Ten sektor nalezy juz aktualnie do Twojej nacji")
            end
        end
    end
end
addCommandHandler("przejmijsektor", cmdPrzejmijSektor)
--[[addCommandHandler("przejmijsektor",function()
		outputChatBox("LOL NIE MA PRZEJMOWANIA SEKTORÓW NA RAZIE CIOTY POSRANE.", player, 255, 0, 0)
	end)]]--

function scoreOnPlayerWasted(totalAmmo, killer, killerWeapon, bodyPart)
	local areaID = getPlayerArea(source)
	if(areaID ~= nil) then	
		if(areas[areaID].capture == true) then
			local nation = getElementData(source, "nation")
			if(nation == 0) then
				areas[areaID].rospkt = areas[areaID].rospkt - 20
			elseif(nation == 1) then
				areas[areaID].usapkt = areas[areaID].usapkt - 20
			end
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), scoreOnPlayerWasted)
setTimer(function()
    local players = getElementsByType("player")
    for key, player in ipairs(players) do
        if(getElementData(player, "loggedIn") == 1) then
            local id = getPlayerArea(player)
            local name
            if(id == nil) then name = "###" else name = areas[id].name end
            triggerClientEvent(player, "getSector", player, name)
            if(id ~= nil) then
				if(areas[id].capture == true) then
					triggerClientEvent(player, "showGUI", player)
					setElementData(player, "showFrame", true)
				else
					triggerClientEvent(player, "hideGUI", player)
					setElementData(player, "showFrame", false)
				end
			end
			if(getElementData(player, "showFrame") == true) then
				triggerClientEvent(player, "refreshGUI", player, areas[id].name, areas[id].rospkt, areas[id].usapkt)
			end
        end
    end
end, 1000, 0)

addCommandHandler("sektorInfo", function(player, command)
	local id = getPlayerArea(player)
	if(id ~= nil) then
		outputChatBox("----------------------", player)
		outputChatBox("Jesteś na sektorze o nazwie "..areas[id].name, player)
		outputChatBox("Jego ID to "..id, player)
		outputChatBox("a jego wartosc to "..areas[id].value, player)
		outputChatBox("----------------------", player)
	else
		outputChatBox("Błąd: Nie znajdujesz się na żadnym sektorze.")
	end
end)

addCommandHandler("wartosc", function(player, command, id, strefa)
	if(id == nil or strefa == nil) then
			outputChatBox("Syntax: /wartosc [id] [wartosc]", player)
	else
		id = tonumber(id)
		if(type(areas[id]) == "table") then
			areas[id].value = tonumber(strefa)
			outputChatBox("WARTOŚĆ ZOSTAŁA ZMIENIONA!", player)
			saveAreaNation(id)
		else outputChatBox("Niewłaściwa strefa", player) end
	end
end)

addCommandHandler("strefaNacja", function(player, command, id, strefa)
	if(id == nil or strefa == nil) then
			outputChatBox("Syntax: /strefaNacja [id] [nacja]", player)
	else
		id = tonumber(id)
		if(type(areas[id]) == "table") then
			areas[id].nation = tonumber(strefa)
			outputChatBox("NACJA ZOSTAŁA ZMIENIONA!", player)
			saveAreaNation(id)
		else outputChatBox("Niewłaściwa strefa", player) end
	end
end)