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
    { import = "plugins.extras.test.core" },
    { import = "plugins.extras.lang.typescript" },
    { import = "plugins.extras.lang.vue" },
    { import = "plugins.extras.lang.python" },
    { import = "plugins.extras.lang.golang" },
    { import = "plugins.extras.lang.yaml" },
    { import = "plugins.extras.lang.nlua" },
    { import = "plugins.extras.lang.xml" },
    { import = "plugins.extras.lang.markdown" },
    { import = "plugins.extras.lang.c" },
    { import = "plugins.extras.lang.ansible" },
    { import = "plugins.dap.golang" },
    { import = "plugins.dap.nlua" },
    { import = "plugins.dap.python" },
    { import = "plugins.dap.jsdebug" },
    { import = "plugins" },
  },
}, {
  defaults = {
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    -- version = false, -- always use the latest git commit
    version = "*", -- try installing the latest stable version for plugins that support semver
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
