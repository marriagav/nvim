-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Keybinds for Obsidian
local base_dir = "/Users/marriagav/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Miguel/"
-- navigate to vault
vim.keymap.set("n", "<leader>oo", ":cd " .. base_dir .. "")
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note-template<cr>")

vim.keymap.set("n", "<leader>ob", ":ObsidianTemplate bookmark-template<cr>" .. ":/^urls:/+1<cr>" .. "A ")

vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate task-template<cr>")

vim.keymap.set("n", "<leader>om", ":ObsidianTemplate monthly-budget-template<cr>")
-- Replace dashes with spaces
-- must have cursor on title:
vim.keymap.set("n", "<leader>of", ":s/-/ /g<cr>")
--
-- search for files in vault
local search_dirs = { "notes", "templates", "hubs", "projects", "tasks", "bookmarks" }

local function join_paths(paths)
	return table.concat(paths, ",")
end

vim.keymap.set(
	"n",
	"<leader>os",
	":Telescope find_files cwd=" .. base_dir .. " search_dirs=" .. join_paths(search_dirs) .. "<cr>"
)

vim.keymap.set(
	"n",
	"<leader>og",
	":Telescope live_grep cwd=" .. base_dir .. " search_dirs=" .. join_paths(search_dirs) .. "<cr>"
)
