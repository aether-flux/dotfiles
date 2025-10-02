vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = " "

-- CUSTOM KEYMAPS
-- Moving between tabs
-- vim.keymap.set('n', '<leader>h', '<C-w>h', {desc = "Move to left split"})
-- vim.keymap.set('n', '<leader>l', '<C-w>l', {desc = "Move to right split"})
-- vim.keymap.set('n', '<leader>k', '<C-w>k', {desc = "Move to up split"})
-- vim.keymap.set('n', '<leader>j', '<C-w>j', {desc = "Move to down split"})

-- Navigate panes better
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')


-- Save quicker
vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', {desc = "Save quicker with leader+W"})

-- Save everything and exit
vim.keymap.set('n', '<C-X>', ':xa<CR>', { noremap = true, silent = true })

-- Fast copy to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { noremap = true, silent = true })

-- Toggle Line Numbers
vim.keymap.set('n', '<leader>rn', function()
---@diagnostic disable-next-line: undefined-field
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {desc = "Toggle relative line numbers"})

vim.keymap.set('n', '<leader>an', function()
---@diagnostic disable-next-line: undefined-field
  vim.opt.number = not vim.opt.number:get()
end, {desc = "Toggle relative line numbers"})

-- Search and replace word under cursor
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { noremap = true })

-- Search for word under cursor
vim.keymap.set('n', '//', '*N', { noremap = true, silent = true })

-- -- Remove the highlights
vim.keymap.set('n', '<leader>h', ':noh<CR>', { noremap = true, silent = true })

-- Split screen
vim.keymap.set('n', '<leader>|', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>-', ':split<CR>', { noremap = true, silent = true })

-- Escape to normal mode
vim.keymap.set({'n', 'i', 'v'}, '<C-e>', '<Esc>', { noremap = true })


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Require files
-- require "alpha-config"
-- require("forkyou")

-- Setup lazy.nvim
require("lazy").setup("plugins")

-- CUSTOM PLUGINS

-- Save Wonder
vim.api.nvim_create_user_command("SaveWonder", function()
  require("save_wonder").save_wonder()
end, {})

-- Power Mode


vim.api.nvim_create_autocmd("BufWritePost", {
  command = [[ SaveWonder ]]
})


vim.api.nvim_create_autocmd("VimEnter", {
  callback = function ()
    vim.o.laststatus = 2

    vim.cmd([[
      highlight StatusPill_n guifg=#1e1e1e guibg=#A2C5AC
      highlight StatusPill_i guifg=#1e1e1e guibg=#E3BF6F
      highlight StatusPill_v guifg=#1e1e1e guibg=#F48FB1
      highlight StatusPill_V guifg=#1e1e1e guibg=#BA68C8
      highlight StatusPill_ctrlv guifg=#1e1e1e guibg=#4FC3F7
      highlight StatusPill_r guifg=#1e1e1e guibg=#FF7043
      highlight StatusPill_c guifg=#1e1e1e guibg=#FFCA28
      highlight StatusPill_middle guifg=#dddddd guibg=#3f3f3f
      highlight StatusPill_right guifg=#3f3f3f guibg=#1e1e1e
    ]])

    local leftPill = ""
    local rightPill = ""

    local mode_colors = {
      n = "StatusPill_n",
      i = "StatusPill_i",
      v = "StatusPill_v",
      V = "StatusPill_V",
      [""] = "StatusPill_ctrlv",
      R = "StatusPill_r",
      c = "StatusPill_c",
    }

    function MyStatusLine()
      local mode = vim.fn.mode()
      local hl_group = mode_colors[mode] or "StatusPill_n"

      local filename = vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]"
      local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "[No FT]"
      
      local pill = "%#"..hl_group.."#"..leftPill..
                   "%#"..hl_group.."# "..filename.." %m "..rightPill

      local right_info = "%=%#StatusPill_middle# "..filetype.." "..os.date("%H:%M").." "

      return pill..right_info
    end

    vim.o.statusline = "%!v:lua.MyStatusLine()"
  end
})

-- Pets
vim.keymap.set('n', '<leader>dd', function() require("duck").hatch("ඞ", 5) end, {})
vim.keymap.set('n', '<leader>dc', function() require("duck").hatch("🦀", 5) end, {})
vim.keymap.set('n', '<leader>db', function() require("duck").hatch("🥸", 5) end, {})
