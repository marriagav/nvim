vim.g.opencode_opts = {
	server = {
		start = function()
			if not vim.env.TMUX then
				vim.cmd("vsplit term://opencode --port | wincmd p")
				return
			end

			vim.system({
				"tmux",
				"split-window",
				"-h", -- side-by-side panes
				"-d", -- keep focus in the Neovim pane
				"-c",
				vim.fn.getcwd(),
				"opencode --port",
			})
		end,
	},
}

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<C-a>", function()
	require("opencode").ask("@this: ")
end, { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Select OpenCode…" })
vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Append range to OpenCode", expr = true })
vim.keymap.set({ "n" }, "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Append line to OpenCode", expr = true })
vim.keymap.set({ "n" }, "<C-A-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll OpenCode up" })
vim.keymap.set({ "n" }, "<C-A-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll OpenCode down" })
