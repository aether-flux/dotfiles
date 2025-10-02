return {
  dir = "~/Projects/nvim_plugs",
  name = "power_mode",
  config = function()
    require("power_mode").setup({
      duration = 2000
    })
  end
}
