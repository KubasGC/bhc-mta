local data = {}
function onRender()
	local players = getElementsByType("player")
	for k, v in ipairs(players) do
		if(type(data[v]) ~= "table") then
			data[v] = {}
			data[v][2] = 0
			data[v][3] = 0
			data[v][4] = 0
			data[v][5] = 0
			data[v][6] = 0
			data[v][7] = 0
			data[v]["current"] = 0
			data[v]["models"] = {}
		end
		if(getElementData(v, "playerSpawned") == false) then break end

		local currentWeapon = getPedWeapon(v)

		for i = 1, 7 do
			local weapon = getPedWeapon(v, i)
			if(weapon == false) then weapon = 0 end
			data[v][i] = tonumber(weapon)
		end

		data[v]["current"] = getPedWeapon(v)


		for key, val in pairs(data[v]) do
			if(key ~= "current" and key ~= "models") then
				if(val ~= 0) then
					if(val == data[v]["current"]) then
						if(isElement(data[v]["models"][getSlotFromWeapon(val)])) then
							destroyElement(data[v]["models"][getSlotFromWeapon(val)])
						end
					else
						if(isElement(data[v]["models"][getSlotFromWeapon(val)]) == false) then
							data[v]["models"][getSlotFromWeapon(val)] = createObject(getWeaponModel(val), 0, 0, 0)
							if(getSlotFromWeapon(val) == 2) then
								exports.bhc_bone_attach:attachElementToBone(data[v]["models"][getSlotFromWeapon(val)], v, 14, 0.1, 0, -0.05, 0, -90, 90, 0)
							elseif(getSlotFromWeapon(val) == 5) then
								exports.bhc_bone_attach:attachElementToBone(data[v]["models"][getSlotFromWeapon(val)], v, 3, 0.19, -0.1, -0.15, 0, -90, 0)
							elseif(getSlotFromWeapon(val) == 6) then
								exports.bhc_bone_attach:attachElementToBone(data[v]["models"][getSlotFromWeapon(val)], v, 3, -0.18, -0.05, -0.3, -5, -90, 180)
							elseif(getSlotFromWeapon(val) == 4) then
								exports.bhc_bone_attach:attachElementToBone(data[v]["models"][getSlotFromWeapon(val)], v, 13, -0.1, 0, 0.05, 0, -90, 90, 0)
							elseif(getSlotFromWeapon(val) == 7) then
								exports.bhc_bone_attach:attachElementToBone(data[v]["models"][getSlotFromWeapon(val)], v, 3, -0.1, 0, 0.05, 0, -90, 90, 0)
							elseif(getSlotFromWeapon(val) == 1) then
								exports.bhc_bone_attach:attachElementToBone(data[v]["models"][getSlotFromWeapon(val)], v, 14, 0.13, -0.15, -0.1, 0, 0, 90, 0)
							end	
						end
					end
				end
			end
		end

		for i = 2, 7 do
			local weapon = getPedWeapon(v, i)
			if(weapon == false or weapon == 0) then
				if(isElement(data[v]["models"][i])) then
					destroyElement(data[v]["models"][i])
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, onRender)

function onQuit()
	for i = 2, 7 do
		if(isElement(data[source]["models"][i])) then
			destroyElement(data[source]["models"][i])
		end
	end
end
addEventHandler("onPlayerQuit", root, onQuit)


function getWeaponModel(weaponid)
	if(weaponid == 4) then return 335 end
	if(weaponid >= 22 and weaponid <= 29) then return tonumber(weaponid) + 324 end
	if(weaponid == 30 or weaponid == 31) then return tonumber(weaponid) + 325 end
	if(weaponid == 32) then return 372 end
	if(weaponid >= 33 and weaponid <= 45) then return tonumber(weaponid) + 324 end
	return false
end