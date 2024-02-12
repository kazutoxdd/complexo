


description 'rs_painel'
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page "index.html"
client_script "client.lua"

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua',
    'config.lua'
}


files {
    'index.html',
    'style.css',
    'index.js',
    'img/*'
}              