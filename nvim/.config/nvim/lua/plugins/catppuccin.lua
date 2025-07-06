return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- require("catppuccin").setup({
      -- flavour = "mocha", -- "latte", "frappe", "macchiato", or "mocha"
--     background = {
--       light = "latte",
--       dark = "macchiato", -- fallback background for dark mode
--     },
--     transparent_background = false, -- Optional
--     show_end_of_buffer = false, -- Optional
    -- })

    -- This ensures the colorscheme is set after setup
    -- vim.cmd.colorscheme("catppuccin-frappe")
  end
}
