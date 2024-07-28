import Xmobar

-- | Configuration
config :: Config
config = defaultConfig
  -- general settings
  { font            = "Fira Code Semi Bold 9"
  , additionalFonts = [ "Symbols Nerd Font 2048-em 24" ]
  , bgColor         = "#282828"
  , fgColor         = "#d4be98"
  , position        = Static { xpos = 1920, ypos = 0, width = 2560, height = 24 }
  -- commands to run
  , commands =
      [ Run $ XPropertyLog "_XMONAD_LOG_1"
      , Run $ Com "uname" ["-r","-s"] "" 0
      , Run $ Date "%a %b %_d %Y <fc=#d8a657>%H:%M:%S</fc>" "date" 10
      , Run $ Weather "YPJT"
                      [ "-t", "Temp: <fc=#d3869b><tempC>C</fc> <fc=#7c6f64>|</fc> Wind: <fc=#a9b665><windKmh>km/h</fc> <fc=#7c6f64>|</fc> Humidity: <fc=#e78a4e><rh>%</fc>" ]
                      18000
      ]
  -- format our bar
  , sepChar  = "%"
  , alignSep = "}{"
  , template = "<hspace=6/><fn=1>\59255</fn>  <fc=#a9b665>%uname%</fc> <fc=#7c6f64>|</fc>%_XMONAD_LOG_1%}{%YPJT% <fc=#7c6f64>|</fc> %date%<hspace=6/>"
  }

main :: IO ()
main = configFromArgs config >>= xmobar
