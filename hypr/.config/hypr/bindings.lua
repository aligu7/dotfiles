-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- ===== Terminal =====
hl.unbind("SUPER + RETURN") -- was: Omarchy default terminal
o.bind("SUPER + RETURN", "Terminal", "ghostty --font-size=12")

-- ===== File manager =====
hl.unbind("SUPER + T")
o.bind("SUPER + T", "File manager", "uwsm-app -- thunar")

-- SUPER+ALT+SHIFT+F: file manager in the current working directory.
o.bind(
	"SUPER + ALT + SHIFT + F",
	"File manager (cwd)",
	'uwsm-app -- nautilus --new-window "$(omarchy-cmd-terminal-cwd)"'
)

-- ===== Browser =====
o.bind("SUPER + B", "Browser", "omarchy-launch-browser")
o.bind("SUPER + ALT + B", "Browser (private)", "omarchy-launch-browser --private")

-- ===== Music =====
o.bind("SUPER + SHIFT + M", "Music", "omarchy-launch-or-focus spotify")
o.bind("SUPER + SHIFT + ALT + M", "Music TUI", "omarchy-launch-or-focus-tui cliamp")

-- ===== Activity / tools =====
o.bind("SUPER + SHIFT + T", "Activity", "omarchy-launch-tui btop")

-- SUPER+SHIFT+D was Docker; now opens Vesktop (Discord).
hl.unbind("SUPER + SHIFT + D")
o.bind("SUPER + SHIFT + D", "Vesktop", "vesktop")

o.bind("SUPER + SHIFT + G", "Signal", 'omarchy-launch-or-focus "^signal$" "uwsm-app -- signal-desktop"')
o.bind("SUPER + SHIFT + O", "Obsidian", 'omarchy-launch-or-focus "^obsidian$" "uwsm-app -- obsidian"')

-- SUPER+SHIFT+W was Omawrite; now opens your todos file.
hl.unbind("SUPER + SHIFT + W")
o.bind(
	"SUPER + SHIFT + W",
	"Todos",
	'uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" nvim -n /home/ag07/org/todos.typ'
)

o.bind("SUPER + SHIFT + SLASH", "Passwords", "uwsm-app -- 1password")
o.bind("SUPER + C", "Code", "code")

-- ===== Window management =====
-- SUPER+F was fullscreen; now toggles floating.
hl.unbind("SUPER + F")
o.bind("SUPER + F", "Toggle floating", hl.dsp.window.float({ action = "toggle" }))

-- SUPER+W (close window) removed; SUPER+Q closes instead.
hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- SUPER+SHIFT+F was the file manager; now fullscreen.
hl.unbind("SUPER + SHIFT + F")
o.bind("SUPER + SHIFT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

o.bind("SUPER + CTRL + SHIFT + F", "Full screen (maximized)", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- SUPER+L was workspace layout toggle; now locks the system.
hl.unbind("SUPER + L")
o.bind("SUPER + L", "Lock", "omarchy-system-lock")

-- SUPER+ALT+M: toggle mouse sensitivity.
o.bind("SUPER + ALT + M", "Toggle mouse sensitivity", "/home/ag07/.config/hypr/toggle-sensitivity.sh")

-- ===== Books =====
-- SUPER+CTRL+B was the Bluetooth panel; now opens the Books folder.
hl.unbind("SUPER + CTRL + B")
o.bind("SUPER + CTRL + B", "Books", "uwsm-app -- thunar /home/ag07/org/library")

-- SUPER+SHIFT+B was Browser; now opens the most recent book.
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Open recent book", "/home/ag07/.local/bin/open-recent-book")

-- ===== Web apps =====
-- SUPER+SHIFT+A was ChatGPT; now Perplexity.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Perplexity", { webapp = "https://perplexity.ai" })

-- SUPER+SHIFT+P was Google Photos; now prayer times.
hl.unbind("SUPER + SHIFT + P")
o.bind(
	"SUPER + SHIFT + P",
	"Prayer Times",
	{ webapp = "https://www.islamicfinder.org/world/azerbaijan/587084/baku-prayer-times" }
)

o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
