-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- customize alpha options
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },
  { "theHamsta/nvim-dap-virtual-text" },
  {
    "nvim-web-devicons",
    opts = {
      override = {
        go = {
          icon = "󰟓",
          color = "#00ADD8",
        },
        makefile = {
          icon = "",
          color = "#e37933",
        },
      },
    },
  },
  {
    "neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
  {
    "noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        hover = {
          enabled = true,
        },
        signature = {
          enabled = false,
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        hover = {
          border = {
            style = "rounded",
            padding = { 0, 2 },
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"

      opts.statusline = {
        status.component.mode {
          mode_text = {
            icon = {
              kind = "VimIcon",
              padding = {
                right = 1,
                left = 1,
              },
            },
            padding = {
              right = 1,
            },
          },
        }, -- add all the other components for the statusline
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
      }
      return opts
    end,
  },
  {
    "jamsmendez/darcula-dark.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "sigmasd/deno-nvim",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local curr_client = vim.lsp.get_client_by_id(args.data.client_id)

          if curr_client and curr_client.name == "denols" then
            local clients = vim.lsp.get_clients { bufnr = bufnr }
            for _, client in ipairs(clients) do
              if client.name == "tsserver" or client.name == "typescript-tools" then
                vim.lsp.stop_client(client.id, true)
              end
            end
          end

          -- if tsserver attached, stop it if there is a denols server attached
          if curr_client and curr_client.name == "tsserver" then
            local clients = vim.lsp.get_clients { bufnr = bufnr }
            for _, client in ipairs(clients) do
              if client.name == "denols" then
                vim.lsp.stop_client(curr_client.id, true)
                break
              end
            end
          end

          -- if typescript-tools attached, stop it if there is a denols server attached
          if curr_client and curr_client.name == "typescript-tools" then
            local clients = vim.lsp.get_clients { bufnr = bufnr }
            for _, client in ipairs(clients) do
              if client.name == "denols" then
                vim.lsp.stop_client(curr_client.id, true)
                break
              end
            end
          end
        end,
      })
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      opts.server = astrolsp_avail and astrolsp.lsp_opts "denols"
      opts.server.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
}
