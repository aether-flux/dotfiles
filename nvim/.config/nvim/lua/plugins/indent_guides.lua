return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require("ibl").setup({
      indent = { char = "│" }, -- Customize the indent character
      scope = { enabled = true }, -- Enable scope highlighting
    })
  end,
}
