-- Default Hilbish config
local lunacolors = require 'lunacolors'
local bait = require 'bait'
local ansikit = require 'ansikit'

local function doPrompt(fail)
        hilbish.prompt(lunacolors.format(
                '{blue}%u {cyan}%d ' .. (fail and '{red}' or '{green}') .. '{red}♥ '
        ))
end

print(lunacolors.format(hilbish.greeting))

doPrompt()

bait.catch('command.exit', function(code)
        doPrompt(code ~= 0)
end)

bait.catch('hilbish.vimMode', function(mode)
        if mode ~= 'insert' then
                ansikit.cursorStyle(ansikit.blockCursor)
        else
                ansikit.cursorStyle(ansikit.lineCursor)
        end
end)

-- Aliases
hilbish.alias('c',  'clear')
hilbish.alias('tp', 'trash-put')
hilbish.alias('la', 'ls -a')
hilbish.alias('ll', 'ls -l')
hilbish.alias('hm', 'cd ~/')
hilbish.alias('ud', 'cd ..')
-- wezterm
hilbish.alias('tt', 'wezterm cli set-tab-title ')
-- nixos
hilbish.alias('uh', 'home-manager switch --flake .#sajenim@fuchsia')
hilbish.alias('us', 'sudo nixos-rebuild switch --flake .#fuchsia')
-- keymap directories
hilbish.alias('crkbd', 'cd ~/keyboards/qmk_keymaps/keyboards/crkbd/keymaps/sajenim/')
hilbish.alias('kchrn', 'cd ~/keyboards/qmk_keymaps/keyboards/keychron/q4/ansi_v2/keymaps/sajenim/')
