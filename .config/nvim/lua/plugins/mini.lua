return {
    "echasnovski/mini.nvim",
    config = function()
        local animate = require("mini.animate")
        animate.setup {
            cursor = {
                timing = animate.gen_timing.linear {
                    duration = 100,
                    unit = "total",
                },
            },
            scroll = { enable = false },
            resize = { enable = false },
            open   = { enable = false },
            close  = { enable = false },
        }

        require("mini.basics").setup {
            options      = { basic = true },
            mappings     = { basic = false },
            autocommands = { basic = true },
        }
        require("mini.bufremove").setup()

        local clue = require("mini.clue")
        clue.setup {
            clues = {
                clue.gen_clues.builtin_completion(),
                clue.gen_clues.g(),
            },
            triggers = {
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },
            },
            window = {
                delay = 300,
                config = {
                    anchor = "SW",
                    row = "auto",
                    col = "auto",
                },
            },
        }

        require("mini.cursorword").setup {}
        vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
        vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true })

        local indentscope = require("mini.indentscope")
        indentscope.setup {
            options = { try_as_border = true },
            draw = {
                delay = 0,
                animation = indentscope.gen_animation.linear { duration = 0 },
            },
        }

        local misc = require("mini.misc")
        misc.setup {}
        misc.setup_restore_cursor()

        require("mini.pairs").setup {}
        require("mini.splitjoin").setup {}
        require("mini.statusline").setup {}
        require("mini.tabline").setup {}
        require("mini.trailspace").setup {}
        vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "#440000" })
    end,
}
