return {
	"github/copilot.vim",
	config = function()
		vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, noremap = true, silent = true })
		vim.g.copilot_no_tab_map = true
	end,
}
