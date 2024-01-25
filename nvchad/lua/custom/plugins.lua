local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
	{
		"luckasRanarison/nvim-devdocs",
		-- ft = { "javascript" },
		-- event = "VeryLazy",
		keys = {
			{
				"<leader>dd",
				mode = { "n", "o", "x" },
				function()
					vim.cmd("set conceallevel=2")
					vim.cmd("DevdocsOpen")
				end,
				desc = "devdocs",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
		config = function()
			require("nvim-devdocs").setup({
				wrap = true,
				float_win = { -- passed to nvim_open_win(), see :h api-floatwin
					relative = "editor",
					height = 45,
					width = 200,
					border = "none",
				},
			})
		end,
	},
	-- Override plugin definition options
	{
		"ellisonleao/glow.nvim",
		enabled = false,
		cmd = "Glow",
		config = function()
			require("glow").setup({
				border = "single", -- floating window border config
				width = 80,
				height = 100,
				width_ratio = 1, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
				height_ratio = 1,
			})
		end,
	},

	{
		{
			"akinsho/toggleterm.nvim",
			cmd = "ToggleTerm",
			-- event = "VeryLazy",
			version = "*",
			opts = {
				start_in_insert = true,
				direction = "float",
				persist_size = true,
				persist_mode = true,
				float_opts = {
					border = "single",
				},
			},
		},
	},
	{
		"zeioth/garbage-day.nvim",
		enabled = false,
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
		opts = {
			-- your options here
		},
	},
	{
		"stevearc/aerial.nvim",
		cmd = "AerialToggle",
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
		end,
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"nvimtools/none-ls.nvim",
				-- "jose-elias-alvarez/null-ls.nvim",
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
		-- event = "BufRead",
		event = "VeryLazy",
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
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		cmd = "Neorg",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- ft = { "norg" },
		-- event = "VeryLazy",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			})
		end,
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
		"nvim-telescope/telescope-frecency.nvim",
		config = function() end,
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
		-- lazy = false,
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "wakatime/vim-wakatime", event = "VeryLazy" },
	{ "capaj/vscode-standardjs-snippets", event = "VeryLazy" },
	{ "xiyaowong/transparent.nvim", event = "BufEnter" },
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({})
		end,
	},
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
	{ "kdheepak/lazygit.nvim", event = "VeryLazy" },
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
			highlight = {
				before = "", -- "fg" or "bg" or empty
				after = "fg", -- "fg" or "bg" or empty
				keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			},
		},
	},
	-- lazy.nvim
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		-- priority = 1, -- High priority is needed if you will use `autoremap()`
		config = function()
			require("langmapper").setup({--[[ your config ]]
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		cmd = "IlluminateToggle",
		-- event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 200,
				filetypes_denylist = { "alpha", "aerial", "markdown", "neo-tree", "toggleterm", "DiffviewFiles" },
				large_file_cutoff = 2000,
				large_file_overrides = {
					providers = { "treesitter" }, --   'lsp', 'treesitter',  'regex',
					-- try lsp and treesitter
				},
			})
		end,
	},
	-- lazy.nvim
	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = "TSContextEnable",
		-- event = "VeryLazy",
		enabled = true,
		opts = { mode = "cursor", max_lines = 3 },
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>x",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
    -- stylua: ignore
    { "<leader>X", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{ "mg979/vim-visual-multi", event = "VeryLazy" },
	{
		"folke/flash.nvim",
		event = "BufRead",
		---@type Flash.Config
		opts = {
			label = {
				style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
				rainbow = { enabled = true, shade = 3 },
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					multi_line = false,
				},
			},
		},
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
