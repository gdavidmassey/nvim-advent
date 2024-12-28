print("advent of neovim")

require("config.lazy")
require("config.options")
require("config.remaps")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking test',
  group = vim.api.nvim_create_augroup('advent-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--vim.api.nvim_create_autocmd({ 'BufNew', 'BufEnter' }, {
--  pattern = { '*.p8' },
--  callback = function(args)
--    vim.lsp.start({
--      name = 'pico8-ls',
--      cmd = { 'pico8-ls', '--stdio' },
--      root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
--      -- Setup your keybinds in the on_attach function
--      on_attach = on_attach,
--    })
--  end
--})
