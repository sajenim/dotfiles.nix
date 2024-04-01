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
import XMonad.Util.EZConfig (additionalKeys)

-- This file is generated based on X.org includes. It contains the keysyms for XF86.
import Graphics.X11.ExtraTypes.XF86

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
myLauncher           = "rofi -modi run,calc -show run"
myScrot              = "scrot -s '%Y%m%d_%H%M%S.png' -e 'mv $f ~/Pictures/scrots/'"
volDown              = "pactl set-sink-volume @DEFAULT_SINK@ -10%"
volUp                = "pactl set-sink-volume @DEFAULT_SINK@ +10%"

-- | Keybindings
myKeys =
    -- launching and killing programs
    [ ((myModMask,                 xK_n        ), spawn myTerminal                          ) -- %! Launch terminal
    , ((myModMask,                 xK_e        ), spawn myLauncher                          ) -- %! Launch rofi
    , ((myModMask,                 xK_s        ), spawn myScrot                             ) -- %! Take screenshot
    , ((myModMask .|. controlMask, xK_w        ), kill                                      ) -- %! Close the focused window
    , ((myModMask .|. shiftMask,   xK_q        ), io exitSuccess                            ) -- %! Quit xmonad

    -- multimedia
    , ((noModMask, xF86XK_AudioPlay            ), spawn "mpc toggle"                        ) -- %! Play/Pause music
    , ((noModMask, xF86XK_AudioStop            ), spawn "mpc stop"                          ) -- %! Stop music
    , ((noModMask, xF86XK_AudioNext            ), spawn "mpc next"                          ) -- %! Next track
    , ((noModMask, xF86XK_AudioPrev            ), spawn "mpc prev"                          ) -- %! Previous track
    , ((noModMask, xF86XK_AudioLowerVolume     ), spawn volDown                             ) -- %! Volume down
    , ((noModMask, xF86XK_AudioRaiseVolume     ), spawn volUp                               ) -- %! Volume up

    -- layouts
    , ((myModMask,                 xK_t        ), sendMessage $ JumpToLayout "Spacing Tiled") -- %! Jump to our tiled layout
    , ((myModMask,                 xK_m        ), sendMessage $ JumpToLayout "Maximized"    ) -- %! Jump to our maximized layout
    , ((myModMask,                 xK_f        ), sendMessage $ JumpToLayout "Fullscreen"   ) -- %! Jump to our fullscreen layout
    , ((myModMask .|. shiftMask,   xK_t        ), withFocused $ windows . W.sink            ) -- %! Push window back into tiling

    -- window stack
    , ((myModMask,                 xK_Down     ), windows W.focusDown                       ) -- %! Move focus to the next window
    , ((myModMask,                 xK_Up       ), windows W.focusUp                         ) -- %! Move focus to the previous window
    , ((myModMask .|. shiftMask,   xK_Down     ), windows W.swapDown                        ) -- %! Swap the focused window with the next window
    , ((myModMask .|. shiftMask,   xK_Up       ), windows W.swapUp                          ) -- %! Swap the focused window with the previous window

    -- master slave
    , ((myModMask,                 xK_space    ), windows W.focusMaster                     ) -- %! Move focus to the master window 
    , ((myModMask .|. shiftMask,   xK_space    ), windows W.swapMaster                      ) -- %! Swap the focused window with the master window
    , ((myModMask,                 xK_Page_Up  ), sendMessage Shrink                        ) -- %! Shrink the master area
    , ((myModMask,                 xK_Page_Down), sendMessage Expand                        ) -- %! Expand the master area
    , ((myModMask .|. shiftMask,   xK_Page_Up  ), sendMessage (IncMasterN 1)                ) -- %! Increase the number of windows in the master area
    , ((myModMask .|. shiftMask,   xK_Page_Down), sendMessage (IncMasterN (-1))             ) -- %! Decrease the number of windows in the master area

    -- workspaces
    , ((myModMask,                 xK_Right    ), moveTo Next hiddenWS                      ) -- %! Move focus to the next hidden workspace
    , ((myModMask,                 xK_Left     ), moveTo Prev hiddenWS                      ) -- %! Move focus to the previous hidden workspace
    , ((myModMask .|. shiftMask,   xK_Right    ), shiftTo Next hiddenWS                     ) -- %! Move focused window to the next hidden workspace
    , ((myModMask .|. shiftMask,   xK_Left     ), shiftTo Prev hiddenWS                     ) -- %! Move focused window to the previous hidden workspace

    -- monitors
    , ((myModMask,                 xK_End      ), nextScreen                                ) -- %! Move focus to the next screen
    , ((myModMask,                 xK_Home     ), prevScreen                                ) -- %! Move focus to the previous screen
    , ((myModMask .|. shiftMask,   xK_End      ), shiftNextScreen                           ) -- %! Move focused window to the next screen
    , ((myModMask .|. shiftMask,   xK_Home     ), shiftPrevScreen                           ) -- %! Move focused window to the previous screen
    ]

-- | Layouts
myLayout = tiled ||| max ||| full
  where
    -- Add a configurable amount of space around windows.
    gaps     = spacingRaw False (Border 10 10 10 10) True (Border 10 10 10 10) True
    -- Our layouts
    tiled    = renamed [Replace "Spacing Tiled"] . avoidStruts . gaps $ Tall nmaster delta ratio
    max      = renamed [Replace "Maximized"    ] . avoidStruts . gaps $ Full
    full     = renamed [Replace "Fullscreen"   ] . noBorders          $ Full
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
    } `additionalKeys` myKeys


