local penaltyData = {}
local czcionka = dxCreateFont("font.ttf")
local screenWidth, screenHeight = guiGetScreenSize()

function penaltyRender()
	dxDrawRectangle(0.021 * screenWidth, 0.352 * screenHeight, 0.23 * screenWidth, 0.257 * screenHeight, tocolor(0, 0, 0, 150), false)
	dxDrawText("#ff0000"..penaltyData.typ, 0.021 * screenWidth, 0.352 * screenHeight, 0.252 * screenWidth, 0.379 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, true, false)
	dxDrawText("Gracz: #C0E366"..penaltyData.playerName, 0.029 * screenWidth, 0.397 * screenHeight, 0.245 * screenWidth, 0.427 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, true, true, false)
	dxDrawText("Nadający: "..penaltyData.adminName, 0.029 * screenWidth, 0.427 * screenHeight, 0.245 * screenWidth, 0.457 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "center", false, false, true, true, false)
	dxDrawText("Powód:\n"..penaltyData.reason, 0.029 * screenWidth, 0.478 * screenHeight, 0.245 * screenWidth, 0.595 * screenHeight, tocolor(255, 255, 255, 255), 1.00, czcionka, "left", "top", true, true, true, false, false)
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
 
	return false
end


function givePenalty(player, typ, admin, reason)
	if(isTimer(penaltyData.timer)) then
		killTimer(penaltyData.timer)
	end

	penaltyData.playerName = getPlayerName(player)
	penaltyData.playerName = string.gsub(penaltyData.playerName, "_", " ")

	local MGI = getElementData(admin, "admin")
	if(MGI == 3) then -- administratorzy
		penaltyData.adminName = "#ff0000"..getElementData(admin, "global:name")
	elseif(MGI == 4) then -- developerzy
		penaltyData.adminName = "#8b1a1a"..getElementData(admin, "global:name")
	elseif(MGI == 2) then -- moderatorzy gry
		penaltyData.adminName = "#008030"..getElementData(admin, "global:name")
	elseif(MGI == 1) then -- supporterzy
		penaltyData.adminName = "#6699ff"..getElementData(admin, "global:name")
	end

	if(typ == 1) then
		penaltyData.typ = "Kick"
	elseif(typ == 2) then
		penaltyData.typ = "Blokada postaci"
	end

	penaltyData.reason = reason

	if(isEventHandlerAdded("onClientRender", getRootElement(), hidePenalty) == false) then
		addEventHandler("onClientRender", getRootElement(), penaltyRender)
	end

	penaltyData.timer = setTimer(hidePenalty, 7000, 1)
end
addEvent("showPenalty", true)
addEventHandler("showPenalty", getRootElement(), givePenalty)

function hidePenalty()
	removeEventHandler("onClientRender", getRootElement(), penaltyRender)
end