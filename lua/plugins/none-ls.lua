-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd.with {
        extra_args = {
          "--trailing-comma none",
          "--arrow-parens avoid",
          "--single-quote",
          "--no-semi",
          "--jsx-single-quote",
          "--use-tabs",
          "--bracket-spacing",
          "--bracket-same-line",
          "--tab-width 4",
        },
      },
      null_ls.builtins.formatting.sql_formatter.with {
        command = "sql-formatter",
        filetypes = { "sql", "mysql", "postgresql" },
        args = { "--config", vim.fn.stdpath "config" .. "/sql_formatter/settings.json" },
      },
    }
    return config -- return final config table
  end,
}
