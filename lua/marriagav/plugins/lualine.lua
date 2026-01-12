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

		local theme = require("lualine.themes.auto")

		for _, mode in pairs(theme) do
			for _, section in pairs(mode) do
				if type(section) == "table" then
					section.bg = nil
				end
			end
		end

		for _, mode in pairs(theme) do
			if type(mode) == "table" and mode.b then
				mode.a = mode.b
			end
		end

		lualine.setup({
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				theme = theme,
			},

			sections = {
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = {
					{
						"branch",
					},
					{
						"diff",
					},
					{
						"diagnostics",
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
					},
					{
						current_session,
					},
				},
				lualine_y = {
					{
						"progress",
					},
				},
				lualine_z = {
					{
						"location",
					},
				},
			},
		})
	end,
}
