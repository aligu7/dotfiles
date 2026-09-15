-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 2

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Generic auto-detected primary monitor. Uses the preferred mode, automatic
-- position, and automatic (detected) scale. Commented out because the laptop
-- panel reads as scale 2 on auto; scale 1.6 keeps the bar a reasonable size.
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Laptop panel.
hl.monitor({ output = "eDP-1", mode = "2560x1600@60.0", position = "3520x80", scale = 1.6 })

-- External display.
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60.0", position = "1600x0", scale = 1.0 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
