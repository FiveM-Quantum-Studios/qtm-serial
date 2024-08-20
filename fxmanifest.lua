fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Quantum Studios'
description 'Description'
version '1.0.0'

dependencies {
    'ox_lib',
    'qtm-lib'
}


shared_scripts {
    '@qtm-lib/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'client/*.lua',
}
server_scripts {
    'server/*.lua',
}
files {
    'database.json',
    'locales/*.*',
}