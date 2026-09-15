-- Personal look'n'feel.
-- Ported from the custom koyanagi theme's hyprland.conf:
--   ~/.config/omarchy/themes/koyanagi/hyprland.conf

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 6,
		border_size = 1,

		col = {
			active_border = {
				colors = { "rgb(C0C0C0)", "rgb(D3D3D3)", "rgb(E5E5E5)", "rgb(B0B0B0)" },
				angle = 45,
			},
			inactive_border = "rgba(404040ff)",
		},

		resize_on_border = true,
		extend_border_grab_area = 15,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 1,

		shadow = {
			enabled = true,
			range = 5,
			render_power = 10,
			color = "rgba(a7a7a7cc)",
			color_inactive = "rgba(00000066)",
			offset = { 0, 0 },
		},

		blur = {
			enabled = false,
		},

		active_opacity = 1.0,
		inactive_opacity = 1.0,
		fullscreen_opacity = 1.0,
	},

	animations = {
		enabled = false,
	},

	misc = {
		background_color = "rgba(262626ff)",
	},
})

-- Blur the bar, notifications and launcher.
-- (Were: layerrules for waybar/walker/notifications/swayosd.)
hl.layer_rule({ match = { namespace = "omarchy-bar" }, blur = true, ignore_alpha = 0.2 })
hl.layer_rule({ match = { namespace = "omarchy-notifications" }, blur = true, ignore_alpha = 0.2 })
hl.layer_rule({ match = { namespace = "omarchy-menu" }, blur = true, ignore_alpha = 0.2 })

-- Fully opaque windows (was: windowrule opacity 1.0 1.0, match:class .*).
o.window(".*", { opacity = "1.0 1.0" })
o.window("code", { opacity = "0.97 0.97 0.97" })
o.window("com.mitchellh.ghostty", { opacity = "0.93 0.93 0.93" })

-- Three-finger swipe to switch workspaces (from the koyanagi theme).
hl.gesture({
	fingers = 3,
	direction = "left",
	action = function()
		hl.dispatch(hl.dsp.focus({ workspace = "e-1" }))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "right",
	action = function()
		hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))
	end,
})
