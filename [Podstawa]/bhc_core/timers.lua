local timer
function globalTimer()
	--[[ Co sekundę dla wszystkich graczy ]]--
	local players = getElementsByType("player")
	for k, v in ipairs(players) do
		if(getElementData(v, "loggedIn") == 1) then
			local playerOnlineTime = getElementData(v, "onlineTime")
			playerOnlineTime = playerOnlineTime + 1
			setElementData(v, "onlineTime", playerOnlineTime)
		end
	end
end

addEventHandler("onResourceStart", getResourceRootElement(), function()
	if(timer) then killTimer(timer) end
	timer = setTimer(globalTimer, 1000, 0)
end)