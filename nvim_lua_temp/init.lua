
vim.g.mapleader = ' '

-- packer path
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

-- map locals
local nmo = {noremap = true, silent = true}
local nvim_keymap = vim.api.nvim_set_keymap

-- Install packer
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  -- Package manager
  use 'wbthomason/packer.nvim'

  ------ Utils
  -- Git integration
  use 'tpope/vim-fugitive'
  -- Git integration :help compl-omni
  use 'tpope/vim-rhubarb'
  -- Make comments easier
  use 'numToStr/Comment.nvim'
  -- Relative lines on current buf(normal mode) only
  use 'jeffkreeftmeijer/vim-numbertoggle'
  -- Automatic tags management
  -- use 'ludovicchabant/vim-gutentags'
  -- EasyMotion provides a much simpler way to use some motions in vim
  -- use 'easymotion/vim-easymotion'
  -- a generic formatter
  use 'mhartington/formatter.nvim'
  use 'godlygeek/tabular'
  --
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  -- debugging
  use 'mfussenegger/nvim-dap'
  -- better terminal support
  use 'Db-dev2002/toggleterm.nvim'

  ------ Telescope
  use "nvim-telescope/telescope.nvim"
  use {
	"nvim-telescope/telescope-fzf-native.nvim",
	run = "make"
  }
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
  use 'navarasu/onedark.nvim'
  use 'Db-dev2002/dbfox.nvim'
  use 'Db-dev2002/sonokai'
  -- use 'Th3Whit3Wolf/onebuddy'
  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use {
	'lewis6991/gitsigns.nvim',
	requires = {'nvim-lua/plenary.nvim'}
  }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- color codes highlighter
  use{
    "norcalli/nvim-colorizer.lua",
    config = function ()
        require("colorizer").setup()
    end,
  }
  -- ansi escape codes(colors) ft
  use {
    "norcalli/nvim-terminal.lua",
    config = function()
        require("terminal").setup()
    end,
  }
  -- Make comments appear IN YO FACE
  use {
    "tjdevries/vim-inyoface",
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>(InYoFace_Toggle) <CR>", {})
    end,
  }
  -- languages that benefit from plugins
  use 'rust-lang/rust.vim'
  -- use 'lervag/vimtex'
  use 'plasticboy/vim-markdown'
  use 'keith/swift.vim'
  use 'neovimhaskell/haskell-vim'
  use 'elmcast/elm-vim'
  use 'tikhomirov/vim-glsl'
  -- languages Utils
  use 'rhysd/vim-clang-format'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  -- use 'simrat39/rust-tools.nvim'
  -- rust crates management
  use {
    'saecki/crates.nvim',
    tag = 'v0.1.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end,
  }

  ------ LSP plugins
  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- Autocomplete plugins
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'
end)

