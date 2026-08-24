-- Hyprland Lua config (replaces hyprland.conf)
-- Requires Hyprland 0.55+
-- Ref: https://wiki.hypr.land/Configuring/Start/

local left   = "DP-1"
local center = "HDMI-A-1"
local right  = "DP-2"

--------------------
-- MONITORS
--------------------

hl.monitor({
    output    = left,
    mode      = "1920x1080@120",
    position  = "auto-left",
    transform = 1,  -- 270
    cm        = "hdr",
    bitdepth  = 10,
})

hl.monitor({
    output    = center,
    mode      = "3840x2160@120",
    position  = "0x0",
    -- scale  = 1.2,
})

hl.monitor({
    output    = right,
    mode      = "1920x1080@120",
    position  = "auto-right",
    transform = 3,  -- 90
})

--------------------
-- ENVIRONMENT
--------------------

-- XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
-- GDK
hl.env("GDK_SCALE", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
-- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")
-- NVIDIA -- https://wiki.hyprland.org/Nvidia/
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- nvidia firefox (hardware acceleration)
-- https://github.com/elFarto/nvidia-vaapi-driver#configuration
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("EGL_PLATFORM", "wayland")
-- Obsidian
hl.env("OBSIDIAN_USE_WAYLAND", "1")

--------------------
-- AUTOSTART
--------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("alacritty")
    hl.exec_cmd("hyprctl setcursor rose-pine-hyprcursor 42")         -- bigger cursor for big monitor
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar -c ~/.config/waybar/config-left.jsonc")
    hl.exec_cmd("waybar -c ~/.config/waybar/config-right.jsonc")
    hl.exec_cmd("librewolf --profile ~/Syncthing/librewolf-profiles/madundead")
    hl.exec_cmd("steam -silent")
    hl.exec_cmd("discord")
    hl.exec_cmd("Telegram")
    hl.exec_cmd("obsidian")
    -- https://www.reddit.com/r/hyprland/comments/1bvbyz8/hyprland_instance_signature_not_updating_on
    hl.exec_cmd("tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE \"$HYPRLAND_INSTANCE_SIGNATURE\"")
    hl.exec_cmd("thunar --daemon")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("systemctl --user start lgtv.service")
    hl.exec_cmd("hypridle")
end)

--------------------
-- LOOK AND FEEL
--------------------

hl.config({
    general = {
        gaps_in      = 2,
        gaps_out     = 16,  -- burn-in protection / pixel shifting on LG TV
        border_size  = 0,
        ["col.active_border"]   = "rgb(81a1c1)",
        ["col.inactive_border"] = "rgb(4c566a)",
    },
    decoration = {
        blur = { enabled = false },
    },
    animations = { enabled = false },
    dwindle = {
        preserve_split = true,
    },
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        vrr = false,
    },
    ecosystem = {
        no_update_news  = true,
        no_donation_nag = true,
    },
    input = {
        kb_layout    = "us,ua",
        kb_options   = "grp:alt_shift_toggle",
        repeat_delay = 200,
        repeat_rate  = 150,
    },
    cursor = {
        no_hardware_cursors = true,
    },
})

--------------------
-- WINDOW RULES
--------------------

-- Ignore maximize requests from apps
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- What goes where
hl.window_rule({ name = "alacritty-ws1",     match = { class = "Alacritty" },                workspace = "1" })
hl.window_rule({ name = "librewolf-ws2",     match = { class = "librewolf" },                workspace = "2", no_initial_focus = true })
hl.window_rule({ name = "telegram-ws4",      match = { class = "org.telegram.desktop" },     workspace = "4", no_initial_focus = true })
hl.window_rule({ name = "discord-ws4",       match = { class = "discord" },                  workspace = "4", no_initial_focus = true })
hl.window_rule({ name = "obsidian-ws5",     match = { class = "obsidian" },                 workspace = "5" })

-- Pavucontrol floating
hl.window_rule({ name = "pavucontrol", match = { class = "org.pulseaudio.pavucontrol" }, float = true, center = true, pin = true })

