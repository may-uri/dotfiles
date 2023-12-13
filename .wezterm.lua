local wezterm = require("wezterm")
-- local act = wezterm.action
local config = {}
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.font_rules = {
	{
		intensity = "Normal",
		font = wezterm.font({
			family = "Iosevka Comfy",
			weight = "Regular",
		}),
	},
}
-- config.font = wezterm.font({ family = "IosevkaTerm Nerd Font", weight = "Regular" })
-- config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })
-- config.font = wezterm.font({ family = "Iosevka Comfy" })
-- config.font = wezterm.font_with_fallback({
-- 	"Iosevka Comfy",
-- 	weight = "Regular",
-- 	{ family = "Symbols Nerd Font Mono", scale = 0.75 },
-- })
-- config.font = wezterm.font({ family = "Iosevka Comfy Motion" })
-- config.font = wezterm.font({ family = "Iosevka Comfy Wide Extended" })
-- config.font = wezterm.font({ family = "Iosevka Comfy Wide Motion Duo Extended" })
-- config.font = wezterm.font({ family = "Iosevka Comfy Wide Motion Extended" })
-- config.font = wezterm.font({ family = "BlexMono Nerd Font" })
-- config.font = wezterm.font({ family = "CaskaydiaCove NF" })
-- config.window_background_opacity =  0.9
-- config.window_background_opacity =  0.9

config.audible_bell = "Disabled"
-- COLORS_SCHEME
-- config.color_scheme = "hardhacker"
-- config.color_scheme = "3024 (base16)"-- good black background
-- config.color_scheme = '3024 Night (Gogh)'-- good black background
-- config.color_scheme = "Adventure" -- good black background
-- config.color_scheme = "ayu"
-- config.color_scheme = "Tomorrow Night Burns" -- black with red
-- config.color_scheme = "Tomorrow Night Bright" -- bright black
-- config.color_scheme = "tender (base16)" -- Gruvbox alt
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Summerfruit Dark (base16)" -- pastel
config.color_scheme = "Atlas (base16)" -- solarized warm dark
-- config.color_scheme = "Solarized Dark - Patched" -- solarized dark
-- config.color_scheme = "Solarized Dark Higher Contrast" -- solarized dark
-- config.color_scheme = "Spacemacs (base16)" -- dark with red
-- config.color_scheme = "synthwave" -- black with neon
-- config.color_scheme = "Square" -- pastel
-- config.color_scheme = "Sandcastle (base16)" -- good pastel
-- config.color_scheme = "Sea Shells (Gogh)" -- pastel dark
-- config.color_scheme = "Seafoam Pastel" -- pastel green
-- config.color_scheme = "Seti UI (base16)" -- good pastel dark
-- config.color_scheme = "Sex Colors (terminal.sexy)" -- black
-- config.color_scheme = "Silk Dark (base16)" -- light solarized
-- config.color_scheme = "Slate" -- dark pastel with neon
-- config.color_scheme = "SleepyHollow" -- dark pastel with orange
-- config.color_scheme = "Smyck" -- good pastel with lightblue
-- config.color_scheme = "Gruvbox dark, soft (base16)"
-- config.color_scheme = "GitHub Dark"
-- config.color_scheme = "Mariana"
-- config.color_scheme = "Mocha (base16)"
-- config.color_scheme = "Black Metal (Immortal) (base16)"
-- config.color_scheme = "DanQing (base16)"
-- config.color_scheme = "Dark Violet (base16)"
-- config.color_scheme = "Fahrenheit"
-- config.color_scheme = "Fideloper"
-- config.color_scheme = "Material Palenight (base16)"
-- config.color_scheme = "Monokai Remastered"
-- config.color_scheme = "Afterglow"
-- config.color_scheme = "Gruber (base16)" -- good pastel but tmux is toxic green
-- config.color_scheme = "Google Dark (base16)"
-- config.color_scheme = "Gigavolt (base16)" -- good blue pastel theme
-- config.color_scheme = "Kimber (base16)" -- good pastel
-- config.color_scheme = 'Violet Dark'
-- config.color_scheme = 'Vice Dark (base16)' -- almost cyberpunk theme :>
-- config.color_scheme = "Vaughn" --  interesting blue theme
-- config.color_scheme = "Twilight" -- good monochrome
-- config.color_scheme = "Atelier Cave (base16)"
-- config.color_scheme = "Ashes (base16)" -- fav pink theme
-- config.color_scheme = "Catppuccin Frappe"
-- config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "Ocean (base16)"
-- config.color_scheme = "OneDark (base16)"
-- config.color_scheme = "Overnight Slumber" -- now enabled
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Apprentice (base16)"
-- config.color_scheme = "iceberg-dark"
-- config.color_scheme = "lovelace"
-- COLORS_SCHEME

config.exit_behavior = "Close"
config.font_size = 18
config.initial_rows = 25
config.initial_cols = 120
config.hide_mouse_cursor_when_typing = true
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
	{ action = wezterm.action.ActivateCommandPalette, mods = "CTRL", key = "p" },
	{ action = wezterm.action.DecreaseFontSize, mods = "CTRL", key = "-" },
	{ action = wezterm.action.IncreaseFontSize, mods = "CTRL", key = "=" },
	{ action = wezterm.action.Hide, mods = "ALT", key = "Enter" },
	{ action = wezterm.action.PasteFrom("Clipboard"), mods = "CTRL", key = "v" },
	{ action = wezterm.action.PasteFrom("PrimarySelection"), mods = "CTRL", key = "v" },
	{ action = wezterm.action.PasteFrom("Clipboard"), mods = "CTRL", key = "м" },
	{ action = wezterm.action.PasteFrom("PrimarySelection"), mods = "CTRL", key = "м" },
	{ key = "w", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "ц", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ action = wezterm.action.ResetFontSize, mods = "CTRL", key = "0" },
	{ action = wezterm.action.ToggleFullScreen, key = "F11" },
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
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.wsl_domains = wezterm.default_wsl_domains()

-- hyperlink
-- Use the defaults as a base
-- config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
-- table.insert(config.hyperlink_rules, {
--   regex = [[\b[tt](\d+)\b]],
--   format = 'https://example.com/tasks/?t=$1',
-- })

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
-- table.insert(config.hyperlink_rules, {
--   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
--   format = 'https://www.github.com/$1/$3',
-- })
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)
config.default_cursor_style = "SteadyBlock"
return config

