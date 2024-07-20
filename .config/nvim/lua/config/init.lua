return {
  -- load the default settings
  defaults = {
    autocmds = true, -- config.autocmds
    keymaps = true, -- config.keymaps
    -- config.options can't be configured here since that's loaded before lazyvim setup
    -- if you want to disable loading options, add `package.loaded["config.options"] = true` to the top of your init.lua
  },
  -- icons used by other plugins
  icons = {
    logo = {
      neovim = "",
    },
    dap = {
      Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = "🟥",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
      branch = " ",
    },
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Copilot = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Null = " ",
      Number = " ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    },
    others = {
      modified_file = "● ",
      read_only = " ",
      lsp = " ",
    },
  },
}
