function jestSobieSAM(samid, veh)
    local creator = getElementData(samid, "owner")
    local X = getElementData(samid, "X")  
    local Y = getElementData(samid, "Y") 
    local Z = getElementData(samid, "Z")   
    
    createProjectile(creator, 20, X, Y, Z + 2, 50, veh, 0, 0, 0, 0.2, 0.2, 0.2)
end
addEvent("jestSobieSAM", true)
addEventHandler("jestSobieSAM", getRootElement(), jestSobieSAM)