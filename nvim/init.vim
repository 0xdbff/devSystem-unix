" =============================================================================
" INITIAL SETUP
" =============================================================================

set shell=/bin/bash

" Set the leader key to space
let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================

" Install vim-plug if it isn't already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start installing plugins
call plug#begin('~/.local/share/nvim/plugged')

" Appearance
" ----------
" Display an info bar (lightline) at the bottom of the screen
Plug 'itchyny/lightline.vim'
" Highlight the region just yanked
Plug 'machakann/vim-highlightedyank'
" Only display relative numbers in places that make sense
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Coloriser for color codes and things
Plug 'norcalli/nvim-colorizer.lua'

" Editing
" -------
" Expand or contract the current selection
Plug 'terryma/vim-expand-region'
" Comment lines easily
Plug 'tpope/vim-commentary'
" Jump to a specific spot easily
Plug 'easymotion/vim-easymotion'

" Files
" -----
" Change working directory to the project root when opening a file
Plug 'airblade/vim-rooter'
" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
" ---
" Display git status of lines
Plug 'airblade/vim-gitgutter'
" Show the git blame for the current line
Plug 'APZelos/blamer.nvim'
" Run Git commands and resolve conflicts inside Vim
Plug 'tpope/vim-fugitive'

" Semantic language support
" -------------------------
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
" Improvements to the built-in LSP UI
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
" Statusline component for LSP information
Plug 'nerosnm/lsp-status.nvim', { 'branch': 'nerosnm/always-add-space' }

" Syntactic language support
" --------------------------
" Languages under active use
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'lervag/vimtex'
Plug 'dag/vim-fish'
Plug 'LnL7/vim-nix'
Plug 'plasticboy/vim-markdown'
" Other languages
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neovimhaskell/haskell-vim'
Plug 'elmcast/elm-vim'
Plug 'gleam-lang/gleam.vim'
Plug 'tikhomirov/vim-glsl'
" Extra tools
Plug 'godlygeek/tabular'
Plug 'rhysd/vim-clang-format'
Plug 'google/vim-maktaba'
Plug 'mhartington/formatter.nvim'

" Utility
" -------
" Protection against modeline vulnerability
Plug 'ciaranm/securemodelines'

" Finish installing plugins
call plug#end()

" =============================================================================
" PLUGIN SETTINGS
" =============================================================================

" lightline.vim
" -------------
" Turn off default nvim display of current mode, because it's shown in lightline
set noshowmode
" Set a colour scheme and add a custom filename pattern.
let g:lightline = {
    \ 'colorscheme': 'onehalfdark',
    \ 'active': {
    \     'left': [
    \         [ 'mode', 'paste' ],
    \         [ 'readonly', 'filename' ],
    \         [ 'lspstatus' ],
    \         [ 'truncate' ],
    \     ],
    \     'right': [
    \         [ 'lineinfo' ],
    \         [ 'percent' ],
    \         [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
    \     ]
    \ },
    \ 'component': {
    \     'truncate': '%<'
    \ },
    \ 'component_visible_condition': {
    \     'truncate': 0,
    \ },
    \ 'component_type': {
    \     'truncate': 'raw',
    \ },
    \ 'component_function': {
    \     'filename': 'LightlineFilename',
    \     'lspstatus': 'LspStatus',
    \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction
function! LspStatus() abort
  return luaeval("require('lsp-status').status()")
endfunction

" nvim-colorizer.lua
" ------------------
" Use truecolor support
set termguicolors
lua require'colorizer'.setup()

" vim-expand-region
" -----------------
" Use v when in visual mode to expand the current selection, and C-v to contract it
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" easymotion
" ----------
" Don't bind any keys by default, because they create conflicts
let g:EasyMotion_do_mapping = 0
" <Leader>f{char} to move to {char}
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" <Leader>j to jump to a word
map  <Leader>j <Plug>(easymotion-bd-w)
nmap <Leader>j <Plug>(easymotion-overwin-w)

" vim-rooter
" ----------
" Set file and directory patterns for detection of project root
let g:rooter_patterns = ['.git', '.git/', 'package-lock.json']

" fzf.vim
" -------
" Shrink the size of the fzf file finder window
let g:fzf_layout = { 'down': '~20%' }
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
" Open a fuzzy file finder with C-p and a fuzzy buffer finder with leader-;
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
" Run a Rg search with <leader>s
noremap <leader>s :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" vim-gitgutter
" ------------
" Don't map any keys by default
let g:gitgutter_map_keys = 0
" Set all these signs to a bar so that just colour is used to distinguish
let g:gitgutter_sign_added = '▏'
let g:gitgutter_sign_modified = '▏'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▏'
let g:gitgutter_sign_modified_removed = '▏'
" Don't highlight line numbers
let g:gitgutter_highlight_linenrs = 0
highlight! link SignColumn LineNr

" blamer.nvim
" -----------
" Disabled by default; run :BlamerToggle to enable
let g:blamer_enabled = 0
" Shorten the delay before updates to blame information
let g:blamer_delay = 300
" Don't put a prefix at the beginning of the blame info
let g:blamer_prefix = ''
" Include short commit hash in addition to default blame info
let g:blamer_template = '<committer>, <committer-time> (<commit-short>) • <summary>'
" Only show the date, not time, in the blame info
let g:blamer_date_format = '%Y-%m-%d'
" Use relative date for recent dates
let g:blamer_relative_time = 1

" nvim-lspconfig, nvim-lsputils, lsp-status.nvim
" ----------------------------------------------
" Set up language server(s)
lua <<EOF
local config = require'lspconfig'
local completion = require'completion'
local status = require'lsp-status'

local on_attach = function(client)
    completion.on_attach(client)
    status.on_attach(client, bufnr)
end

config.rust_analyzer.setup({
    on_attach = on_attach,
    on_init = function(client)
        client.config.flags = {
            allow_incremental_sync = false;
        }
    end,
    capabilities = status.capabilities,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = {
                    "unresolved-proc-macro"
                }
            }
        },
    },
    flags = {
        debounce_did_change_notify = 50,
    },
})

