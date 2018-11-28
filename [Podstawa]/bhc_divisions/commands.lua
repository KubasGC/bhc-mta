function isNull(zmienna)
	if(zmienna == nil or zmienna == "") then return true end
	return false
end



function cmdDywizja(player, command, val0, val1, val2)
	if(tonumber(getElementData(player, "division:id")) == -1) then
		outputChatBox("BŁĄD: Nie jesteś w żadnej dywizji.", player, 163, 163, 163)
		return
	end

	
		if(isNull(val0)) then
			outputChatBox("SYNTAX: /dywizja [zapros | wypros | rank | opusc]", player, 163, 163, 163)
			return
		end

		if(val0 == "zapros") then
			if(tonumber(getElementData(player, "division:leader")) == 0) then return end
			if(isNull(val1)) then
				outputChatBox("SYNTAX: /dywizja zapros [IDGracza]", player, 163, 163, 163)
				return
			end

			local elem = getElementByID("p"..tonumber(val1))
			if(isElement(elem)) then
				if(getElementData(elem, "division:id") ~= -1) then
					outputChatBox("BŁĄD: Ten gracz jest już w innej dywizji.", player, 163, 163, 163)
					return
				end

				if(getElementData(elem, "division:id") == getElementData(player, "division:id")) then
					outputChatBox("BŁĄD: Ten gracz jest już w Twojej dywizji.", player, 163, 163, 163)
					return
				end

				setElementData(elem, "division:id", tonumber(getElementData(player, "division:id")))
				setElementData(elem, "division:leader", 0)
				savePlayerDivision(elem)

				outputChatBox("INFORMACJA: Dodałeś gracza "..string.gsub(getPlayerName(elem), "_", " ").." do swojej dywizji.", player, 163, 163, 163)
				outputChatBox("INFORMACJA: Zostałeś dodany do dywizji przez gracza "..string.gsub(getPlayerName(player), "_", " "), elem, 163, 163, 163)
				return
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end

		elseif(val0 == "wypros") then
			if(tonumber(getElementData(player, "division:leader")) == 0) then return end
			if(isNull(val1)) then
				outputChatBox("SYNTAX: /dywizja wypros [IDGracza]", player, 163, 163, 163)
				return
			end

			local elem = getElementByID("p"..tonumber(val1))
			if(isElement(elem)) then
				if(player == elem) then
					outputChatBox("BŁĄD: Nie możesz wyrzucić sam siebie.", player, 163, 163, 163)
					return
				end

				if(tonumber(getElementData(elem, "division:id")) ~= tonumber(getElementData(player, "division:id"))) then
					outputChatBox("BŁĄD: Ten gracz nie jest w Twojej dywizji.", player, 163, 163, 163)
					return
				end

				setElementData(elem, "division:id", -1)
				setElementData(elem, "division:leader", 0)
				savePlayerDivision(elem)

				outputChatBox("INFORMACJA: Wyrzuciłeś gracza "..string.gsub(getPlayerName(elem), "_", " ").." ze swojej dywizji.", player, 163, 163, 163)
				outputChatBox("INFORMACJA: Zostałeś wyrzucony z dywizji przez gracza "..string.gsub(getPlayerName(player), "_", " "), elem, 163, 163, 163)
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end
		elseif(val0 == "rank") then
			if(tonumber(getElementData(player, "division:leader")) == 0) then return end
			if(isNull(val1) or isNull(val2)) then
				outputChatBox("SYNTAX: /dywizja rank [IDGracza] [numer rangi]", player, 163, 163, 163)
				return
			end

			local elem = getElementByID("p"..tonumber(val1))
			if(isElement(elem)) then

				if(tonumber(getElementData(elem, "division:id")) ~= tonumber(getElementData(player, "division:id"))) then
					outputChatBox("BŁĄD: Ten gracz nie jest w Twojej dywizji.", player, 163, 163, 163)
					return
				end

				setElementData(elem, "division:rank", val2)
				savePlayerDivision(elem)

				
			else
				outputChatBox("BŁĄD: Nie znaleziono gracza o podanym ID.", player, 163, 163, 163)
				return
			end
		elseif(val0 == "opusc") then
			outputChatBox("Opuściłeś dywizję.", player, 163, 163, 163)
			setElementData(player, "division:id", -1)
			setElementData(player, "division:leader", 0)
			setElementData(player, "division:data", 0)
			setElementData(player, "division:rank", 0)
		end
end
addCommandHandler("dywizja", cmdDywizja)