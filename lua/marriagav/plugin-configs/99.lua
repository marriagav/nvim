local _99 = require("99")

_99.setup({
	-- From https://models.dev/
	provider = _99.Providers.OpenCodeProvider,
	model = "github-copilot/claude-opus-4.5",
	tmp_dir = "./tmp",
	md_files = {
		"AGENT.md",
		"CLAUDE.md",
	},
	completion = {
		custom_rules = {},
	},
})

vim.keymap.set("n", "<leader>9ww", function()
	_99.Extensions.Worker.set_work({})
end, { desc = "[9]9 [W]ork" })

vim.keymap.set("n", "<leader>9ws", function()
	_99.Extensions.Worker.search()
end, { desc = "[9]9 [W]ork [S]earch" })

vim.keymap.set("v", "<leader>9v", function()
	_99.visual({})
end, { desc = "[9]9 [V]isual prompt" })

vim.keymap.set("n", "<leader>9x", function()
	_99.stop_all_requests()
end, { desc = "[9]9 [X] Stop all requests" })

vim.keymap.set("n", "<leader>9s", function()
	_99.search({})
end, { desc = "[9]9 [S]earch" })

vim.keymap.set("n", "<leader>9m", function()
	require("99.extensions.telescope").select_model()
end, { desc = "[9]9 [M]odel selector" })
