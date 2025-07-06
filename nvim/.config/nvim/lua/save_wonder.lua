local M = {}

function M.save_wonder()
  local frames = {
    {
        [[ /\_/\  ]],
        [[( o.o ) ]],
        [[ > ^ <  ]],
    },
    {
        [[ /\_/\  ]],
        [[( -.- ) ]],
        [[ > ^ <  ]],
    }
  }

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = 10,
      height = 3,
      row = 42,
      col = 196,
      style = 'minimal',
      border = 'rounded',
  })

  local index = 1
  local start_time = vim.loop.now()

  local function update_frame()
      if vim.loop.now() - start_time > 3000 then
          vim.api.nvim_win_close(win, true) -- Close window after 3 seconds
          return
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, frames[index]) -- Update frame
      index = index % #frames + 1

      vim.defer_fn(update_frame, 200) -- Animate every 200ms
  end

  vim.defer_fn(update_frame, 200)

end

return M

