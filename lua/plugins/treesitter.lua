-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  opts = function(_, opts)
    -- tree-sitter CLI >= 0.26 dropped `--no-bindings`, which the `master` branch still passes
    require("nvim-treesitter.install").ts_generate_args = { "generate", "--abi", vim.treesitter.language_version }

    opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
      "lua",
      "vim",
    })
    return opts
  end,
}
