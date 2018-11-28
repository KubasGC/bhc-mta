function loadObject()
	local dff
	dff = engineLoadDFF("fire.dff", 0)
    engineReplaceModel(dff, 1830)

    dff = engineLoadDFF("fire_bike.dff", 0)
    engineReplaceModel(dff, 1831)

    dff = engineLoadDFF("fire_car.dff", 0)
    engineReplaceModel(dff, 1832)

    dff = engineLoadDFF("fire_hat01.dff", 0)
    engineReplaceModel(dff, 1833)

    dff = engineLoadDFF("fire_hat02.dff", 0)
    engineReplaceModel(dff, 1834)

    dff = engineLoadDFF("fire_large.dff", 0)
    engineReplaceModel(dff, 1835)

    dff = engineLoadDFF("fire_med.dff", 0)
    engineReplaceModel(dff, 1836)

end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadObject)