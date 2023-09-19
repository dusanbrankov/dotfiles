if has('termguicolors')
    set termguicolors
endif

" Colorscheme: {{{
" https://github.com/sainnhe/everforest/tree/master

    set background=dark

    " Set contrast
    " This configuration option should be placed before `colorscheme`.
    " Available values: 'hard', 'medium'(default), 'soft'
    let g:everforest_background = 'hard'

    let g:everforest_better_performance = 1
    let g:everforest_disable_italic_comment = 1
    let g:everforest_transparent_background = 1
    let g:everforest_ui_contrast = 'high'

    colorscheme everforest
" }}}

" Set: {{{

" General:
    syntax on
    " Disable compatibility with Vi
    set nocompatible
    set timeoutlen=3000
    set ttimeoutlen=100
    " fold based on indent
    set foldmethod=marker
    " Use system clipboard as register
    set clipboard=unnamedplus

" Indentation:
    " number of columns occupied by a tab
    set tabstop=4
    " convert tabs to white space
    set expandtab
    " with for autoindents
    set shiftwidth=4
    set smarttab
    set softtabstop=4
    " indent a new line the same amount as the line just typed
    set autoindent

" Linenumbers:
    " enable line numbers
    set number
    " enable relative line numbers
    set relativenumber

" Editor:
    " highlight current cursorline
    " set cursorline
    " set an 80 column border for good coding style
    set cc=80
    " enable search highlighting
    " set hlsearch
    set incsearch
    set scrolloff=10
    " enable mouse interaction in insert mode
    set mouse=i
    " Ignore capital letters during search.
    set ignorecase
    set linebreak

" Misc:
    " display command line's tab complete options as a menu
    set wildmenu
    set title
    set laststatus=2
" }}}

" Status_Line: {{{
" https://learnvimscriptthehardway.stevelosh.com/chapters/17.html

    set statusline=%.20f\       " Path to the file
    set statusline+=%y\         " Filetype of the file
    set statusline+=%=          " Switch to the right side
    set statusline+=[%l,%c      " Current line
    set statusline+=/           " Separator
    set statusline+=%L]         " Total lines
" }}}

" Filetype: {{{

" Filetype_Settings:
    filetype plugin on
    " switch on file type detection, with automatic indenting and settings
    filetype plugin indent on
" }}}

" Key_Mappings: {{{

" Types_of_mappings:
    " map    normal, visual and operator-pending mode
    " nmap   normal mode
    " imap   insert mode
    " vmap   visual mode
    " map!   command and insert mode
    " cmap   command mode
    " omap   operator-pending mode

" Leader_Key:
    let mapleader = ","
    let maplocalleader = "\\"

" Normal_Visual_Mode:
    " move text up and down
    noremap <a-up> :m .-2<cr>==
    noremap <a-down> :m .+1<cr>==

    " duplicate line
    noremap <c-up> YP
    noremap <c-down> Yp

    " comment
    noremap <leader>c :s/^/# /<cr>
    noremap <leader>C :s/^# //<cr>

" Normal_Mode:
    nnoremap <leader>ev :split $MYVIMRC<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>
    nnoremap <leader>w :w<cr>
    nnoremap <leader>x :x<cr>
    nnoremap <leader>q :q!<cr>
    nnoremap <c-a> 0
    nnoremap <c-w> ^
    nnoremap <c-e> $
    nnoremap ; :
    " toggle relativenumber
    nnoremap <leader>r :set relativenumber!<cr>
    " add a new line and stay in normal mode
    nnoremap <leader>o o<esc>
    nnoremap <leader>O O<esc>
    " fold/unfold
    nnoremap zz za
    " tabs
    nnoremap <leader>tn :tabnew
    nnoremap <leader>tc :tabclose<cr>
    nnoremap <a-left> :tabprevious<cr>
    nnoremap <a-right> :tabnext<cr>

