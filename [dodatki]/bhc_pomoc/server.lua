local zmienne = {}

function onResourceStart()
	local query = exports.DB:fetchArray("SELECT * FROM `bhc_preferences` WHERE `id` = '1'")

	zmienne.zmienna1 = query.ogolnaPomoc
	zmienne.zmienna2 = query.ogolneKomendy
	zmienne.zmienna3 = query.ogolneArta

end
addEventHandler("onResourceStart", resourceRoot, onResourceStart)

function onPlayerJoin()
	triggerClientEvent(source, "loadGUI", root, zmienne.zmienna1, zmienne.zmienna2, zmienne.zmienna3)
end
addEventHandler("onPlayerJoin", root, onPlayerJoin)