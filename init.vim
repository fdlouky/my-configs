" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
" :CocInstall coc-pyright: The main Python plugin I use
" :CocCommand snippets.edit... FOR EACH FILE TYPE

set number " Line number in cursor position
set relativenumber " Relative line number
set autoindent
set tabstop=4
set shiftwidth=4 " For shifting text left or righ
set smarttab
set softtabstop=4
set mouse=a " To use the mouse in the Vim editor
set colorcolumn=79 " To show vertical line in column 79
set cursorline  " Horizontal line in cursor position


call plug#begin()

Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'ctrlpvim/ctrlp.vim' " A fuzzy file finder
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-airline/vim-airline' " Status bar
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine (autocompletion)
Plug 'preservim/tagbar' " Tagbar for code navigation
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " CTRL + N for multiple cursors
Plug 'vim-scripts/indentpython.vim'  " Auto-Indentation for python
Plug 'APZelos/blamer.nvim' " Similar to GitLense
Plug 'tmhedberg/matchit' " Switch to the begining and the end of a block by pressing %
Plug 'tpope/vim-fugitive' " Git integration
Plug 'jiangmiao/auto-pairs' " Auto-close braces and scopes
Plug 'jmcantrell/vim-virtualenv' " To show venv in vim-airline (bottom bar)
Plug 'tomasiser/vim-code-dark' " Theme codedark
Plug 'sainnhe/everforest' " Theme everforest

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " Shows Git status flags for files and folders in NERDTree.
Plug 'ryanoasis/vim-devicons' " Adds filetype-specific icons to NERDTree files and folders,
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Adds syntax highlighting to NERDTree based on filetype.
" Plug 'scrooloose/nerdtree-project-plugin' " Saves and restores the state of the NERDTree between sessions.
" Plug 'PhilRunninger/nerdtree-buffer-ops' " 1) Highlights open files in a different color. 2) Closes a buffer directly from NERDTree. -> incompatible with nerdtree-git-plugin and vim-devicons
Plug 'PhilRunninger/nerdtree-visual-selection' " Enables NERDTree to open, delete, move, or copy multiple Visually-selected files at once.

" Syntax highlight plugins
Plug 'numirias/semshi'
" Plug 'sheerun/vim-polyglot' " Better syntax-highlighting for filetypes in vim
" Plug 'vim-python/python-syntax'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " After installing the pluging -> :TSInstall python

set encoding=UTF-8

call plug#end()

" Theme: codedark
set background=dark
let g:codedark_conservative=1 " If you don't like many colors and prefer the conservative style of the standard Visual Studio
let g:codedark_italics=1 " Activates italicized comments (make sure your terminal supports italics)
" let g:codedark_transparent=1 " Make the background transparent (totally dark)
" let g:airline_theme = 'codedark' " If you have vim-airline, you can also enable the provided theme
colorscheme codedark

" Theme: everforest (best for eyes)
" let g:everforest_background = 'hard' " Available values: 'hard', 'medium'(default), 'soft'
" let g:everforest_better_performance = 1 " For better performance
" colorscheme everforest

" Airline theme
let g:airline_theme = 'dark'

" Highlight inlay type hints for python
hi CocInlayHint ctermbg=0 ctermfg=8

" Highlight active tab
hi TabLineSel gui=NONE guibg=#3e4452 guifg=#abb2bf cterm=NONE term=NONE ctermfg=black ctermbg=white

" Move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" Move split panes to left/bottom/top/right
nnoremap <A-h> <C-W>H
nnoremap <A-j> <C-W>J
nnoremap <A-k> <C-W>K
nnoremap <A-l> <C-W>L
" Move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NerdTree shortcuts and some icon configs
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <F12> :call CocAction('jumpDefinition', 'tab drop')<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Error and warning list
nnoremap <F8> :CocDiagnostic<CR>

" Tagbar
nmap <F7> :TagbarToggle<CR>

" For No Previews
set completeopt-=preview


" Airline configs
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Gitlens
let g:blamer_enabled = 1

" Specific configs por python files
au BufNewFile,BufRead *.py
    \| set textwidth=79
    \| set expandtab
    \| set fileformat=unix

" Color leading and trailing whitespaces
highlight default BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


" Show venv in airline
let g:airline#extensions#virtualenv#enabled = 1

" User defined commands
command Format :call CocAction('format') " format document

" Highlight all matching tokens under cursor -> coc-highlight
autocmd CursorHold * silent call CocActionAsync('highlight')

" Config for autocompletion from https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
" Use <cr> to confirm completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(6)<CR>
inoremap <A-t> <Esc>:call TermToggle(6)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(6)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)