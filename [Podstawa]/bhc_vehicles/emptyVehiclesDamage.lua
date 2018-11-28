function allVehs()
	local table = getElementsByType("vehicle")
	
	for k, v in ipairs(table) do
		if(getElementHealth(v) < 300) then
			if(getElementData(v, "removeTime") == false) then
				setElementData(v, "removeTime", getTickCount() + (1000 * 60 * 5))
			else
				if(getElementData(v, "removeTime") < getTickCount()) then
					destroyElement(v)
				end
			end
		end
	end
end
setTimer(allVehs, 5000, 0)