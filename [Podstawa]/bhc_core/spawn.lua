local spawnUSA = createElement("USASpawn")
local spawnROS = createElement("ROSSpawn")

setElementID(spawnUSA, "USAs")
setElementID(spawnROS, "ROSs")

function onResourceStartSpawn()
	local query = exports.DB:getArray("SELECT * FROM `bhc_spawns`")

	local player0_i = 0
	local player1_1 = 0

	local table_player0 = {}
	local table_player1 = {}


	local pojazdy1_0_i = 0
	local pojazdy1_1_i = 0

	local pojazdy20 = 0
	local pojazdy21 = 0

	local pojazdy30 = 0
	local pojazdy31 = 0

	local pojazdy40 = 0
	local pojazdy41 = 0

	local pojazdy50 = 0
	local pojazdy51 = 0

	local table_pojazdy1_0 = {} -- SAMOCHODY ZSRR
 	local table_pojazdy1_1 = {} -- SAMOCHODY USA

	local table_pojazdy2_0 = {} -- PANCERNE ZSRR
	local table_pojazdy2_1 = {} -- PANCERNE USA

	local table_pojazdy3_0 = {} -- ŚMIGŁOWCE ZSRR
	local table_pojazdy3_1 = {} -- ŚMIGŁOWCE USA

	local table_pojazdy4_0 = {} -- SAMOLOTY ZSRR
	local table_pojazdy4_1 = {} -- SAMOLOTY USA

	local table_pojazdy5_0 = {} -- POZOSTALE ZSRR
	local table_pojazdy5_1 = {} -- POZOSTALE USA

	for k, v in ipairs(query) do
		if(v.type == 1) then
			if(v.nation == 0) then
				player0_i = player0_i + 1

				table_player0[player0_i] = {}
				table_player0[player0_i].x = v.x
				table_player0[player0_i].y = v.y
				table_player0[player0_i].z = v.z
				table_player0[player0_i].rot = v.rot

			elseif(v.nation == 1) then
				player1_1 = player1_1 + 1
				
				table_player1[player1_1] = {}
				table_player1[player1_1].x = v.x
				table_player1[player1_1].y = v.y
				table_player1[player1_1].z = v.z
				table_player1[player1_1].rot = v.rot
			end
		end

		if(v.type == 2) then
			if(v.nation == 0) then
				pojazdy20 = pojazdy20 + 1

				table_pojazdy2_0[pojazdy20] = {}
				table_pojazdy2_0[pojazdy20].x = v.x
				table_pojazdy2_0[pojazdy20].y = v.y
				table_pojazdy2_0[pojazdy20].z = v.z
				table_pojazdy2_0[pojazdy20].rot = v.rot
			elseif(v.nation == 1) then
				pojazdy21 = pojazdy21 + 1

				table_pojazdy2_1[pojazdy21] = {}
				table_pojazdy2_1[pojazdy21].x = v.x
				table_pojazdy2_1[pojazdy21].y = v.y
				table_pojazdy2_1[pojazdy21].z = v.z
				table_pojazdy2_1[pojazdy21].rot = v.rot
			end
		end

		if(v.type == 3) then
			if(v.nation == 0) then
				pojazdy30 = pojazdy30 + 1

				table_pojazdy3_0[pojazdy30] = {}
				table_pojazdy3_0[pojazdy30].x = v.x
				table_pojazdy3_0[pojazdy30].y = v.y
				table_pojazdy3_0[pojazdy30].z = v.z
				table_pojazdy3_0[pojazdy30].rot = v.rot
			elseif(v.nation == 1) then
				pojazdy31 = pojazdy31 + 1

				table_pojazdy3_1[pojazdy31] = {}
				table_pojazdy3_1[pojazdy31].x = v.x
				table_pojazdy3_1[pojazdy31].y = v.y
				table_pojazdy3_1[pojazdy31].z = v.z
				table_pojazdy3_1[pojazdy31].rot = v.rot
			end
		end

		if(v.type == 4) then
			if(v.nation == 0) then
				pojazdy1_0_i = pojazdy1_0_i + 1

				table_pojazdy1_0[pojazdy1_0_i] = {}
				table_pojazdy1_0[pojazdy1_0_i].x = v.x
				table_pojazdy1_0[pojazdy1_0_i].y = v.y
				table_pojazdy1_0[pojazdy1_0_i].z = v.z
				table_pojazdy1_0[pojazdy1_0_i].rot = v.rot
			elseif(v.nation == 1) then
				pojazdy1_1_i = pojazdy1_1_i + 1

				table_pojazdy1_1[pojazdy1_1_i] = {}
				table_pojazdy1_1[pojazdy1_1_i].x = v.x
				table_pojazdy1_1[pojazdy1_1_i].y = v.y
				table_pojazdy1_1[pojazdy1_1_i].z = v.z
				table_pojazdy1_1[pojazdy1_1_i].rot = v.rot
			end
		end

		if(v.type == 5) then
			if(v.nation == 0) then
				pojazdy50 = pojazdy50 + 1

				table_pojazdy5_0[pojazdy50] = {}
				table_pojazdy5_0[pojazdy50].x = v.x
				table_pojazdy5_0[pojazdy50].y = v.y
				table_pojazdy5_0[pojazdy50].z = v.z
				table_pojazdy5_0[pojazdy50].rot = v.rot
			elseif(v.nation == 1) then
				pojazdy51 = pojazdy51 + 1

				table_pojazdy5_1[pojazdy51] = {}
				table_pojazdy5_1[pojazdy51].x = v.x
				table_pojazdy5_1[pojazdy51].y = v.y
				table_pojazdy5_1[pojazdy51].z = v.z
				table_pojazdy5_1[pojazdy51].rot = v.rot
			end

		end

		if(v.type == 6) then
			if(v.nation == 0) then
				pojazdy40 = pojazdy40 + 1

				table_pojazdy4_0[pojazdy40] = {}
				table_pojazdy4_0[pojazdy40].x = v.x
				table_pojazdy4_0[pojazdy40].y = v.y
				table_pojazdy4_0[pojazdy40].z = v.z
				table_pojazdy4_0[pojazdy40].rot = v.rot
			elseif(v.nation == 1) then
				pojazdy41 = pojazdy41 + 1

				table_pojazdy4_1[pojazdy41] = {}
				table_pojazdy4_1[pojazdy41].x = v.x
				table_pojazdy4_1[pojazdy41].y = v.y
				table_pojazdy4_1[pojazdy41].z = v.z
				table_pojazdy4_1[pojazdy41].rot = v.rot
			end
			
		end
	end
	
	setElementData(spawnROS, "player", table_player0)
	setElementData(spawnUSA, "player", table_player1)

	setElementData(spawnROS, "vehicle1", table_pojazdy1_0) -- samochody
	setElementData(spawnUSA, "vehicle1", table_pojazdy1_1)

	setElementData(spawnROS, "vehicle2", table_pojazdy3_0) -- pancerne
	setElementData(spawnUSA, "vehicle2", table_pojazdy3_1)

	setElementData(spawnROS, "vehicle3", table_pojazdy4_0) -- smiglowce
	setElementData(spawnUSA, "vehicle3", table_pojazdy4_1)

	setElementData(spawnROS, "vehicle4", table_pojazdy2_0) -- samoloty
	setElementData(spawnUSA, "vehicle4", table_pojazdy2_1)

	setElementData(spawnROS, "vehicle5", table_pojazdy5_0) -- pozostale
	setElementData(spawnUSA, "vehicle5", table_pojazdy5_1)

	outputServerLog("[SPAWNS] Zaladowano pomyslnie.") 


end
addEventHandler("onResourceStart", getResourceRootElement(), onResourceStartSpawn)