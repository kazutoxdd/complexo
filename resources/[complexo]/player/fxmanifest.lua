

fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/config/Item.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}              