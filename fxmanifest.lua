        
fx_version('cerulean')
games({ 'gta5' })

author 'gasiguus#0'
description 'Advanced drug script'
version '1.0.1'


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
