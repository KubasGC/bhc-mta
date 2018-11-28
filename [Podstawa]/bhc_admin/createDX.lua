local screenWidth, screenHeight = guiGetScreenSize()
local czcionka = dxCreateFont("font.ttf", 20)
local adminData = {}
local elem1 = getElementByID("USAs")
local elem2 = getElementByID("ROSs")


function isCursor(minX, maxX, minY, maxY)
	local x, y = getCursorPosition()
	x, y = x * screenWidth, y * screenHeight

	if(x >= minX and x <= maxX and y >= minY and y <= maxY) then
		return true
	end
	return false
end

function generateDX()
	if(getElementData(localPlayer, "spawnDebugMode") == true) then
		local xcam, ycam, zcam = getCameraMatrix()
		if(getElementData(elem1, "player") ~= false) then
			for k,v in ipairs(getElementData(elem1, "player")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn graczy: USA", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem1, "vehicle1") ~= false) then
			for k,v in ipairs(getElementData(elem1, "vehicle1")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn samochodów: USA", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem1, "vehicle2") ~= false) then
			for k,v in ipairs(getElementData(elem1, "vehicle2")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn pancernych: USA", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem1, "vehicle3") ~= false) then
			for k,v in ipairs(getElementData(elem1, "vehicle3")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn śmigłowców: USA", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem1, "vehicle4") ~= false) then
			for k,v in ipairs(getElementData(elem1, "vehicle4")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn samolotów: USA", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem1, "vehicle5") ~= false) then
			for k,v in ipairs(getElementData(elem1, "vehicle5")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn pozostałych: USA", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end





		if(getElementData(elem2, "player") ~= false) then
			for k,v in ipairs(getElementData(elem2, "player")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn graczy: ZSRR", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem2, "vehicle1") ~= false) then
			for k,v in ipairs(getElementData(elem2, "vehicle1")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn samochodów: ZSRR", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem2, "vehicle2") ~= false) then
			for k,v in ipairs(getElementData(elem2, "vehicle2")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn pancernych: ZSRR", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem2, "vehicle3") ~= false) then
			for k,v in ipairs(getElementData(elem2, "vehicle3")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn śmigłowców: ZSRR", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem2, "vehicle4") ~= false) then
			for k,v in ipairs(getElementData(elem2, "vehicle4")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn samolotów: ZSRR", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end

		if(getElementData(elem2, "vehicle5") ~= false) then
			for k,v in ipairs(getElementData(elem2, "vehicle5")) do
				local x, y, z = v.x, v.y, v.z
				local xekran, yekran = getScreenFromWorldPosition(x, y, z, 10)
				if(not xekran or not yekran) then break end
				if(getDistanceBetweenPoints3D(xcam, ycam, zcam, x, y, z) > 200) then break end
				dxDrawText("Spawn pozostałych: ZSRR", xekran, yekran, xekran, yekran, tocolor(0, 0, 0, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
			end
		end
	end
end
addEventHandler("onClientRender", root, generateDX)

addCommandHandler("testujem", function()
	setElementData(localPlayer, "spawnDebugMode", not getElementData(localPlayer, "spawnDebugMode"))
	end)