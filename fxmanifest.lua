fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'es_extended'
}

this_is_a_map 'yes'