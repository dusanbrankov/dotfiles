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
    {
        "itchyny/lightline.vim",
        config = function ()
            vim.cmd([[
                let g:lightline = { "colorscheme": "wombat" }
            ]])
        end
    },
    {
        "pacha/vem-tabline",
        config = function ()
            vim.g.vem_tabline_show = 2

            vim.keymap.set("n", "<leader>bj", "<plug>vem_move_buffer_left-")
            vim.keymap.set("n", "<leader>bk", "<plug>vem_move_buffer_right-")
            vim.keymap.set("n", "<leader>bp", "<plug>vem_prev_buffer-")
            vim.keymap.set("n", "<leader>bn", "<plug>vem_next_buffer-")
            vim.keymap.set("n", "<a-j>", ":tabprev<cr>")
            vim.keymap.set("n", "<a-k>", ":tabnext<cr>")
            vim.keymap.set("n", "<leader>bd", "<Plug>vem_delete_buffer-")
        end
    },
    {
        "norcalli/nvim-colorizer.lua", -- Highlight colors and colorcodes
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "tpope/vim-vinegar", -- Netrw file navigation made easier
    },
}

