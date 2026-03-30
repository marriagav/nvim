require("marriagav.core")

-- Load plugins
if vim.g.vscode then
	-- VSCode extensions
else
	-- require("marriagav.lazy")
	require("marriagav.pack")
	require("marriagav.plugin-configs")
end