config.hls.setup({
    on_attach = on_attach,
    capabilities = status.capabilities,
})

config.tsserver.setup({
    on_attach = on_attach,
    capabilities = status.capabilities,
})

config.metals.setup({
    on_attach = on_attach,
    capabilities = status.capabilities,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = '>',
        },
        signs = true,
        update_in_insert = false,
    }
)

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

status.register_progress()
status.config({
    status_symbol = 'ȸ',
    current_function = false,
    indicator_errors = '●',
    indicator_warnings = '◉',
    indicator_info = '◎',
    indicator_hint = '○',
    indicator_ok = 'Ok',
    spinner_frames = { '◜', '◝', '◞', '◟' },
    -- spinner_frames = { '○', '◔', '◑', '◕', '●' },
})
EOF

" Code navigation shortcuts
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gu    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>

" Set updatetime for CursorHold
" 100ms of no cursor movement to trigger CursorHold
set updatetime=100
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g< <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '▷ ', highlight = "InlayHint", enabled = { "TypeHint", "ChainingHint", "ParameterHint" } }

augroup lspcolors | au!
    " Customise some of the colours used for LSP things
    au ColorScheme * hi! NormalFloat guibg=#3c4048
    au ColorScheme * hi! LspDiagnosticsDefaultHint guifg=#5c6370
    au ColorScheme * hi! LspDiagnosticsDefaultInformation guifg=#5c6370
    au ColorScheme * hi! LspDiagnosticsDefaultWarning guifg=#e5c07b
    au ColorScheme * hi! LspDiagnosticsDefaultError guifg=#f23235
    " Customise some of the symbols used
    sign define LspDiagnosticsSignError text=●
    sign define LspDiagnosticsSignWarning text=◉
    sign define LspDiagnosticsSignInformation text=◎
    sign define LspDiagnosticsSignHint text=○
    " Add a highlight group for inlay hints
    au ColorScheme * hi! InlayHint guifg=#848b98
augroup END

" completion-nvim
" ---------------
" Set completeopt to have a better completion experience
" - menuone: popup even when there's only one match
" - noinsert: Do not insert text until a selection is made
" - noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Turn off extra completion messages
set shortmess+=c

" Don't automatically pop up completion unless Tab has been pressed
let g:completion_enable_auto_popup = 0

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Set matching strategy for completions
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

" Complete parentheses for functions
let g:completion_enable_auto_paren = 1

