local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values
local themes = require "telescope.themes"
local M = {}

local bufgrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.fn.expand("%:p:h")

  local bufname = vim.fn.expand("%:t")

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local args = { "rg" }
      table.insert(args, "-e")
      table.insert(args, prompt)

      table.insert(args, "-g")
      table.insert(args, bufname)

      --@diagnostic disable-next-line: Deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd

  }

  pickers.new(opts, themes.get_ivy({
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require('telescope.sorters').empty(),
  })):find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>fb", bufgrep)
end

return M
