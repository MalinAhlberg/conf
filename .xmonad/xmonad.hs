--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad hiding ((|||))
import System.Exit
import XMonad.Layout.NoBorders
import XMonad.Actions.DwmPromote
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Master
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile

import XMonad.Layout.Maximize
-- import XMonad.Layout.WindowSwitcherDecoration
-- import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.Decoration
-- import XMonad.Layout.DecorationAddons
--import XMonad.Layout.ButtonDecoration
import XMonad.Layout.BorderResize
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.Named
import XMonad.Layout.LayoutCombinators 
import XMonad.Util.Font


import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myLayout = 
      avoidStrutsOn [] $
        ( smartBorders 
        $ mkToggle (FULL ?? EOT) 
        $ mkToggle (single MIRROR) 
        $ named "Normal"            (ResizableTall 1 (3/100) (1/2) [])
      ||| named "Three-pane"        (mastered (3/100) (1/3) tall)
      ||| named "Three-pane mirror" (mastered (3/100) (1/3) (Mirror tall))
        ) 

ninjaTheme =
    Theme { activeColor         = "#1e98e0"
          , activeBorderColor   = "#2296e3"
          , activeTextColor     = "#ffffff"
          , inactiveColor       = "#1485b5"
          , inactiveBorderColor = "#0671a1"
          , inactiveTextColor   = "#eeeeee"
          , urgentColor         = "#dd00dd"
          , urgentBorderColor   = "#ff00ff"
          , urgentTextColor     = "#ffff00"
          , fontName            = "-*-nu.se-*-*-*-*-*-*-*-*-*-*-*-*"
          , decoWidth           = 200
          , decoHeight          = 15
        --  , windowTitleAddons   = [ (" (M)", AlignLeft)
         --                         , ("[]"  , AlignRightOffset 25)
          --                        , ("X"   , AlignRightOffset 10)
                                 -- ]
          }

tall = Tall 1 (3/100) (1/2)

myTerminal =  "urxvt -fn \"xft:terminus-8\" +sb"

myBorderWidth   = 1
myModMask       = mod4Mask

myNumlockMask   = mod2Mask

myWorkspaces    = map show [1..9] 

myNormalBorderColor = "#105577"
myFocusedBorderColor  = "#1892f8"

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask ,		 xK_r	), spawn "urxvt -fn \"xft:Bitstream Vera Sans Mono-10\" -rv +sb")

    --, ((modMask ,		 xK_c	), spawn "urxvt -fn \"xft:Bitstream Vera Sans Mono-8\" +sb")
    , ((modMask ,		 xK_c	), spawn "gvim")
    , ((modMask,                 xK_t     ), spawn "thunderbird")
    , ((modMask,                 xK_a     ), spawn "chromium-browser")

    , ((modMask ,		 xK_g	), spawn "urxvt -fn \"xft:Bitstream Vera Sans Mono-10\" +sb")

    , ((modMask ,		 xK_e	), spawn "urxvt -fn \"xft:Bitstream Vera Sans Mono-10\" +sb")

    , ((modMask ,		 xK_u	), spawn "urxvt +sb")
    , ((modMask .|. shiftMask , xK_u	), spawn "urxbvt +sb -rv")

    , ((modMask ,		 xK_i	), spawn "urxvt -fn \"xft:Inconsolata-10\" +sb")

    , ((modMask ,		 xK_f	), spawn "firefox")
    , ((modMask ,		 xK_o	), spawn "spotify")

    , ((modMask,                 xK_l   ), spawn "libreoffice --writer")
    , ((modMask .|. shiftMask,   xK_l   ), spawn "libreoffice")
    -- launch dmenu
    --, ((modMask,         xK_l     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

	-- mpd bindings
    {-
    , ((modMask			, xK_p     ), spawn "mpc toggle" ) 
    , ((modMask			, xK_o     ), spawn "mpc next" )
    , ((modMask			, xK_a     ), spawn "mpc prev" )

-}
    -- change keymap
    , ((modMask ,		 xK_F1	), spawn "setxkbmap  -layout 'us(dvorak-alt-intl)'; xmodmap xmodmap-shiftesc; xmodmap svensk-aoe")
    , ((modMask ,        xK_F2  ), spawn "setxkbmap se; xmodmap xmodmap-swapcapsesc")
    , ((modMask ,		 xK_F4	), spawn "setxkbmap -layout 'us(dvorak-alt-intl)'; xmodmap xmodmap-swapcapsesc; xmodmap svensk-aoe")

    -- close focused window 
    , ((modMask .|. shiftMask, xK_d     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    --, ((modMask,               xK_n     ), refresh)

    -- Shrink and expand the windows on the non-master area
	, ((modMask, xK_v), sequence_ [sendMessage MirrorShrink,sendMessage ShrinkSlave])
	, ((modMask, xK_w), sequence_ [sendMessage MirrorExpand,sendMessage ExpandSlave])

    -- Move focus to the next window
    , ((mod1Mask,               xK_Tab   ), windows W.focusDown)

	-- Move focus to the next window
--    , ((modMask,               xK_n     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_n     ), windows W.focusUp  )

    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), dwmpromote )

      -- Swap the focused window with the next window
--    , ((modMask .|. shiftMask, xK_n     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_n     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_s     ), sendMessage Expand)

     -- Toggle upper gap
    -- , ((modMask,               xK_g     ), sendMessage $ ToggleStrut U)

	-- Toggle full
    , ((modMask,               xK_z   ), sendMessage $ Toggle FULL )

	-- Toggle mirror
    , ((modMask,               xK_m   ), sendMessage $ Toggle MIRROR )

    -- Push window back into tiling
    , ((modMask,               xK_b     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask              , xK_q     ), restart "xmonad" True	)	
          --	broadcastMessage ReleaseResources >> restart (Just (Maybe "xmonad")) True)

     -- Raise volume
    , ((0                    ,0x1008ff13), spawn "amixer set 'Master' 2%+")
     -- Lower volume
    , ((0                    ,0x1008ff11), spawn "amixer set 'Master' 2%-")
	
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++

    
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_k, xK_j, xK_x] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]




------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , resource  =? "kicker"       --> doIgnore ]


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
-- myLogHook = dynamicLogXmobar

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults --  xmobar $ \conf -> xmonad $ defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        --numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
      	normalBorderColor  = myNormalBorderColor,
      	focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook
        -- logHook            = myLogHook
    }

