-- fxmanifest.lua
fx_version 'cerulean'
game 'gta5'

lua54 'yes'  -- Enable Lua 5.4

author 'Your Name'
description 'Advanced Duty Script with ox_lib and Discord ACE Perms'
version '1.0.0'

shared_script '@ox_lib/init.lua'
client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'ox_lib'
}
