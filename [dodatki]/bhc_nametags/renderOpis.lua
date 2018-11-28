local MAX_DIST = 100
local font = dxCreateFont("font.ttf", 30)
function renderOpis()
	local xPlayer, yPlayer, zPlayer = getElementPosition(localPlayer)
	local camX, camY, camZ = getCameraMatrix()
	for k, v in ipairs(getElementsByType("player")) do
		while true do
			if(v ~= localPlayer) then
				if(getElementData(v, "loggedIn") == 1) then
						if(getElementData(v, "desc") ~= false) then

							


							
							local x, y, z = getPedBonePosition(v, 3)

							--if(processLineOfSight(camX, camY, camZ, x, y, z)) then break end
							if processLineOfSight(camX, camY, camZ, x, y, z, true, false, false, true, false, true) then break end
							local dist = getDistanceBetweenPoints3D(xPlayer, yPlayer, zPlayer, x, y, z)

							if(dist <= MAX_DIST) then

							local screenW, screenH = getScreenFromWorldPosition (x, y, z, 25, false)
							if(not screenW or not screenH) then break end

							local progress = dist / MAX_DIST
							local scale = interpolateBetween(0.4, 0, 0, 0, 0, 0, progress, "Linear")

							local alpha = 50 - (20 / 3)
							local progress2 = dist / alpha

							alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress2, "Linear")
							if(progress < 1 and alpha > 0) then
								dxDrawText(getElementData(v, "desc"), screenW - 100 + 1, screenH + 1, screenW + 100 + 1, screenH + 150 + 1, tocolor(0, 0, 0, alpha), scale, font, "center", "top", false, true, false, false, false)
								dxDrawText(getElementData(v, "desc"), screenW - 100, screenH, screenW + 100, screenH + 150, tocolor(220, 162, 244, alpha), scale, font, "center", "top", false, true, false, false, false)
							end

						end
					end
				end
			end
			break
		end
	end

end
addEventHandler("onClientRender", root, renderOpis)