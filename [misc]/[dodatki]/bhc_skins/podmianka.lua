function loadObject()

	txd = engineLoadTXD("USA/skinUSA.txd", true)
	engineImportTXD(txd, 285)

	dff = engineLoadDFF("USA/skinUSA.dff", 0)
	engineReplaceModel(dff, 285)

	txd = engineLoadTXD("zsrr.txd", true)
	engineImportTXD(txd, 61)  -- 61 zsrr
	
	dff = engineLoadDFF("zsrr.dff", 0)
	engineReplaceModel(dff, 61)


end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadObject)