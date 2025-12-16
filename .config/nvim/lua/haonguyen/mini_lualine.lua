-- ~  Config for Minimal Lualine
--    Inspire by @Tibor5
--    https://github.com/Tibor5/minim_lualine/blob/master/lua/minim.lua

-- ~  --------------------------------------------------------------------------------  ~ --

local icons = require("config.init").icons
-- ~  --------------------------------------------------------------------------------  ~ --

local condition = {
  is_buf_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  is_git_repo = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local auto_theme_custom = require("lualine.themes.auto")
auto_theme_custom.normal.c.bg = "none"
-- ~  --------------------------------------------------------------------------------  ~ --
-- ~  Config
local config = {
  options = {
    theme = auto_theme_custom,
    component_separators = "",
    section_separators = "",
    always_divide_middle = false,
    globalstatus = true,
    disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = { "location" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  -- tabline = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
}

local status_c = function(component)
  table.insert(config.sections.lualine_c, component)
end
local status_x = function(component)
  table.insert(config.sections.lualine_x, component)
end

-- ~  --------------------------------------------------------------------------------  ~ --

-- ~  Status line
-- ~  Left
status_c({
  -- Colored mode icon
  function()
    return icons.logo.neovim
  end,
  color = { fg = "#69a33e" },
  padding = {
    left = 1,
    right = 1,
  },
})
status_c({
  "mode",
})

status_c({
  "filename",
  cond = condition.is_buf_empty,
  path = 1, -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory
  -- 4: Filename and parent dir, with tilde as the home directory
  symbols = {
    modified = icons.others.modified_file,
    readonly = icons.others.read_only,
    unnamed = "[No Name]",
    newfile = "[New]",
  },
})

status_c({
  "filetype",
  colored = true, -- Displays filetype icon in color if set to true
  icon_only = true, -- Display only an icon for filetype
})

-- ~  --------------------------------------------------------------------------------  ~ --
-- ~  Mid

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
status_c({
  function()
    return "%="
  end,
})

status_c({
  "diagnostics",
  sources = { "nvim_lsp" },

  -- Displays diagnostics for the defined severity types
  sections = { "error", "warn", "info" }, -- don't show "hint" section
  symbols = { error = "E", warn = "W", info = "I", hint = "H" },
})

status_c({
  "lsp_status",
  icon = "[LSP] ",
  symbols = {
    done = "",
    -- Standard unicode symbols to cycle through for LSP progress:
    spinner = "",
    -- Delimiter inserted between LSP names:
    separator = " | ",
  },
  -- color = (vim.g.colors_name == "gruvbox") and "GruvboxGreen" or nil,
})
-- status_c({
--   function()
--     local linters = require("lint").linters_by_ft[vim.bo.filetype]
--     if #linters == 0 then
--       return "󰦕"
--     end
--     return "󱉶 " .. table.concat(linters, ", ")
--   end,
-- })

-- ~  --------------------------------------------------------------------------------  ~ --
-- ~  Right

status_x({
  "diff",
  cond = condition.is_git_repo,
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
    end
  end,
  symbols = {
    added = icons.git.added,
    modified = icons.git.modified,
    removed = icons.git.removed,
  },
  colored = true,
})

status_x({

  "branch",
  icon = icons.git.branch,
})

status_x({
  "encoding",
})
status_x({
  "fileformat",
})
status_x({
  "location",
})
status_x({
  "progress",
})

-- ~  --------------------------------------------------------------------------------  ~ --

return config
