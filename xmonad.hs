import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks

import XMonad.Util.EZConfig
import XMonad.Util.Run

{- XMonad config -}

myModMask ::KeyMask
myModMask = mod4Mask -- changes the mod key to "super"

myTerminal :: String
myTerminal = "terminator" -- which terminal software to use

{- Key bindings -}
myKeyBindings = [
  ]

{- Management hooks. -}

myManagementHooks :: [ManageHook]
myManagementHooks = [
  resource =? "stalonetray" --> doIgnore
  ]

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ defaultConfig {
      terminal = myTerminal
    , modMask = myModMask
    , manageHook = manageHook defaultConfig
                   <+> composeAll myManagementHooks
                   <+> manageDocks
    , layoutHook  = avoidStruts $ layoutHook defaultConfig
    , logHook = takeTopFocus <+> dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmproc
      }
    } `additionalKeys` myKeyBindings
