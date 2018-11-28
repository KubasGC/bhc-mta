function cmdBomba()
	local x, y, z = getElementPosition(localPlayer)
	local hit, hitX, hitY, hitZ = processLineOfSight(x, y, z, x, y, -10)

	if(hitZ == nil) then
		hit, hitX, hitY, hitZ = testLineAgainstWater(x, y, z, x, y, -10)
	end

	

	outputChatBox(tostring(hitZ))
end
addCommandHandler("bomba", cmdBomba)