Config = {}
----------------------------------------------------------------
Config.checkForUpdates = true
Config.Debug = true
----------------------------------------------------------------
Config.Locations = {
    ['Marshall'] = {
        Coords = vector4(451.7164, -979.0562, 30.6896, 178.2531),
        JobTable = {'police', 'usms'}
    }
}
----------------------------------------------------------------
Config.OXTarget = false

Config.Target = {
    TargetSize = 2,
    InteractDistance = 5
}

Config.Marker = {
    type = 20,
    sizeX = 1.0,
    sizeY = 1.0,
    sizeZ = 1.0,
    r = 255,
    g = 255,
    b = 255,
    a = 100,
    rotate = true,
    distance = 2
}

Config.UsePed = {
    -- If you enable this, the enter marker is replaced with a ped
    Enabled = true,
    Model = 'mp_f_meth_01'
}