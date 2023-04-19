fx_version 'adamant'
games { 'gta5' }

author 'Musiker15 - MSK Scripts'
name 'msk_trackphone'
description 'Track a Player by his Phonenumber'
version '1.1'

shared_scripts {
	'@msk_core/import.lua'
	'config.lua'
}

client_scripts {
	'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'oxmysql',
	'msk_core'
}