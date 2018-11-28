if(SQL) then destroyElement(SQL) end
local SQL

function connect()
    SQL = dbConnect("mysql", "dbname=bhc;host=127.0.0.1", "bhc","secret","share=1")
    if (not SQL) then
        outputServerLog("[MySQL] Brak polaczenia")
    else
        outputServerLog("[MySQL] Polaczono")
    end
end
addEventHandler("onResourceStart", getResourceRootElement(), connect)

addEventHandler("onResourceStop", getResourceRootElement(), function()
destroyElement(SQL)
outputServerLog("[MySQL] Rozlaczono")
end)

function fetchArray(...)
    local h=dbQuery(SQL,...)
    if (not h) then 
        return nil
    end
    local rows = dbPoll(h, -1)
    if not rows then return nil end
    return rows[1]
end

function zapytanie(...)
    local h=dbQuery(SQL,...)
    local result,numrows, lastinsertid =dbPoll(h,-1)
    return numrows, lastinsertid
end

function getArray(...)
    local h=dbQuery(SQL,...)
    if (not h) then 
        return nil
    end
    local rows = dbPoll(h, -1)
    return rows
end