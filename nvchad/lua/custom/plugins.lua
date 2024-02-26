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
		-- event = "BufRead",
		-- event = "VeryLazy",
		event = "UIEnter",
		-- event = { "BufReadPost", "BufNewFile" },
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
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	opts = overrides.mason,
	-- },
	{
		"nacro90/numb.nvim",
		enabled = true,
		event = { "VeryLazy" },
		opts = {
			show_numbers = true, -- Enable 'number' for the window while peeking
			show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
			number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			centered_peeking = true, -- Peeked line will be centered relative to window
		},
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "wakatime/vim-wakatime", event = "VeryLazy" },
	{
		"nvim-lualine/lualine.nvim",
		-- event = "VimEnter",
		event = "VeryLazy",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "everforest",
			},
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"michaelb/sniprun",
		event = "VeryLazy",
		-- ft = { "javascript",
		-- cmd = "SnipRun",
		--
		-- keys = {
		-- 	{
		-- 		"<leader>rr",
		-- 		mode = { "v" },
		-- 		function()
		-- 			vim.cmd("SnipRun")
		-- 		end,
		-- 		desc = "snip run",
		-- 	},
		-- 	{
		-- 		"<leader>rr",
		-- 		mode = { "n" },
		-- 		function()
		-- 			vim.cmd("SnipClose")
		-- 		end,
		-- 		desc = "snip close",
		-- 	},
		-- },
	},

	{
		"RRethy/vim-illuminate",
		-- event = "VeryLazy",
		cmd = "IlluminateResume",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
				},
				min_count_to_highlight = 2,
			})
		end,
	},

	{ "capaj/vscode-standardjs-snippets", ff = { "javascript" } },
	{ "xiyaowong/transparent.nvim", event = "BufEnter" },
	{
		"ahmedkhalf/project.nvim",
		event = "BufEnter",
		-- event = "UIEnter",
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
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	-- event = "VeryLazy",
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	{ "kdheepak/lazygit.nvim", event = "VeryLazy" },
	{
		"folke/twilight.nvim",
		enabled = false,
		event = "BufRead",
		opts = {
			alpha = 0.95, -- amount of dimming
			color = { "Normal", "#ffffff" },
			term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
			treesitter = true,
			-- refer to the configuration section below
		},
	},
	{
		{
			"lmburns/lf.nvim",
			dependencies = { "akinsho/toggleterm.nvim" },
			cmd = "Lf",
			config = function()
				-- This feature will not work if the plugin is lazy-loaded
				vim.g.lf_netrw = 1
				require("lf").setup({
					direction = "float", -- window type: float horizontal vertical
					border = "none", -- border kind: single double shadow curved
					width = vim.o.columns, -- maximally available columns
					height = vim.o.lines - 1, -- maximally available lines
					winblend = 0, -- psuedotransparency level
					default_file_manager = true, -- make lf default file manager
					escape_quit = true, -- map escape to the quit command (so it doesn't go into a meta normal mode)
					mappings = true, -- whether terminal buffer mapping is enabled
					disable_netrw_warning = true, -- don't display a message when opening a directory with `default_file_manager` as true
					highlights = { -- highlights passed to toggleterm
						Normal = { link = "Normal" },
						NormalFloat = { link = "Normal" },
					},
				})
				vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
			end,
			requires = { "toggleterm.nvim" },
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
				keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			},
		},
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	opts = overrides.treesitter,
	-- },

	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	opts = overrides.nvimtree,
	-- },

	-- Install a plugin
	{ "mg979/vim-visual-multi", event = "VeryLazy", enabled = true },

	{
		"folke/flash.nvim",
		-- event = "BufRead",
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
	-- { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{
		"luckasRanarison/nvim-devdocs",
		-- event = "VeryLazy",
		cmd = "DevdocsOpenFloat",
		keys = {
			{
				"<leader>dd",
				mode = { "n", "o", "x" },
				function()
					vim.cmd("set conceallevel=2")
					vim.cmd("DevdocsOpen")
				end,
				desc = "devdocs open",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			filetypes = {
				-- extends the filetype to docs mappings used by the `DevdocsOpenCurrent` command, the version doesn't have to be specified
				-- scss = "sass",
				javascript = { "node", "javascript" },
			},
			float_win = { -- passed to nvim_open_win(), see :h api-floatwin
				relative = "editor",
				height = 55,
				width = 150,
				border = "none",
				-- • "none": No border (default).
				-- • "single": A single line box.
				-- • "double": A double line box.
				-- • "rounded": Like "single", but with rounded corners ("╭"
				--   etc.).
				-- • "solid": Adds padding by a single whitespace cell.
				-- • "shadow": A drop shadow effect by blending with the
				--   background.
			},
			wrap = true, -- text wrap, only applies to floating window
			-- previewer_cmd = "glow", -- for example: "glow"
			-- cmd_args = { "-s", "dark", "-w", "80" },
			-- picker_cmd = true, -- use cmd previewer in picker preview
			-- picker_cmd_args = { "-s", "dark", "-w", "50" },
		},
	},

	{
		"nvim-focus/focus.nvim",
		version = "*",
		cmd = "FocusEnable",
		-- event = "VeryLazy",
		opts = {
			split = {
				-- bufnew = false, -- Create blank buffer for new split windows
				-- tmux = true, -- Create tmux splits instead of neovim splits
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		-- cmd = "ToogleTerm",
		-- enabled = true,
		version = "*",
		opts = {
			size = 120,
			direction = "float", -- "horizontal" | "tab" | "float",
			close_on_exit = true, -- close the terminal window when the process exits
			-- Change the default shell. Can be a string or a function returning a string
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "curved",
				-- 'single' | 'double' | 'shadow' | 'curved' |
			},
		},
	},
	{
		"max397574/better-escape.nvim",
		event = { "CursorHold", "CursorHoldI" },
		opts = {
			mapping = { "jj" }, -- a table with mappings to use
			timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
			clear_empty_lines = false, -- clear line after escaping if there is only whitespace
			keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
		},
	},
	{
		"echasnovski/mini.starter",
		version = "*",
		enabled = false,
		lazy = false,
		-- event = "VimEnter",
		config = function()
			local opts = require("custom.configs.starter")
			require("mini.starter").setup(opts)
		end,
	},
	{
		"jghauser/mkdir.nvim",
		event = "VeryLazy",
	},
	{
		"zeioth/garbage-day.nvim",
		enabled = true,
		dependencies = "neovim/nvim-lspconfig",

		-- event = "VeryLazy",
		opts = {
			-- your options here
		},
	},
	{ "nvim-treesitter/nvim-treesitter-context", cmd = "TSContextEnable", opts = { mode = "cursor", max_lines = 3 } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
		"nvim-neorg/neorg",
		-- enabled = false,
		cmd = "Neorg",
		build = ":Neorg sync-parsers",
		-- ft = { "norg" },
		-- lazy = false,
		-- event = "VeryLazy",
		-- after = "nvim-treesitter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
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
		},
	},
}

return plugins
