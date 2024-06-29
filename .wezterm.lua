-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"
config.font = wezterm.font("Cascadia Code NF")
config.font_size = 15.0
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
