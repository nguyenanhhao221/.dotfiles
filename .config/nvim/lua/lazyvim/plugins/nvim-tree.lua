--Nvim-Tree file explorer
return {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    opt = true, -- optional, for file icons
  },
  opts = {
    sort_by = "case_sensitive",
    view = {
      width = 30,
      side = "right",
      relativenumber = true,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
    },
    filters = {
      dotfiles = false,
    },
    git = {
      ignore = false,
    },
  },
  keys = {
    { "<leader>pv", ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
    { "<leader>pV", ":NvimTreeFocus<CR>", desc = "Focus File Explorer" },
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    -- open nvim-tree on setup
    local function open_nvim_tree(data)
      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      -- buffer is a directory
      local directory = vim.fn.isdirectory(data.file) == 1

      if not no_name and not directory then
        return
      end

      -- change to the directory
      if directory then
        vim.cmd.cd(data.file)
      end

      -- open the tree
      require("nvim-tree.api").tree.open()
    end

    -- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
  end,
}
