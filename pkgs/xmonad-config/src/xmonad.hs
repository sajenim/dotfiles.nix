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
import XMonad.Layout.BinarySpacePartition

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
    [ ((myModMask,                 xK_Return), spawn myTerminal  ) -- %! Launch terminal
    , ((myModMask,                 xK_Tab   ), spawn myLauncher  ) -- %! Launch rofi
    , ((myModMask,                 xK_s     ), spawn myScrot     ) -- %! Take screenshot
    , ((myModMask,                 xK_Escape), kill              ) -- %! Close the focused window
    , ((myModMask .|. controlMask, xK_Escape), io exitSuccess    ) -- %! Quit xmonad

    -- multimedia
    , ((noModMask, xF86XK_AudioPlay         ), spawn "mpc toggle") -- %! Play/Pause music
    , ((noModMask, xF86XK_AudioStop         ), spawn "mpc stop"  ) -- %! Stop music
    , ((noModMask, xF86XK_AudioNext         ), spawn "mpc next"  ) -- %! Next track
    , ((noModMask, xF86XK_AudioPrev         ), spawn "mpc prev"  ) -- %! Previous track
    , ((noModMask, xF86XK_AudioLowerVolume  ), spawn volDown     ) -- %! Volume down
    , ((noModMask, xF86XK_AudioRaiseVolume  ), spawn volUp       ) -- %! Volume up

    -- layouts
    , ((myModMask,               xK_t        ), sendMessage $ JumpToLayout "tile") -- %! Jump to our tiled layout
    , ((myModMask,               xK_b        ), sendMessage $ JumpToLayout "bsp" ) -- %! Jump to our bsp layout
    , ((myModMask,               xK_m        ), sendMessage $ JumpToLayout "max" ) -- %! Jump to our maximized layout
    , ((myModMask,               xK_f        ), sendMessage $ JumpToLayout "full") -- %! Jump to our fullscreen layout
    , ((myModMask .|. shiftMask, xK_t        ), withFocused $ windows . W.sink   ) -- %! Push window back into tiling

    -- window stack
    , ((myModMask,               xK_Down     ), windows W.focusDown              ) -- %! Move focus to the next window
    , ((myModMask,               xK_Up       ), windows W.focusUp                ) -- %! Move focus to the previous window
    , ((myModMask .|. shiftMask, xK_Down     ), windows W.swapDown               ) -- %! Swap the focused window with the next window
    , ((myModMask .|. shiftMask, xK_Up       ), windows W.swapUp                 ) -- %! Swap the focused window with the previous window

    -- master slave
    , ((myModMask,               xK_space    ), windows W.focusMaster            ) -- %! Move focus to the master window 
    , ((myModMask .|. shiftMask, xK_space    ), windows W.swapMaster             ) -- %! Swap the focused window with the master window
    , ((myModMask,               xK_Page_Up  ), sendMessage Shrink               ) -- %! Shrink the master area
    , ((myModMask,               xK_Page_Down), sendMessage Expand               ) -- %! Expand the master area
    , ((myModMask .|. shiftMask, xK_Page_Up  ), sendMessage (IncMasterN 1)       ) -- %! Increase the number of windows in the master area
    , ((myModMask .|. shiftMask, xK_Page_Down), sendMessage (IncMasterN (-1))    ) -- %! Decrease the number of windows in the master area

    -- workspaces
    , ((myModMask,               xK_Right    ), moveTo Next hiddenWS             ) -- %! Move focus to the next hidden workspace
    , ((myModMask,               xK_Left     ), moveTo Prev hiddenWS             ) -- %! Move focus to the previous hidden workspace
    , ((myModMask .|. shiftMask, xK_Right    ), shiftTo Next hiddenWS            ) -- %! Move focused window to the next hidden workspace
    , ((myModMask .|. shiftMask, xK_Left     ), shiftTo Prev hiddenWS            ) -- %! Move focused window to the previous hidden workspace

    -- monitors
    , ((myModMask,               xK_End      ), nextScreen                       ) -- %! Move focus to the next screen
    , ((myModMask,               xK_Home     ), prevScreen                       ) -- %! Move focus to the previous screen
    , ((myModMask .|. shiftMask, xK_End      ), shiftNextScreen                  ) -- %! Move focused window to the next screen
    , ((myModMask .|. shiftMask, xK_Home     ), shiftPrevScreen                  ) -- %! Move focused window to the previous screen 

    -- binary space partition
    , ((myModMask .|. mod1Mask,                 xK_Right    ), sendMessage $ ExpandTowardsBy R 0.01) -- %! Expand window towards the right
    , ((myModMask .|. mod1Mask,                 xK_Left     ), sendMessage $ ExpandTowardsBy L 0.01) -- %! Expand window towards the left
    , ((myModMask .|. mod1Mask,                 xK_Down     ), sendMessage $ ExpandTowardsBy D 0.01) -- %! Expand window downwards
    , ((myModMask .|. mod1Mask,                 xK_Up       ), sendMessage $ ExpandTowardsBy U 0.01) -- %! Expand window upwards
    , ((myModMask .|. mod1Mask .|. controlMask, xK_Right    ), sendMessage $ ShrinkFromBy    R 0.01) -- %! Shrink window from the right
    , ((myModMask .|. mod1Mask .|. controlMask, xK_Left     ), sendMessage $ ShrinkFromBy    L 0.01) -- %! Shrink window from the left
    , ((myModMask .|. mod1Mask .|. controlMask, xK_Down     ), sendMessage $ ShrinkFromBy    D 0.01) -- %! Shrink window downwards
    , ((myModMask .|. mod1Mask .|. controlMask, xK_Up       ), sendMessage $ ShrinkFromBy    U 0.01) -- %! Shrink window upwards
    , ((myModMask .|. mod1Mask,                 xK_Page_Up  ), sendMessage Rotate                  ) -- %! Rotate a split (horizontal/vertical) in the BSP
    , ((myModMask .|. mod1Mask,                 xK_Page_Down), sendMessage Swap                    ) -- %! Swap the left child of a split with the right child of split
    , ((myModMask .|. mod1Mask,                 xK_Home     ), sendMessage $ SplitShift Prev       ) -- %! Shift window by splitting previous neighbour
    , ((myModMask .|. mod1Mask,                 xK_End      ), sendMessage $ SplitShift Next       ) -- %! Shift window by splitting next neighbour
    ]