" Multiple_Modes:
    " Escape insert/visual mode
    inoremap <ctrl-c> <esc><right>
    vnoremap <ctrl-c> <esc>

    " Indent text
    vnoremap <s-tab> <gv
    vnoremap <tab> >gv
    nnoremap <s-tab> v<
    nnoremap <tab> v>

    " Enclose text with ', ", {, and so on...
    nnoremap <leader>' ciw'<esc>pa'<esc>
    nnoremap <leader>" ciw"<esc>pa"<esc>
    nnoremap <leader>( ciw(<esc>pa)<esc>
    nnoremap <leader>{ ciw{<esc>pa}<esc>
    nnoremap <leader>` ciw`<esc>pa`<esc>
    vnoremap ' <esc>a'<esc>`<i'<esc>
    vnoremap \" <esc>a"<esc>`<i"<esc>
    vnoremap ` <esc>`<i`<esc>`>a`<esc>
    vnoremap ` <esc>a`<esc>`<i`<esc>
    vnoremap ( <esc>a)<esc>`<i(<esc>
    vnoremap { <esc>a}<esc>`<i{<esc>
    vnoremap < <esc>a><esc>`<i<<esc>
    vnoremap [ <esc>a]<esc>`<i[<esc>

    " Delete lines
    inoremap <c-d> <esc>ddi
    inoremap <leader>d <esc>ddO

    " Select word
    noremap vv viw

    " Transform text to uppercase
    inoremap <c-u> <esc>viwU<esc>i
    nnoremap <c-u> viwU<esc>

" Insert_Mode:
    " Empty line ('D' in case comment symbol is added by Vim, i.e. '#')
    nnoremap <leader>d ddO<esc>D<esc>
    " Undo
    inoremap <leader>u <esc>ui
    " Move cursor to the beginning/end of the current line
    inoremap <c-a> <esc>0i
    inoremap <c-w> <esc>^i
    inoremap <c-e> <esc>$a

" Operator_Pending_mode:
"     onoremap p i(
"     onoremap s i[
"     onoremap b i{
"     onoremap sq i'
"     onoremap dq i"
"     onoremap in( :<c-u>normal! f(vi(<cr>
"     onoremap il( :<c-u>normal! F)vi(<cr>
"     onoremap in[ :<c-u>normal! f[vi[<cr>
"     onoremap il[ :<c-u>normal! F]vi[<cr>
" }}}

" Abbreviations: {{{

    " iabbrev --- —
    iabbrev iff if [ ]<left><left>
" }}}

" Autocommands: {{{

    augroup filtetype_vim
        autocmd!
        " comment/uncomment line (works currently only in visual block mode)
        autocmd FileType vim vnoremap <buffer> <localleader>" :s/^/" /<cr>
        autocmd FileType vim vnoremap <buffer> <localleader>' :s/\s*" //<cr>
    augroup END

    augroup filetype_md
        autocmd!
        autocmd FileType markdown vnoremap <buffer> <localleader>b <esc>`>a**<esc>`<i**<esc>
        autocmd FileType markdown nnoremap <buffer> <localleader>B V<esc>`>a**<esc>`<i**<esc>
        autocmd FileType markdown vnoremap <buffer> <localleader>i <esc>`>a_<esc>`<i_<esc>
        autocmd FileType markdown vnoremap <buffer> <localleader>c <esc>`<O```<esc>`>o```<esc>`<kA
    augroup END

    augroup clear_spaces
        autocmd!
        " Remove trailing spaces on :write
        autocmd BufWrite * :%s/\s\+$//e
    augroup END

    augroup filetype_sh
        autocmd!
        autocmd FileType sh nnoremap <buffer> <localleader>c :wa<cr>:!clear && shellcheck %<cr>
        autocmd FileType sh nnoremap <buffer> <localleader>r :wa<cr>:!clear && %<cr>
        autocmd FileType sh nnoremap <buffer> <localleader>R :wa<cr>:!clear && %

    augroup filetype_python
        autocmd!
        autocmd FileType python nnoremap <buffer> <localleader>c :wa<cr>:!clear && mypy %<cr>
        autocmd FileType python nnoremap <buffer> <localleader>r :wa<cr>:!clear && python %<cr>

    augroup filetype_javascript
        autocmd!
        autocmd FileType javascript nnoremap <buffer> <localleader>r :wa<cr>:!clear && node %<cr>

" }}}

