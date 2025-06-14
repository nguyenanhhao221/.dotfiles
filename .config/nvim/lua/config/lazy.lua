local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Load everything with the config inside the plugins directory
require("lazy").setup({
  spec = {
    -- import any extras modules here
    -- { import = "plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    -- Add each config for each language here
    { import = "plugins" },
    { import = "plugins.editor" },
    { import = "plugins.extras.lang.typescript" },
    { import = "plugins.extras.lang.vue" },
    { import = "plugins.extras.lang.python" },
    { import = "plugins.extras.lang.golang" },
    { import = "plugins.extras.lang.rust" },
    { import = "plugins.extras.lang.yaml" },
    { import = "plugins.extras.lang.helm" },
    { import = "plugins.extras.lang.nlua" },
    { import = "plugins.extras.lang.xml" },
    { import = "plugins.extras.lang.markdown" },
    { import = "plugins.extras.lang.c" },
    { import = "plugins.extras.lang.ansible" },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/Code",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
