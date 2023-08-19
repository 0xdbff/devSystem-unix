vim.g.mapleader = " "

-- require('plugins')

-- packer path
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- map locals
local nmo = { noremap = true, silent = true }
local nvim_keymap = vim.api.nvim_set_keymap

-- Install packer
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[
augroup Packer
autocmd!
autocmd BufWritePost init.lua PackerCompile
augroup end
]])

local use = require("packer").use
require("packer").startup(function()
    -- Package manager
    use("wbthomason/packer.nvim")
    use({ "ellisonleao/gruvbox.nvim" })
    use("EdenEast/nightfox.nvim")

    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        -- tag = "nightly", -- optional, updated every week. (see issue #1193)
    })
    use({
        "lewis6991/gitsigns.nvim",
        -- tag = "release", -- To use the latest release
    })

    ------ Utils
    -- Git integration
    use("tpope/vim-fugitive")
    -- Git integration :help compl-omni
    use("tpope/vim-rhubarb")

    -- Make comments easier
    use("numToStr/Comment.nvim")
    -- Relative lines on current buf(normal mode) only
    -- use 'jeffkreeftmeijer/vim-numbertoggle'

    -- Automatic tags management
    -- use 'ludovicchabant/vim-gutentags'

    -- EasyMotion provides a much simpler way to use some motions in vim
    -- use 'easymotion/vim-easymotion'

    -- a generic formatter
    -- use 'mhartington/formatter.nvim'
    use("jose-elias-alvarez/null-ls.nvim")

    use("godlygeek/tabular")
    --
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    -- debugging
    use("mfussenegger/nvim-dap")

    -- better terminal support
    use("akinsho/toggleterm.nvim")

    -- use({ "glepnir/dashboard-nvim" })

    ------ Telescope
    use("nvim-telescope/telescope.nvim")
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    -- use "nvim-telescope/telescope-rs.nvim"
    -- use "nvim-telescope/telescope-fzf-writer.nvim"
    -- use "nvim-telescope/telescope-github.nvim"
    -- use "nvim-telescope/telescope-symbols.nvim"
    -- use "nvim-telescope/telescope-hop.nvim"
    -- use "nvim-telescope/telescope-file-browser.nvim"
    -- use "nvim-telescope/telescope-ui-select.nvim"
    -- use "nvim-telescope/telescope-smart-history.nvim"

    ------ UI settings
    -- Colorshemes
    -- use 'mjlbach/onedark.nvim'
    use("navarasu/onedark.nvim")
    use 'folke/tokyonight.nvim'

    -- use 'Db-dev2002/dbfox.nvim'
    -- use 'Db-dev2002/sonokai'
    -- use 'Th3Whit3Wolf/onebuddy'
    -- Status line
    -- use 'folke/tokyonight.nvim'
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    -- lsp status info for lua line
    use("arkav/lualine-lsp-progress")
    -- Add indentation guides 'soft vertical bars'
    -- use("lukas-reineke/indent-blankline.nvim")
    -- Add git related info in the signs columns and popups

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use("nvim-treesitter/nvim-treesitter")
    -- Additional textobjects for treesitter
    use("nvim-treesitter/nvim-treesitter-textobjects")
    -- color codes highlighter
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    -- ansi escape codes(colors) ft
    use({
        "norcalli/nvim-terminal.lua",
        config = function()
            require("terminal").setup()
        end,
    })
    -- Make comments appear IN YO FACE
    use({
        "tjdevries/vim-inyoface",
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>(InYoFace_Toggle) <CR>", {})
        end,
    })
    -- languages that benefit from plugins
    -- use("rust-lang/rust.vim")
    -- use 'lervag/vimtex'
    -- use("plasticboy/vim-markdown")
    use("keith/swift.vim")
    use("neovimhaskell/haskell-vim")
    use("elmcast/elm-vim")
    use("tikhomirov/vim-glsl")
    -- languages Utils
    -- use("rhysd/vim-clang-format")
    use("jose-elias-alvarez/nvim-lsp-ts-utils")
    -- use 'nvim-lua/lsp_extensions.nvim'
    use("simrat39/rust-tools.nvim")
    -- rust crates management
    use({
        "saecki/crates.nvim",
        -- tag = 'v0.1.0',
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    })

    ------ LSP plugins
    -- Collection of configurations for built-in LSP client
    use("neovim/nvim-lspconfig")
    -- Autocomplete plugins
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")
    -- Snippets plugin
    use({ "L3MON4D3/LuaSnip" })