-- PiP youtube
hl.window_rule({ name = "pip", match = { title = "^Picture-in-Picture$" }, float = true, pin = true, size = "1280 800" })

-- Path of Exile
hl.window_rule({ name = "poe", match = { initial_class = "pathofexile.exe" }, workspace = "5", fullscreen = true })

--------------------
-- WORKSPACE RULES
--------------------

hl.workspace_rule({ workspace = "1", monitor = center, default = true })
hl.workspace_rule({ workspace = "2", monitor = center })
hl.workspace_rule({ workspace = "3", monitor = center })
hl.workspace_rule({ workspace = "4", monitor = left,  border_size = 2, gaps_in = 2, gaps_out = 4 })
hl.workspace_rule({ workspace = "5", monitor = right, border_size = 2, gaps_in = 2, gaps_out = 4 })

--------------------
-- KEYBINDS
--------------------

-- Launchers
hl.bind("SUPER+return", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER+E", hl.dsp.exec_cmd("thunar"))
hl.bind("CONTROL+SPACE", hl.dsp.exec_cmd("vicinae toggle"), { non_consuming = true })

-- Window management
hl.bind("SUPER+Q", hl.dsp.window.close())
hl.bind("SUPER+M", hl.dsp.exit())
hl.bind("SUPER+F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER+T", hl.dsp.window.float({ action = "toggle" }))

-- Focus movement (vim-style: H=left, J=down, K=up, L=right)
hl.bind("SUPER+H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER+J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER+K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER+L", hl.dsp.focus({ direction = "right" }))

-- Resize active window
hl.bind("SUPER+SHIFT+J", hl.dsp.window.resize({ x = -70, y = 0 }))
hl.bind("SUPER+SHIFT+K", hl.dsp.window.resize({ x = 70, y = 0 }))

-- Workspace switching
for i = 1, 5 do
    hl.bind("SUPER+" .. i,           hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind("SUPER+SHIFT+" .. i,     hl.dsp.window.move({ workspace = tostring(i), follow = true }))
end

-- Special (scratchpad) workspace
hl.bind("SUPER+W",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER+SHIFT+W",   hl.dsp.window.move({ workspace = "special:magic", follow = true }))

-- Mouse: move / resize windows
hl.bind("SUPER+mouse:272", hl.dsp.window.drag())
hl.bind("SUPER+mouse:273", hl.dsp.window.resize({ keep_aspect_ratio = true }))

-- Audio volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

-- Screenshots (deps: wl-clipboard, grimblast AUR)
local screenshot_cmd = "grim - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png"
local screenshot_sel = "grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png"
hl.bind("SUPER+S",        hl.dsp.exec_cmd(screenshot_cmd))
hl.bind("SUPER+SHIFT+S",  hl.dsp.exec_cmd(screenshot_sel))

-- Focus specific app
hl.bind("CONTROL+ALT+SHIFT+B", hl.dsp.focus({ window = "librewolf" }))
hl.bind("XF86Tools", hl.dsp.focus({ window = "librewolf" }))

-- Display / TV power
hl.bind("SUPER+CONTROL+Q", function()
    hl.dispatch(hl.dsp.dpms({ action = "off" }))
    hl.exec_cmd("/home/madundead/.scripts/lgtv/off.sh")
end)
hl.bind("SUPER+SHIFT+Q", function()
    hl.exec_cmd("/home/madundead/.scripts/lgtv/on.sh && sleep 1")
    hl.dispatch(hl.dsp.dpms({ action = "on" }))
end)

-- Ctrl+Scroll = Ctrl+Click for Path of Exile
-- hl.bind("CONTROL+mouse_down", hl.dsp.exec_cmd("wlrctl pointer click"), { non_consuming = true })
-- hl.bind("CONTROL+mouse_up",   hl.dsp.exec_cmd("wlrctl pointer click"), { non_consuming = true })
