local telescope_config = require('plugins/telescope_config')

local module = {}

function module.init()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.5',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        'github/copilot.vim',
        'crusoexia/vim-monokai',
        'nvim-lualine/lualine.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
        },
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-tree/nvim-web-devicons',
            },
        },
        {
            'mattn/emmet-vim',
            init = function()
                vim.g.user_emmet_leader_key = '<C-h>'
            end,
        },
        {
            'mg979/vim-visual-multi',
            branch = 'master',
        },
        { "catppuccin/nvim", name = "catppuccin" },
        {
            "ellisonleao/gruvbox.nvim",
            priority = 1000,
            config = true
        },
        { "Mofiqul/dracula.nvim" },
        {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
        },
        { "rose-pine/neovim", name = "rose-pine" },
        {
            'maxmx03/fluoromachine.nvim',
            lazy = false,
            priority = 1000,
            config = function ()
                local fm = require 'fluoromachine'

                fm.setup {
                    glow = true,
                    theme = 'fluoromachine',
                    transparent = true,
                }

                vim.cmd.colorscheme 'fluoromachine'
            end
        },
        'MattesGroeger/vim-bookmarks',
        'tom-anders/telescope-vim-bookmarks.nvim',
        'windwp/nvim-autopairs',
        'tpope/vim-commentary',
        'editorconfig/editorconfig-vim',
        'nanozuki/tabby.nvim',
        'terrastruct/d2-vim',
        'sindrets/diffview.nvim',
        'kchmck/vim-coffee-script',
        {
            "hedyhli/outline.nvim",
            config = function()
                -- Example mapping to toggle outline
                vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                { desc = "Toggle Outline" })

                require("outline").setup {
                -- Your setup opts here (leave empty to use defaults)
                }
            end,
        },
        {
            'neoclide/coc.nvim',
            branch = 'master',
            build = 'npm ci',
            init = function()
                vim.g.coc_global_extensions = {
                    'coc-tsserver',
                    'coc-json',
                    'coc-html',
                    'coc-css',
                    'coc-yaml',
                    'coc-emmet',
                    'coc-snippets',
                    'coc-pyright',
                    'coc-clangd',
                }
            end,
        },
        {
            'f-person/git-blame.nvim',
        }
    })

    telescope_config.init()

    require('nvim-web-devicons').setup()
    require("nvim-autopairs").setup({})
end

return module
