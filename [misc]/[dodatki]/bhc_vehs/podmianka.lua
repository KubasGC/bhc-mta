function loadObject()

	txd = engineLoadTXD("blackhawk/blackhawk.txd", true)
	engineImportTXD(txd, 563)
	
	dff = engineLoadDFF("blackhawk/blackhawk.dff", 0)
	engineReplaceModel(dff, 563)

	--

	txd = engineLoadTXD("littlebird/littlebird.txd", true)
	engineImportTXD(txd, 447)
	
	dff = engineLoadDFF("littlebird/littlebird.dff", 0)
	engineReplaceModel(dff, 447)

	--

	txd = engineLoadTXD("artillery/artillery.txd", true)
	engineImportTXD(txd, 443)
	
	dff = engineLoadDFF("artillery/artillery.dff", 0)
	engineReplaceModel(dff, 443)

	--

	txd = engineLoadTXD("v22/v22.txd", true)
	engineImportTXD(txd, 511)
	
	dff = engineLoadDFF("v22/v22.dff", 0)
	engineReplaceModel(dff, 511)

	--

	txd = engineLoadTXD("tupolew/tupolew.txd", true)
	engineImportTXD(txd, 553)
	
	dff = engineLoadDFF("tupolew/tupolew.dff", 0)
	engineReplaceModel(dff, 553)

	--

	txd = engineLoadTXD("chinook/chinook.txd", true)
	engineImportTXD(txd, 548)
	
	dff = engineLoadDFF("chinook/chinook.dff", 0)
	engineReplaceModel(dff, 548)

	--

	txd = engineLoadTXD("uaz/uaz.txd", true)
	engineImportTXD(txd, 500)
	
	dff = engineLoadDFF("uaz/uaz.dff", 0)
	engineReplaceModel(dff, 500)





end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadObject)