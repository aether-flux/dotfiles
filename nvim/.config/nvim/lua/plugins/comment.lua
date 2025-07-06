return {
  'numToStr/Comment.nvim',
  dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"},
  config = function()
--    require('Comment').setup({
--      pre_hook = function(ctx)
--        local U = require("Comment.utils")
--        local ts_utils = require("ts_context_commentstring.utils")
--        local ts_internal = require("ts_context_commentstring.internal")
--
--        if ts_utils.is_in_tsx(ctx.ctype == U.ctype.line and 'comment' or 'multiline') then
--          return ts_internal.calculate_commentstring()
--        end
--      end
--    })
  require('Comment').setup({})
  end
}
