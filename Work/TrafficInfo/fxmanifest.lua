fx_version "cerulean"

version '1.1'

game "gta5"

lua54 "yes"

author 'RDM Canadian'

description 'General Vehicle UI'

client_scripts {
    "nui.lua",
    "speedometer.lua"
}

ui_page 'html/index.html'

files {
    'html/index.css',
    'html/hud.js',
    'html/index.html',
    'speedometer.lua',
    'nui.lua'
}