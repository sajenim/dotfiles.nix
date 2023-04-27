import Xmobar

-- | Configuration
config :: Config
config = defaultConfig
  -- general settings
  { font            = "Fira Code Semi Bold 9"
  , additionalFonts = [ "Symbols Nerd Font 2048-em 24" ]
  , bgColor         = bg1
  , fgColor         = fg0
  , position        = Static { xpos = 1920, ypos = 1056, width = 2560, height = 24 }
  -- commands to run
  , commands =  [ ]
  -- format our bar
  , sepChar  = "%"
  , alignSep = "}{"
  , template = "<hspace=6/>}{<hspace=6/>"
  }

-- | Gruvbox material
bg0, bg1, fg0, fg1, red, orange, yellow, green, aqua, blue, purple :: String
-- backgrounds
bg0    = "#1d2021"
bg1    = "#282828"
-- foregrounds
fg0    = "#d4be98"
fg1    = "#ddc7a1"
-- greys
grey0  = "#7c6f64"
-- colors
red    = "#ea6962"
orange = "#e78a4e"
yellow = "#d8a658"
green  = "#a9b665"
aqua   = "#89b482"
blue   = "#7daea3"
purple = "#d3869b"

main :: IO ()
main = configFromArgs config >>= xmobar