end)

-- vim.g.lsp_diagnostics_virtual_text_prefix = "-"
-- vim.api.nvim_set_var("g:lsp_diagnostics_virtual_text_prefix", "-")

vim.o.termguicolors = true

--Set highlight on search
vim.o.hlsearch = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
-- Split to righ and bottom of the screen
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wildmenu = true
vim.colorcolumn = false
vim.o.expandtab = true
vim.o.autoindent = true
-- Make line numbers default
vim.o.number = true
vim.opt.relativenumber = true
--Enable mouse mode
vim.o.mouse = "a"
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
vim.wo.cursorline = true

-- Enable cursorline for active window only
vim.api.nvim_exec([[
  augroup CursorLine
    autocmd!
    autocmd WinEnter,BufEnter * setlocal cursorline
    autocmd WinLeave,BufLeave * setlocal nocursorline
  augroup END
]], false)



-- vim.g['guicursor']= 'n-i-v-c:ver100-iCursor'
-- only replace o-pending is a block, !TODO set it as a beam on terminal mode
vim.opt.guicursor = "a:ver100-iCursor"
-- vim.opt.guicursor = "n-v-c:ver100,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"




-- vim.cmd[[ let g:completion_enable_auto_paren = 1 ]]
-- vim.cmd([[ let g:rustfmt_autosave = 1 ]])
-- vim.cmd([[ let g:clang_format#code_style = 'llvm' ]])

-- Easier Moving between splits
vim.cmd([[ nnoremap <C-J> <C-W><C-J> ]])
vim.cmd([[ nnoremap <C-K> <C-W><C-K> ]])
vim.cmd([[ nnoremap <C-L> <C-W><C-L> ]])
vim.cmd([[ nnoremap <C-H> <C-W><C-H> ]])

-- Make windows to be basically the same size
vim.cmd([[ nnoremap <leader>= <C-w>= ]])

-- vim.cmd([[
--     augroup c| au!
--         au Filetype c setlocal shiftwidth=4 softtabstop=4
--         au BufNewFile,BufRead *.c,*.h :ClangFormatAutoEnable
--     augroup END
-- ]])
--
-- vim.cmd([[
--     augroup cpp| au!
--         au Filetype cpp setlocal shiftwidth=4 softtabstop=4
--         au BufNewFile,BufRead *.cpp,*.hpp :ClangFormatAutoEnable
--     augroup END
-- ]])
--
-- vim.cmd([[
--     augroup cuda| au!
--         au Filetype cuda setlocal shiftwidth=4 softtabstop=4
--         au BufNewFile,BufRead *.cu :ClangFormatAutoEnable
--     augroup END
-- ]])

-- vim.cmd [[
-- augroup rust | au!
--     " Set the text width in Rust files to 80, for comment wrapping.
--     au Filetype rust setlocal textwidth=80
--     " au BufNewFile,BufRead *.rs :require('rust-tools').setup({})
-- augroup END
-- ]]

-- Copy and paste to/from system clipboard
vim.cmd([[ vmap <leader>y "+y ]])
vim.cmd([[ vmap <leader>d "+d ]])
vim.cmd([[ nmap <leader>p "+p ]])
vim.cmd([[ nmap <leader>P "+P ]])
vim.cmd([[ vmap <leader>p "+p ]])
vim.cmd([[ vmap <leader>P "+P ]])

-- i like things fast
vim.o.updatetime = 100
vim.o.timeoutlen = 260

function Getos()
    local os_name = io.popen("uname -s 2>/dev/null", "r")
    if os_name then
        return os_name:read()
    end

    return "not supported"
end

OS = Getos()
local is_darwin = (OS == "Darwin")
local is_linux = (OS == "Linux")

-- permanent undo dir
vim.o.undofile = true
if is_linux then
    vim.o.undodir = "/home/db/dev/.temp/nvim/did"
elseif is_darwin then
    vim.o.undodir = "/Users/db/dev/.temp/nvim/did"
else
    -- TODO
end

vim.cmd([[set completeopt=menu,menuone,noselect ]])

-- Set the number of lines to keep visible above and below the cursor at the
-- top and bottom of the screen
vim.o.scrolloff = 8
-- vim.o.nowrap = true -- THIS BREAKS NVIM 0.10
vim.o.textwidth = 80

vim.cmd([[ nnoremap <leader><leader> <c-^> ]])

vim.cmd([[ nmap <silent> <leader>/ :noh<cr> ]])

-- quick switch buffers
nvim_keymap("n", "<leader><leader>", "<c-^>", nmo)
-- reset highlight
nvim_keymap("n", "<leader>/", "<cmd>noh<cr>", nmo)

-- create new files adjacent to current working dir
nvim_keymap("n", ";e", ':e <C-R>=expand("%:p:h") . "/" <CR>', {})
nvim_keymap("n", ";te", ':tabe <C-R>=expand("%:p:h") . "/" <CR>', {})
-- quick save with ;w
nvim_keymap("n", ";w", "<cmd>w<CR>", {})
-- quick suspend with ;s
nvim_keymap("n", ";f", "<cmd>lua vim.lsp.buf.format()<CR>", {})
-- !TODO improve
nvim_keymap("n", ";cr", "<cmd>TermExec cmd='cargo run'<CR>", {})
nvim_keymap("n", ";cb", "<cmd>TermExec cmd='cargo build'<CR>", {})
nvim_keymap("n", ";m", "<cmd>TermExec cmd='make'<CR>", {})
nvim_keymap("n", ";cc", "<cmd>TermExec cmd='cargo check'<CR>", {})
nvim_keymap("n", ";t", "<cmd>NvimTreeFocus<CR>", { silent = false })
nvim_keymap("n", ";T", "<cmd>NvimTreeToggle<CR>", { silent = false })
nvim_keymap("n", ";q", ":q!<CR>", {})
nvim_keymap("n", ";qq", ":qa!<CR>", {})

-- quick save with <leader> w
-- vim.cmd[[ nmap <leader>w :w<CR> ]]

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "node_modules", "/dist", "/venv","/migrations", "/build", "__pycache__" },
        layout_strategy = "horizontal",
        layout_config = {
            height = 0.8,
            width = 0.7,
            preview_cutoff = 120,
            preview_width = 0.64,
        },
    },
    extensions = {
        frecency = {
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
        },
    },
})

require("nvim-treesitter.configs").setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    -- ignore_install = { "phpdoc" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        disable = {
            "phpdoc",
            -- disable for large buffers, it can cause performance issues on some ft's...
            function(lang, bufnr)
                return lang == "rust" and vim.api.nvim_buf_line_count(bufnr) > 1200 -- i like things fast!(...) true rustacean :)
                -- !TODO
            end,
        },

        -- list of language that will be disabled
        -- disable = { "phpdoc" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
})

require("Comment").setup()

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')

local tb = "<cmd>lua require('telescope.builtin')."
nvim_keymap("n", "<leader>ff", tb .. "find_files()<cr>", {})
nvim_keymap("n", "<leader>fg", tb .. "live_grep()<cr>", {})
nvim_keymap("n", "<leader>fb", tb .. "buffer()<cr>", {})
nvim_keymap("n", "<leader>fh", tb .. "help_tags()<cr>", {})
nvim_keymap("n", "<leader>la", tb .. 'lsp_code_actions(require("telescope.themes").get_cursor())<cr>', {})

-- null ls
require("null-ls").setup({
    debug = true,
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.clang_format,

        require("null-ls").builtins.diagnostics.fish,
        require("null-ls").builtins.diagnostics.zsh,
    },
})

local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
-- -- Set configuration for specific filetype.
-- cmp.setup.filetype("gitcommit", {
--     sources = cmp.config.sources({
--         { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
--     }, {
--         { name = "buffer" },
--     }),
-- })
--
-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ "/", "?" }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = "buffer" },
--     },
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(":", {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = "path" },
--     }, {
--         { name = "cmdline" },
--     }),
-- })

-- Diagnostic keymaps
nvim_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", nmo)
nvim_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", nmo)
nvim_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", nmo)
nvim_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", nmo)

local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
    local lspkeymap = vim.api.nvim_buf_set_keymap
    local lsp_cmd = "<cmd>lua vim.lsp.buf."
    local cmdl = "<cmd>lua"
    lspkeymap(bufnr, "n", "gD", lsp_cmd .. "declaration()<CR>", nmo)
    lspkeymap(bufnr, "n", "gd", lsp_cmd .. "definition()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>k", lsp_cmd .. "hover()<CR>", nmo)
    lspkeymap(bufnr, "n", "gi", lsp_cmd .. "implementation()<CR>", nmo)
    lspkeymap(bufnr, "n", "<C-k>", lsp_cmd .. "signature_help()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>wa", lsp_cmd .. "add_workspace_folder()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>wr", lsp_cmd .. "remove_workspace_folder()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>wl", cmdl .. "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>D", lsp_cmd .. "type_definition()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>rn", lsp_cmd .. "rename()<CR>", nmo)
    lspkeymap(bufnr, "n", "gr", lsp_cmd .. "references()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>ca", lsp_cmd .. "code_action()<CR>", nmo)
    lspkeymap(bufnr, "n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], nmo)

    vim.diagnostic.config({
        virtual_text = {
            prefix = "◈",  -- Change this to whatever prefix you prefer.
        }
    })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities);

-- Enable the following language servers, quick setup default settings
-- local servers = { "pyright" }
-- for _, lsp in ipairs(servers) do
--     lspconfig[lsp].setup({
    --         on_attach = on_attach,
    --         capabilities = capabilities,
    --     })
    -- end

    lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "c", "cpp", "cuda" },
    })

    -- CSS, intall vscode css language server with bins
    lspconfig.cssls.setup({
        cmd = { 'css-languageserver', '--stdio' };
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
    })

    lspconfig.html.setup({
        cmd = { "html-languageserver", "--stdio" },
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html" },
        init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
                css = true,
                javascript = true
            },
            provideFormatter = true
        },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
    })

    -- lspconfig.pyright.setup({
    --     -- cmd = { 'pyright-langserver', '--stdio', '--skipunannotated' };
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    --     root_dir = lspconfig.util.root_pattern('package.json', 'package-lock.json', 'manage.py', 'pyrightconfig.json');
    -- })
    lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic", -- Change to "basic" or "strict" as per your requirements
                    -- You can add more settings here based on your requirements
                }
            }
        }
    })

    lspconfig.tsserver.setup({
        cmd = { 'typescript-language-server', '--stdio' };
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' };
        root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json');
        settings = {};
    })

    local pid = vim.fn.getpid()
    local omnisharp_path

    if is_linux then
        omnisharp_path = "/home/db/.local/bin/omnisharp/OmniSharp"
    elseif is_darwin then
        omnisharp_path = "/Users/db/.local/bin/omnisharp/OmniSharp"
    end

    lspconfig.omnisharp.setup({
        cmd = { omnisharp_path, "--languageserver", "--hostPID", tostring(pid) },
        on_attach = on_attach,
        capabilities = capabilities,
    })

