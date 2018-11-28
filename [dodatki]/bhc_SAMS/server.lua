    addCommandHandler("build",
    function(player)
        local x,y,z = getElementPosition(player)
        local object = createObject(3267, x+1, y, z-1.5)
        local colshape = createColSphere(x, y, z, 200)
        setElementData(object, "SAM", true)
        setElementData(object, "owner", player)
        setElementData(object, "X", x)
        setElementData(object, "Y", y)
        setElementData(object, "Z", z)
        setElementData(object, "colsphere", colshape)
        setElementData(object, "pociski", 4)
        setElementData(object, "nation", getElementData(player, "nation"))
    end)
    
    setTimer(
        function()
            for id, value in ipairs(getElementsByType("object")) do
                if(getElementData(value, "SAM")) == true then
                    if(getElementData(value, "przeladowanie")) == false then
                        local pociski = getElementData(value, "pociski")
                        if(pociski > 0) then
                            for k, v in ipairs(getElementsWithinColShape(getElementData(value, "colsphere"), "player")) do
                                if(isPedInVehicle(v)) then
                                    local veh = getPedOccupiedVehicle(v)
                                    local veh2 = getElementModel(veh)
                                    if(veh2 == 425 or veh2 == 447 or veh2 == 464 or veh2 == 465 or veh2 == 469 or veh2 == 476 or veh2 == 487 or veh2 == 488 or veh2 == 497 or veh2 == 501 or veh2 == 511 or veh2 == 512 or veh2 == 513 or veh2 == 519 or veh2 == 520 or veh2 == 548 or veh2 == 553 or veh2 == 563 or veh2 == 577 or veh2 == 592 or veh2 == 593) then
                                        pociski = pociski - 1
                                        if(getElementData(value, "nation") ~= getElementData(v, "nation")) then    
                                            setElementData(value, "przeladowanie", true)
                                            setElementData(value, "pociski", pociski)
                                            setTimer(function() setElementData(value, "przeladowanie", false) end, 5000, 1)
                                            triggerClientEvent("jestSobieSAM", getRootElement(), value, veh)
                                        end
                                    end
                                end    
                            end
                        else
                            local sphere = getElementData(value, "colsphere")
                            destroyElement(sphere)
                            destroyElement(value)
                        end
                    end
                end
            end
        end, 2000, 0)