-- | Layouts
myLayout = tile ||| bsp ||| max ||| full
  where
    -- Add a configurable amount of space around windows.
    gaps     = spacingRaw False (Border 10 10 10 10) True (Border 10 10 10 10) True
    -- Our layouts
    tile     = renamed [Replace "tile"] . avoidStruts . gaps $ Tall nmaster delta ratio
    bsp      = renamed [Replace "bsp" ] . avoidStruts . gaps $ emptyBSP
    max      = renamed [Replace "max" ] . avoidStruts . gaps $ Full
    full     = renamed [Replace "full"] . noBorders          $ Full
    -- Layout settings
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

-- | Xmobar
xmobarTop = statusBarPropTo "_XMONAD_LOG_1" "xmobar-top" (pure ppTop)

ppTop :: PP
ppTop = def
    { ppSep             = grey0 " | "
    -- workspace labels
    , ppCurrent         = purple . wrap " " ""
    , ppVisible         = blue   . wrap " " ""
    , ppHidden          = grey0  . wrap " " ""
    , ppHiddenNoWindows = grey0  . wrap " " ""
    , ppUrgent          = red    . wrap " " ""
    -- misc
    , ppLayout          = aqua  . wrap "" ""
    , ppOrder           = \[ws, l, _] -> [ws, l]
    }
  where
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


