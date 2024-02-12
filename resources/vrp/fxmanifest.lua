shared_script "lib/lib.lua"

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "gui/index.html"

client_scripts {
	"config/Vehicles.lua",
	"config/Item.lua",
	"config/Native.lua",
	"lib/utils.lua",
	"client/*"
}

server_scripts {
	"config/Vehicles.lua",
	"config/Item.lua",
	"lib/utils.lua",
	"modules/*"
}

files {
	"lib/*",
	"gui/*",
	"loading/*",
	'index.html'
}

loadscreen "loading/index.html"