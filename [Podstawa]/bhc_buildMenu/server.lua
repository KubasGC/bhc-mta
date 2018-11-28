--[[
*
*	Autor: Kubas
*	Skrypt: BrotherHoodCombat.pl
*	Moduł: bhc_buildMenu
*	
*
*	Funkcje odpowiadające za budowanie struktur
*			All Rights Reserverd
]]--

function getXYInFrontOfPlayer( player, distance )
	local x, y, z = getElementPosition( player )
	local _, _, rot = getElementRotation( player )
	x = x + math.sin( math.rad( -rot ) ) * distance
	y = y + math.cos( math.rad( -rot ) ) * distance
	return x, y
end
function createBlock(player, command)
	if(isElement(player)) then
		local _,_,z = getElementPosition(player)
    	local x, y = getXYInFrontOfPlayer( player, 2.0 )
    	local rx, ry, rz = getElementRotation(player)
		local object = createObject (2060, x, y, z-1, rx, ry, rz)
		setElementData(object, "build", 1)
		local objects = {}
		local z1row = 0
		--[[Lecimy w dół]]--
		for i=1,5 do
			z1row = z1row + 0.2
			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, 0, 0, z1row)
		end
		--[[Lecimy w dół - koniec]]--
		--[[Lecimy w prawo]]--
		local x1row = 0
		for i = 1,2 do
			x1row = x1row + 1
			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 1)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.8)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.6)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.4)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.2)
		end
		--[[Lecimy w prawo - koniec]]--
		--[[Lecimy w lewo]]--
		local x1row = 0
		for i = 1,2 do
			x1row = x1row + -1
			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 1)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.8)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.6)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.4)

			objects[i] = createObject (2060, x, y, z)
			attachElements(objects[i], object, x1row, 0, 0.2)
		end
		--[[Lecimy w lewo - koniec]]--
	end
end
addCommandHandler("worek", createBlock)

addCommandHandler("removeworek", function(player, command)
	local x, y, z = getElementPosition(player)
	local sphere = createColSphere(x, y, z, 2.0)

	for k, v in ipairs(getElementsWithinColShape(sphere)) do
		if(getElementType(v) == "object") then
			if(getElementData(v, "build") == 1) then
				local attaches = getAttachedElements(v)
				for i, j in ipairs(attaches) do
					destroyElement(j)
				end
				destroyElement(v)
				destroyElement(sphere)
				return
			end
		end
	end
	destroyElement(sphere)
end)

