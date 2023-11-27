local vim = vim
local lspconfig = require('lspconfig')

-- Be sure to install ruff lsp server
-- `pip install ruff-lsp`
lspconfig.ruff_lsp.setup{
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

-- Be sure to install python lsp server
-- `pip install python-lsp-server`
lspconfig.pylsp.setup{
    settings = {
        pylsp = {
            plugins = {
                autopep8 = { enabled = false, },
                flake8 = { enabled = false, },
                mccabe = { enabled = false, },
                pycodestyle = { enabled = false, },
                pydocstyle = { enabled = false, },
                pyflakes = { enabled = false, },
                pylint = { enabled = false, },
                yapf = { enabled = false, },
            }
        }
    }
}

-- Install lua lsp server with
-- `pamac install lua-language-server`
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})


--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Esc>'] = cmp.mapping(function(fallback)
            cmp.abort()
            fallback()
        end, { 'i', 's' }),
        ['<C-c>'] = cmp.mapping(function(fallback)
            cmp.abort()
            fallback()
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
            -- Define menu shorthand for different completion sources.
            local menu_icon = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buf]",
                path = "[Path]",
            }
            -- Set the menu "icon" to the shorthand for each completion source.
            item.menu = menu_icon[entry.source.name]

            -- Kind icons
            item.kind = string.format("%s", kind_icons[item.kind])

            -- Set the fixed width of the completion menu to 60 characters.
            -- local fixed_width = 20
            local fixed_width = false

            -- Set 'fixed_width' to false if not provided.
            fixed_width = fixed_width or false

            -- Get the completion entry text shown in the completion window.
            local content = item.abbr

            -- Set the fixed completion window width.
            if fixed_width then
                vim.o.pumwidth = fixed_width
            end

            -- Get the width of the current window.
            local win_width = vim.api.nvim_win_get_width(0)

            -- Set the max content width based on either: 'fixed_width'
            -- or a percentage of the window width, in this case 20%.
            -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
            local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

            -- Truncate the completion entry text if it's longer than the
            -- max content width. We subtract 3 from the max content width
            -- to account for the "..." that will be appended to it.
            if #content > max_content_width then
                item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
            else
                item.abbr = content .. (" "):rep(max_content_width - #content)
            end
            return item
        end,
    },
}
