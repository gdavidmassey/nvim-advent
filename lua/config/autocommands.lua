vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking test',
  group = vim.api.nvim_create_augroup('advent-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufNew', 'BufEnter' }, {
  pattern = { '*.p8' },
  callback = function(args)
    vim.lsp.start({
      name = 'pico8-ls',
      cmd = { 'pico8-ls', '--stdio' },
      root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
      -- Setup your keybinds in the on_attach function
      on_attach = on_attach,
    })
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

local job_id = 0
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)

  job_id = vim.bo.channel
end)

vim.keymap.set("n", "<space>example", function()
  vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
end)
