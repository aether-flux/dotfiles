return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      filetypes = {"html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact"},
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        names = false,
        rgb_fn = true,
        hsl_fn = true,
        css_fn = true,
        mode = 'foreground'
      }
    })
    vim.keymap.set('n', '<leader>c', "<Cmd>ColorizerToggle<CR>", {desc = "Toggle color previews"})
  end
}
