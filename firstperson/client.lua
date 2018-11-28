player = getLocalPlayer ( )
sw, sh = guiGetScreenSize ( )
mouse1_pressed = false
FPS_CAMERA = false

--FUNCTION MADE BY 'Doomed_Space_Marine', FIXED BY 'robhol'
function findRotation ( x1, y1, x2, y2 )
    local t = -math.deg ( math.atan2 ( x2 - x1, y2 - y1 ) )
    if t < 0 then t = t + 360 end
    return t
end

--ALWAYS SET CAMERA POSITION IN THE PLAYER'S HEAD
addEventHandler ( "onClientPreRender", getRootElement ( ),
    function ( )
	    if FPS_CAMERA then
            local x1, y1, z1 = getPedBonePosition ( player, 6 )
            local x, x, x, x2, y2, z2 = getCameraMatrix()
            setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
            --if not getControlState ( "aim_weapon" ) then setControlState ( "aim_weapon", false ) end
		end
    end )

--MAKE SURE THE PLAYER AIMS WITH THE MOUSE
addEventHandler ( "onClientCursorMove", getRootElement ( ),
    function ( guiy1, guiy1, guix2, guiy2, x2, y2, z2 )
        if not isCursorShowing ( ) and not isChatBoxInputActive ( ) and not isMainMenuActive ( ) and FPS_CAMERA then
            local x1, y1, z1 = getPedBonePosition ( player, 6 )
            setPedRotation ( player, findRotation ( x1, y1, x2, y2 ) )
	        setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
        end
    end )

--A SIMPLE WAY TO MAKE A KEY REPEATER
bindKey ( "mouse1", "both",
    function ( k, state )
	    if state == "down" then mouse1_pressed = true
		else mouse1_pressed = false end
    end )

--CONTROLS PART
function resetControls ( )
    toggleControl ( "aim_weapon",               true)
    toggleControl ( "backwards",     not FPS_CAMERA )
    toggleControl ( "sprint",        not FPS_CAMERA )
    toggleControl ( "right",         not FPS_CAMERA )
    toggleControl ( "left",          not FPS_CAMERA )
    toggleControl ( "fire",                     true)
	toggleControl ( "enter_vehicle",            true)
	toggleControl ( "enter_passenger",          true)
    if FPS_CAMERA then setElementAlpha ( player,  0 )
	else setElementAlpha ( player, 255 ) end
end

--DRAW A BEAUTIFUL CROSSHAIR IN THE MIDDLE OF THE SCREEN
addEventHandler ( "onClientRender", getRootElement ( ), function ( ) if FPS_CAMERA then dxDrawImage ( ( sw / 2 ) - 4, ( sh / 2 ) - 4, 8, 8, "crosshair.png" ) end end )

addCommandHandler ( "fp", function ( )
    FPS_CAMERA = not FPS_CAMERA
	if not FPS_CAMERA then setCameraTarget ( player ) end
	resetControls ( )
end )
