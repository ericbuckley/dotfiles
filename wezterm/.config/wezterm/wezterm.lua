-- ~/.wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    weight = "Regular",
  },
  {
    family = "Maple Mono NF",
    weight = "Regular",
    harfbuzz_features = { "zero=1", "cv01=1" },
  },
  {
    family = "Hack Nerd Font",
    weight = "Regular",
  },
})

config.font_size = 16.0
config.color_scheme = "Solarized Dark - Patched"

config.front_end = "WebGpu"
config.window_decorations = "RESIZE"

return config
