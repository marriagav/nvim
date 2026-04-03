vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>d", vim.diagnostic.open_float, "[D]iagnostics for current line")

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {
			desc = "Show documentation for what is under cursor",
		})
	end,
})

vim.lsp.config["*"] = {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
}

-- See more in https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.enable({
	"lua_ls",
	"sourcekit",
	"emmet_language_server",
	"html",
	"rust_analyzer",
	"pyrefly",
})

-- Commands
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
	desc = "Show LSP Info",
})

vim.api.nvim_create_user_command("LspLog", function(_)
	local state_path = vim.fn.stdpath("state")
	local log_path = vim.fs.joinpath(state_path, "lsp.log")

	vim.cmd(string.format("edit %s", log_path))
end, {
	desc = "Show LSP log",
})

vim.api.nvim_create_user_command("LspRestart", "lsp restart", {
	desc = "Restart LSP",
})

vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local value = ev.data.params.value or {}
		if not value.kind then
			return
		end

		local status = value.kind == "end" and 0 or 1
		local percent = value.percentage or 0

		local osc_seq = string.format("\27]9;4;%d;%d\a", status, percent)

		if os.getenv("TMUX") then
			osc_seq = string.format("\27Ptmux;\27%s\27\\", osc_seq)
		end

		io.stdout:write(osc_seq)
		io.stdout:flush()
	end,
})
