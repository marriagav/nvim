-- Seamless <C-hjkl> navigation across nvim splits and the surrounding multiplexer.
--   tmux: handled by vim-tmux-navigator (its default mappings).
--   rex:  rex owns <C-hjkl> and asks this nvim (over a socket) to move via
--         M.try(); at the edge rex moves to the next block / tab itself.
--         See ~/.config/rex/init.lua.

local M = {}

local dirs = { h = "left", j = "down", k = "up", l = "right" }

-- Called by rex: "pass" (forward the key), "moved" or "edge".
function M.try(key)
	if vim.api.nvim_get_mode().mode ~= "n" then
		return "pass"
	end
	local win = vim.api.nvim_get_current_win()
	vim.cmd.wincmd(key)
	return vim.api.nvim_get_current_win() == win and "edge" or "moved"
end

if os.getenv("TMUX") then
	return M
end

-- Not in tmux: keep vim-tmux-navigator from mapping <C-hjkl>.
vim.g.tmux_navigator_no_mappings = 1

for key, dir in pairs(dirs) do
	vim.keymap.set("n", "<C-" .. key .. ">", "<C-w>" .. key, { desc = "Navigate " .. dir })
end

-- In rex: expose a socket rex can find from the foreground pid. Since 0.12 the
-- TUI is a separate client process (our parent), and that's what rex sees.
if os.getenv("REX_SESSION") then
	for _, pid in ipairs({ vim.fn.getpid(), vim.uv.os_getppid() }) do
		local sock = "/tmp/nvim-rex-" .. pid .. ".sock"
		pcall(os.remove, sock) -- stale socket from a recycled pid
		pcall(vim.fn.serverstart, sock)
	end
end

return M
