return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })

		require("mini.surround").setup()

		require("mini.pairs").setup()

		require("mini.sessions").setup({
			autoread = true,
			autowrite = true,
		})

		-- Keymaps
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
