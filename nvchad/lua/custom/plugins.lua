local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		event = "BufRead",
		-- event = "VeryLazy",
		-- event = "UIEnter",
		keys = {
			{
				"zr",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"zm",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
			{
				"zp",
				function()
					require("ufo").peekFoldedLinesUnderCursor()
				end,
				desc = "Peek folded lines under cursor",
			},
		},
		opts = {
			open_fold_hl_timeout = 0,
			fold_virt_text_handler = function(text, lnum, endLnum, width)
				-- local suffix = "⨊"
				local suffix = (" ··· %d lines ···"):format(endLnum - lnum)
				-- local totalLines = vim.api.nvim_buf_line_count(0) - 1
				-- local foldedLines = endLnum - lnum
				-- local suffix = (" ⤶ %d lines %d%%"):format(foldedLines, foldedLines / totalLines * 100)
				local lines = ("[%d lines] "):format(endLnum - lnum)

				local cur_width = 0
				for _, section in ipairs(text) do
					cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
				end

				suffix = suffix .. (" "):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)

				table.insert(text, { suffix, "Comment" })
				table.insert(text, { lines, "Todo" })
				return text
			end,
			provider_selector = function(_, _, _)
				return { "treesitter" }
			end,
			preview = {
				win_config = {
					border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
					-- border = { "", "", "", "", "", "", "", "" },
					winblend = 0,
					winhighlight = "Normal:LazyNormal",
				},
			},
		},
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"nacro90/numb.nvim",
		enabled = true,
		event = { "VeryLazy" },
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
				hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
				number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
				centered_peeking = true, -- Peeked line will be centered relative to window
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},

		config = function()
			require("oil").setup({
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["t"] = "actions.select",
					["T"] = "actions.parent",
					["<C-s>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
			})
		end,
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
},
	{ "wakatime/vim-wakatime", event = "VeryLazy" },
	{ "michaelb/sniprun", event = "VeryLazy" },
	{ "capaj/vscode-standardjs-snippets", event = "VeryLazy" },
	{ "xiyaowong/transparent.nvim", event = "BufEnter" },
	{

		"Exafunction/codeium.vim",
		enabled = false,
		event = "BufEnter",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<F4>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	-- event = "VeryLazy",
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	{ "kdheepak/lazygit.nvim", event = "VeryLazy" },
	{ "kevinhwang91/nvim-ufo", event = "VeryLazy", dependencies = {
		"kevinhwang91/promise-async",
	} },
	{
		"folke/twilight.nvim",
		event = "BufRead",
		opts = {
			alpha = 0.95, -- amount of dimming
			color = { "Normal", "#ffffff" },
			term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
			treesitter = true,
			-- refer to the configuration section below
		},
	},
	{ "ThePrimeagen/vim-be-good", event = "VeryLazy" },
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			highlight = {
				keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{ "mg979/vim-visual-multi", event = "VeryLazy" },
	{
		"folke/flash.nvim",
		event = "BufRead",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},
	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
