import Xmobar
import System.Environment (getEnv)
import System.IO.Unsafe   (unsafeDupablePerformIO)

-- | Candybar
config :: Config
config = defaultConfig
  -- general settings
  { font            = "Fira Code Semi Bold 9"
  , additionalFonts = [ ]
  , bgColor         = "#282828"
  , fgColor         = "#d4be98"
  , position        = Static { xpos = 1920, ypos = 0, width = 2560, height = 24 }
  , iconRoot        = homeDir <> "/.config/xmonad/icons"
  -- commands to run
  , commands = 
      [ Run $ XMonadLog
      ]
  -- format our bar
  , sepChar  = "%"
  , alignSep = "}{"
  , template = "\59255 %XMonadLog%"
  }

-- | Get home directory
homeDir :: String
homeDir = unsafeDupablePerformIO (getEnv "HOME")

main :: IO ()
main = configFromArgs config >>= xmobar
