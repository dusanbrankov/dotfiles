return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    -- {
    --     "itchyny/lightline.vim",
    --     config = function ()
    --         vim.cmd([[
    --             let g:lightline = { "colorscheme": "wombat" }
    --         ]])
    --     end
    -- },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            require("lualine").setup {
                options = {
                    theme = "auto",
                    section_separators = '',
                    component_separators = ''
                }
            }
        end
    },
    -- {
    --     "pacha/vem-tabline",
    --     config = function ()
    --         vim.g.vem_tabline_show = 1
    --
    --         vim.keymap.set("n", "<leader>bj", "<plug>vem_move_buffer_left-")
    --         vim.keymap.set("n", "<leader>bk", "<plug>vem_move_buffer_right-")
    --         vim.keymap.set("n", "<leader>bp", "<plug>vem_prev_buffer-")
    --         vim.keymap.set("n", "<leader>bn", "<plug>vem_next_buffer-")
    --         vim.keymap.set("n", "<a-j>", ":tabprev<cr>")
    --         vim.keymap.set("n", "<a-k>", ":tabnext<cr>")
    --         vim.keymap.set("n", "<leader>bd", "<Plug>vem_delete_buffer-")
    --
    --         vim.cmd([[
    --             highlight VemTablineNormal           term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#cdcdcd guibg=#242424 gui=none
    --             highlight VemTablineLocation         term=reverse cterm=none ctermfg=239 ctermbg=251 guifg=#cdcdcd guibg=#666666 gui=none
    --             highlight VemTablineNumber           term=reverse cterm=none ctermfg=239 ctermbg=251 guifg=#cdcdcd guibg=#666666 gui=none
    --             highlight VemTablineSelected         term=bold    cterm=bold ctermfg=0   ctermbg=255 guifg=#ffffff guibg=#242424 gui=bold
    --             highlight VemTablineLocationSelected term=bold    cterm=none ctermfg=239 ctermbg=255 guifg=#ffffff guibg=#666666 gui=bold
    --             highlight VemTablineNumberSelected   term=bold    cterm=none ctermfg=239 ctermbg=255 guifg=#ffffff guibg=#666666 gui=bold
    --             highlight VemTablineShown            term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#cdcdcd guibg=#242424 gui=none
    --             highlight VemTablineLocationShown    term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#cdcdcd guibg=#666666 gui=none
    --             highlight VemTablineNumberShown      term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#cdcdcd guibg=#666666 gui=none
    --             highlight VemTablineSeparator        term=reverse cterm=none ctermfg=246 ctermbg=251 guifg=#cdcdcd guibg=#888888 gui=none
    --             highlight VemTablinePartialName      term=reverse cterm=none ctermfg=246 ctermbg=251 guifg=#cdcdcd guibg=#888888 gui=none
    --             highlight VemTablineTabNormal        term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#4a4a4a guibg=#242424 gui=none
    --             highlight VemTablineTabSelected      term=bold    cterm=bold ctermfg=0   ctermbg=255 guifg=#ffffff guibg=#242424 gui=bold
    --         ]])
    --     end
    -- },
    -- {
    --     "norcalli/nvim-colorizer.lua", -- Highlight colors and colorcodes
    --     config = function()
    --         require("colorizer").setup()
    --     end,
    -- },
    -- {
    --     "ap/vim-css-color",
    -- },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function ()
            require('nvim-highlight-colors').setup {}
        end
    },
    {
        "tpope/vim-vinegar", -- Netrw file navigation made easier
    },
    { "tpope/vim-sleuth" },
    -- { "mattn/emmet-vim" },
}

