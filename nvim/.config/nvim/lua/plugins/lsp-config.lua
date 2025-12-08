return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "xml" },
      })
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {'efm', 'lua_ls', 'bashls', 'clangd', 'cssls', 'graphql', 'html', 'emmet_ls', 'eslint', 'ts_ls', 'jsonls', 'rust_analyzer', 'grammarly', 'prismals', 'pylsp', 'sqlls'}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconf = require('lspconfig')

      lspconf.efm.setup({
        init_options = {documentFormatting = true},
        filetypes = {'lua', 'python', 'javascript', 'typescript', 'json', 'java', 'markdown', 'html', 'css'},
        settings = {
          rootMarkers = {".git/"},
          languages = {
            lua = {
              {formatCommand = "stylua -", formatStdin = true}
            },
            python = {
              {formatCommand = "black --quiet -", formatStdin = true}
            },
            javascript = {
              {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
            },
            c = {
              {formatCommand = "clang-format --assume-filename=${INPUT}", formatStdin = true}
            },
            cpp = {
              {formatCommand = "clang-format --assume-filename=${INPUT}", formatStdin = true}
            }
          }
        }
      })

      lspconf.emmet_ls.setup({
        filetypes = {"html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact"}
      })

      lspconf.lua_ls.setup({
        capabilities = capabilities
      })
      lspconf.ts_ls.setup({
        capabilities = capabilities
      })
      lspconf.rust_analyzer.setup({});
      lspconf.clangd.setup({
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconf.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
      })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
