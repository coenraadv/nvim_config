-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}
local augroup = vim.api.nvim_create_augroup("RememberCursor", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    local lastpos = vim.fn.line("'\"")
    if lastpos > 0 and lastpos <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, {lastpos, 0})
    end
  end,
})
return M
