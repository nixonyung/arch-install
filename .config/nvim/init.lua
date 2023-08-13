-- (ref.) [LazyVim / starter](https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua)

vim.loader.enable()
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        version = "*",
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

vim.opt.cursorlineopt = "number"
vim.opt.scrolloff     = 10
vim.opt.sidescrolloff = 20
vim.opt.shortmess:append "S" -- hide search result count

-- disable comments continuation
-- (ref.) https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.cmd [[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
    end,
})

local make_opts = function(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- editing:
vim.keymap.set("", "<SPACE>", "<NOP>", make_opts(nil))
vim.keymap.set("", "<C-a>", "<NOP>", make_opts(nil)) -- disable increment
vim.keymap.set("", "<C-x>", "<NOP>", make_opts(nil)) -- disable decrement
vim.keymap.set("", "<C-d>", "10j", make_opts(nil))
vim.keymap.set("", "<C-u>", "10k", make_opts(nil))
vim.keymap.set({ "n", "i", "x" }, "<C-c>", "<ESC>", make_opts(nil))
vim.keymap.set("n", "Q", "@q", make_opts(nil))           -- `qq` to record, `q`` to stop, `Q` to run
vim.keymap.set("n", "r", "<C-r>", make_opts(nil))        -- remap redo
vim.keymap.set("n", "x", '"_x', make_opts(nil))          -- delete character without yanking
vim.keymap.set("x", "p", '"_dP', make_opts(nil))         -- paste without yanking
vim.keymap.set("x", "Y", '"+y', make_opts(nil))          -- yank to system clipboard
vim.keymap.set({ "n", "x" }, "?", "*``", make_opts(nil)) -- load word under cursor to search register

-- repeatable indenting:
vim.keymap.set("n", "<<", "V<gv", make_opts(nil))
vim.keymap.set("x", "<", "<gv", make_opts(nil))
vim.keymap.set("n", ">>", "V>gv", make_opts(nil))
vim.keymap.set("x", ">", ">gv", make_opts(nil))

-- windows / buffers manipulation:
vim.keymap.set("", "<leader>n", "<CMD>vnew<CR>", make_opts("[n]ew buffer"))
vim.keymap.set("", "<leader>w", "<CMD>w<CR>", make_opts("[w]rite buffer"))
vim.keymap.set("", "<leader>q", "<CMD>lua MiniBufremove.delete()<CR>", make_opts("[q]uit buffer"))
vim.keymap.set("", "<leader>c", "<CMD>:close<CR>", make_opts("[c]lose window"))
vim.keymap.set("", "[b", "<CMD>bp<CR>", make_opts(nil))
vim.keymap.set("", "]b", "<CMD>bn<CR>", make_opts(nil))

-- nvim-tree view:
vim.keymap.set("", "<leader>e", "<CMD>NvimTreeToggle<CR>", make_opts("[e]xplorer view"))

-- telescope views:
vim.keymap.set("", "<C-TAB>", "<CMD>Telescope oldfiles initial_mode=normal cwd_only=true<CR>",
    make_opts("recent project files"))
vim.keymap.set("", "<C-p>", "<CMD>Telescope find_files hidden=true<CR>", make_opts("[p]roject [f]iles"))
vim.keymap.set("", "<C-r>", "<CMD>Telescope zoxide list<CR>", make_opts("recent projects"))
vim.keymap.set("", "<leader>f", "<CMD>Telescope grep_string<CR>", make_opts("[f]ind word view"))
vim.keymap.set("", "<leader>g", "<CMD>Telescope git_status initial_mode=normal<CR>", make_opts("[g]it view"))
vim.keymap.set("", "<leader>t", "<CMD>Telescope diagnostics initial_mode=normal<CR>", make_opts("[t]roubles view"))
