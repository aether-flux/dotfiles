return {
  {
    "preservim/vim-markdown",
    config = function()
      -- Set conceallevel and concealcursor
      -- vim.opt.conceallevel = 2
      -- vim.opt.concealcursor = "nc"

      -- Plugin settings
      -- vim.g.vim_markdown_conceal = 0
      -- vim.g.vim_markdown_conceal_code_blocks = 0
      -- vim.g.vim_markdown_conceal_math = 0

      -- Optional: Set custom highlighting for headings
      -- vim.cmd [[
      --   hi markdownH1 guifg=#ff5555 gui=bold
      --   hi markdownH2 guifg=#f1fa8c gui=bold
      --   hi markdownH3 guifg=#8be9fd gui=bold
      -- ]]
    end
  }
}

