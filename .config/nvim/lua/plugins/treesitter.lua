return {
  --Treesitter
  {
    -- Highlight, edit, and navigate code "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter",
    -- https://github.com/nvim-treesitter/nvim-treesitter/commit/42fc28ba918343ebfd5565147a42a26580579482
    -- Use master branch for now, in the future Treesitter may switch to main branch as the default
    branch = "master",
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    -- Additional text objects via treesitter
    keys = {
      { "<leader>tp", "<cmd>InspectTree<CR>", desc = "Treesitter Playground Toggle" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- require("vim.treesitter.query").set(
      --   "markdown",
      --   "highlights",
      --   "(fenced_code_block_delimiter) @punctuation.delimiter"
      -- )
    end,
  },
}
