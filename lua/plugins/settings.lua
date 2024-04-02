return {
  "AstroNvim/astrolsp",
  ---@params opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts, {
      config = {
        denols = function(options)
          options.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
          return options
        end,
        eslint = function(options)
          options.root_dir = require("lspconfig.util").root_pattern(".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs")
          return options
        end,
        tsserver = function(options)
          options.root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json")
          options.single_file_support = false
          options.settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          }
          return options
        end,
        gopls = function(options)
          options.settings = {
            gopls = {
              semanticTokens = true,
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              gofumpt = true,
            },
          }
          return options
        end,
      },
    })
  end,
}
