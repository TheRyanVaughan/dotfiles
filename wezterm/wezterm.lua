-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.font = wezterm.font("Fira Code")
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"
config.window_background_image = "~/Pictures/wallpapersden.com_stargazing-hd-pixel-art_1920x1080.jpg"

-- and finally, return the configuration to wezterm
return config
