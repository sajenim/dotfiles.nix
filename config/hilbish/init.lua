-- Default Hilbish config
local lunacolors = require 'lunacolors'
local bait = require 'bait'
local ansikit = require 'ansikit'

local function doPrompt(fail)
        hilbish.prompt(lunacolors.format(
                '{blue}%u {cyan}%d ' .. (fail and '{red}' or '{green}') .. '∆ '
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
hilbish.alias('c', 'clear')
hilbish.alias('hm', 'cd ~/')
hilbish.alias('tp', 'trash-put')
hilbish.alias('ud', 'cd ..')
hilbish.alias('la', 'ls -a')
hilbish.alias('ll', 'ls -l')
hilbish.alias('uh', 'home-manager switch --flake .#sajenim@fuchsia')
hilbish.alias('us', 'sudo nixos-rebuild switch --flake .#fuchsia')
