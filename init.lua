require('general').init()
require('autocommands').init()
require('plugins').init()
require('keybindings').init()
require('filetree').init()
require('tabby').init()

local git_blame = require('gitblame')

function init_lualine()
    require('lualine').setup()
end

function init_commentary()
    -- Set `commentstring` of c++ files for `vim-commentary`.
    vim.api.nvim_exec([[
        au FileType cpp setlocal commentstring=//\ %s
    ]], false)
end

-- Color scheme
vim.cmd.colorscheme 'gruvbox'
vim.g.VM_theme = 'spacegray'

-- Main
init_lualine()
init_commentary()

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}

-- Disable Copilot by running Copilot disable.
vim.api.nvim_exec([[
    Copilot disable
]], false)

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
