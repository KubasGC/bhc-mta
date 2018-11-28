function onWasted()
	local x, y, z = getElementPosition(source)
	setCameraMatrix(source, x + 5, y + 5, z + 5, x, y, z)
	setElementData(source, "BW", true)
	triggerClientEvent(source, "setPlayerBW", source)
end
addEventHandler("onPlayerWasted", root, onWasted)

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

addEvent("playerSpawnBW", true)
addEventHandler("playerSpawnBW", root, playerSpawn)

