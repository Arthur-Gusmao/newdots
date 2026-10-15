sloppy_focus               = true
bypass_surface_visibility  = false
log_level                  = "debug"  -- "silent", "error", "info", "debug"

appearance = {
    -- inner border
    inner_border_px    = 2,
    inner_border_color = 0x5a647eff,
    inner_focus_color  = 0x6d9cbeff,
    inner_urgent_color = 0xda4939ff,
    -- outer border
    outer_border_px    = 2,
    outer_border_color = 0x060a07ff,
    outer_focus_color  = 0x060a07ff,
    outer_urgent_color = 0x060a07ff,
    -- gaps
    gaps         = 8,  
    smart_gaps   = false,
    -- rootcol
    root_color   = 0x060a07ff,
    fullscreen_bg = 0x060a07ff,
    -- opacity
    inactive_opacity = 1.0,
    active_opacity = 1.0,
}


input = {
    repeat_rate             = 50,
    repeat_delay            = 225,
    tap_to_click            = true,
    tap_and_drag            = true,
    drag_lock               = true,
    natural_scrolling       = false,
    disable_while_typing    = true,
    left_handed             = false,
    middle_button_emulation = false,
    scroll_method           = "2fg", -- "2fg", "edge", "button"
    click_method            = "button_areas", -- "button_areas", "clickfinger"
    accel_profile           = "adaptive",   -- "adaptive", "flat"
    accel_speed             = 0.0,
    layout                  = "us",   -- "us", "de", "de,us", ...
 -- variant               = "nodeadkeys",
 -- options               = "grp:alt_shift_toggle",
}

rules = {
--   { app_id = "Gimp",    floating = true,  monitor = -1 },
--   { app_id = "firefox", tags = 1 << 8,    floating = false, monitor = -1 },
}

monitors = {
    -- catch-all rule; name = nil means match anything
   -- { name = nil, mfact = 0.55, nmaster = 1, scale = 1.0,
    --  layout = "dwindle", x = -1, y = -1 },

    -- HiDPI laptop example:
     { name = "DP-1", mfact = 0.5, nmaster = 1, scale = 1.0,
       layout = "dwindle", x = -1, y = -1 },
}

-- autostart: it starts stuff in sequence 
autostart = {
    "waybar",
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP",
    "wlr-randr --output DP-1 --mode 1920x1080@100Hz",
    "openrc -U wayland",
    "wawa fill /home/aw/Wallpapers/NhW.jpg",
--    "pgrep -x pipewire || pipewire",
--    "pgrep -x dunst || dunst",
}


keybinds = {
    { mods = {"logo", "shift"}, key = "P",     action = "spawn",  args = {"/home/aw/.local/bin/mew-flatpak", "-f", "IosevkaTerm Nerd Font:size=10.5"} },
    -- PipeWire: volume em passos de 5%, limitado a 100%, e mudo
    { mods = {}, key = "XF86AudioRaiseVolume", action = "spawn", args = {"wpctl", "set-volume", "-l", "1.0", "@DEFAULT_AUDIO_SINK@", "5%+"} },
    { mods = {}, key = "XF86AudioLowerVolume", action = "spawn", args = {"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"} },
    { mods = {}, key = "XF86AudioMute",        action = "spawn", args = {"wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"} },
    { mods = {}, key = "XF86AudioMicMute",     action = "spawn", args = {"wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle"} },
    { mods = {"logo", "shift"},          key = "return",     action = "spawn",  args = {"havoc"} },
    { mods = {"logo"},          key = "p",     action = "spawn",  args = {"mew-run", "-f", "IosevkaTerm Nerd Font:size=10.5"} },
    { mods = {"logo", "shift"}, key = "c",     action = "killclient" },
    { mods = {"logo"},          key = "v",     action = "togglefloating" },
    { mods = {"logo"},          key = "f",     action = "togglefullscreen" },
    { mods = {"logo"},          key = "g",     action = "togglegaps" },
    { mods = {"logo"},          key = "h",     action = "focusdir",  args = {"left"} },
    { mods = {"logo"},          key = "j",     action = "focusdir",  args = {"down"} },
    { mods = {"logo"},          key = "k",     action = "focusdir",  args = {"up"} },
    { mods = {"logo"},          key = "l",     action = "focusdir",  args = {"right"} },
    { mods = {"logo", "shift"}, key = "H",     action = "swapdir",   args = {"left"} },
    { mods = {"logo", "shift"}, key = "J",     action = "swapdir",   args = {"down"} },
    { mods = {"logo", "shift"}, key = "K",     action = "swapdir",   args = {"up"} },
    { mods = {"logo", "shift"}, key = "L",     action = "swapdir",   args = {"right"} },
    { mods = {"logo"},          key = "Tab",   action = "view" },
    { mods = {"logo"},          key = "0",     action = "view",      args = {"all"} },
    { mods = {"logo"},          key = "comma",  action = "focusmon", args = {"left"} },
    { mods = {"logo"},          key = "period", action = "focusmon", args = {"right"} },
    { mods = {"logo", "shift"}, key = "less",    action = "tagmon", args = {"left"} },
    { mods = {"logo", "shift"}, key = "greater", action = "tagmon", args = {"right"} },
    { mods = {"logo", "shift"}, key = "q",     action = "quit" },
}

for i = 1, 9 do
    local key  = tostring(i)
    local mask = 1 << (i - 1)
    table.insert(keybinds, { mods = {"logo"},                    key = key, action = "view",      args = {tostring(mask)} })
    table.insert(keybinds, { mods = {"logo", "ctrl"},            key = key, action = "toggleview", args = {tostring(mask)} })
    table.insert(keybinds, { mods = {"logo", "shift"},           key = key, action = "tag",        args = {tostring(mask)} })
    table.insert(keybinds, { mods = {"logo", "ctrl", "shift"},   key = key, action = "toggletag",  args = {tostring(mask)} })
end

buttons = {
    { mods = {"logo"}, button = "left",   action = "moveresize",     args = {"move"} },
    { mods = {"logo"}, button = "middle", action = "togglefloating" },
    { mods = {"logo"}, button = "right",  action = "moveresize",     args = {"resize"} },
}