" rust.vim
" --------
" Turn on automatic formatting on save using nightly rustfmt $rustup run nightly rustfmt
"let g:rustfmt_command = 'cargo fmt'
let g:rustfmt_autosave = 1

" vimtex
" ------
" Explicitly specify that TeX is always really LaTeX
let g:tex_flavor = 'latex'
" Set the leader key for insert-mode bindings
let g:vimtex_imaps_leader = ';'

" vim-markdown
" ------------
" Disable automatic folding of sections in Markdown files
let g:vim_markdown_folding_disabled = 1

" Disable markdown conceal feature
let g:vim_markdown_conceal = 0

" Disable TeX conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Turn on support for frontmatter in Markdown files
let g:vim_markdown_frontmatter = 1 " YAML
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" vim-clang-format
" ----------------
let g:clang_format#code_style = 'llvm'

" formatter.nvim
" --------------
lua <<EOF
require('formatter').setup({
    logging = false,
    filetype = {
        haskell = {
            function()
                return {
                    exe = "stylish-haskell",
                    args = {},
                    stdin = true
                }
            end
        }
    }
})
EOF

augroup Formatter | au!
    au BufWritePost *.hs :FormatWrite
augroup END

" =================
" LANGUAGE SETTINGS
" =================

" Rust
" ----
augroup rust | au!
    " Set the text width in Rust files to 80, for comment wrapping.
    au Filetype rust setlocal textwidth=80
augroup END

" Go
" --
augroup go | au!
    " Set the indentation to use tabs
    au FileType go setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
augroup END

" C++
" ----
augroup cpp | au!
    au Filetype cpp setlocal shiftwidth=2 softtabstop=2
    au BufNewFile,BufRead *.cpp,*.hpp :ClangFormatAutoEnable
augroup END

" LaTeX
" -----
augroup latex | au!

    " Set filetype correctly for .cls files
    au BufNewFile,BufRead *.cls setlocal syntax=tex

    " Set indentation levels for LaTeX files
    au Filetype tex setlocal shiftwidth=2 softtabstop=2

    " In LaTeX files, we want to wrap both "normal text" and comments.
    au Filetype tex setlocal fo-=c
    au Filetype tex setlocal fo+=tc

    " Build TeX files with ninja, not make, when running a make keybinding
    au Filetype tex setlocal makeprg=ninja
augroup END

" JavaScript and Web Languages
" ----------------------------
augroup web | au!
    " Set an indentation level of 2 spaces for JavaScript and TypeScript files
    au BufRead,BufNewFile *.js,*.jsx,*.mjs,*.ts,*.tsx setlocal shiftwidth=2 softtabstop=2
    " Same for CSS-family files
    au BufRead,BufNewFile *.css,*.less,*.scss,*.sass setlocal shiftwidth=2 softtabstop=2
    " Same for markup languages
    au BufRead,BufNewFile *.html,*.md,*.yaml setlocal shiftwidth=2 softtabstop=2
    " Same for other JS-adjacent file types
    au BufRead,BufNewFile *.graphql,*.json setlocal shiftwidth=2 softtabstop=2
augroup END

" Ruby
" ----
augroup rb | au!

    " Set filetype correctly for Podfiles
    au BufNewFile,BufRead Podfile setlocal syntax=ruby
augroup END

" Email
" -----
augroup eml | au!

    " Set the textwidth to the smaller standard 72 chars for emails
    au BufRead,BufNewFile *.eml setlocal textwidth=72
augroup END

" YAML
" ----
augroup yaml | au!

    " Set the indentation width to 2 spaces for YAML
    au Filetype yaml setlocal shiftwidth=2 softtabstop=2
augroup END

" Gemini
" ------
augroup gemini | au!
    au BufRead,BufNewFile *.gmi setlocal wrap linebreak textwidth=0 wrapmargin=0
augroup END

" Haskell
" ----
augroup hs | au!

    " Set the indentation width to 2 spaces for Haskell
    au Filetype haskell setlocal shiftwidth=2 softtabstop=2
augroup END

" =============================================================================
" EDITOR SETTINGS
" =============================================================================

