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

local cmp = require'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['rust-analyzer'].setup {
    capabilities = capabilities
  }

vim.cmd [[colorscheme onedark]]
