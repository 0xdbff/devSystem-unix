-- use space as the leader key
vim.g.mapleader = ' '

-- packer path
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

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
  use 'easymotion/vim-easymotion'

  use{ "nvim-lua/popup.nvim" }
  use{ "nvim-lua/plenary.nvim" }

  ------ Telescope
  use "nvim-telescope/telescope.nvim"
  use {
	"nvim-telescope/telescope-fzf-native.nvim",
	run = "make"
  }
  use "nvim-telescope/telescope-rs.nvim"
  use "nvim-telescope/telescope-fzf-writer.nvim"
  use "nvim-telescope/telescope-github.nvim"
  use "nvim-telescope/telescope-symbols.nvim"
  use "nvim-telescope/telescope-hop.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-smart-history.nvim"

  ------ UI settings
  -- Colorshemes
  use 'mjlbach/onedark.nvim'
  -- use 'navarasu/onedark.nvim'
  use 'EdenEast/nightfox.nvim'
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
  use "norcalli/nvim-colorizer.lua"
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

  ------ LSP settings
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
vim.o.hlsearch = false
--Make line numbers default
vim.wo.number = true
--Enable mouse mode
vim.o.mouse = 'a'
--Set colorscheme
vim.o.termguicolors = true

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {"node_modules", "/dist"},
	layout_strategy = "bottom_pane",
    		layout_config = {
      		height = 0.26,
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
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require('Comment').setup()

require('lualine').setup({
	theme = 'onedark'
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

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


vim.cmd [[colorscheme onedark]]
