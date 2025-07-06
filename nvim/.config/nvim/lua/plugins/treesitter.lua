return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {"c", "lua", "vim", "html", "css", "javascript", "typescript", "tsx", "java", "rust", "python"},
        sync_install = false,
        highlight = {enable = true},
        indent = {enable = true},
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }
}
