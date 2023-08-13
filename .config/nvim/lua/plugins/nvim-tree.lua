return {
    "nvim-tree/nvim-tree.lua", -- file tree
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "stevearc/dressing.nvim", opts = {} },
    },
    init = function()
        vim.g.loaded_netrw       = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        local api = require("nvim-tree.api")

        require("nvim-tree").setup {
            sync_root_with_cwd  = true,
            update_focused_file = { enable = true },
            actions             = {
                change_dir = {
                    global             = true,
                    restrict_above_cwd = true,
                }
            },
            view                = {
                float = {
                    enable          = true,
                    open_win_config = {
                        width  = 50,
                        height = 35,
                    },
                },
            },
            on_attach           = function(bufnr)
                local make_opts = function(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- navigation:
                vim.keymap.set("n", "l", api.node.open.edit, make_opts("open"))
                vim.keymap.set("n", "h",
                    function()
                        api.node.navigate.parent()
                        api.node.open.edit()
                    end,
                    make_opts("open")
                )
                vim.keymap.set("n", "<CR>", api.node.open.edit, make_opts("open"))
                vim.keymap.set("n", "<2-LEFTMOUSE>", api.node.open.edit, make_opts("open"))
                vim.keymap.set("n", "L", api.tree.change_root_to_node, make_opts("cd"))
                vim.keymap.set("n", "H", api.tree.change_root_to_parent, make_opts("cd parent"))
                vim.keymap.set("n", "<2-RIGHTMOUSE>", api.tree.change_root_to_node, make_opts("cd"))

                -- creating/renaming/moving/deleting file:
                vim.keymap.set("n", "o", api.fs.create, make_opts("new"))
                vim.keymap.set("n", "r", api.fs.rename, make_opts("rename"))
                vim.keymap.set("n", "yy", api.fs.copy.node, make_opts("copy"))
                vim.keymap.set("n", "D", api.fs.cut, make_opts("cut"))
                vim.keymap.set("n", "p", api.fs.paste, make_opts("paste"))
                vim.keymap.set("n", "dd", api.fs.remove, make_opts("delete"))

                -- misc:
                vim.keymap.set("n", "gc", api.tree.collapse_all, make_opts("collapse"))
                vim.keymap.set("n", "gr", api.tree.reload, make_opts("reload"))
                vim.keymap.set("n", "gp", api.fs.copy.relative_path, make_opts("copy relative path"))
                vim.keymap.set("n", "g?", api.tree.toggle_help, make_opts("[?] help"))
                vim.keymap.set("n", "<ESC>", api.tree.close, make_opts("[<ESC>] close"))
            end,
        }

        -- auto open file upon creation
        -- (ref.) https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#automatically-open-file-upon-creation
        api.events.subscribe(
            api.events.Event.FileCreated,
            function(file)
                vim.cmd("edit " .. file.fname)
            end
        )
    end,
}
