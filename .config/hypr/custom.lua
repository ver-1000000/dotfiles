-- User customizations loaded from hyprland.lua.

local mainMod = "SUPER"
local terminal = "ghostty"
local menu = "rofi -show run"

----------------
--- Autostart ---
----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("thunar --daemon")
    hl.exec_cmd("gsr-ui launch-hide-announce")
end)

----------------
--- Monitors ---
----------------

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-------------
--- Input ---
-------------

hl.config({
    input = {
        kb_layout = "jp",
        follow_mouse = 0,
    },
})

---------------
--- Layouts ---
---------------

hl.config({
    general = {
        layout = "monocle",
        gaps_out = 10,
    },
    misc = {
        focus_on_activate = true,
    },
    decoration = {
        rounding = 4,
    },
})

----------------
--- Floating ---
----------------

hl.window_rule({
    name = "float-all-windows",
    match = { class = ".*" },

    float = true,
    center = true,
})

hl.window_rule({
    name = "ghostty-opacity",
    match = { class = "com.mitchellh.ghostty" },
    opacity = "0.9 0.7",
})

hl.window_rule({
    name = "ghostty-no-blur",
    match = { class = "com.mitchellh.ghostty" },
    no_blur = true,
})

hl.window_rule({
    name = "chrome-large-floating",
    match = { class = "google-chrome" },
    float = true,
    center = true,
    size = "monitor_w-20 monitor_h-20",
})

-------------------
--- Keybindings ---
-------------------

hl.unbind(mainMod .. " + Q")
hl.unbind(mainMod .. " + C")
hl.unbind(mainMod .. " + M")
hl.unbind(mainMod .. " + J")
hl.unbind(mainMod .. " + R")

-- awesome like: Super + Enter
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- awesome like: Super + Ctrl + R
hl.bind("CTRL + " .. mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))

-- awesome like: Super + R
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- awesome like: Super + Shift + Q
hl.bind("SHIFT + " .. mainMod .. " + Q", hl.dsp.exit())

-- awesome like: Super + Shift + C
hl.bind("SHIFT + " .. mainMod .. " + C", hl.dsp.window.close())

-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" "$HOME/Downloads/$(date +%Y%m%d%H%M%S).png"\''))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" - | wl-copy\''))

-- awesome like: Super + Tab
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("hyprctl hyprstack focus last"))

-- awesome like: Super + Shift + Tab
hl.bind("SHIFT + " .. mainMod .. " + TAB", hl.dsp.exec_cmd("toggle-tablet-monitors"))

-- awesome like: Super + Ctrl + Tab
hl.bind("CTRL + " .. mainMod .. " + TAB", hl.dsp.focus({ monitor = "+1" }))

-- awesome like: Super + T / Super + M
hl.bind(mainMod .. " + T", hl.dsp.window.pin())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl dispatch setfloating; hyprctl dispatch resizeactive exact monitor_w-20 monitor_h-20; hyprctl dispatch centerwindow"))

-- vim-like focus movement
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd("hyprctl hyprstack focus next"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprctl hyprstack focus prev"))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- vim-like window movement / stack reorder
hl.bind("SHIFT + " .. mainMod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SHIFT + " .. mainMod .. " + J", hl.dsp.exec_cmd("hyprctl hyprstack swap next"))
hl.bind("SHIFT + " .. mainMod .. " + K", hl.dsp.exec_cmd("hyprctl hyprstack swap prev"))
hl.bind("SHIFT + " .. mainMod .. " + L", hl.dsp.window.move({ direction = "right" }))

-- awesome like: move active window to next monitor
hl.bind(mainMod .. " + O", hl.dsp.window.move({ monitor = "+1" }))

pcall(require, "local")
