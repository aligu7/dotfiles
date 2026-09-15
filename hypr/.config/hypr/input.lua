-- Personal input settings.
-- Ported from the pre-Quattro ~/.config/hypr/input.conf.

hl.config({
  input = {
    kb_layout = "us,az,ru",
    kb_options = "grp:lalt_lshift_toggle",

    repeat_rate = 40,
    repeat_delay = 300,

    numlock_by_default = true,

    sensitivity = -0.6,

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,
    },
  },
})

-- Smooth scrolling in terminals (ported from input.conf).
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
