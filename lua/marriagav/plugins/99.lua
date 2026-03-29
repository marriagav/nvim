return {
	"ThePrimeagen/99",
	config = function()
		local _99 = require("99")

		-- local cwd = vim.uv.cwd()
		_99.setup({
			-- From https://models.dev/
			provider = _99.Providers.OpenCodeProvider,
			model = "github-copilot/claude-opus-4.6",

			-- completion = {
			--   -- I am going to disable these until i understand the
			--   -- problem better.  Inside of cursor rules there is also
			--   -- application rules, which means i need to apply these
			--   -- differently
			--   -- cursor_rules = "<custom path to cursor rules>"
			--
			--   --- A list of folders where you have your own SKILL.md
			--   --- Expected format:
			--   --- /path/to/dir/<skill_name>/SKILL.md
			--   ---
			--   --- Example:
			--   --- Input Path:
			--   --- "scratch/custom_rules/"
			--   ---
			--   --- Output Rules:
			--   --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
			--   --- ... the other rules in that dir ...
			--   ---
			--   custom_rules = {
			--     "scratch/custom_rules/",
			--   },
			--
			--   --- Configure @file completion (all fields optional, sensible defaults)
			--   files = {
			--     -- enabled = true,
			--     -- max_file_size = 102400,     -- bytes, skip files larger than this
			--     -- max_files = 5000,            -- cap on total discovered files
			--     -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
			--   },
			--
			--   --- What autocomplete do you use.  We currently only
			--   --- support cmp right now
			--   source = "blink",
			-- },

			--- WARNING: if you change cwd then this is likely broken
			--- ill likely fix this in a later change
			---
			--- md_files is a list of files to look for and auto add based on the location
			--- of the originating request.  That means if you are at /foo/bar/baz.lua
			--- the system will automagically look for:
			--- /foo/bar/AGENT.md
			--- /foo/AGENT.md
			--- assuming that /foo is project root (based on cwd)
			md_files = {
				"AGENT.md",
				"CLAUDE.md",
			},
		})

		-- Keymaps
		vim.keymap.set("v", "<leader>9v", function()
			_99.visual({})
		end, { desc = "[9]9 [V]isual prompt" })

		vim.keymap.set("v", "<leader>9x", function()
			_99.stop_all_requests()
		end, { desc = "[9]9 [X] Stop all requests" })

		vim.keymap.set("n", "<leader>9s", function()
			_99.search()
		end, { desc = "[9]9 [S]earch" })

		vim.keymap.set("n", "<leader>9m", function()
			require("99.extensions.telescope").select_model()
		end, { desc = "[9]9 [M]odel selector" })
	end,
}
