local options = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim", -- trim indentations
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",

		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		-- layout_strategy = "flex",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			-- width = 0.87,
			-- height = 0.80,
			width = vim.o.columns, -- maximally available columns
			height = vim.o.lines, -- maximally available lines
			-- preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		generic_sorter = require("telescope.sorters").fuzzy_with_index_bias,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		projects = require("telescope").load_extension("projects"),
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		fzf = require("telescope").load_extension("fzf"),
		mappings = {
			i = { ["<C-q>"] = require("telescope.actions").close },
			n = { ["<C-q>"] = require("telescope.actions").close },
		},
	},

	extensions_list = { "themes", "terms", "projects", "fzf" },
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}
local themes = require("telescope.themes")
function curbuf()
	local opts = themes.get_ivy({
		winblend = 6,
		shorten_path = false,
	})
	require("telescope.builtin").current_buffer_fuzzy_find(opts)
end
function grep_open_files(opts)
	opts = opts or {}
	opts.grep_open_files = true
	opts.path_display = { "shorten" }
	opts.prompt_title = "Live Grep in Open Files"

	require("telescope.builtin").live_grep(opts)
end

return options
