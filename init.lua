print("advent of neovim")

require("config.lazy")
require("config.options")
require("config.remaps")
require("config.autocommands")

require("nvim-treesitter.parsers").get_parser_configs().pico8 = {
  install_info = {
    url = "https://github.com/paradoxskin/tree-sitter-pico8.git",
    files = { "src/parser.c" },
  },
  filetype = "pico8"
}

-- Define the log file path
local log_file = vim.fn.expand("~/.config/nvim-advent/nvim_log.txt")

-- Function to log messages
local function log_message(message)
  local log_msg = string.format("[%s] %s\n", os.date("%Y-%m-%d %H:%M:%S"), message)
  local f = io.open(log_file, "a")
  if f then
    f:write(log_msg)
    f:close()
  else
    print("Failed to open log file: " .. log_file)
  end
end

-- Export the log function to be used globally
_G.log_message = log_message
