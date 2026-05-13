require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

vim.keymap.set("n", "<leader>hgb", ":Gitsigns blame<cr>", { desc = "[H][G]it [B]lame" })

vim.keymap.set({ "n", "v" }, "<leader>cl", function()
	Snacks.gitbrowse({
		notify = false,
		open = function(url)
			vim.fn.setreg("+", url)
			vim.notify("Copied: " .. url)
		end,
	})
end, { desc = "[C]ode github yank [L]ink" })
