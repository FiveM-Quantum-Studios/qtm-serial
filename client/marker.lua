lib.locale()
Citizen.CreateThread(function()
    if not Config.OXTarget then
        local marker = Config.Marker
        for locationId, data in pairs(Config.Locations) do
            local coords = data.Coords
            local enterMarker = lib.points.new({
                coords = coords,
                distance = 20,
                interactPoint = nil,
                nearby = function()
                    if not Config.UsePed.Enabled then
                        DrawMarker(marker.type, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0 , 0.0, 0.0, 0.0, marker.sizeX, marker.sizeY, marker.sizeZ, marker.r, marker.b, marker.g, marker.a, false, false, 0, marker.rotate, false, false, false)
                    end
                end,
                onEnter = function(self)
                    if self.interactPoint then return end
                    if Config.UsePed.Enabled then
                        lib.requestModel(Config.UsePed.Model)
                        local ped = CreatePed(CIVMALE, GetHashKey(Config.UsePed.Model), coords.x, coords.y, coords.z - 1, coords.w, false, true)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                    end
                    self.interactPoint = lib.points.new({
                        coords = coords,
                        distance = 1,
                        nearby = function()
                            if IsControlJustReleased(0, 51) then
                                TriggerServerEvent('qtm-serial:server:doSerialStuff', locationId)
                            end
                        end,
                        onEnter = function()
                            lib.showTextUI(locale('textUI'))
                        end,
                        onExit = function()
                            lib.hideTextUI()
                        end
                    })
                end,
                onExit = function(self)
                    if not self.interactPoint then return end
                    if Config.UsePed.Enabled then
                        DeletePed(ped)
                    end
                    self.interactPoint:remove()
                    self.interactPoint = nil
                end,
            })
        end
    else
        for locationId, data in pairs(Config.Locations) do
            exports.ox_target:addSphereZone({
                coords = data.Coords,
                radius = Config.Target.TargetSize,
                debug = Config.Debug,
                drawSprite = Config.Debug,
                options = {
                    {
                        name = 'PoliceSerialLookUp'..locationId,
                        label = locale('textUI'),
                        distance = Config.Target.InteractDistance,
                        onSelect = function(data)
                            TriggerServerEvent('qtm-serial:server:doSerialStuff', locationId)
                        end,
                    }
                }
            })
        end
    end
end)

lib.callback.register('qtm-serial:client:getSerial', function()
    local input = lib.inputDialog('Serial Input', {
        {type = 'input', label = 'Serial input', description = 'Put the serial you want to lookup here', required = true},
      })
    return input[1]
end)

RegisterNetEvent('qtm-serial:client:printResult', function(data)
    local alert = lib.alertDialog({
        header = locale('serial_'..data.type),
        content = locale('serial')..': '..data.serial..'  \n '..locale('owner')..': '..data.owner,
        centered = true,
        cancel = false
    })
end)