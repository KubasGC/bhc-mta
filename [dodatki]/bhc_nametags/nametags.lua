-------[EDITED] mR|Monster--------------------
-------[ORIGINAL AUTHOR] Yakuza.Real ---------

srfont = dxCreateFont("font.ttf",50)

g_Root = getRootElement()
g_ResRoot = getResourceRootElement(getThisResource())
g_Players = getElementsByType('player')
g_Me = getLocalPlayer()
 
nametag = {}
local nametags = {}
local g_screenX,g_screenY = guiGetScreenSize()
local bHideNametags = false
 
local NAMETAG_SCALE = 0.03 --Overall adjustment of the nametag, use this to resize but constrain proportions
local NAMETAG_ALPHA_DISTANCE = 50 --Distance to start fading out
local NAMETAG_DISTANCE = 100 --Distance until we're gone
local NAMETAG_ALPHA = 255 --The overall alpha level of the nametag
--The following arent actual pixel measurements, they're just proportional constraints
local NAMETAG_TEXT_BAR_SPACE = 2
local NAMETAG_WIDTH = 30
local NAMETAG_HEIGHT = 5
local NAMETAG_TEXTSIZE = 0.3
local NAMETAG_OUTLINE_THICKNESS = 0
 
 
--
local NAMETAG_ALPHA_DIFF = NAMETAG_DISTANCE - NAMETAG_ALPHA_DISTANCE
NAMETAG_SCALE = 1/NAMETAG_SCALE * 800 / g_screenY
 
-- Ensure the name tag doesn't get too big
local maxScaleCurve = { {0, 0}, {3, 3}, {13, 5} }
-- Ensure the text doesn't get too small/unreadable
local textScaleCurve = { {0, 0.8}, {0.8, 1.2}, {99, 99} }
-- Make the text a bit brighter and fade more gradually
local textAlphaCurve = { {0, 0}, {25, 100}, {120, 190}, {255, 190} }
 
function nametag.create ( player )
	nametags[player] = true
end
 
function nametag.destroy ( player )
	nametags[player] = nil
end
 
addEventHandler ( "onClientRender", g_Root,
	function()
		-- Hideous quick fix --
		for _, v in ipairs(getElementsByType("player")) do
			if(isElement(v)) then
					if(v ~= getLocalPlayer()) then
						if not nametags[v] then
							nametag.create(v)
						end
					end
			end
		end
		if bHideNametags then
			return
		end
		local x,y,z = getCameraMatrix()
   
		for player in pairs(nametags) do
			local nation = getElementData(player, "nation")
			local mnation = getElementData(g_Me, "nation")
			if(nation == mnation or getElementData(localPlayer, "adminDuty") == 1 or getElementData(player, "adminDuty") == 1) then
				while true do
					if not isElement(player) then break end
					if getElementDimension(player) ~= getElementDimension(g_Me) then break end
					local px,py,pz = getElementPosition ( player )
					if processLineOfSight(x, y, z, px, py, pz, true, false, false, true, false, true) then break end
					local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
					if pdistance <= NAMETAG_DISTANCE then
						--Get screenposition
						local sx,sy = getScreenFromWorldPosition ( px, py, pz+1.2, 0.06 )
						if not sx or not sy then break end
						--Calculate our components
						local scale = 1/(NAMETAG_SCALE * (pdistance / NAMETAG_DISTANCE))
						local alpha = ((pdistance - NAMETAG_ALPHA_DISTANCE) / NAMETAG_ALPHA_DIFF)
						alpha = (alpha < 0) and NAMETAG_ALPHA or NAMETAG_ALPHA-(alpha*NAMETAG_ALPHA)
						scale = math.evalCurve(maxScaleCurve,scale)
						local textscale = math.evalCurve(textScaleCurve,scale)
						local textalpha = math.evalCurve(textAlphaCurve,alpha)
						local outlineThickness = NAMETAG_OUTLINE_THICKNESS*(scale)
						--Draw our text

						local dywizja = getElementData(player, "division:id")
						local dname = "Brak"
						if(dywizja == 0) then
							dname = "Piechota"
						elseif(dywizja == 1) then
							dname = "Pancerna"
						elseif(dywizja == 2) then
							dname = "Lotnicza"
						elseif(dywizja == 3) then
							dname = "Transportowa"
						end

						local admin = ""
						if(getElementData(player, "adminDuty") == 1) then
							local MGI = getElementData(player, "admin")

							if(MGI == 3) then
								admin = "#ff0000 Administrator"
							elseif(MGI == 4) then
								admin = "#8b1a1a Główny Administrator"
							elseif(MGI == 2) then
								admin = "#008030 GameMaster"
							elseif(MGI == 1) then
								admin = "#6699ff Supporter"
							end
						end

						local nazwa = getPlayerNameR(player)
						if(admin ~= "") then
							nazwa = getElementData(player, "global:name")
						end

						if(getElementData(localPlayer, "adminDuty") == 1) then
							if(nation == 0) then
								nazwa = "#ff0000"..nazwa
							else
								nazwa = "#00ff00"..nazwa
							end
						end

						if(getElementData(player, "nickDMG") == true) then
							nazwa = "#ff0000"..nazwa
						end

						if(getElementData(player, "playerSpawned") == false) then
							nazwa = "#494A45"..nazwa
						end

						local offset = (scale) * NAMETAG_TEXT_BAR_SPACE/2
						local w = dxGetTextWidth(getPlayerNameR(player), textscale * NAMETAG_TEXTSIZE, srfont) / 2

						if(getElementData(player, "division:rank") ~= false and getElementData(player, "division:rank") ~= 0) then
							local nazwa
							if(getElementData(player, "nation") == 1) then nazwa = "USA" else nazwa = "ZSRR" end
							local sx2,sy2 = getScreenFromWorldPosition ( px, py, pz+1.5, 1 )
							local value = (NAMETAG_DISTANCE - pdistance) / NAMETAG_DISTANCE
							if(value <= 1) then
								dxDrawImage(sx2 - (50 * value) + 20, sy2 - (52 * value) - (25 * value), 50 * value, 52 * value, "images/"..nazwa.."/"..tostring(getElementData(player, "division:rank"))..".png", 0, 0, 0, tocolor(255, 255, 255, textalpha), false)
							end
						end

						

						dxDrawColorText ( "#ffffff"..admin, sx-w , sy - offset, sx, sy - offset - 0.022 * g_screenY, tocolor(255, 255, 255,textalpha), 0.25, srfont, "center", "bottom", false, false, false )
						dxDrawColorText ( "#ffffff "..nazwa.." #e9d971("..getElementData(player, "id")..")", sx-w, sy - offset, sx, sy - offset, tocolor(255, 255, 255,textalpha), textscale*NAMETAG_TEXTSIZE, srfont, "center", "bottom", false, false, false )
						if(admin == "") then
							dxDrawColorText ( "#ffffff  Dywizja: #e9d971"..dname, sx-w, sy - offset, sx, sy - offset, tocolor(255, 255, 255,textalpha), (textscale*NAMETAG_TEXTSIZE) / 1.5, srfont, "center", "top", false, false, false )
						end
					end
					break
				end
			end
		end
	end
)
 
 
---------------THE FOLLOWING IS THE MANAGEMENT OF NAMETAGS-----------------
addEventHandler('onClientResourceStart', getResourceRootElement(getThisResource()),
	function()
		for i,player in ipairs(getElementsByType("player")) do
			if player ~= g_Me then
					nametag.create ( player )
			end
		end
	end
)

