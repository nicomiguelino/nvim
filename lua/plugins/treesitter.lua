-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  opts = function(_, opts)
    -- tree-sitter CLI >= 0.26 dropped `--no-bindings`, which the `master` branch still passes
    require("nvim-treesitter.install").ts_generate_args = { "generate", "--abi", vim.treesitter.language_version }

    -- nvim 0.12 ignores `all = false` and always passes lists of nodes in query matches, which the `master` branch's
    -- predicates/directives don't expect; re-register them with the match unwrapped
    local query = vim.treesitter.query
    local function unwrap_match(match)
      return setmetatable({}, {
        __index = function(_, capture_id)
          local nodes = match[capture_id]
          if type(nodes) == "table" then return nodes[#nodes] end
          return nodes
        end,
      })
    end
    local add_directive, add_predicate = query.add_directive, query.add_predicate
    query.add_directive = function(name, handler, directive_opts)
      return add_directive(name, function(match, ...) return handler(unwrap_match(match), ...) end, directive_opts)
    end
    query.add_predicate = function(name, handler, predicate_opts)
      return add_predicate(name, function(match, ...) return handler(unwrap_match(match), ...) end, predicate_opts)
    end
    package.loaded["nvim-treesitter.query_predicates"] = nil
    require "nvim-treesitter.query_predicates"
    query.add_directive, query.add_predicate = add_directive, add_predicate

    opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
      "lua",
      "vim",
    })
    return opts
  end,
}
