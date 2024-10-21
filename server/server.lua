lib.locale()
local ox_inventory = exports.ox_inventory

local hookId = ox_inventory:registerHook('buyItem', function(payload)
    if not string.match(payload.itemName, "WEAPON_") then return end

    if payload.metadata and payload.metadata.registered and payload.metadata.serial then
        local serialString = tostring(payload.metadata.serial)
        local ownerString = qtm.Framework.GetChar(payload.source).fullname
        database[serialString] = ownerString
        saveDatabase(database)
    end
end, {
    print = true,
})

lib.callback.register('qtm-serial:server:getJob', function(source)
    return qtm.Framework.GetJob(source).name
end)

RegisterNetEvent('qtm-serial:server:doSerialStuff', function(point)
    if lib.table.contains(Config.Locations[point].JobTable, qtm.Framework.GetJob(source).name) then
        local serial = lib.callback.await('qtm-serial:client:getSerial', source)

        if database[serial] then
            TriggerClientEvent('qtm-serial:client:printResult', source, {serial = serial, owner = database[serial], type = 'valid'})
        else
            TriggerClientEvent('qtm-serial:client:printResult', source, {serial = serial, owner = locale('owner_error'), type = 'invalid'})
        end
    end
end)