" Appearance
" ----------
augroup appearance | au!
    " Give the sign column a transparent background
    au ColorScheme * hi! SignColumn guibg=none
    " Darken special (doc) comments a bit
    au ColorScheme * hi! SpecialComment guifg=#5c6370
    " Make comments italic
    au ColorScheme * hi! Comment gui=italic
    au ColorScheme * hi! SpecialComment gui=italic
    " Use undercurl for misspelled words
    au ColorScheme * hi! SpellBad guisp=Red gui=undercurl
    au ColorScheme * hi! SpellCap guisp=Yellow gui=undercurl
augroup END
" Display a background on the line with the cursor on it
set cursorline
" Always show the signcolumn
set signcolumn=yes
" Set the color scheme
" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
    "screen does not (yet) support truecolor
    set termguicolors
endif
" set background=dark
" let base16colorspace=256
colorscheme db_onehalfdark
syntax on
hi Normal ctermbg=NONE
" hi Normal guibg=NONE ctermbg=NONE

" Text Editing
" ------------
" Turn on filetype detection and plugin/indent info loading
filetype plugin indent on
" Use 4-space indentation
set shiftwidth=4
set softtabstop=4
set expandtab
" Auto-indent on new lines
set autoindent
" Don't insert two spaces after certain characters when using a join command
set nojoinspaces
" Wrap to 100 characters
set textwidth=100
" Format options (default fo=jcroql)
set fo=ca " Auto-wrap comments to textwidth
set fo+=r " Auto-insert the current comment leader when pressing enter in insert mode
set fo+=o " Auto-insert the current comment leader when entering new lines with o
set fo+=q " Allow `gq` to format comments
set fo+=w " Use a single trailing whitespace character to indicate continuing paragraphs
set fo+=n " Format numbered lists as well
set fo+=j " Auto-remove comment characters when joining lines
" Enable mouse usage (all modes) in terminals
set mouse=a
" Enable spell check
" set spell spelllang=en_gb

" Text Display
" ------------
" Display tab characters with a width of 8 spaces
set tabstop=8
" Set the number of lines to keep visible above and below the cursor at the top and bottom of the
" screen
set scrolloff=2
" Don't soft-wrap long lines to display them in the buffer
set nowrap
" Display line numbers in the sidebar
set number
" Display line numbers for every line but the current one as an offset
set relativenumber

" Searching
" ---------
" Jump to search results as the search pattern is typed
set incsearch
" Ignore case in search results by default
set ignorecase
" Don't ignore case if the search pattern contains uppercase characters
set smartcase
" Vertically centre search results in the buffer when jumping to them
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" Turn on magic options for searching by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
" Set the grep program to ag or rg (preferred) if available
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Utility
" -------
" Use undo files for permanent undo history
set undodir=~/.local/share/nvim/did
set undofile
" Hide buffers when they're abandoned rather than unloading them
set hidden
" Set up wildmenu for decent completions
set wildmenu
set wildmode=full
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set colorcolumn=101

" Annoyance Fixes
" ---------------
" Split in sane directions by default
set splitright
set splitbelow
" Reduce the time before vim executes a command
set timeoutlen=300

" Platform Specific
" -----------------
let OS=substitute(system('uname -s'),"\n","","")
if (OS == "Darwin")
    " macOS Specific Settings
elseif ( OS == 'Linux' )
    " Linux Specific Settings
endif

" =============================================================================
" KEYBOARD SHORTCUTS
" =============================================================================

" Quick-save with <leader>w
nmap <leader>w :w<CR>

" Write buffer through sudo
cnoreabbrev w!! w !sudo tee % >/dev/null

" Suspend nvim
nnoremap <leader>ss :sus<cr>

" Copy and paste to/from system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Quick switch between the last two buffers using <leader><leader>
nnoremap <leader><leader> <c-^>

" Open a new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Toggle search highlighting
nmap <silent> <leader>/ :noh<cr>

" Create splits with <leader>s and a direction
nmap <silent> <leader>sh :leftabove vnew<cr>
nmap <silent> <leader>sl :rightbelow vnew<cr>
nmap <silent> <leader>sk :leftabove new<cr>
nmap <silent> <leader>sj :rightbelow new<cr>

" Move between splits with C and a direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Run make from the current directory
noremap M :make<cr>
" Run make from the directory containing the current file
norema p MM :!cd "%:p:h" \| make<cr>
