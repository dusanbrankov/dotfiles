vim.cmd([[
    augroup bash_functions
      au!
      autocmd BufNewFile,BufRead ~/dotfiles/dots/.config/bash/functions set syntax=bash
    augroup END

    augroup bash_aliases
      au!
      autocmd BufNewFile,BufRead ~/dotfiles/dots/.config/bash/aliases set syntax=bash
    augroup END

    " autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    " autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
    " autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2

    augroup filetype_md
        autocmd!
        autocmd FileType markdown vnoremap <buffer> <localleader>b <esc>`>a**<esc>`<i**<esc>
        autocmd FileType markdown nnoremap <buffer> <localleader>B V<esc>`>a**<esc>`<i**<esc>
        autocmd FileType markdown vnoremap <buffer> <localleader>i <esc>`>a_<esc>`<i_<esc>
        autocmd FileType markdown vnoremap <buffer> <localleader>c <esc>`<O```<esc>`>o```<esc>`<kA
    augroup END

    augroup filetype_sh
        autocmd!
        autocmd FileType sh nnoremap <buffer> <localleader>c :wa<cr>:!clear && shellcheck %<cr>
        autocmd FileType sh nnoremap <buffer> <localleader>r :wa<cr>:!clear && ./%<cr>
        autocmd FileType sh nnoremap <buffer> <localleader>R :wa<cr>:!clear && ./%

    augroup filetype_python
        autocmd!
        autocmd FileType python nnoremap <buffer> <localleader>c :wa<cr>:!clear && mypy %<cr>
        autocmd FileType python nnoremap <buffer> <localleader>r :wa<cr>:!clear && python %<cr>

    augroup filetype_javascript
        autocmd!
        autocmd FileType javascript nnoremap <buffer> <localleader>r :wa<cr>:!clear && node %<cr>
        autocmd FileType javascript nnoremap <buffer> <localleader>c ^i// <esc>
        autocmd FileType javascript nnoremap <buffer> <localleader>w :wa<cr>:!page-reload<cr><cr>

    augroup filetype_php
        autocmd!
        autocmd FileType php nnoremap <buffer> <localleader>r :wa<cr>:!clear && php %<cr>
]])
