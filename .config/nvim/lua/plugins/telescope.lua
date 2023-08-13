return {
    "nvim-telescope/telescope.nvim", -- file finder
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        {
            "jvgrootveld/telescope-zoxide",
            dependencies = { "nvim-lua/popup.nvim", },
            config = function() require("telescope").load_extension("zoxide") end,
        },
    },
    opts = {
        defaults = {
            layout_strategy = "center",
            layout_config = { anchor = "center" },
            sorting_strategy = "ascending",
            scroll_strategy = "limit",
            mappings = {
                n = {
                    ["<C-j>"]     = "move_selection_next",
                    ["<C-k>"]     = "move_selection_previous",
                    ["gg"]        = "move_to_top",
                    ["G"]         = "move_to_bottom",
                    ["<DOWN>"]    = "cycle_history_next",
                    ["<UP>"]      = "cycle_history_prev",
                    ["<C-d>"]     = "preview_scrolling_down",
                    ["<C-u>"]     = "preview_scrolling_up",
                    ["<C-c>"]     = "close",
                    ["<ESC>"]     = "close",
                    -- close shortcuts for custom views
                    ["<C-TAB>"]   = "close",
                    ["<leader>f"] = "close",
                    ["<leader>g"] = "close",
                    ["<leader>t"] = "close",
                },
                i = {
                    ["<C-j>"]  = "move_selection_next",
                    ["<C-k>"]  = "move_selection_previous",
                    ["<DOWN>"] = "cycle_history_next",
                    ["<UP>"]   = "cycle_history_prev",
                    ["<C-d>"]  = "preview_scrolling_down",
                    ["<C-u>"]  = "preview_scrolling_up",
                    ["<C-c>"]  = "close",
                    ["<ESC>"]  = "close",
                    -- close shortcuts for custom views
                    ["<C-p>"]  = "close",
                    ["<C-r>"]  = "close",
                },
            },
        },
    },
}
