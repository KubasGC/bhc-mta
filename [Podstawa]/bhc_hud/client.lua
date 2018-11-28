local screenWidth, screenHeight = guiGetScreenSize()

local data = {}

data.font1 = dxCreateFont("font.ttf")
data.font2 = dxCreateFont("font.ttf", 15)

function render()
	if(getElementData(localPlayer, "showHud") == false) then return end
	local tick = getTickCount()

	dxDrawRectangle(screenWidth - 215, 40, 200, 26, tocolor(159, 0, 0, 130), false)
	dxDrawRectangle(screenWidth - 215, 70, 200, 26, tocolor(86, 76, 72, 130), false)
	
	
	local HP = getElementHealth(localPlayer)
	HP = math.floor(HP)
	dxDrawRectangle(screenWidth - 215, 40, 200 * (HP / 100), 26, tocolor(159, 0, 0, 255), false)

	local Armor = getPedArmor(localPlayer)
	Armor = math.floor(Armor)
	dxDrawRectangle(screenWidth - 215, 70, 200 * (Armor / 100), 26, tocolor(86, 76, 72, 255), false)

	dxDrawImage(screenWidth - 212, 45, 18, 16, "images/hp.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenWidth - 212, 75, 18, 16, "images/armour.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

	local playerName = string.gsub(getPlayerName(localPlayer), "_", " ")
	local weaponName = getWeaponNameFromID(getPedWeapon(localPlayer))
	local ammoInClip = getPedAmmoInClip(localPlayer)
	local totalAmmo = getPedTotalAmmo(localPlayer) - ammoInClip

	if(getPedWeapon(localPlayer) == 35) then
		weaponName = "RPG"
	end

	dxDrawText(playerName, screenWidth - 200, 10, screenWidth - 10, 29, tocolor(255, 255, 255, 255), 1.00, data.font1, "center", "center", false, false, false, false, false)

	dxDrawText(weaponName, screenWidth - 202, 134, screenWidth - 57, 153, tocolor(255, 255, 255, 255), 1.00, data.font1, "center", "center", false, false, false, false, false)
	
	if(not(ammoInClip == 0 and totalAmmo == 1)) then
		dxDrawText(totalAmmo.." | "..ammoInClip, screenWidth - 202, 153, screenWidth - 57, 174, tocolor(255, 255, 255, 255), 1.00, data.font1, "center", "center", false, false, false, false, false)	
	end

	dxDrawImage(screenWidth - 232, 115, 64, 64, "images/"..getPedWeapon(localPlayer)..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	
end
addEventHandler("onClientRender", root, render)