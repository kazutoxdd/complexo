

fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/core.lua",
	'client/client.lua',
	'client/mph4_gtxd.meta',
	'client/water.lua'
}

server_scripts {
	"@vrp/config/Vehicles.lua",
	"@vrp/lib/utils.lua",
	"server/server.lua"
}

data_file 'GTXD_PARENTING_DATA' 'client/mph4_gtxd.meta'              