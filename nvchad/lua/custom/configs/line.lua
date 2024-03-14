local ok, el = pcall(require, "el")
if ok then
	require("el").reset_windows()

	vim.opt.laststatus = 3

	local builtin = require("el.builtin")
	local extensions = require("el.extensions")
	local sections = require("el.sections")
	local subscribe = require("el.subscribe")
	local lsp_statusline = require("el.plugins.lsp_status")
	local diagnostic = require("el.diagnostic")

	local diagnostic_display = diagnostic.make_buffer()

	local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
		local icon = extensions.file_icon(_, bufnr)
		if icon then
			return icon .. " "
		end
		return ""
	end)

	local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
		local branch = extensions.git_branch(window, buffer)
		if branch then
			return " " .. extensions.git_icon() .. " " .. branch
		end
	end)

	local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
		return extensions.git_changes(window, buffer)
	end)

	local show_current_func = function(window, buffer)
		if buffer.filetype == "lua" then
			return ""
		end

		return lsp_statusline.current_function(window, buffer)
	end

	el.setup({
		generator = function(_window, _buffer)
			local mode = extensions.gen_mode({ format_string = " %s " })
			local is_minimal = false

			local items = {
				{ mode, required = true },
				{ git_branch },
				{ " " },
				{ sections.split, required = true },
				{ git_icon },
				{ sections.maximum_width(builtin.file_relative, 0.60), required = true },
				{ sections.collapse_builtin({ { " " }, { builtin.modified_flag } }) },
				{ sections.split, required = true },
				{ diagnostic_display },
				{ show_current_func },
				{ git_changes },
				{ "[" },
				{ builtin.line_with_width(3) },
				{ ":" },
				{ builtin.column_with_width(2) },
				{ "]" },
				{
					sections.collapse_builtin({
						"[",
						builtin.help_list,
						builtin.readonly_list,
						"]",
					}),
				},
				{ builtin.filetype },
			}

			local add_item = function(result, item)
				if is_minimal and not item.required then
					return
				end
				table.insert(result, item)
			end

			local result = {}

			for _, item in ipairs(items) do
				add_item(result, item)
			end

			return result
		end,
	})
end
