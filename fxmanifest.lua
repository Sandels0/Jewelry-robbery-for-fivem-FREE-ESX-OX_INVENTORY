fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Sandels'
description 'Jewelry Heist'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/*.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

escrow_ignore {
    'config.lua',
    'locales/*.lua'
}
