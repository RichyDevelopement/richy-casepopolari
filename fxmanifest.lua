fx_version 'cerulean'
game 'gta5'
lua54 'yes'

Descrizione 'Sistema case popolari'

Autore 'RICHY DEVELOPEMENT '

Discord 'https://discord.gg/richydev' 

shared_script "@es_extended/imports.lua"
shared_script '@ox_lib/init.lua'

client_script {
    'config.lua',
    "client/*.lua"
}

server_script {
    'config.lua',
    "server/*.lua"
}

dependencies {
	'ox_target',
	'ox_inventory',
}
