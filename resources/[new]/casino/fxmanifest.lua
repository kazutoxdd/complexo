

fx_version 'cerulean'
game 'gta5'

ui_page('sound/client/html/index.html')

files({
    'sound/client/html/index.html',
    'sound/client/html/sounds/TD_BIG_WIN_01.ogg',
	'sound/client/html/sounds/TD_NO_WIN_01.ogg',
	'sound/client/html/sounds/TD_PLACE_BET.ogg',
	'sound/client/html/sounds/TD_PLACE_MAX_BET.ogg',
	'sound/client/html/sounds/TD_SMALL_WIN_01.ogg',
	'sound/client/html/sounds/TD_SPIN_01.ogg',
	'sound/client/html/sounds/TD_WELCOME_STINGER.ogg',
	'sound/client/html/sounds/LUCKY_WHEEL_WIN_WIN_CAR.ogg',
	'sound/client/html/sounds/TD_NO_WIN_03.ogg',
	'sound/client/html/sounds/LUCKY_WHEEL_WIN_WIN_CASH.ogg',
	'sound/client/html/sounds/LUCKY_WHEEL_WIN_WIN_CHIPS.ogg',
	'sound/client/html/sounds/LUCKY_WHEEL_WIN_STEREO_WIN_STINGER_GENERAL.ogg',
	'sound/client/html/sounds/TD_WIN_JACKPOT.ogg'
})
              


client_scripts {
    '@vrp/lib/utils.lua',
	'sound/client/main.lua',
	'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@vrp/lib/utils.lua',
	'sound/server/main.lua'
}              

server_scripts { '@mysql-async/lib/MySQL.lua' }              