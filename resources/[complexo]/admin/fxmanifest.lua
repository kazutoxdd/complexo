

fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/config/Vehicles.lua",
	"@vrp/config/Item.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/config/Vehicles.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}