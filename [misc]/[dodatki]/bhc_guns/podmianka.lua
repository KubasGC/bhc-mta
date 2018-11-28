function loadObject()

	--

	txd = engineLoadTXD("AK-47/ak47.txd", true)
	engineImportTXD(txd, 355)
	
	dff = engineLoadDFF("AK-47/ak47.dff", 0)
	engineReplaceModel(dff, 355)

	--

	txd = engineLoadTXD("colt9mm/colt.txd", true)
	engineImportTXD(txd, 346)
	
	dff = engineLoadDFF("colt9mm/colt.dff", 0)
	engineReplaceModel(dff, 346)

	--

	txd = engineLoadTXD("countryRifle/country.txd", true)
	engineImportTXD(txd, 357)
	
	dff = engineLoadDFF("countryRifle/country.dff", 0)
	engineReplaceModel(dff, 357)

	--

	txd = engineLoadTXD("desertEagle/desert.txd", true)
	engineImportTXD(txd, 348)
	
	dff = engineLoadDFF("desertEagle/desert.dff", 0)
	engineReplaceModel(dff, 348)

	--

	txd = engineLoadTXD("m4/m4.txd", true)
	engineImportTXD(txd, 356)
	
	dff = engineLoadDFF("m4/m4.dff", 0)
	engineReplaceModel(dff, 356)

	--

	txd = engineLoadTXD("MP5/mp5.txd", true)
	engineImportTXD(txd, 353)
	
	dff = engineLoadDFF("MP5/mp5.dff", 0)
	engineReplaceModel(dff, 353)

	--

	txd = engineLoadTXD("Shotgun/shotgun.txd", true)
	engineImportTXD(txd, 349)
	
	dff = engineLoadDFF("Shotgun/shotgun.dff", 0)
	engineReplaceModel(dff, 349)

	--

	txd = engineLoadTXD("sniperRifle/sniper.txd", true)
	engineImportTXD(txd, 358)
	
	dff = engineLoadDFF("sniperRifle/sniper.dff", 0)
	engineReplaceModel(dff, 358)


end
addEventHandler("onClientResourceStart", resourceRoot, loadObject)