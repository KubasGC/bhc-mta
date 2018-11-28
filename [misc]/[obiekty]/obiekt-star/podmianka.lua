function loadObject()

	local txd = engineLoadTXD("Star.txd", true)
	engineImportTXD(txd, 2000)

	local dff = engineLoadDFF("Star.dff", 0)
    engineReplaceModel(dff, 2000)
 
    local col = engineLoadCOL("Star.col")
    engineReplaceCOL(col, 2000)
    engineSetModelLODDistance(2000, 500)

end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadObject)