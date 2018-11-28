--[[
*
*	Autor: Kubas
*	Skrypt: BrotherHoodCombat.pl
*	Moduł: bhc_core
*	
*
*	Funkcje odpowiadające za wszystkie podstawowe rzeczy
*			All Rights Reserverd
]]--

setDevelopmentMode(true)

setPlayerHudComponentVisible("vehicle_name", false)
setPlayerHudComponentVisible("area_name", false)
setPlayerHudComponentVisible("health", false)
setPlayerHudComponentVisible("armour", false)
setPlayerHudComponentVisible("breath", false)
setPlayerHudComponentVisible("clock", false)
setPlayerHudComponentVisible("money", false)
setPlayerHudComponentVisible("weapon", false)
setPlayerHudComponentVisible("radio", false)
setPlayerHudComponentVisible("wanted", false)
setPlayerHudComponentVisible("ammo", false)

local data = {}

data.show = false
data.showing = false
data.czasRozpoczecia = 0

local font = dxCreateFont("font.ttf", 15)
local screenWidth, screenHeight = guiGetScreenSize()
local progress = 0
addEventHandler("onClientRender", getRootElement(),
	function()
		dxDrawText("s-gaming.pl #build 27042014", screenWidth - 383, screenHeight - 12, screenWidth - 84, screenHeight, tocolor(255, 255, 255, 130), 1.00, "default", "right", "center", false, false, true, false, false)
		
		if(data.showing == true) then
			data.showing = false
			data.show = true
			data.czasRozpoczecia = getTickCount()
		end

		if(data.show == true) then
			local progress = (getTickCount() - data.czasRozpoczecia) / 300
			local alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "Linear")

			dxDrawRectangle(0, 0, screenWidth, screenHeight, tocolor(255, 0, 0, alpha), true)

			if(progress >= 1) then
				data.show = false
			end
		end

		

	end
)

addEventHandler ( "onClientPlayerDamage", localPlayer, 
	function ()
 		data.showing = true
	end
)

function onPlayerGotDamage()
	data.showing = true
end
addEvent("onPlayerGotDamage", true)
addEventHandler("onPlayerGotDamage", root, onPlayerGotDamage)

addEventHandler("onClientRender", root, function()
	if(progress ~= 0) then
		progress = progress + 1
		dxDrawImage(0.517 * screenWidth, 0.38 * screenHeight, 0.026 * screenWidth, 0.04 * screenHeight, "cel.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		if(progress == 8) then
				progress = 0
		end
	end
end)

function onDMG()
	progress = 1
end
addEvent("onDMG", true)
addEventHandler("onDMG", root, onDMG)

function onHeadshot(player)
	sound = playSound("headshot.mp3")
	setSoundVolume(sound, 0.1)
end
addEvent("onHeadshot", true)
addEventHandler("onHeadshot", root, onHeadshot)

function onTextMess()
	sound = playSound("files/message.mp3")
	setSoundVolume(sound, 0.5)
end
addEvent("onTextMess", true)
addEventHandler("onTextMess", root, onTextMess)