local datastring = LoadResourceFile(GetCurrentResourceName(), "database.json")
database = json.decode(datastring)

---@param data table
saveDatabase = function(data)
    SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data, { indent = true }), -1)
end

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    saveDatabase(database)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        Wait(30000)
        saveDatabase(database) -- save 30 seconds bevor server restart
    end
end)
