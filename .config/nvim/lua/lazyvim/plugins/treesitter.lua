return {
  --Treesitter
  {
    -- Highlight, edit, and navigate code "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    -- Additional text objects via treesitter
    keys = {
      { "<leader>tp", "<cmd>InspectTree<CR>", desc = "Treesitter Playground Toggle" },
    },
    dependencies = {
      -- {
      --   "nvim-treesitter/playground",
      --   keys = {
      --     { "<leader>tp", "<cmd>TSPlaygroundToggle<CR>", desc = "Treesitter Playground Toggle" },
      --   },
      -- },
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "windwp/nvim-ts-autotag",
        config = function()
          vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
              underline = true,
              virtual_text = {
                spacing = 5,
                severity = { min = vim.diagnostic.severity.WARN },
              },
              update_in_insert = true,
            })
          require("nvim-ts-autotag").setup()
        end,
      },
      --Treesitter context for sticky scroll
      {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter",
        config = true,
      },
    },
    ---@type TSConfig
    opts = {
      -- A list of parser names, or "all" (the four listed parsers should always be installed)
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "toml",
        "rst",
        "ninja",
        "rust",
        "typescript",
        "vimdoc",
        "vim",
        "markdown_inline",
        "markdown",
        "regex",
        "bash",
        "tsx",
        "gitignore",
        "javascript",
        "json",
        "css",
        "html",
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "python" } },
      autotag = { enable = true },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
