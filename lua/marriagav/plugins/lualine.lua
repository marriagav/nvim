return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local function current_session()
			local session_path = vim.v.this_session
			-- Use pattern matching to capture everything after the last slash
			local session_name = session_path:match("([^/\\]+)$")
			local prefix = "(g)"
			if session_name == "Session.vim" then
				prefix = "(l)"
			end
			return prefix .. " " .. session_name
		end
		lualine.setup({
			options = {
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},

			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ current_session },
					{ "encoding" },
					{ "filetype" },
				},
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		})
	end,
}