--Set highlight on search
vim.o.hlsearch = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
-- Split to righ and bottom of the screen
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wildmenu = true
vim.colorcolumn = true
vim.o.expandtab = true
vim.o.autoindent = true
-- Make line numbers default
vim.o.number = true
--Enable mouse mode
vim.o.mouse = 'a'
--Set colorscheme
vim.o.termguicolors = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- vim.cmd[[ let g:completion_enable_auto_paren = 1 ]]
vim.cmd[[ let g:rustfmt_autosave = 1 ]]
vim.cmd[[ let g:clang_format#code_style = 'llvm' ]]

-- Easier Moving between splits
vim.cmd[[ nnoremap <C-J> <C-W><C-J> ]]
vim.cmd[[ nnoremap <C-K> <C-W><C-K> ]]
vim.cmd[[ nnoremap <C-L> <C-W><C-L> ]]
vim.cmd[[ nnoremap <C-H> <C-W><C-H> ]]


-- Make windows to be basically the same size
vim.cmd[[ nnoremap <leader>= <C-w>= ]]

vim.cmd[[ 
augroup c | au!
    au Filetype c setlocal shiftwidth=4 softtabstop=4
    au BufNewFile,BufRead *.c,*.h :ClangFormatAutoEnable
augroup END
]]

-- vim.cmd [[
-- augroup rust | au!
--     " Set the text width in Rust files to 80, for comment wrapping.
--     au Filetype rust setlocal textwidth=80
--     " au BufNewFile,BufRead *.rs :require('rust-tools').setup({})
-- augroup END
-- ]]


-- require("rust-tools").setup({
--     tools = { -- rust-tools options
--         -- Automatically set inlay hints (type hints)
--         autoSetHints = true,
--
--         -- Whether to show hover actions inside the hover window
--         -- This overrides the default hover handler
--         hover_with_actions = true,
--
--         -- how to execute terminal commands
--         -- options right now: termopen / quickfix
--         executor = require("rust-tools/executors").termopen,
--
--         runnables = {
--             -- whether to use telescope for selection menu or not
--             use_telescope = true
--
--             -- rest of the opts are forwarded to telescope
--         },
--
--         debuggables = {
--             -- whether to use telescope for selection menu or not
--             use_telescope = true
--
--             -- rest of the opts are forwarded to telescope
--         },
--
--         -- These apply to the default RustSetInlayHints command
--         inlay_hints = {
--
--             -- Only show inlay hints for the current line
--             only_current_line = false,
--
--             -- Event which triggers a refersh of the inlay hints.
--             -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
--             -- not that this may cause  higher CPU usage.
--             -- This option is only respected when only_current_line and
--             -- autoSetHints both are true.
--             only_current_line_autocmd = "CursorHold",
--
--             -- wheter to show parameter hints with the inlay hints or not
--             show_parameter_hints = true,
--
--             -- whether to show variable name before type hints with the inlay hints or not
--             show_variable_name = false,
--
--             -- prefix for parameter hints
--             parameter_hints_prefix = "<- ",
--
--             -- prefix for all the other hints (type, chaining)
--             other_hints_prefix = "=> ",
--
--             -- whether to align to the length of the longest line in the file
--             max_len_align = false,
--
--             -- padding from the left if max_len_align is true
--             max_len_align_padding = 1,
--
--             -- whether to align to the extreme right or not
--             right_align = false,
--
--             -- padding from the right if right_align is true
--             right_align_padding = 7,
--
--             -- The color of the hints
--             highlight = "Comment",
--         },
--         hover_actions = {
--             -- the border that is used for the hover window
--             -- see vim.api.nvim_open_win()
--             border = {
--                 {"╭", "FloatBorder"}, {"─", "FloatBorder"},
--                 {"╮", "FloatBorder"}, {"│", "FloatBorder"},
--                 {"╯", "FloatBorder"}, {"─", "FloatBorder"},
--                 {"╰", "FloatBorder"}, {"│", "FloatBorder"}
--             },
--             -- whether the hover action window gets automatically focused
--             auto_focus = false
--         },
--         -- settings for showing the crate graph based on graphviz and the dot
--         -- command
--         crate_graph = {
--             -- Backend used for displaying the graph
--             -- see: https://graphviz.org/docs/outputs/
--             -- default: x11
--             backend = "x11",
--             -- where to store the output, nil for no output stored (relative
--             -- path from pwd)
--             -- default: nil
--             output = nil,
--             -- command to pipe the output to, nil for no piping
--             pipe = nil,
--             -- NOTE: Be careful when using pipe and output together
--             -- true for all crates.io and external crates, false only the local
--             -- crates
--             -- default: true
--             full = true,
--         }
--     },
--     -- all the opts to send to nvim-lspconfig
--     -- these override the defaults set by rust-tools.nvim
--     -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
--     server = {
--         -- standalone file support
--         -- setting it to false may improve startup time
--         standalone = false,
--     }, -- rust-analyer options
--
--     -- debugging stuff
--     dap = {
--         adapter = {
--             ype = 'executable',
--             command = 'lldb-vscode',
--             name = "rt_lldb"
--         }
--     }
-- })
--
-- require('rust-tools.inlay_hints').set_inlay_hints()

-- Copy and paste to/from system clipboard
vim.cmd[[ vmap <leader>y "+y ]]
vim.cmd[[ vmap <leader>d "+d ]]
vim.cmd[[ nmap <leader>p "+p ]]
vim.cmd[[ nmap <leader>P "+P ]]
vim.cmd[[ vmap <leader>p "+p ]]
vim.cmd[[ vmap <leader>P "+P ]]

-- i like things fast
vim.o.updatetime = 100
vim.o.timeoutlen = 260

function Getos()
    local os_name = io.popen("uname -s 2>/dev/null","r")
    if os_name then
       return os_name:read()
    end

    return "not supported"
end

OS = Getos()
local is_darwin = (OS=='Darwin')
local is_linux = (OS=='Linux')

-- undo dir
if (is_linux) then
    vim.o.undodir = '/home/db/dev/.temp/nvim/did'
elseif (is_darwin) then
    vim.o.undodir='/Users/db/dev/.temp/nvim/did'
else
    -- TODO
end

vim.o.undofile = true
-- Set the number of lines to keep visible above and below the cursor at the
-- top and bottom of the screen
vim.o.scrolloff = 8
-- vim.o.nowrap = true
vim.o.termguicolors = true
-- better comments
vim.o.textwidth = 80
vim.o.colorcolumn = '100'

vim.cmd[[ set nowrap ]]
vim.cmd[[ nnoremap <leader><leader> <c-^> ]]
vim.cmd[[ nmap <silent> <leader>/ :noh<cr> ]]

-- quick switch buffers
nvim_keymap('n', '<leader><leader>', '<c-^>' , nmo)
-- reset highlight
nvim_keymap('n', '<leader>/', '<cmd>noh<cr>' , nmo)

-- create new files adjacent to current working dir
nvim_keymap('n', ';e', ':e <C-R>=expand("%:p:h") . "/" <CR>', {})
nvim_keymap('n', ';te', ':tabe <C-R>=expand("%:p:h") . "/" <CR>', {})
-- quick save with ;w
nvim_keymap('n',';w', '<cmd>w<CR>', {} )
-- quick suspend with ;s
nvim_keymap('n', ';f', '<cmd>sus<CR>', {})
-- !TODO improve
nvim_keymap('n', ';cr', '<cmd>!cargo run<CR>', {})
nvim_keymap('n', ';cb', '<cmd>TermExec cmd=\'cargo build\'<CR>', {})
nvim_keymap('n', ';m', '<cmd>TermExec cmd=\'make\'<CR>', {})
nvim_keymap('n', ';cc', '<cmd>!cargo check<CR>', {})

-- quick save with <leader> w
-- vim.cmd[[ nmap <leader>w :w<CR> ]]

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {"node_modules", "/dist"},
	layout_strategy = "horizontal",
    		layout_config = {
      		height = 0.6,
            width= 0.6,
		preview_cutoff = 120
      		-- preview_width = 0.55,
    	},
    },
    extensions = {
        frecency = {
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/tmp/*", "*/node_modules/*"},
        }
    }
})

require'nvim-treesitter.configs'.setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "maintained",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = { "javascript" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
})

require('Comment').setup()


-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local tb = "<cmd>lua require('telescope.builtin')."
nvim_keymap('n','<leader>ff', tb..'find_files()<cr>',{})
nvim_keymap('n','<leader>fg', tb..'live_grep()<cr>',{})
nvim_keymap('n','<leader>fb', tb..'buffer()<cr>',{})
nvim_keymap('n','<leader>fh', tb..'help_tags()<cr>',{})
nvim_keymap('n','<leader>la', tb .. 'lsp_code_actions(require("telescope.themes").get_cursor())<cr>',{})

-- Diagnostic keymaps
nvim_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', nmo)
nvim_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', nmo)
nvim_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', nmo)
nvim_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', nmo)

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local lspkeymap = vim.api.nvim_buf_set_keymap
  local lsp_cmd = '<cmd>lua vim.lsp.buf.'
  local cmdl = '<cmd>lua'
  lspkeymap(bufnr, 'n', 'gD'         , lsp_cmd..'declaration()<CR>'                                         , nmo)
  lspkeymap(bufnr, 'n', 'gd'         , lsp_cmd..'definition()<CR>'                                          , nmo)
  lspkeymap(bufnr, 'n', 'K'          , lsp_cmd..'hover()<CR>'                                               , nmo)
  lspkeymap(bufnr, 'n', 'gi'         , lsp_cmd..'implementation()<CR>'                                      , nmo)
  lspkeymap(bufnr, 'n', '<C-k>'      , lsp_cmd..'signature_help()<CR>'                                      , nmo)
  lspkeymap(bufnr, 'n', '<leader>wa' , lsp_cmd..'add_workspace_folder()<CR>'                                , nmo)
  lspkeymap(bufnr, 'n', '<leader>wr' , lsp_cmd..'remove_workspace_folder()<CR>'                             , nmo)
  lspkeymap(bufnr, 'n', '<leader>wl' , cmdl..'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>' , nmo)
  lspkeymap(bufnr, 'n', '<leader>D'  , lsp_cmd..'type_definition()<CR>'                                     , nmo)
  lspkeymap(bufnr, 'n', '<leader>rn' , lsp_cmd..'rename()<CR>'                                              , nmo)
  lspkeymap(bufnr, 'n', 'gr'         , lsp_cmd..'references()<CR>'                                          , nmo)
  lspkeymap(bufnr, 'n', '<leader>ca' , lsp_cmd..'code_action()<CR>'                                         , nmo)
  lspkeymap(bufnr, 'n', '<leader>so' , [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]] , nmo)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers, quick setup default settings
local servers = { 'clangd', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Rust
lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Lua
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
             -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

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
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require("toggleterm").setup {
  -- -- size can be a number or function which is passed the current terminal
  -- size = 20 | function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'vertical',
  size = 100,
  close_on_exit = true, -- close the terminal window when the process exits
  shell = "/usr/bin/env fish", -- change the default shell
}

function Set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua Set_terminal_keymaps()')

-- require('rust-tools').setup({})
-- require('rust-tools.inlay_hints').set_inlay_hints()
-- require'rust-tools.open_cargo_toml'.open_cargo_toml()

-- -- Colorscheme
-- local dbfox = require('nightfox')
-- -- This function set the configuration of nightfox. If a value is not passed in the setup function
-- -- it will be taken from the default configuration above
-- dbfox.setup({
--   fox = "dbfox", -- change the colorscheme to use nordfox
--   styles = {
--     comments = "italic", -- change style of comments to be italic
--     -- keywords = "bold", -- change style of keywords to be bold
--     functions = "italic" -- styles can be a comma separated list
--   },
--   -- inverse = {
--   --   match_paren = true, -- inverse the highlighting of match_parens
--   -- },
--   -- colors = {
--   --     bg = '#23272e'
--   -- },
--   -- hlgroups = {
--   --   TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
--   --   LspCodeLens = { bg = "#000000", style = "italic" },
--   -- }
-- })
--
-- -- Load the configuration set above and apply the colorscheme
-- dbfox.load()
-- --
require('lualine').setup({
    theme = 'onedark'
})

require('onedark').setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'Italic',
        keywords = 'none',
        functions = 'none',
        strings = 'italic',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = false,    -- use background color for virtual text
    },
}
require('onedark').load()

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

----- indent guidelines
vim.cmd [[highlight IndentBlank_bar guifg=#303742 gui=nocombine]]
vim.cmd [[highlight IndentBlank_bar guibg=#282c34 gui=nocombine]]
-- vim.cmd [[highlight IndentBlank_dot guifg=#313844 gui=nocombine]]
-- vim.cmd [[highlight IndentBlank_dot guibg=#282c34 gui=nocombine]]

require("indent_blankline").setup {
    -- space_char_blankline = "",
    -- show_current_context = true,
    -- show_current_context_start = true,
    char_highlight_list = {
        "IndentBlank_bar",
    },
    -- space_char_highlight_list = {
    --     "IndentBlank_dot",
    -- },
}
