local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_scroll_bar=true
config.font= wezterm.font 'Hack'
config.font_size = 15.0

config.keys = {}
for i = 1, 9 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

config.treat_east_asian_ambiguous_width_as_wide = false
config.unicode_version = 14
return config
