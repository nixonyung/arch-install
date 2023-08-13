-- (ref.) [Supported languages](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

return {
    "nvim-treesitter/nvim-treesitter", -- syntax highlighting
    build = ":TSUpdate",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring", -- plugin to better detect commentstring
        "windwp/nvim-ts-autotag",                      -- plugin for linked editing
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            highlight             = { enable = true },
            context_commentstring = { enable = true },
            autotag               = { enable = true },
            auto_install          = true,
            ensure_installed      = {
                "bash",
                "c",
                "css",
                "dockerfile",
                "fish",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "html",
                "javascript",
                "jsonc",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "sql",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml",
            },
        }

        -- generate folds
        vim.cmd [[
            set foldmethod=expr
            set foldexpr=nvim_treesitter#foldexpr()
            set nofoldenable
        ]]
    end,
}
