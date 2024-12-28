local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values
local themes = require "telescope.themes"

local M = {}

local bufgrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.fn.expand("%:p:h")

  -- Read the current buffer's contents
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local stdin = table.concat(lines, "\n")

  local finder = finders.new_job {
    command = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local args = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
        "--smart-case", "-e", prompt }

      return args
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
    max_results = opts.max_results or 100,
    env = {
      LANG = "en_US.UTF-8",
    },
    writer = function()
      return stdin
    end
  }

  pickers.new(opts, themes.get_dropdown({
    debounce = 100,
    prompt_title = "Buffer Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require('telescope.sorters').empty(),
  })):find()
end

M.setup = function()
  vim.keymap.set('n', '<leader>gb', bufgrep)
end

return M
