return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "amongus",
      transparent_bg = false,

      options = {
        show_source = {
          enabled = true,
          if_many = false,
        }
      }
    })
    vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
}
