require("marriagav.core")

-- Load plugins
if vim.g.vscode then
    -- VSCode extensions
else
  require("marriagav.lazy")
end