local leadersElement = createElement("divisionLeaders", "divisionLeaders")

function onResourceStart()
	local leaders = exports.DB:getArray("SELECT * FROM `bhc_divisionLeaders`")
	local i = 0
	for k, v in ipairs(leaders) do
		i = i + 1
		if(v.nation == 0) then -- ZSRR

			local name = "BRAK"
			if(v.guid ~= 0) then
				name = v.username
			end
			if(v.division == 0) then

				setElementData(leadersElement, "ZSRR:PIECHOTA.guid", v.guid)
				setElementData(leadersElement, "ZSRR:PIECHOTA.name", name)
			elseif(v.division == 1) then

				setElementData(leadersElement, "ZSRR:PANCERNA.guid", v.guid)
				setElementData(leadersElement, "ZSRR:PANCERNA.name", name)
			elseif(v.division == 2) then

				setElementData(leadersElement, "ZSRR:LOTNICZA.guid", v.guid)
				setElementData(leadersElement, "ZSRR:LOTNICZA.name", name)
			elseif(v.division == 3) then

				setElementData(leadersElement, "ZSRR:TRANSPORTOWA.guid", v.guid)
				setElementData(leadersElement, "ZSRR:TRANSPORTOWA.name", name)
			end


		elseif(v.nation == 1) then -- USA

			local name = "BRAK"
			if(v.guid ~= 0) then
				name = v.username
			end
			if(v.division == 0) then
				setElementData(leadersElement, "USA:PIECHOTA.guid", v.guid)
				setElementData(leadersElement, "USA:PIECHOTA.name", name)
			elseif(v.division == 1) then
				setElementData(leadersElement, "USA:PANCERNA.guid", v.guid)
				setElementData(leadersElement, "USA:PANCERNA.name", name)
			elseif(v.division == 2) then
				setElementData(leadersElement, "USA:LOTNICZA.guid", v.guid)
				setElementData(leadersElement, "USA:LOTNICZA.name", name)
			elseif(v.division == 3) then
				setElementData(leadersElement, "USA:TRANSPORTOWA.guid", v.guid)
				setElementData(leadersElement, "USA:TRANSPORTOWA.name", name)
			end
			
		end
	end
	outputServerLog("[GENERALOWIE] Zaladowano "..i.." rekordow z bazy danych.")
end
addEventHandler("onResourceStart", getResourceRootElement(), onResourceStart)

function saveSometimes()
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "ZSRR:PIECHOTA.name").."', `guid` = '"..getElementData(leadersElement, "ZSRR:PIECHOTA.guid").."' WHERE `division` = '0' and `nation` = '0'")
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "ZSRR:PANCERNA.name").."', `guid` = '"..getElementData(leadersElement, "ZSRR:PANCERNA.guid").."' WHERE `division` = '1' and `nation` = '0'")
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "ZSRR:LOTNICZA.name").."', `guid` = '"..getElementData(leadersElement, "ZSRR:LOTNICZA.guid").."' WHERE `division` = '2' and `nation` = '0'")
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "ZSRR:TRANSPORTOWA.name").."', `guid` = '"..getElementData(leadersElement, "ZSRR:TRANSPORTOWA.guid").."' WHERE `division` = '3' and `nation` = '0'")

	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "USA:PIECHOTA.name").."', `guid` = '"..getElementData(leadersElement, "USA:PIECHOTA.guid").."' WHERE `division` = '0' and `nation` = '1'")
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "USA:PANCERNA.name").."', `guid` = '"..getElementData(leadersElement, "USA:PANCERNA.guid").."' WHERE `division` = '1' and `nation` = '1'")
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "USA:LOTNICZA.name").."', `guid` = '"..getElementData(leadersElement, "USA:LOTNICZA.guid").."' WHERE `division` = '2' and `nation` = '1'")
	exports.DB:zapytanie("UPDATE `bhc_divisionLeaders` SET `username` = '"..getElementData(leadersElement, "USA:TRANSPORTOWA.name").."', `guid` = '"..getElementData(leadersElement, "USA:TRANSPORTOWA.guid").."' WHERE `division` = '3' and `nation` = '1'")
end
setTimer(saveSometimes, 1000 * 60 * 15, 0)