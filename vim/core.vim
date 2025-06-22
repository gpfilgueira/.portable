" ======================================================
" COMBINED Vi / Vim / Neovim CONFIGURATION
" ======================================================

" Detect if running original Vi (no :set support)
if !exists(':set')
    " ===== Vi minimal config =====
    " Only basic options supported by original Vi:

    " Enable line numbers (if supported)
    if exists('&number')
        set number
    endif

    " Tabs and indentation
    set tabstop=4
    set shiftwidth=4
    set autoindent

    " Basic search settings
    set ignorecase

    " Visible bell instead of beep
    set vb

    " Fallback minimal status line (if supported)
    set laststatus=2

    " Disable compatibility if possible
    if exists(':set')
        set nocompatible
    endif

    " End of Vi minimal config
    finish
endif

" ===== Vim / Neovim full config =====

" --- BASIC SETTINGS ---
set nocompatible                 " Disable Vi compatibility
filetype plugin indent on       " Auto-detect filetypes
syntax enable                   " Syntax highlighting

" Line numbers (Vi will ignore 'relativenumber')
set number
if exists('&relativenumber') | set relativenumber | endif

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
if exists('&smartindent') | set smartindent | endif

" UI/Behavior
set nowrap
set title
set showcmd
set cmdheight=2
set showmode
set laststatus=2
set signcolumn=auto
set scrolloff=8
set sidescrolloff=8
set wildmenu
set updatetime=50

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Files
set nobackup
set nowritebackup
set noswapfile
set path+=**

" Colors (Neovim/Vim with +termguicolors only)
if exists('&termguicolors') | set termguicolors | endif

" Clipboard (if available)
if has('clipboard')
    set clipboard=unnamedplus
    if !has('nvim') | set clipboard+=unnamed | endif
endif

" Persistent undo (if supported)
if exists('&undofile')
    silent! call mkdir(expand('~/.vi/undodir'), 'p')
    set undodir=~/.vi/undodir
    set undofile
endif

" Mouse (if supported)
if has('mouse') | set mouse=a | endif

" Completion
if exists('&completeopt') | set completeopt=menuone,noselect | endif

set fileencoding=utf-8

" --------------------
" --- KEY MAPPINGS ---
" --------------------

let mapleader = " "
let maplocalleader = "\\"

" Window management
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Left> :vertical resize +3<CR>
nnoremap <C-Right> :vertical resize -3<CR>

" Tab management
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>x :tabclose<CR>
nnoremap <leader>j :tabprevious<CR>
nnoremap <leader>k :tabnext<CR>

" Buffer management
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Explorer (only if netrw is available)
if exists(':Lex')
    nnoremap <leader>e :w<CR>:25Lex<CR>
endif

" Select all
nnoremap <Leader>a ggVG

" Clipboard mappings (if supported)
if has('clipboard') || has('unnamedplus')
    nnoremap <silent> <Leader>y "+y
    vnoremap <silent> <Leader>y "+y
    nnoremap <silent> <Leader>Y "+Y
    nnoremap <silent> <Leader>A ggVG"+y
else
    nnoremap <Leader>y :echo "Clipboard not supported in this environment"<CR>
    nnoremap <Leader>Y :echo "Clipboard not supported in this environment"<CR>
endif

" Delete without yanking
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d

" Insert new lines
nnoremap <Leader>b o<Esc>xk
nnoremap <Leader>B O<Esc>xj

" Visual mode line moving
if exists(':vnoremap')
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv
endif

" Center search matches
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z

" Centered scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Quickfix/location list navigation
if exists(':cnext')
    nnoremap <C-k> :cnext<CR>zz
    nnoremap <C-j> :cprev<CR>zz
    nnoremap <Leader>k :lnext<CR>zz
    nnoremap <Leader>j :lprev<CR>zz
endif

" Search/replace
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <Leader>x :!chmod +x %<CR>

" Insert mode helpers
inoremap kj <Esc>
inoremap jk <Esc>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap () ()<left>
inoremap [] []<left>
inoremap {} {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap /* /**/<left><left>

" ----------------------
" --- PLUGIN LOADING ---
" ----------------------

function! LoadPlugins()
    let l:plugins_file = expand('~/.vi/plugins.vim')
    if filereadable(l:plugins_file)
        execute 'source' l:plugins_file
    else
        echo "Plugins file not found. Continuing without plugins."
    endif
endfunction

call LoadPlugins()

" ======================================================
" END OF CORE CONFIG
" ======================================================
