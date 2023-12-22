return {
    {
        "aktersnurra/no-clown-fiesta.nvim",
        priority = 1000,
        config = function ()
            require("no-clown-fiesta").setup({
                transparent = true,
                styles = {
                    type = { bold = false },
                    lsp = { underline = true }
                }
            })
            -- vim.cmd.colorscheme("no-clown-fiesta")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function ()
            require("rose-pine").setup({
                --- @usage "auto"|"main"|"moon"|"dawn"
                variant = "moon",
                --- @usage "main"|"moon"|"dawn"
                dark_variant = "main",
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = true,
                disable_float_background = false,
                disable_italics = true,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = "base",
                    background_nc = "_experimental_nc",
                    panel = "surface",
                    panel_nc = "base",
                    border = "highlight_med",
                    comment = "muted",
                    link = "iris",
                    punctuation = "subtle",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    warn = "gold",

                    headings = {
                        h1 = "iris",
                        h2 = "foam",
                        h3 = "rose",
                        h4 = "gold",
                        h5 = "pine",
                        h6 = "foam",
                    }
                    -- or set all headings at once
                    -- headings = "subtle"
                },
            })

            -- Set colorscheme after options
            -- vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "miikanissi/modus-themes.nvim",
        priority = 1000,
        config = function ()
            -- Default options
            require("modus-themes").setup({
                style = "auto",
                variant = "tinted", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { fg = "#807777", italic = false },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                },
                on_highlights = function(hl, c)
                    hl.Boolean = { fg = c.blue, bold = false }
                end,
            })

            vim.cmd.colorscheme("modus")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    },
}
