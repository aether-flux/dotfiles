return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- stylua: ignore
    local colors = {
      background      = '#1e1e1e', -- Base background
      background_alt  = '#a7c080', -- Slightly lighter background
      foreground      = '#ffffff', -- Text color
      highlight       = '#e3bf6f', -- Selected/highlight color
      active          = '#7B6C5B', -- Active item color
      urgent          = '#934A1C', -- Urgent color
      black           = '#080808', -- For contrast
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.background, bg = colors.highlight, gui = 'bold' },
        b = { fg = colors.black, bg = colors.background_alt },
        c = { fg = colors.background, bg = colors.background },
      },

      insert = { a = { fg = colors.background, bg = colors.active, gui = 'bold' } },
      visual = { a = { fg = colors.background, bg = colors.urgent, gui = 'bold' } },
      replace = { a = { fg = colors.background, bg = colors.highlight, gui = 'bold' } },

      inactive = {
        a = { fg = colors.black, bg = colors.background_alt },
        b = { fg = colors.black, bg = colors.background },
        c = { fg = colors.black, bg = colors.background },
      },
    }

    require('lualine').setup {
      options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'branch', 'diff', 'diagnostics' }, -- Add git diff & diagnostics
        lualine_c = {
          { 'filename', path = 1 }, -- Show relative path
          '%=', -- Center alignment
        },
        lualine_x = { 'encoding', 'fileformat' }, -- Add encoding and fileformat
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end
}
