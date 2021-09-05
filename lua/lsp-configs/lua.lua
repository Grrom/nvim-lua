USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_root_path = "/home/" .. USER .. "/.config/nvim/language-servers/lua-language-server"
sumneko_binary = "/home/" .. USER .. "/.config/nvim/language-servers/lua-language-server/bin/Linux/lua-language-server"

local on_attach = function()
    print("uauto format lua")
    vim.api.nvim_command([[
      autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
    ]])
end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}

require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
                    formatStdin = true
                }
            }
        }
    }
}
