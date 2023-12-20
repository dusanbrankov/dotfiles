vim.cmd([[
    augroup bash_functions
      au!
      autocmd BufNewFile,BufRead ~/dotfiles/home/.config/bash/functions set syntax=bash
    augroup END

    augroup bash_aliases
      au!
      autocmd BufNewFile,BufRead ~/dotfiles/home/.config/bash/aliases set syntax=bash
    augroup END

    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
    autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
]])
