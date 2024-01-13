fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_script '@ox_lib/init.lua'

server_script {
  'config.lua',
	'@qbx_core/modules/playerdata.lua',
  'server.lua',
}