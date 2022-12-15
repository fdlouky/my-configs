" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
" :CocInstall coc-pyright: The main Python plugin I use
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" -----------------------------------------------------------------------------
" Plugins 
" -----------------------------------------------------------------------------

call plug#begin()

Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-airline/vim-airline' " Status bar
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine (autocompletion)
Plug 'preservim/tagbar' " Tagbar for code navigation
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " CTRL + N for multiple cursors
Plug 'vim-scripts/indentpython.vim'  " Auto-Indentation for python
Plug 'APZelos/blamer.nvim' " Similar to GitLense
Plug 'airblade/vim-matchquote' " Switch to the begining and the end of a block by pressing %
Plug 'tpope/vim-fugitive' " Git integration
Plug 'jiangmiao/auto-pairs' " Auto-close braces and scopes
Plug 'jmcantrell/vim-virtualenv' " To show venv in vim-airline (bottom bar)
Plug 'lukas-reineke/indent-blankline.nvim' " This plugin adds indentation guides to all lines (including empty lines)

" Vim signature to see marks in the left bar
Plug 'kshenoy/vim-signature'

" Dim inactive split
Plug 'blueyed/vim-diminactive'

" Run a diff on 2 directories.
Plug 'will133/vim-dirdiff'
" Run a diff on 2 blocks of text.
Plug 'AndrewRadev/linediff.vim'

" Highlight which character to jump to when using horizontal movement keys.
Plug 'unblevable/quick-scope'

" Dim paragraphs above and below the active paragraph.
Plug 'junegunn/limelight.vim'

" A bunch of useful language related snippets (ultisnips is the engine).
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Fold code
Plug 'tmhedberg/SimpylFold'

" Modify * to also work with visual selections
Plug 'nelstrom/vim-visual-star-search'

" Themes (colorschemes)
Plug 'tomasiser/vim-code-dark' " Theme codedark
Plug 'sainnhe/everforest' " Theme everforest
Plug 'jamespwilliams/bat.vim'

" Fuzzy finder
" Plug 'ctrlpvim/ctrlp.vim' " A fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'

" Pretty Tabs
Plug 'romgrk/barbar.nvim'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " Shows Git status flags for files and folders in NERDTree.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Adds syntax highlighting to NERDTree based on filetype.
Plug 'PhilRunninger/nerdtree-visual-selection' " Enables NERDTree to open, delete, move, or copy multiple Visually-selected files at once.

" Icons
Plug 'ryanoasis/vim-devicons' " Adds filetype-specific icons to NERDTree files and folders,
Plug 'nvim-tree/nvim-web-devicons' " for barbar plugin

" Syntax highlight plugins
Plug 'numirias/semshi'
" Plug 'sheerun/vim-polyglot' " Better syntax-highlighting for filetypes in vim
" Plug 'vim-python/python-syntax'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " After installing the pluging -> :TSInstall python

" Languages and file types.
Plug 'cakebaker/scss-syntax.vim'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'fatih/vim-go'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'godlygeek/tabular' | Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'jvirtanen/vim-hcl'
Plug 'lifepillar/pgsql.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'stephpy/vim-yaml'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-git'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'towolf/vim-helm'
Plug 'hashivim/vim-terraform'

call plug#end()

" -----------------------------------------------------------------------------
" settings  
" -----------------------------------------------------------------------------
:let mapleader=","

set encoding=UTF-8
set number " Line number in cursor position
set relativenumber " Relative line number
set autoindent
set tabstop=4
set shiftwidth=4 " For shifting text left or righ
set smarttab
set softtabstop=4
set mouse=a " To use the mouse in the Vim editor
set cursorline  " Horizontal line in cursor position

" Background color for inactive split
:hi ColorColumn ctermbg=0 guibg=#eee8d5

" -----------------------------------------------------------------------------
" theme and colors settings 
" -----------------------------------------------------------------------------

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

" Theme bat
" set termguicolors
" colorscheme bat

" Airline theme
let g:airline_theme = 'dark'

" Limelight -> Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Highlight inlay type hints for python
hi CocInlayHint ctermbg=0 ctermfg=8

" Highlight active tab
" hi TabLineSel gui=NONE guibg=#3e4452 guifg=#abb2bf cterm=NONE term=NONE ctermfg=black ctermbg=white
" hi BufferCurrent ctermfg=18 ctermbg=236 guifg=#d4d4d4 guibg=#1e1e1e " -> problems with icon background

" For No Previews
set completeopt-=preview

