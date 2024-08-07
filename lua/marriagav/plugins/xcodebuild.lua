return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("xcodebuild").setup({
			code_coverage = {
				enabled = true,
			},
		})

		vim.keymap.set("n", "<leader>xcl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
		vim.keymap.set("n", "<leader>xcb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
		vim.keymap.set("n", "<leader>xcr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
		vim.keymap.set("n", "<leader>xct", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
		vim.keymap.set("n", "<leader>xcT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
		vim.keymap.set("n", "<leader>XC", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
		vim.keymap.set("n", "<leader>xcd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
		vim.keymap.set("n", "<leader>xcp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
		vim.keymap.set("n", "<leader>xcc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
		vim.keymap.set(
			"n",
			"<leader>xC",
			"<cmd>XcodebuildShowCodeCoverageReport<cr>",
			{ desc = "Show Code Coverage Report" }
		)
		vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })
	end,
}
