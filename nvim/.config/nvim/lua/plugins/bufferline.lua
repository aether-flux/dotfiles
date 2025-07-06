return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
          --mode = "tabs",  -- Tabs mode (display as tabs like in VSCode)
          close_command = "bdelete %d",  -- Command to close buffer
          right_mouse_command = "bdelete %d",  -- Right-click to close
          separator_style = "slope",  -- Style of separator (can be "slant", "thin", etc.)
      },
    })

    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {silent=true, noremap=true})
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {silent=true, noremap=true})
    vim.keymap.set('n', '<leader>x', '<Cmd>bdelete<CR>', {silent=true, noremap=true})
  end
}
