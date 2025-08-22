return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local function current_session()
			local session_path = vim.v.this_session
			local session_name = session_path:match("([^/\\]+)$")
			local prefix = "(g)"
			if session_name == "Session.vim" then
				prefix = "(l)"
			end
			return prefix .. " " .. session_name
		end

		local mocha = require("catppuccin.utils.lualine")("mocha")
		local fg_color = "fg"
		local bg_color = mocha.inactive.a.bg

		lualine.setup({
			options = {
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "|", right = "|" },
				globalstatus = true,
			},

			sections = {
				lualine_a = {
					{
						"mode",
						color = function()
							local current_mode = vim.api.nvim_get_mode().mode
							local fg = mocha.normal.b.fg
							local visual_modes = { v = true, V = true, ["\22"] = true }
							local replace_modes = { R = true, ["Rv"] = true }
							local select_modes = { s = true, S = true, ["\19"] = true }
							if current_mode == "i" then
								fg = mocha.insert.b.fg
							elseif visual_modes[current_mode] then
								fg = mocha.visual.b.fg
							elseif replace_modes[current_mode] then
								fg = mocha.replace.b.fg or "#ff0000" -- fallback color if mocha doesn't have replace
							elseif select_modes[current_mode] then
								fg = mocha.select.b.fg or "#ffaa00" -- fallback color
							elseif current_mode == "c" then
								fg = mocha.command.b.fg or "#00ffaa" -- fallback color
							elseif current_mode == "t" then
								fg = mocha.terminal.b.fg or "#00aaff" -- fallback color
							else
								fg = mocha.normal.b.fg
							end
							return { fg = fg, bg = bg_color, gui = "bold" }
						end,
					},
				},
				lualine_b = {
					{ "branch", color = { bg = bg_color } },
					{ "diff", color = { bg = bg_color } },
					{ "diagnostics", color = { bg = bg_color } },
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						color = { fg = fg_color, bg = bg_color },
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64", bg = bg_color },
					},
					{ current_session, color = { fg = fg_color, bg = bg_color } },
				},
				lualine_y = { { "progress", color = { fg = fg_color, bg = bg_color } } },
				lualine_z = { { "location", color = { fg = fg_color, bg = bg_color } } },
			},
		})
	end,
}
