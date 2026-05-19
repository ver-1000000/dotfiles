-- User customizations loaded from hyprland.lua.

local mod = "SUPER"
local terminal = "ghostty"
local menu = "rofi -show run"

-- [画面消灯/点灯]
--- HACK: メインマシンのディスプレイ特性をlocal.luaで上書き吸収できるように、グローバル関数として定義しておく
_G.suspend_displays = function() hl.dispatch(hl.dsp.dpms({ action = "disable" })) end
_G.resume_displays = function() hl.dispatch(hl.dsp.dpms({ action = "enable" })) end

-- [起動時]
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

-- [モニタ]
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, })

-- [入力]
hl.config({ input = { kb_layout = "jp", follow_mouse = 0, }, })

-- [レイアウト]
hl.config({
    general = { layout = "monocle", gaps_out = 10 },
    misc = { focus_on_activate = true },
    decoration = { rounding = 4 },
})

-- [フローティング]
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

-- [キーバインド]
hl.unbind(mod .. " + Q")
hl.unbind(mod .. " + C")
hl.unbind(mod .. " + M")
hl.unbind(mod .. " + J")
hl.unbind(mod .. " + R")
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("CTRL + " .. mod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind("SHIFT + " .. mod .. " + Q", hl.dsp.exit())
hl.bind("SHIFT + " .. mod .. " + C", hl.dsp.window.close())
hl.bind("PRINT", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" "$HOME/Downloads/$(date +%Y%m%d%H%M%S).png"\'')) -- スクリーンショット(grim, slurp, wl-copyに依存)
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" - | wl-copy\''))
hl.bind(mod .. " + TAB", hl.dsp.exec_cmd("hyprctl hyprstack focus last"))
hl.bind("SHIFT + " .. mod .. " + TAB", hl.dsp.exec_cmd("toggle-tablet-monitors"))
hl.bind("CTRL + " .. mod .. " + TAB", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mod .. " + T", hl.dsp.window.pin())
hl.bind(mod .. " + M", hl.dsp.exec_cmd("hyprctl dispatch setfloating; hyprctl dispatch resizeactive exact monitor_w-20 monitor_h-20; hyprctl dispatch centerwindow"))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.exec_cmd("hyprctl hyprstack focus next"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("hyprctl hyprstack focus prev"))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SHIFT + " .. mod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SHIFT + " .. mod .. " + J", hl.dsp.exec_cmd("hyprctl hyprstack swap next"))
hl.bind("SHIFT + " .. mod .. " + K", hl.dsp.exec_cmd("hyprctl hyprstack swap prev"))
hl.bind("SHIFT + " .. mod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + O", hl.dsp.window.move({ monitor = "+1" }))

-- マシン固有の上書き設定(~/.config/hypr/local.lua)があれば読み込む
pcall(require, "local")
