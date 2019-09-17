import XMonad
import XMonad.Hooks.ManageDocks (ToggleStruts(..),avoidStruts,docks,manageDocks,manageDocks,docks,docksEventHook)
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout (Mirror, Tall, Full)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import System.IO
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeysP, removeKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.UrgencyHook


------------------------------------------------------------------------
-- Extensible layouts
--
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--

-- | The available layouts.  Note that each layout is separated by |||, which
-- denotes layout choice.
layout = mkToggle (single MIRROR) (tiled ||| Full)

-- default tiling algorithm partitions the screen into two panes
tiled   = Tall nmaster delta ratio
     where

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta = 3/100

main = do
  h <- spawnPipe "dzconky"
  xmonad $ withUrgencyHook NoUrgencyHook $ ewmh $ docks $ (myConf h)
  
myConf h = def
    { borderWidth        = 2
    , manageHook         = manageDocks <+> myManageHook <+> manageHook def
    , layoutHook         = avoidStruts $ layoutHook def
    , logHook            = myLogHook h
    , handleEventHook    = mconcat [handleEventHook def, fullscreenEventHook, docksEventHook]
    , startupHook = do
       startupHook def
       setWMName "LG3D"
    , terminal           = "terminator"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00"
    , modMask            = mod4Mask     -- Rebind Mod to the Windows key
    , focusFollowsMouse  = False
    , workspaces = ["1:focus", "2:web", "3:comm", "4:code", "5:term", "6:media", "7", "8:set", "9:tmp"]
    } `additionalKeysP` [
     ("M-S-C-l", spawn "systemctl suspend"),
     ("M1-C-<Space>", spawn "~/bin/toggle-vm.sh"),
     ("M-S-p", spawn "dmenu_run"),
     ("M-<Return>", spawn "terminator"),
     ("M-w", kill),
     ("M-f", sendMessage $ Toggle MIRROR),
     ("<XF86AudioRaiseVolume>", spawn "notify_volume + 1"),
     ("<XF86AudioLowerVolume>", spawn "notify_volume - 1")
    ]


toggleStruts XConfig {modMask = modMask} = (modMask, xK_n)

myManageHook :: ManageHook
myManageHook = composeAll . concat $
   [ 
     [ className =? "Firefox-esr"  --> doShift "2:web" ]
   , [ className =? "WEECHAT"      --> doShift "3:comm" ]
   , [ className =? "discord"      --> doShift "3:comm" ]
   , [ className =? "Signal"       --> doShift "3:comm" ]
   , [ className =? "Emacs"        --> doShift "4:code" ]
   , [ className =? "xterm"        --> doShift "5:term" ]
   , [ className =? "terminator"   --> doShift "5:term" ]
   , [ className =? "VLC"          --> doShift "6:media" ]
   , [ className =? "Pavucontrol"  --> doShift "8:set" ]
   , [ className =? "virt-manager" --> doShift "8:set" ]
   , [ className =? "Barrier"      --> doShift "8:set" ]
   , [ className =? "net-ftb-main-Main"      --> doShift "7" ]
   , [(className =? "Firefox-esr" <&&> resource =? "Dialog") --> doFloat]
   , [(className =? "discord" <&&> resource =? "GtkFileChooserDialog") --> doFloat]
   ]

myLogHook h = dynamicLogWithPP $ def
   -- display current workspace as darkgrey on light grey (opposite of
  -- default colors)
  { ppCurrent         = dzenColor "#303030" "#909090" . pad
  -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#909090" "" . pad
    -- display other workspaces with no windows as a normal grey
    , ppHiddenNoWindows = dzenColor "#606060" "" . pad
    -- display the current layout as a brighter grey
    , ppLayout          = dzenColor "#909090" "" . pad
    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip
    -- shorten if it goes over 100 characters
    , ppTitle           = shorten 100
    -- no separator between workspaces
    , ppWsSep           = ""
    -- put a few spaces between each object
    , ppSep             = "  "
    -- output to the handle we were given as an argument
    , ppOutput          = hPutStrLn h
}
