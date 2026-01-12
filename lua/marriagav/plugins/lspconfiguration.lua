return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Keymaps

				-- Navigation
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Actions
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("<leader>d", vim.diagnostic.open_float, "[D]iagnostics for current line")

				vim.keymap.set("n", "K", vim.lsp.buf.hover, {
					desc = "Show documentation for what is under cursor",
				})
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			sourcekit = {
				filetypes = {
					"swift",
					"objective-c",
					"objective-cpp",
				},
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					local opts = { noremap = true, silent = true, buffer = bufnr }
				end,
			},

			emmet_language_server = {
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
				filetypes = {
					"html",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"php",
				},
			},

			rust_analyzer = {},
		}

		local servers_to_ignore_from_mason = {
			"sourcekit",
		}

		for server_name, server_config in pairs(servers) do
			server_config.capabilities =
				vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
			-- require("lspconfig")[server_name].setup(server_config)
			vim.lsp.config[server_name] = server_config
		end

		for _, server in ipairs(servers_to_ignore_from_mason) do
			servers[server] = nil
		end
		local ensure_installed = vim.tbl_keys(servers or {})

		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"graphql",
			"pyright",
			"eslint",
			"biome",
			"prettier", -- prettier formatter
			"intelephense",
			"stylua", -- lua formatter
			"isort", -- python formatter
			"black", -- python formatter
			"pylint", -- python linter
			"eslint_d", -- js linter
			"swiftlint",
			"terraformls",
			"rust_analyzer",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	end,
}
