        
fx_version('cerulean')
games({ 'gta5' })

lua54 'yes'

server_scripts{
  'sv_*.lua',
  'config.lua'
}

client_scripts{
    'cl_*.lua',
    'config.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}
