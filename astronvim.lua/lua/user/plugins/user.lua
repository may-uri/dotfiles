  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
return {
 {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end
    },
    {'xiyaowong/transparent.nvim',
     event = "VeryLazy"},

    {'mg979/vim-visual-multi',
    event = "VeryLazy"},
    {"sainnhe/everforest", event="VeryLazy"},
    {"savq/melange-nvim", event="VeryLazy"},

    {"ThePrimeagen/vim-be-good", event="VeryLazy"},

    {
        "karb94/neoscroll.nvim",
        config = function()
           require 'neoscroll'.setup {
	mappings = { '<C-y>', '<C-e>' },
}
        end
    },{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts ={ },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
},
            {
                "folke/twilight.nvim", lazy = false,
                as = "twilight",
                config = function()
                    require("twilight").setup {
                        dimming = {
                            alpha = 0.25, -- amount of dimming
                            -- we try to get the foreground from the highlight groups or fallback color
                            color = { "Normal", "#ffffff" },
                            term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                            inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
                        },
                        context = 10, -- amount of lines we will try to show around the current line
                        treesitter = true, -- use treesitter when available for the filetype
                        -- treesitter is used to automatically expand the visible text,
                        -- but you can further control the types of nodes that should always be fully expanded
                        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                            "function",
                            "method",
                            "table",
                            "if_statement",
                        },
                        exclude = {}, -- exclude these filetypes
                    }
                end,
            }
            
}


