return {
	"ThePrimeagen/99",
	config = function()
		local _99 = require("99")

		-- local cwd = vim.uv.cwd()
		_99.setup({
			-- From https://models.dev/
			-- TODO: uncomment after https://github.com/ThePrimeagen/99/issues/98
			model = "github-copilot/claude-opus-4.6",

			--- TODO: uncomment and configure after blink support is added: https://github.com/ThePrimeagen/99/issues/61
			--- A new feature that is centered around tags
			-- completion = {
			-- 	--- Defaults to .cursor/rules
			-- 	-- I am going to disable these until i understand the
			-- 	-- problem better.  Inside of cursor rules there is also
			-- 	-- application rules, which means i need to apply these
			-- 	-- differently
			-- 	-- cursor_rules = "<custom path to cursor rules>"
			--
			-- 	--- A list of folders where you have your own SKILL.md
			-- 	--- Expected format:
			-- 	--- /path/to/dir/<skill_name>/SKILL.md
			-- 	---
			-- 	--- Example:
			-- 	--- Input Path:
			-- 	--- "scratch/custom_rules/"
			-- 	---
			-- 	--- Output Rules:
			-- 	--- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
			-- 	--- ... the other rules in that dir ...
			-- 	---
			-- 	custom_rules = {
			-- 		"scratch/custom_rules/",
			-- 	},
			--
			-- 	--- What autocomplete do you use.  We currently only
			-- 	--- support cmp right now
			-- 	source = "cmp",
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
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>9f", function()
			_99.fill_in_function()
		end, { desc = "[9]9 [F]ill in function" })
		vim.keymap.set("v", "<leader>9v", function()
			_99.visual_prompt({})
		end, { desc = "[9]9 [V]isual prompt" })

		vim.keymap.set("v", "<leader>9s", function()
			_99.stop_all_requests()
		end, { desc = "[9]9 [S]top all requests" })
	end,
}
