-- Base
import XMonad
import System.Exit
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CycleWS

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

-- Layout modifiers
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)

-- xmobar dependencies
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers

-- | Configuration
myTerminal           = "wezterm"
myModMask            = mod4Mask
myBorderWidth        = 5
myNormalBorderColor  = "#282828"
myFocusedBorderColor = "#282828"
myWorkspaces         = ["code", "chat", "web", "games", "misc"]

-- | Keybindings
myKeys =
    -- launching and killing programs
    [ ("M-n"            , spawn myTerminal                 ) -- %! Launch terminal
    , ("M-e"            , spawn "rofi -show run"           ) -- %! Launch rofi
    , ("M-C-w"          , kill                             ) -- %! Close the focused window
    -- layouts
    , ("M-t"            , sendMessage $ JumpToLayout "Spacing Tiled") -- %! Jump to our tiled layout
    , ("M-m"            , sendMessage $ JumpToLayout "Maximized"    ) -- %! Jump to our maximized layout
    , ("M-f"            , sendMessage $ JumpToLayout "Fullscreen"   ) -- %! Jump to our fullscreen layout
    -- move focus up or down the window stack
    , ("M-<Down>"       , windows W.focusDown              ) -- %! Move focus to the next window
    , ("M-<Up>"         , windows W.focusUp                ) -- %! Move focus to the previous window
    , ("M-<Return>"     , windows W.focusMaster            ) -- %! Move focus to the master window 
    -- modifying the window order
    , ("M-S-<Down>"     , windows W.swapDown               ) -- %! Swap the focused window with the next window
    , ("M-S-<Up>"       , windows W.swapUp                 ) -- %! Swap the focused window with the previous window
    , ("M-S-<Return>"   , windows W.swapMaster             ) -- %! Swap the focused window with the master window
    -- resizing the master/slave ratio
    , ("M-<Page_Up>"    , sendMessage Expand               ) -- %! Expand the master area
    , ("M-<Page_Down>"  , sendMessage Shrink               ) -- %! Shrink the master area
    -- number of windows in the master area
    , ("M-S-<Page_Up>"  , sendMessage (IncMasterN 1)       ) -- %! Increase the number of windows in the master area
    , ("M-S-<Page_Down>", sendMessage (IncMasterN (-1))    ) -- %! Decrease the number of windows in the master area
    -- floating layer support
    , ("M-<Space>"      , withFocused $ windows . W.sink            ) -- %! Push window back into tiling
    -- workspace navigation
    , ("M-<Right>"      , moveTo Next hiddenWS             ) -- %! Move focus to the next hidden workspace
    , ("M-<Left>"       , moveTo Prev hiddenWS             ) -- %! Move focus to the previous hidden workspace
    -- move window to workspace
    , ("M-S-<Right>"    , shiftTo Next hiddenWS            ) -- %! Move focused window to the next hidden workspace
    , ("M-S-<Left)"     , shiftTo Prev hiddenWS            ) -- %! Move focused window to the previous hidden workspace
    -- move focus up or down the screen stack
    , ("M-<End>"        , nextScreen                       ) -- %! Move focus to the next screen
    , ("M-<Home>"       , prevScreen                       ) -- %! Move focus to the previous screen
    -- move windows between screens
    , ("M-S-<End>"      , shiftNextScreen                  ) -- %! Move focused window to the next screen
    , ("M-S-<Home>"     , shiftPrevScreen                  ) -- %! Move focused window to the previous screen
    -- quit, or restart
    , ("M-S-q"          , io exitSuccess                   ) -- %! Quit xmonad
    ]

-- | Layouts
myLayout = tiled ||| full
  where
    -- Add a configurable amount of space around windows.
    gaps     = spacingRaw False (Border 10 10 10 10) True (Border 10 10 10 10) True
    -- Our layouts
    tiled    = renamed [Replace "Spacing Tiled"] . avoidStruts . gaps $ Tall nmaster delta ratio
    full     = renamed [Replace "Fullscreen"]    $ noBorders Full
    -- Layout settings
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

-- | Xmobar
xmobarTop    = statusBarPropTo "_XMONAD_LOG_1" "xmobar-top"    (pure ppTop)

ppTop :: PP
ppTop = def
    { ppSep             = grey0 " | "
    , ppTitleSanitize   = xmobarStrip
    -- workspace labels
    , ppCurrent         = purple . wrap " " ""
    , ppVisible         = blue   . wrap " " ""
    , ppHidden          = grey0  . wrap " " ""
    , ppHiddenNoWindows = grey0  . wrap " " ""
    , ppUrgent          = red    . wrap " " ""
    -- misc
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (grey0 "") (grey0 " ") . purple . ppWindow
    formatUnfocused = wrap (grey0 "") (grey0 " ") . blue   . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
    
    -- | Gruvbox material
    bg0, bg1, fg0, fg1, red, orange, yellow, green, aqua, blue, purple :: String -> String
    -- backgrounds
    bg0    = xmobarColor "#1d2021" ""
    bg1    = xmobarColor "#282828" ""
    -- foregrounds
    fg0    = xmobarColor "#d4be98" ""
    fg1    = xmobarColor "#ddc7a1" ""
    -- greys
    grey0  = xmobarColor "#7c6f64" ""
    -- colors
    red    = xmobarColor "#ea6962" ""
    orange = xmobarColor "#e78a4e" ""
    yellow = xmobarColor "#d8a658" ""
    green  = xmobarColor "#a9b665" ""
    aqua   = xmobarColor "#89b482" ""
    blue   = xmobarColor "#7daea3" ""
    purple = xmobarColor "#d3869b" ""

-- | The main function
main :: IO ()
main = xmonad
     . docks
     . ewmhFullscreen
     . ewmh
     . withSB (xmobarTop)
     $ myConfig

myConfig = def
    { modMask            = myModMask
    , layoutHook         = myLayout
    , terminal           = myTerminal
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    } `additionalKeysP` myKeys


