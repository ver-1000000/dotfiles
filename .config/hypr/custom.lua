-- User customizations loaded from hyprland.lua.

local mod = "SUPER"
local terminal = "ghostty"
local menu = "rofi -show run"

-- フローティングウィンドウをWaybarと被らない最大サイズへ広げる
--- NOTE: maximize/fullscreenはfloating z-orderと相性が悪く、hyprstackで前面に出ないことがある
local maximize_window = function()
    local monitor = hl.get_active_monitor()
    if monitor == nil then return end
    local gap = 4
    local waybar_namespace = "waybar"
    local reserved = { top = 0, bottom = 0 }
    -- waybarはreserved areaを直接取れないため、layer surfaceから上下の占有分を読む
    for _, layer in ipairs(hl.get_layers({ namespace = waybar_namespace })) do
        local on_monitor = layer.mapped and layer.monitor ~= nil and layer.monitor.name == monitor.name
        local on_top = on_monitor and layer.y <= monitor.y + 1
        local on_bottom = on_monitor and layer.y + layer.h >= monitor.y + monitor.height - 1
        if on_top then reserved.top = math.max(reserved.top, layer.h) end
        if on_bottom then reserved.bottom = math.max(reserved.bottom, layer.h) end
    end
    hl.dispatch(hl.dsp.window.float({ action = "enable" }))
    hl.dispatch(hl.dsp.window.resize({
        x = monitor.width - gap * 2,
        y = monitor.height - reserved.top - reserved.bottom - gap * 2,
        relative = false,
    }))
    hl.dispatch(hl.dsp.window.move({
        x = monitor.x + gap,
        y = monitor.y + reserved.top + gap,
        relative = false,
    }))
end

-- 画面消灯/点灯設定
--- HACK: メインマシンのディスプレイ特性をlocal.luaで上書き吸収できるように、グローバル関数として定義しておく
_G.suspend_displays = function() hl.dispatch(hl.dsp.dpms({ action = "disable" })) end
_G.resume_displays = function() hl.dispatch(hl.dsp.dpms({ action = "enable" })) end

-- スタートアップ
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

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.config({
    input = { kb_layout = "jp", follow_mouse = 0, },
    general = { layout = "monocle", gaps_out = 10 },
    misc = { focus_on_activate = true },
    decoration = { rounding = 4 },
})

-- hyprstackのfocus/swapを重なり順として扱うため、通常ウィンドウもfloatingに寄せる
hl.window_rule({
    name = "float-all-windows",
    match = { class = ".*" },
    float = true,
    center = true,
})

-- ghosttyの後ろ側のウィンドウが見えるように、hyprlandで透明化してblurも切る
hl.window_rule({
    name = "ghostty-style",
    match = { class = "com.mitchellh.ghostty" },
    opacity = "0.9 0.7",
    no_blur = true,
})

-- キーバインド
--- デフォルト割り当て解除
hl.unbind(mod .. " + Q") -- terminal
hl.unbind(mod .. " + C") -- close
hl.unbind(mod .. " + M") -- exit
hl.unbind(mod .. " + J") -- togglesplit
hl.unbind(mod .. " + R") -- menu
--- 起動/終了
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mod .. " + SHIFT + C", hl.dsp.window.close())
--- スクリーンショット
hl.bind("PRINT", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" "$HOME/Downloads/$(date +%Y%m%d%H%M%S).png"\'')) -- スクリーンショット(grim, slurp, wl-copyに依存)
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" - | wl-copy\''))
--- stack/focus
hl.bind(mod .. " + TAB", hl.dsp.exec_cmd("hyprctl hyprstack focus last"))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.exec_cmd("hyprctl hyprstack focus next"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("hyprctl hyprstack focus prev"))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
--- window移動/swap
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.exec_cmd("hyprctl hyprstack swap next"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.exec_cmd("hyprctl hyprstack swap prev"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
--- window操作
hl.bind(mod .. " + T", hl.dsp.window.pin())
hl.bind(mod .. " + M", maximize_window)
hl.bind(mod .. " + O", hl.dsp.window.move({ monitor = "+1" }))
--- モニタ/端末切替
hl.bind(mod .. " + CTRL + TAB", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mod .. " + SHIFT + TAB", hl.dsp.exec_cmd("toggle-tablet-monitors"))

-- マシン固有の上書き設定(~/.config/hypr/local.lua)があれば読み込む
pcall(require, "local")
