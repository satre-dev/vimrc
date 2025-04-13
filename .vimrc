" Generic settings
set nocompatible
filetype off
filetype plugin indent on

set number
syntax on
set nohlsearch

let mapleader = " "
set incsearch
set ignorecase
set smartcase
set smartindent
set autoindent
set showmatch
set clipboard=unnamedplus
set scrolloff=8
set ttyfast
set showcmd
set showmode
set undofile
set undodir=~/.vim/undodir

set list
set listchars=tab:→\ ,trail:·,extends:>,precedes:<,nbsp:␣
set autoread
set tabstop=4
set shiftwidth=4
set nowrap
set softtabstop=4
set expandtab
set matchpairs+="<:>"
set ruler
set cursorline
set colorcolumn=80
set updatetime=300

autocmd FocusGained,BufEnter * checktime
autocmd BufWritePre * %s/\s\+$//e

" Plugins

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'preservim/tagbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'neovimhaskell/haskell-vim'
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'vim-python/python-syntax'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-dadbod'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

call plug#end()

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_align = 'right'
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview


" Remaps

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fuzzy find files
nnoremap <leader>ff :Files<CR>
" Fuzzy search in files (requires ripgrep)
nnoremap <leader>fg :Rg<CR>
" Buffers
nnoremap <leader>fb :Buffers<CR>
" Git files
nnoremap <leader>gf :GFiles<CR>
" Recent files
nnoremap <leader>fr :History<CR>
" Command palette
nnoremap <leader>fc :Commands<CR>

" Git related keymaps (vim-fugitive integration)
nnoremap <leader>ga :G add .<CR>
nnoremap <leader>gs :G status<CR>
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>gd :G diff<CR>
nnoremap <leader>gl :G log<CR>
nnoremap <leader>gb :G blame<CR>

" LSP Remaps
nmap <silent> gd <Plug>(lsp-definition)
nmap <silent> gr <Plug>(lsp-references)
nmap <silent> K  <Plug>(lsp-hover)
nmap <silent> <leader>rn <Plug>(lsp-rename)

map <leader>q gqip

" Move between header and source files
nnoremap <leader>h :e %:r.h*<CR>
nnoremap <leader>c :e %:r.c*<CR>

" LSP Settings
let g:lsp_settings = {
    \ 'clangd': {
    \   'cmd': ['clangd']
    \ },
    \ 'erlang_ls': {
    \   'cmd': ['erlang_ls']
    \ },
    \ 'hls': {
    \   'cmd': ['haskell-language-server-wrapper', '--lsp']
    \ },
    \ 'pyright': {
    \   'cmd': ['pyright-langserver', '--stdio']
    \ },
    \ 'tsserver': {
    \   'cmd': ['typescript-language-server', '--stdio']
    \ },
    \ 'omnisharp': {
    \   'cmd': ['omnisharp', '--languageserver']
    \ },
    \ 'sqlls': {
    \   'cmd': ['sql-language-server', 'up', '--stdio']
    \ }
\ }

" Formatting
autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.rs :silent! execute '%!rustfmt'
autocmd BufWritePre *.c,*.cpp,*.h :silent! execute '%!clang-format'

" Colorscheme
set modelines=0
set t_Co=256
set background=dark
colorscheme gruvbox

" Fuzzy Find settings
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:fzf_preview_window = ['right:60%:wrap', 'ctrl-/']

" Airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#lsp#enabled = 1

" Modify LSP Diagnostic window
" Enable floating popups for LSP diagnostics when pressing K
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_align = 'right'
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_prefix = '● '
let g:lsp_diagnostics_virtual_text_separator = '  '

" Diagnostic hover
nnoremap K :LspHover<CR>    " Maps K to show hover information

" Tab and Buffer navigation
" Basic Navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>

" Fuzzy buffer switching (fzf)
nnoremap <leader>bb :Buffers<CR>

" Buffer Utilities
nnoremap <leader>bl :ls<CR>
nnoremap <leader>bd :bdelete<CR>

" Tab page navigation
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tn :tabnext<CR>

" Create a new vertical split
nnoremap <leader>vs :vsplit<CR>
" Move to the next vertical split
nnoremap <leader>vl <C-w>w

" Move to the previous vertical split
nnoremap <leader>vr <C-w>W
" Close the current window (vertical or horizontal)
nnoremap <leader>vq :q<CR>

" Statusline config
" Define a function to display language-specific icons in the status line
function! FiletypeIcon()
    if &filetype == 'go'
        return 'ﯧ' " Go icon from Nerd Font
    elseif &filetype == 'rust'
        return '' " Rust icon from Nerd Font
    elseif &filetype == 'python'
        return '' " Python icon from Nerd Font
    elseif &filetype == 'javascript'
        return '' " JavaScript icon from Nerd Font
    elseif &filetype == 'typescript'
        return '' " TypeScript icon from Nerd Font
    elseif &filetype == 'c'
        return '' " C icon from Nerd Font
    elseif &filetype == 'cpp'
        return '' " C++ icon from Nerd Font
    elseif &filetype == 'haskell'
        return '' " Haskell icon from Nerd Font
    elseif &filetype == 'erl'
        return '' " Erlang icon from Nerd Font
    elseif &filetype == 'vim'
        return '' " Vim logo from Nerd Font (for testing purposes)
    else
        return '' " No icon for unknown file types
    endif
:endfunction

" Set the statusline with the filetype icon
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD
let g:airline_section_c ='%{expand("%:t")} %{FiletypeIcon()}'
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 1     " disables the weird orange arrow on the tabline
