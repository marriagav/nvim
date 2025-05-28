return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		require("mini.sessions").setup({
			-- Whether to read default session if Neovim opened without file arguments
			autoread = true,
			-- Whether to write currently read session before quitting Neovim
			autowrite = true,
		})
		vim.keymap.set("n", "<leader>mss", function()
			MiniSessions.select()
		end, { desc = "[M]ini [S]ession [S]elect" })

		vim.keymap.set("n", "<leader>msc", function()
			local session_name = vim.fn.input("Enter session name (or enter for local): ")
			if session_name == "" then
				MiniSessions.write(MiniSessions.config.file)
			else
				MiniSessions.write(session_name)
			end
		end, { desc = "[M]ini [S]ession [C]reate" })

		vim.keymap.set("n", "<leader>msw", function()
			MiniSessions.write()
		end, { desc = "[M]ini [S]ession [W]rite" })

		vim.keymap.set("n", "<leader>msd", function()
			local session_name = vim.fn.input("Enter session name to delete: ")
			MiniSessions.delete(session_name)
		end, { desc = "[M]ini [S]ession [D]elete" })
	end,
}
