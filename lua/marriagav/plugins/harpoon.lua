return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			local make_finder = function()
				local paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(paths, item.value)
				end

				return require("telescope.finders").new_table({
					results = paths,
				})
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = make_finder(),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_buffer_number, map)
						map(
							"n",
							"dd", -- your mapping here
							function()
								local state = require("telescope.actions.state")
								local selected_entry = state.get_selected_entry()
								local current_picker = state.get_current_picker(prompt_buffer_number)

								harpoon:list():remove_at(selected_entry.index)
								current_picker:refresh(make_finder())
							end
						)

						return true
					end,
				})
				:find()
		end

		vim.keymap.set("n", "<leader>hs", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })
	end,
}
