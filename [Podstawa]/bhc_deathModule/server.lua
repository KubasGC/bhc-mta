function onPlayerDeath(ammo, killer, weapon, bodypart)
	setElementData(source, "playerSpawned", false)
	if(source ~= killer and isElement(killer)) then
	--	triggerClientEvent(killer, "toggleKillPlayer", root, 1)
	end
	--triggerClientEvent(source, "toggleVictimMessage", root, 1)
end
addEventHandler("onPlayerWasted", getRootElement(), onPlayerDeath)

function playerSpawn(player)
	local skin = getElementData(player, "skin")
	local spawnX, spawnY, spawnZ, spawnROT
	local nation = getElementData(player, "nation")

	if(nation == 0) then
        skin = 61
        local elem = getElementByID("ROSs")
        local table = getElementData(elem, "player")
        local max = #table
        local cyfra = math.random(1, max)

        spawnX, spawnY, spawnZ, spawnROT = table[cyfra].x, table[cyfra].y, table[cyfra].z, table[cyfra].rot

    else
        skin = 285
        local elem = getElementByID("USAs")
        local table = getElementData(elem, "player")
        local max = #table
        local cyfra = math.random(1, max)
        
        spawnX, spawnY, spawnZ, spawnROT = table[cyfra].x, table[cyfra].y, table[cyfra].z, table[cyfra].rot
    end
    spawnPlayer(player, spawnX, spawnY, spawnZ, 0, skin)
    setElementData(player, "playerSpawned", true)
    setElementRotation(player, 0, 0, spawnROT)
    setCameraTarget(player, player)

    setElementData(player, "BW", false)
end
addEvent("playerSpawn", true)
addEventHandler("playerSpawn", getRootElement(), playerSpawn)