import XMonad
import System.Exit
-- Actions
import XMonad.Actions.CycleWS
-- Hooks
import XMonad.Hooks.EwmhDesktops
-- Layout
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
-- Util
import XMonad.Util.EZConfig (additionalKeysP)
-- xmobar dependencies
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
-- qualified imports
import qualified XMonad.StackSet as W

main :: IO ()
main = xmonad 
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "candybar" (pure myXmobarPP)) defToggleStrutsKey
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

-- | Keybindings
myKeys =
    -- launching and killing programs
    [ ("M-n"            , spawn myTerminal                 ) -- %! Launch terminal
    , ("M-e"            , spawn "dmenu_run"                ) -- %! Launch dmenu
    , ("M-C-w"          , kill                             ) -- %! Close the focused window
    -- layouts
    , ("M-<Space>"      , sendMessage NextLayout           ) -- %! Rotate through the available layout algorithms
    , ("M-f"            , sendMessage $ JumpToLayout "Full") -- %! Focus fullscreen layout
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
    , ("M-t"            , withFocused $ windows . W.sink   ) -- %! Push window back into tiling
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

-- | Configuration
myTerminal           = "wezterm"
myModMask            = mod4Mask
myBorderWidth        = 5
myNormalBorderColor  = "#282828"
myFocusedBorderColor = "#282828"
myWorkspaces         = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- | Layouts
myLayout = gaps $ tiled ||| threeCol ||| Full
  where
    -- Add a configurable amount of space around windows.
    gaps     = spacingRaw False (Border 50 50 50 50) True (Border 10 10 10 10) True

    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

-- | Xmobar
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

