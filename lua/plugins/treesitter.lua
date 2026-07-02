-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  opts = {
    ensure_installed = {
      "lua",
      "vim",
    },
  },
}
