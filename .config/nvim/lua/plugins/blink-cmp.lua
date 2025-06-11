return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
  },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "enter",
      ["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
      ["<C-f>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    -- Config for cmdline
    cmdline = {
      keymap = {
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
      },
    },

    signature = {
      enabled = true,
      window = { border = "rounded", show_documentation = false },
    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",
    },

    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      ghost_text = {
        enabled = false,
      },
      documentation = {
        window = {
          border = "rounded",
          winhighlight = "NormalFloat:Normal,FloatBorder:Comment,EndOfBuffer:BlinkCmpDoc",
        },
        auto_show = true,
        auto_show_delay_ms = 200,
        treesitter_highlighting = true,
      },
      menu = {
        winhighlight = "NormalFloat:Normal,CursorLine:TelescopeSelection,FloatBorder:Comment",
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
        },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`

    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbob", module = "vim_dadbod_completion.blink" },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
