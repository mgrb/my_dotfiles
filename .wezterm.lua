-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font")
config.font_size = 10
config.line_height = 1.1

-- disable tab & Window boards
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

-- For example, changing the color scheme:
config.color_scheme = 'SeaShells'
-- config.window_background_opacity = 0.9

-- Recuperando o hostname
local hostname = wezterm.hostname()
-- Recuperando o username
local username = os.getenv("USER") or os.getenv("USERNAME") or "unknown"

-- Seta o titulo da janela
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return string.format("%s :: %s@%s", tab.tab_id, username, hostname)
end)

-- and finally, return the configuration to wezterm
return config
