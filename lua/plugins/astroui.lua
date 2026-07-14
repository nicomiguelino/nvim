-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "dracula",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = function() -- this function overrides highlights in all themes
        local get_hlgroup = require("astroui").get_hlgroup
        -- remove the background from these groups to make Neovim transparent
        local transparent_groups = {
          "Normal",
          "NormalNC",
          "NormalFloat",
          "FloatBorder",
          "SignColumn",
          "EndOfBuffer",
          "MsgArea",
          "TabLineFill",
          "WinBar",
          "WinBarNC",
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "TelescopeNormal",
          "TelescopeBorder",
        }
        -- capture the theme's background before it gets stripped,
        -- so opaque windows (e.g. Lazy) can keep it
        local normal = get_hlgroup("Normal", {})
        local float_bg = get_hlgroup("NormalFloat", {}).bg or normal.bg

        local highlights = {}
        for _, group in ipairs(transparent_groups) do
          local hl = get_hlgroup(group, {})
          hl.bg = "NONE"
          hl.ctermbg = "NONE"
          highlights[group] = hl
        end

        -- keep the Lazy dialog opaque
        highlights.LazyNormal = { fg = normal.fg, bg = float_bg }

        return highlights
      end,
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
