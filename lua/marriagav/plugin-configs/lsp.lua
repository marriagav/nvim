vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
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

require("mason").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local sourcekit_capabilities = vim.deepcopy(capabilities)
sourcekit_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local servers = {
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".stylua.toml",
			"stylua.toml",
			".git",
		},
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
	sourcekit = {
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift", "objective-c", "objective-cpp" },
		root_markers = { "Package.swift", ".git" },
		capabilities = sourcekit_capabilities,
	},
	emmet_language_server = {
		cmd = { "emmet-language-server", "--stdio" },
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"pug",
			"typescriptreact",
			"php",
		},
	},
	html = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"php",
		},
	},
	rust_analyzer = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_markers = { "Cargo.toml", ".git" },
	},
}

for server_name, server_config in pairs(servers) do
	server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
	vim.lsp.config[server_name] = server_config
	vim.lsp.enable(server_name)
end

local ensure_installed = {
	"lua-language-server",
	"emmet-language-server",
	"html-lsp",
	"rust-analyzer",
	"stylua",
	"biome",
	"prettier",
	"isort",
	"black",
	"pylint",
	"eslint_d",
	"swiftlint",
}
require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
})
