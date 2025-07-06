return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      return
    end

    local dashboard = require("alpha.themes.dashboard")
--    dashboard.section.header.val = {

--    [[          ▀████▀▄▄              ▄█ ]],
--    [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
--    [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
--    [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
--    [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
--    [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
--    [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
--    [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
--    [[   █   █  █      ▄▄           ▄▀   ]],

--    }    

    -- dashboard.section.header.val = {

    -- [[   █████╗ ███████╗████████╗██╗  ██╗███████╗██████╗  ██████╗ ███████╗ ]],
    -- [[  ██╔══██╗██╔════╝╚══██╔══╝██║  ██║██╔════╝██╔══██╗██╔═══██╗██╔════╝ ]],
    -- [[  ███████║█████╗     ██║   ███████║█████╗  ██████╔╝██║   ██║███████╗ ]],
    -- [[  ██╔══██║██╔══╝     ██║   ██╔══██║██╔══╝  ██╔══██╗██║   ██║╚════██║ ]],
    -- [[  ██║  ██║███████╗   ██║   ██║  ██║███████╗██║  ██║╚██████╔╝███████║ ]],
    -- [[  ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ]],

    -- }

    dashboard.section.header.val = {

    [[   ██████╗  ██████╗  ██████╗  ██╗   ██╗ ███╗   ██╗  ]],
    [[  ██╔═══██╗ ██╔══██╗ ██╔══██╗ ╚██╗ ██╔╝ ████╗  ██║  ]],
    [[  ██║   ██║ ██████╔╝ ██████╔╝  ╚████╔╝  ██╔██╗ ██║  ]],
    [[  ██║   ██║ ██╔══██╗ ██╔══██╗   ╚██╔╝   ██║╚██╗██║  ]],
    [[  ╚██████╔╝ ██║  ██║ ██║  ██║    ██║    ██║ ╚████║  ]],
    [[   ╚═════╝  ╚═╝  ╚═╝ ╚═╝  ╚═╝    ╚═╝    ╚═╝  ╚═══╝  ]],

    }
                                                                  
    dashboard.section.buttons.val = {
       dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
       dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
       dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
       dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
       dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.vim<CR>"),
       dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    local function footer()
      return "Yeeeaahhhh bbooiiiiiii !!!!!!"
    end

    local function center_padding()
      local tot_height = vim.fn.winheight(0)
      local content_height = #dashboard.section.header.val + #dashboard.section.buttons.val + #dashboard.section.footer.val
      local padding = math.max(0, math.floor((tot_height - content_height) / 2))
      return padding
    end

    local padding = center_padding()

    dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.config.layout = {
      {type = "padding", val = padding},
      dashboard.section.header,
      {type = "padding", val = 2},
      dashboard.section.buttons,
      {type = "padding", val = 2},
      dashboard.section.footer
    }


      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end
  }
