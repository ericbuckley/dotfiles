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
    family = "VictorMono Nerd Font",
    weight = "Medium",
  },
  {
    family = "Hack Nerd Font",
    weight = "Regular",
  },
})

local theme_map = {
  ["Light"] = "Solarized Dark (Gogh)",
  ["Dark"]  = "Solarized Dark Higher Contrast (Gogh)",
}
config.font_size = 16.0
config.front_end = "WebGpu"
config.window_decorations = "RESIZE"
config.enable_kitty_keyboard = true
config.hide_tab_bar_if_only_one_tab = true

-- Default to dark if we can't determine the state
local appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"
config.color_scheme = theme_map[appearance]
config.set_environment_variables = {
  TERM_APPEARANCE = appearance:lower(),
}

return config
