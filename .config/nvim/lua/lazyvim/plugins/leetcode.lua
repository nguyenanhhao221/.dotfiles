return {
  "Dhanus3133/LeetBuddy.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("leetbuddy").setup({})
  end,
  keys = {
    { "<leader>lq", "<cmd>LBQuestions<cr>", desc = "Leetcode List Questions" },
    { "<leader>ll", "<cmd>LBQuestion<cr>", desc = "Leetcode View Question" },
    { "<leader>lr", "<cmd>LBReset<cr>", desc = "Leetcode Reset Code" },
    { "<leader>lt", "<cmd>LBTest<cr>", desc = "Leetcode Run Code Test" },
    { "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Leetcode Submit Code" },
  },
}
