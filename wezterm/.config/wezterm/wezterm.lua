-- ~/.wezterm.lua

local wezterm = require("wezterm")

wezterm.on("toggle-scratchpad", function(window, pane)
  local overrides = window:get_config_overrides() or {}

  if overrides.scratchpad then
    -- We are in scratchpad mode, so disable it
    wezterm.log_info "Disabling scratchpad mode"
    
    -- Restore normal window behavior
    window:perform_action(wezterm.action.SetWindowLevel "Normal", pane)
    
    -- Remove all overrides
    window:set_config_overrides(nil)
  else
    -- We are in normal mode, so enable scratchpad
    wezterm.log_info "Enabling scratchpad mode"

    -- Apply your appearance settings
    overrides.scratchpad = true
    overrides.window_padding = {
      left = 10, right = 10, top = 10, bottom = 10,
    }
    overrides.initial_cols = 80
    overrides.initial_rows = 24
    overrides.window_decorations = "RESIZE"
    overrides.window_background_opacity = 0.9
    window:set_config_overrides(overrides)

    -- Make the window float on top of all other windows
    window:perform_action(wezterm.action.SetWindowLevel "AlwaysOnTop", pane)
  end
end)

return {
  -- Theme
  color_scheme = "Solarized Dark - Patched",

  -- Font settings
  font = wezterm.font("Hack Nerd Font", {
    weight = "Regular",
  }),
  font_size = 16.0,

  -- Ghostty’s “font-thicken = true” doesn’t have a direct equivalent.
  -- The closest is enabling built-in HarfBuzz features or adjusting bold font:
  -- freetype_load_target = "HorizontalLcd", -- (optional visual thickening)
  -- freetype_load_flags = "NO_HINTING",

  -- “bold-color = bright” is default behavior in WezTerm (bright colors for bold text),
  -- so no extra setting needed.

  -- Cursor settings
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 0,  -- disables blinking

  -- Closest equivalent to Ghostty "shell-integration-features = no-cursor"
  -- (WezTerm doesn’t allow disabling cursor for shell integration)
  -- but we *can* disable CSI u / bracketed paste / etc. if desired.

  -- Ghostty “macos-titlebar-proxy-icon = hidden”
  -- WezTerm can hide everything but doesn't control only the proxy icon:
  window_decorations = "RESIZE", -- remove MENU/TITLEBAR icons if desired

  -- Hyperlinks
  hyperlink_rules = wezterm.default_hyperlink_rules(),

  -- Auto-update
  check_for_updates = true,
}
