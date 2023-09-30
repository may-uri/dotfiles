local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
-- local mux = wezterm.mux
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.font = wezterm.font { family = 'IosevkaTerm Nerd Font Mono' }
config.audible_bell = 'Disabled'

-- COLORS_SCHEME
-- config.color_scheme = 'Everforest Dark (Gogh)'
-- config.color_scheme = 'hardhacker'
-- config.color_scheme = 'Kasugano (terminal.sexy)'
-- config.color_scheme = 'Gruvbox dark, pale (base16)'
-- config.color_scheme = 'Gruvbox dark, soft (base16)'
-- config.color_scheme = 'Gruvbox Material (Gogh)'
-- config.color_scheme = 'GitHub Dark'
-- config.color_scheme = 'Google (dark) (terminal.sexy)'
-- config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Ashes (dark) (terminal.sexy)'
-- config.color_scheme = 'Mariana'
-- config.color_scheme = 'Mocha (base16)'
-- config.color_scheme = 'Zenburn (Gogh)'
-- config.color_scheme = 'Black Metal (Immortal) (base16)'
-- config.color_scheme = 'Canvased Pastel (terminal.sexy)'
-- config.color_scheme = 'Catch Me If You Can (terminal.sexy)'
-- config.color_scheme = 'DanQing (base16)'
-- config.color_scheme = 'Dark Violet (base16)'
-- config.color_scheme = 'Dawn (terminal.sexy)'
config.color_scheme = 'Embers (dark) (terminal.sexy)'
-- config.color_scheme = 'Fahrenheit'
-- config.color_scheme = 'Fideloper'
-- config.color_scheme = 'Geohot (Gogh)'
-- config.color_scheme = 'Grayscale (dark) (terminal.sexy)'


config.exit_behavior = 'Close'
config.font_size = 18
config.initial_rows = 15
config.initial_cols = 80
config.hide_mouse_cursor_when_typing = true
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
  { action = wezterm.action.ActivateCommandPalette, mods = 'CTRL', key = 'p' },
  { action = wezterm.action.DecreaseFontSize, mods = 'CTRL', key = '-' },
  { action = wezterm.action.IncreaseFontSize, mods = 'CTRL', key = '=' },
  { action = wezterm.action.Hide, mods = 'ALT', key = 'Enter' },
  { action = wezterm.action.PasteFrom 'Clipboard', mods = 'CTRL', key = 'v' },
  { action = wezterm.action.PasteFrom 'PrimarySelection', mods = 'CTRL', key = 'v' },
  { action = wezterm.action.PasteFrom 'Clipboard', mods = 'CTRL', key = 'м' },
  { action = wezterm.action.PasteFrom 'PrimarySelection', mods = 'CTRL', key = 'м' },
  { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentTab { confirm = false } },
  { key = 'ц', mods = 'ALT', action = wezterm.action.CloseCurrentTab { confirm = false } },
  { action = wezterm.action.ResetFontSize, mods = 'CTRL', key = '0' },
  { action = wezterm.action.ToggleFullScreen, key = 'F11' },
}
  -- ALT + number to activate that tab
-- for i = 1, 8 do
--   table.insert(config.keys, {
--     key = tostring(i),
--     mods = 'ALT',
--     action = act.ActivateTab(i - 1),
--   })
-- end

config.scrollback_lines = 10000
config.show_update_window = true
config.unicode_version = 15
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.wsl_domains = wezterm.default_wsl_domains()

return config