-- Rust
-- lspconfig.rust_analyzer.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }

local rust_opts = {
    tools = { -- rust-tools options

        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require("rust-tools/executors").termopen,

        -- callback to execute once rust-analyzer is done initializing the workspace
        -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
        on_initialized = nil,

        -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
        reload_workspace_from_cargo_toml = true,

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "› ",
            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "» ",
            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
        },

        -- options same as lsp hover / vim.lsp.util.open_floating_preview()
        hover_actions = {

            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
            },

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = false,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- standalone file support
        -- setting it to false may improve startup time
        -- standalone = false,
        -- load lsp on rust
        on_attach = on_attach,
        capabilities = capabilities,

        -- rust-analyzer options
        -- settings = {
        --     ["rust-analyzer"] = {
        --         cargo = {
        --             allFeatures = true,
        --         },
        --         diagnostics = {
        --             disabled = {
        --                 "unresolved-proc-macro",
        --             },
        --         },
        --         completion = {
        --             postfix = {
        --                 enable = false,
        --             },
        --         },
        --     },
        -- },
    },

    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
}

require("rust-tools").setup(rust_opts)

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Lua
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
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

require("toggleterm").setup({
    -- -- size can be a number or function which is passed the current terminal
    -- size = 20 | function(term)
    --   if term.direction == "horizontal" then
    --     return 15
    --   elseif term.direction == "vertical" then
    --     return vim.o.columns * 0.4
    --   end
    -- end,
    open_mapping = [[<c-c>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = false,
    highlights = {
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        Normal = {
            guibg = "#23272e",
        },
        NormalFloat = {
            link = "Normal",
        },
        FloatBorder = {
            guifg = "#abb2bf",
            guibg = "#23272e",
        },
    },
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = "vertical",
    size = 80,
    close_on_exit = true, -- close the terminal window when the process exits
    shell = "/usr/bin/env fish", -- change the default shell
})

function Set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua Set_terminal_keymaps()")

-- require('rust-tools').setup({})
-- require('rust-tools.inlay_hints').set_inlay_hints()
-- require'rust-tools.open_cargo_toml'.open_cargo_toml()

-- Default options
-- require("nightfox").setup({
--     options = {
--         -- Compiled file's destination location
--         compile_path = vim.fn.stdpath("cache") .. "/nightfox",
--         compile_file_suffix = "_compiled", -- Compiled file suffix
--         transparent = false, -- Disable setting background
--         terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
--         dim_inactive = false, -- Non focused panes set to alternative background
--         styles = { -- Style to be applied to different syntax groups
--             comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
--             conditionals = "NONE",
--             constants = "NONE",
--             functions = "NONE",
--             keywords = "NONE",
--             numbers = "NONE",
--             operators = "NONE",
--             strings = "NONE",
--             types = "NONE",
--             variables = "NONE",
--         },
--         inverse = { -- Inverse highlight for different types
--             match_paren = false,
--             visual = false,
--             search = false,
--         },
--         modules = { -- List of various plugins and additional options
--             -- ...
--         },
--     },
--     palettes = {},
--     specs = {},
--     groups = {},
-- })
--
-- -- setup must be called before loading
-- vim.cmd("colorscheme nordfox")

vim.cmd("set laststatus=3")

-- vim.cmd[[colorscheme tokyonight]]
-- require("onedark").setup({
--     -- Main options --
--     style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--     transparent = true, -- Show/hide background
--     term_colors = true, -- Change terminal color as per the selected theme style
--     ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--     -- toggle theme style ---
--     -- toggle_style_key = "<leader>ts", -- Default keybinding to toggle
--     -- toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between
--
--     -- Change code style ---
--     -- Options are italic, bold, underline, none
--     -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
--     code_style = {
--         comments = "none",
--         keywords = "italic",
--         functions = "bold",
--         strings = "italic",
--         variables = "none",
--     },
--
--     -- Custom Highlights --
--     colors = {}, -- Override default colors
--     highlights = {
--         NvimTreeNormal = { fg = "#abb2bf", bg = "#23272e" },
--         -- CursorLineNr = { fg = "#ffffff" , bg = "#000000"},
--         TelescopeBorder = { fg = "#61afef" },
--         TelescopePromptBorder = { fg = "#000000" },
--         TelescopeResultsBorder = { fg = "#000000" },
--         TelescopePreviewBorder = { fg = "#000000" },
--     }, -- Override highlight groups
--
--     -- Plugins Config --
--     diagnostics = {
--         darker = false, -- darker colors for diagnostic
--         undercurl = true, -- use undercurl instead of underline for diagnostics
--         background = false, -- use background color for virtual text
--     },
-- })
-- require("onedark").load()

require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true},
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    sidebars = { "qf" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = 0.1, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors)
        -- colors.bg_dark = "#252930"
        -- colors.bg = "#282c34"
        -- colors.bg_visual = "#30353f"
        -- colors.bg_highlight = "#23272c"
        -- colors.terminal_black = "#000206"
        -- colors.bg_sidebar = "#1E2228"
        -- colors.fg = "#abb2bf"
        -- colors.fg_dark = "#7f8c98"
        -- colors.fg_gutter = "#323741"
        -- colors.dark3 = "#373d48"
        colors.bg_dark = "#1d222d"
        colors.bg = "#202632"
        colors.bg_visual = "#272e3c"
        colors.bg_highlight = "#1a1f28"
        colors.terminal_black = "#000006"
        colors.bg_sidebar = "#191d26"
        colors.fg = "#abb2bf"
        colors.fg_dark = "#7f8c98"
        colors.fg_gutter = "#2a3241"
        colors.dark3 = "#2d3646"
        colors.comment = "#687186"
        colors.dark5 = "#31394b"
        colors.cyan = "#59bbdc"
        colors.blue = "#61afef"
        colors.blue0 = "#458588"
        colors.blue1 = "#5293c8"
        colors.blue2 = "#5fabea"
        colors.blue5 = "#619aef"
        colors.blue6 = "#6190ef"
        colors.blue7 = "#617def"
        colors.magenta = "#e86671"
        colors.magenta2 = "#7f7ff0"
        colors.purple = "#e87966"
        colors.orange = "#d19a66"
        colors.yellow = "#e5c07b"
        colors.green = "#98c379"
        colors.green1 = "#79c3a0"
        -- colors.green2 = "#a0c379"
        colors.green2 = "#689d6a"
        colors.teal = "#1abc9c"
        colors.red = "#e06c75"
        colors.red1 = "#d45c66"
        colors.bg_popup = colors.bg_dark
        colors.bg_statusline = colors.bg_dark
        colors.git = { change = "#4a88ff", add = "#79c3a0", delete = "#e06c75" }

        -- black:   '##282828'
        -- red:     '##cc241d'
        -- green:   '##98971a'
        -- yellow:  '##d79921'
        -- blue:    '##458588'
        -- magenta: '##b16286'
        -- cyan:    '##689d6a'
        -- white:   '##a89984'

    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(hl, c)
        local prompt = c.bg
        hl.TelescopeNormal = {
            bg = prompt,
            fg = c.fg,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }

        hl.DiagnosticVirtualTextError = { bg = "NONE",italic = true, fg = "#1f0000" }
        hl.DiagnosticVirtualTextWarn = { bg = "NONE",italic = true, fg = "#00001f" }
        hl.DiagnosticVirtualTextInfo = { bg = "NONE",italic = true, fg = "#00001f" } 
        hl.DiagnosticVirtualTextHint = { bg = "NONE",italic = true, fg = "#00001f" }

        hl.NormalFloat = { fg = c.fg_float, bg = c.dark3 }

        hl.LineNr = { fg = "#000008" }
        hl.CursorLine = { bg = c.bg_visual }
        hl.CursorLineNr = {fg = c.blue, italic = true }

        hl.SignColumn = { bg = c.bg_highlight, fg = c.fg_gutter }
        hl.GitSignsAdd = { bg = c.bg_highlight , fg = c.gitSigns.add }
        hl.GitSignsChange = { bg = c.bg_highlight, fg = c.gitSigns.change }
        hl.GitSignsDelete = { bg = c.bg_highlight,  fg = c.gitSigns.delete }
        hl.DiagnosticError = { bg = c.bg_highlight, fg = c.error, italic = true }
        hl.DiagnosticWarn = { bg = c.bg_highlight, fg = c.warning, italic = true }
        hl.DiagnosticInfo = { bg = c.bg_highlight, fg = c.info, italic = true }
        hl.DiagnosticHint = { bg = c.bg_highlight, fg = c.hint, italic = true }
        hl.DiagnosticUnnecessary = { fg = c.comment }
    end,
})
--
-- vim.cmd[[colorscheme tokyonight]]
require("tokyonight").load()

require("lualine").setup({
    options = {
        icons_enabled = true,
        -- theme = 'nightfox',
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename", "lsp_progress" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})

require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
})

require("nvim-tree").setup()
