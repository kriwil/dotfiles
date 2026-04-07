local M = {}

local function listed_buffers()
  return vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())
end

local function tabline_hl(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  return ok and hl or {}
end

function M.refresh_highlights()
  local normal = tabline_hl("Normal")
  local tabline = tabline_hl("TabLine")
  local selected = tabline_hl("TabLineSel")

  local fill_bg = tabline.bg or normal.bg
  local fill_fg = tabline.fg or normal.fg
  local active_bg = selected.bg or fill_fg or normal.fg
  local active_fg = selected.fg or fill_bg or normal.bg

  vim.api.nvim_set_hl(0, "NvimPureTablineFill", {
    fg = fill_fg,
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "NvimPureTablineInactive", {
    fg = fill_fg,
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "NvimPureTablineActive", {
    fg = active_fg,
    bg = active_bg,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "NvimPureTablineActiveEdge", {
    fg = active_bg,
    bg = fill_bg,
  })
  vim.api.nvim_set_hl(0, "NvimPureTablineMuted", {
    fg = fill_fg,
    bg = fill_bg,
    italic = true,
  })
end

local function buffer_icon(buf)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return ""
  end

  local name = vim.api.nvim_buf_get_name(buf)
  local filename = name == "" and "untitled" or vim.fn.fnamemodify(name, ":t")
  local extension = vim.fn.fnamemodify(filename, ":e")
  local icon = devicons.get_icon(filename, extension, { default = true })
  return icon or ""
end

local function buffer_label(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  local label = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")
  local icon = buffer_icon(buf)
  local modified = vim.bo[buf].modified and " ●" or ""

  return ("%s %s%s"):format(icon, label, modified):gsub("%%", "%%%%")
end

local function delete_buffers(targets)
  if #targets == 0 then
    return
  end

  local current = vim.api.nvim_get_current_buf()
  local deleting_current = vim.tbl_contains(targets, current)

  if deleting_current then
    vim.cmd("enew")
  end

  for _, buf in ipairs(targets) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      pcall(vim.cmd, "bdelete " .. buf)
    end
  end
end

local function close_all_buffers()
  delete_buffers(listed_buffers())
end

local function close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  local targets = vim.tbl_filter(function(buf)
    return buf ~= current
  end, listed_buffers())

  delete_buffers(targets)
end

function _G.nvim_pure_tabline_click(buf)
  if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
    vim.api.nvim_set_current_buf(buf)
  end
end

function _G.nvim_pure_tabline()
  local current = vim.api.nvim_get_current_buf()
  local parts = {}
  local buffers = listed_buffers()

  for _, buf in ipairs(buffers) do
    if buf == current then
      parts[#parts + 1] = "%#NvimPureTablineActiveEdge#"
      parts[#parts + 1] = "%#NvimPureTablineActive#%" .. buf .. "@v:lua.nvim_pure_tabline_click@ "
        .. buffer_label(buf)
        .. " %T"
      parts[#parts + 1] = "%#NvimPureTablineActiveEdge#"
    else
      parts[#parts + 1] = "%#NvimPureTablineInactive#%" .. buf .. "@v:lua.nvim_pure_tabline_click@ "
        .. buffer_label(buf)
        .. " %T"
    end
    parts[#parts + 1] = "%#NvimPureTablineFill# "
  end

  parts[#parts + 1] = "%#NvimPureTablineFill#%="
  parts[#parts + 1] = "%#NvimPureTablineMuted# " .. #buffers .. " "
  return table.concat(parts)
end

function M.setup()
  local map = vim.keymap.set

  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.nvim_pure_tabline()"

  map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
  map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
  map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
  map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
  map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to Other Buffer" })
  map("n", "<leader>`", "<cmd>e #<CR>", { desc = "Switch to Other Buffer" })
  map("n", "<leader>ba", close_all_buffers, { desc = "Delete All Buffers" })
  map("n", "<leader>bo", close_other_buffers, { desc = "Delete Other Buffers" })

  vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Refresh custom tabline highlights",
    group = vim.api.nvim_create_augroup("nvim-pure-tabline-highlights", { clear = true }),
    callback = function()
      M.refresh_highlights()
    end,
  })
end

return M
