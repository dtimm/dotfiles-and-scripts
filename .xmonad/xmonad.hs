import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote
import System.IO

defaultLayouts = tiled ||| Mirror tiled ||| noBorders Full
	where  
		-- default tiling algorithm partitions the screen into two panes
		tiled = Tall nmaster delta ratio
		-- The default number of windows in the master pane
		nmaster = 1
		-- Default proportion of screen occupied by master pane
		ratio = 2/3
		-- Percent of screen to increment by when resizing panes  
		delta = 3/100

nobordersLayout = noBorders $ Full
myWorkspaces  = ["1:Main","2:Web","3:VBox","4","5","6", "7:Play", "8:Hide"]
myLayout = onWorkspace "7:Play" nobordersLayout $ defaultLayouts

myKeys =
	[ ("M-b"        , sendMessage ToggleStruts		) -- toggle the status bar gap
	, ("M-<Return>" , dwmpromote				) -- swap the focused window and the master window
	, ("M-<Right>"  , nextWS				) -- go to next workspace
	, ("M-<Left>"   , prevWS				) -- go to prev workspace
	, ("M-S-<Right>", shiftToNext				) -- move client to next workspace
	, ("M-S-<Left>" , shiftToPrev				) -- move client to prev workspace
	, ("M-x g"	, spawn "subl3"				)
	, ("M-x s"	, spawn "steam"				)
	, ("M-x c"	, spawn "chromium"			)
	, ("M-x f"	, spawn "firefox"			)
	, ("M-<KP_Add>"	, spawn "amixer -q set Master 10%+"	) -- volume up
	, ("M-<KP_Subtract>", spawn "amixer -q set Master 10%-"	) -- volume down
	]

myManageHook = composeAll  
	[ className =? "Firefox" --> doShift "2:Web"
	, className =? "Steam" --> doFloat <+> doShift "7:Play"
	, className =? "Yakuake" --> doFloat
	, className =? "Chromium" --> doShift "2:Web"
	]  
   

main = do
xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
myDropship <- spawnPipe "yakuake"
xmonad $ defaultConfig
	{ modMask		= mod4Mask -- Use Super instead of Alt
	, handleEventHook	= fullscreenEventHook
	, terminal		= "konsole"
	, normalBorderColor	= "grey"
	, focusedBorderColor	= "#004354"
	, borderWidth	= 3
	, workspaces	= myWorkspaces
	, manageHook	= manageDocks <+> myManageHook <+> manageHook defaultConfig
	, layoutHook	= avoidStruts $ myLayout  
	, logHook		= dynamicLogWithPP xmobarPP  
		{ ppOutput	= hPutStrLn xmproc  
		, ppTitle	= xmobarColor "green" "" . shorten 50   
		, ppLayout	= const "" -- to disable layout info
		}   
	}
	`additionalKeysP` myKeys
