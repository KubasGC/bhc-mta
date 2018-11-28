function loadObject()
	local txd, dff, col
	
	txd = engineLoadTXD("betbar.txd", true)
	engineImportTXD(txd, 1837)
	dff = engineLoadDFF("betbar.dff", 0)
    engineReplaceModel(dff, 1837)
    col = engineLoadCOL("betbar.col")
    engineReplaceCOL(col, 1837)
    engineSetModelLODDistance(1837, 500)

    txd = engineLoadTXD("hesco.txd", true)
	engineImportTXD(txd, 1838)
	dff = engineLoadDFF("hesco.dff", 0)
    engineReplaceModel(dff, 1838)
    col = engineLoadCOL("hesco.col")
    engineReplaceCOL(col, 1838)
    engineSetModelLODDistance(1838, 500)

    txd = engineLoadTXD("mina.txd", true)
	engineImportTXD(txd, 1851)
	dff = engineLoadDFF("mina.dff", 0)
    engineReplaceModel(dff, 1851)
    col = engineLoadCOL("mina.col")
    engineReplaceCOL(col, 1851)
    engineSetModelLODDistance(1851, 500)

end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadObject)