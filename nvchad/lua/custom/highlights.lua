-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = true,
	},
	-- Visual = { bg = "#231942", fg = "white" },
	Visual = { bg = "#4c3743" }, -- from everforest colorscheme

	-- MatchWord = { bg = "none" },
	-- MatchParen = { bg = "none" },
	IncSearch = { fg = "black", bg = "pink" },
	Search = { fg = "black", bg = "pink" },
	-- Cursor = { bg = "pink", fg = "black" },
	-- CursorLine = { bg = "#2f2e3e" },
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
	-- Visual = { fg = "green", bold = true },
  --  gitsigns
 GitSignsChange = { fg = "green" },
 GitSignsAdd = { fg = "vibrant_green" },
 GitSignsDelete = { fg = "red" },
 GitSignsText = { fg = "white", bg = "red", bold = true },
}

return M