" Gitlens
let g:blamer_enabled = 1

" Highlight all matching tokens under cursor -> coc-highlight
autocmd CursorHold * silent call CocActionAsync('highlight')
set updatetime=300 " Make coc-highlight faster

" Tabout
inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

" -----------------------------------------------------------------------------
" keybindings, functions and commands 
" -----------------------------------------------------------------------------

" Remove marks also in shada
nnoremap m<space> :delm!<CR> :wshada!<CR>

" User defined command to format code
command Format :call CocAction('format') " format document

" Open definition (example: a function definition)
nnoremap <F12> :call CocAction('jumpDefinition', 'tab drop')<CR>

" Allow files to be saved as root when forgetting to start Vim using sudo.
command Sw :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Add 2 new lines to start paragraph
nnoremap <leader>O o<ESC>O
nnoremap <leader>o o<ESC>o
" Use o and O but not entering to insert mode
nnoremap o o<Esc>
nnoremap O O<Esc>


" Exit insert mode
inoremap jk <esc>
inoremap kj <esc>

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

" Replace highlighted text in normal mode
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
" Replace highlighet text in visual mode
xnoremap <Leader>r :%s///g<Left><Left>
xnoremap <Leader>rc :%s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Prevent x and the delete key from overriding what's in the clipboard.
noremap x "_x
noremap X "_x
noremap <Del> "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" Source Vim config file.
map <Leader>sv :source $MYVIMRC<CR>

" Toggle quickfix window.
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" Add all TODO items to the quickfix list relative to where you opened Vim.
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niIw -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniIw -e TODO -e FIXME . 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction

command! Todo call s:todo()


" Map ñ to turn highlighted text off
nnoremap ñ :noh<CR>

" Copy to system clipboard with Ctrl+Shift+c
vnoremap <C-C> "+y
vnoremap <C-X> "+ygvd

" Error and warning list. Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <F8> :CocDiagnostic<CR>
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Tagbar
nmap <F7> :TagbarToggle<CR>

" Resize split
nnoremap + :res +3<CR>
nnoremap - :res -3<CR>
" Increase height (by 1): Ctrl-W +
" Decrease height (by 1): Ctrl-W -
" Increase width (by 1): Ctrl-W >
" Decrease width (by 1): Ctrl-W 
" Increase height by 5: 5 Ctrl-W +

" .............................................................................
" coc-git
" .............................................................................

" navigate chunks of current buffer
nmap [n <Plug>(coc-git-prevchunk)
nmap ]n <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gd <plug>(coc-git-commit)
" undo chunk
nmap gu :CocCommand git.chunkUndo<CR>
" stage chunk
nmap ga :CocCommand git.chunkStage<CR>

" .............................................................................
" junegunn/fzf.vim
" .............................................................................

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Customize fzf colors to match your color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-b': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" .............................................................................
" unblevable/quick-scope
" .............................................................................

" Trigger a highlight in the appropriate direction when pressing these keys.
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

" Only underline the highlights instead of using custom colors.
highlight QuickScopePrimary gui=underline cterm=underline
highlight QuickScopeSecondary gui=underline cterm=underline

" .............................................................................
" mhinz/vim-grepper
" .............................................................................

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" .............................................................................
" iamcco/markdown-preview.nvim
" .............................................................................

let g:mkdp_auto_close=0
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css=fnameescape($HOME).'/.local/lib/github-markdown-css/github-markdown.css'

" .............................................................................
" SirVer/ultisnips
" .............................................................................

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" .............................................................................
" preservim/nerdtree
" ............................................................................

" nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" .............................................................................
" vim-airline/vim-airline
" .............................................................................

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

" .............................................................................
" python settings
" .............................................................................

" Specific configs por python files
au BufNewFile,BufRead *.py
    \| set textwidth=79
    \| set colorcolumn=79 " To show vertical line in column 79
    \| set expandtab
    \| set fileformat=unix

" Color leading and trailing whitespaces
highlight default BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Show venv in airline
let g:airline#extensions#virtualenv#enabled = 1

" Config for autocompletion from https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
" Use <cr> to confirm completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"


" .............................................................................
" terminal 
" .............................................................................

let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        " hide
		:bd!
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

" -----------------------------------------------------------------------------
" romgrk/barbar.nvim
" -----------------------------------------------------------------------------
" barbar keymapping
" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-ñ> <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-w> <Cmd>BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight
" Magic buffer-picking mode
" nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