addEventHandler ( "onClientPlayerJoin", g_Root,
	function()
		if source == g_Me then return end
			nametag.create ( source )
	end
)
 
addEventHandler ( "onClientPlayerQuit", g_Root,
	function()
		nametag.destroy ( source )
	end
)
 
-- Math functions
function math.lerp(from,to,alpha)
	return from + (to-from) * alpha
end
 
-- curve is { {x1, y1}, {x2, y2}, {x3, y3} ... }
function math.evalCurve( curve, input )
	-- First value
	if input<curve[1][1] then
		return curve[1][2]
	end
	-- Interp value
	for idx=2,#curve do
		if input<curve[idx][1] then
			local x1 = curve[idx-1][1]
			local y1 = curve[idx-1][2]
			local x2 = curve[idx][1]
			local y2 = curve[idx][2]
			-- Find pos between input points
			local alpha = (input - x1)/(x2 - x1);
			-- Map to output points
			return math.lerp(y1,y2,alpha)
		end
	end
	-- Last value
	return curve[#curve][2]
end

 function removeColorCoding ( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

function getPlayerNameR ( player )
	local nick = removeColorCoding (getPlayerName(player))
	nick = nick:gsub("_", " ")
	return nick
end


function dxDrawColorText(str, ax, ay, bx, by, color, scale, font,alignX,alignY,clip, wordBreak, postGUI)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  while s do
	if s ~= 1 or cap ~= "" then 
	  local w = dxGetTextWidth(cap, scale, font)
	  dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,alignX,alignY,clip, wordBreak, postGUI)
	  ax = ax + w
	  color = tocolor(tonumber("0x"..string.sub(col, 1, 2)), tonumber("0x"..string.sub(col, 3, 4)), tonumber("0x"..string.sub(col, 5, 6)), 255)
	end
	last = e+1
	s, e, cap, col = str:find(pat, last)
  end
  if last <= #str then
	cap = str:sub(last)
	local w = dxGetTextWidth(cap, scale, font)
	dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,alignX,alignY,clip, wordBreak, postGUI, true)
  end
end 

function giveDamagehehe (attacker, weapon, bodypart)
	if(isTimer(getElementData(localPlayer, "timerNicku"))) then
		killTimer(getElementData(localPlayer, "timerNicku"))
	end
	setElementData(localPlayer, "nickDMG", true)
	local timer = setTimer(function() setElementData(localPlayer, "nickDMG", false) end, 500, 1)

	setElementData(localPlayer, "timerNicku", timer)
end
addEventHandler ("onClientPlayerDamage", localPlayer, giveDamagehehe)