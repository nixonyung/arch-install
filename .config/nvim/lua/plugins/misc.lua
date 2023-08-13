return {
    {
        "EdenEast/nightfox.nvim", -- colorscheme
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup {
                groups = {
                    all = {
                        LineNr    = { fg = "bg4" }, -- override statuscolumn line number highlight
                        VertSplit = { fg = "bg2" }, -- override split border highlight
                    },
                },
                options = {
                    transparent = true,
                    styles = {
                        comments = "italic",
                        functions = "bold",
                    },
                },
            }
            vim.cmd.colorscheme "nightfox"
        end,
    },

    "jghauser/mkdir.nvim",                      -- creates missing folders on save
    "tpope/vim-sleuth",                         -- auto adjusts tab size
    "dstein64/vim-startuptime",                 -- profile startup time
    { "kylechui/nvim-surround",    opts = {} }, -- surround commands
    { "NvChad/nvim-colorizer.lua", opts = {} }, -- colorize color codes
    {                                           -- indentation guide
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = { scope = { enabled = false } },
    },

    {
        "numToStr/Comment.nvim", -- toggling comment
        priority = 0,            -- (hotfix, load last)
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            toggler = { line = "<leader>/" },
            opleader = { line = "<leader>/" },
        },
    },

    {
        "lewis6991/gitsigns.nvim", -- git signs
        opts = {
            current_line_blame = true,
            current_line_blame_formatter = "\t<author> (<author_time:%Y-%m-%d>): <summary>",
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 0,
                ignore_whitespace = false,
            },
        },
    },

    {
        "petertriho/nvim-scrollbar",     -- scrollbar
        dependencies = {
            "kevinhwang91/nvim-hlslens", -- hint for search results
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            require("scrollbar").setup {
                handle = { blend = 0 },
            }
            require("scrollbar.handlers.search").setup {
                -- overrides hlslens config
                virt_priority = 1,
            }
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
}
