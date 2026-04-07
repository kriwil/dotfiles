local M = {}

local mode_labels = {
  n = "N",
  no = "N?",
  nov = "N?",
  noV = "N?",
  ["no\22"] = "N?",
  niI = "Ni",
  niR = "Nr",
  niV = "Nv",
  nt = "Nt",
  v = "V",
  vs = "Vs",
  V = "VL",
  Vs = "VL",
  ["\22"] = "VB",
  ["\22s"] = "VB",
  s = "S",
  S = "SL",
  ["\19"] = "SB",
  i = "I",
  ic = "Ic",
  ix = "Ix",
  R = "R",
  Rc = "Rc",
  Rx = "Rx",
  Rv = "Rv",
  Rvc = "Rv",
  Rvx = "Rv",
  c = "C",
  cv = "Ex",
  r = "Pr",
  rm = "M",
  ["r?"] = "?",
  ["!"] = "!",
  t = "T",
}

local function hl(name)
  local ok, value = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  return ok and value or {}
end

function M.refresh_highlights()
  local normal = hl("Normal")
  local status = hl("StatusLine")
  local inactive = hl("StatusLineNC")
  local constant = hl("Constant")
  local comment = hl("Comment")

  local base_bg = status.bg or normal.bg
  local base_fg = status.fg or normal.fg
  local muted_fg = inactive.fg or comment.fg or base_fg
  local accent_bg = constant.fg or base_fg or normal.fg
  local accent_fg = base_bg or normal.bg

  vim.api.nvim_set_hl(0, "NvimPureStatuslineFill", {
    fg = base_fg,
    bg = base_bg,
  })
  vim.api.nvim_set_hl(0, "NvimPureStatuslineMuted", {
    fg = muted_fg,
    bg = base_bg,
  })
  vim.api.nvim_set_hl(0, "NvimPureStatuslineMode", {
    fg = accent_fg,
    bg = accent_bg,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "NvimPureStatuslineModeEdge", {
    fg = accent_bg,
    bg = base_bg,
  })
  vim.api.nvim_set_hl(0, "NvimPureStatuslineFile", {
    fg = base_fg,
    bg = base_bg,
    bold = true,
  })
end

local function mode_label()
  return mode_labels[vim.api.nvim_get_mode().mode] or "?"
end

local function file_label(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  local label = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")

  if vim.bo[buf].modified then
    label = label .. " +"
  end

  if vim.bo[buf].readonly then
    label = label .. " ro"
  end

  return label:gsub("%%", "%%%%")
end

local function diagnostics_label(buf)
  local counts = {
    errors = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.ERROR }),
    warns = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.WARN }),
  }

  local parts = {}
  if counts.errors > 0 then
    parts[#parts + 1] = "E" .. counts.errors
  end
  if counts.warns > 0 then
    parts[#parts + 1] = "W" .. counts.warns
  end

  return table.concat(parts, " ")
end

function _G.nvim_pure_statusline()
  local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
  local current = winid == vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(winid)
  local filetype = vim.bo[buf].filetype
  local diagnostics = diagnostics_label(buf)
  local parts = {}

  if current then
    parts[#parts + 1] = "%#NvimPureStatuslineModeEdge#"
    parts[#parts + 1] = "%#NvimPureStatuslineMode# " .. mode_label() .. " "
    parts[#parts + 1] = "%#NvimPureStatuslineModeEdge#"
    parts[#parts + 1] = "%#NvimPureStatuslineFile# " .. file_label(buf) .. " "
    parts[#parts + 1] = "%#NvimPureStatuslineFill#%="
    if diagnostics ~= "" then
      parts[#parts + 1] = "%#NvimPureStatuslineMuted# " .. diagnostics .. " "
    end
    if filetype ~= "" then
      parts[#parts + 1] = "%#NvimPureStatuslineMuted# " .. filetype:gsub("%%", "%%%%") .. " "
    end
    parts[#parts + 1] = "%#NvimPureStatuslineMuted# %l:%c %p%% "
  else
    parts[#parts + 1] = "%#StatusLineNC# " .. file_label(buf) .. " "
    parts[#parts + 1] = "%#StatusLineNC#%="
  end

  return table.concat(parts)
end

function M.setup()
  vim.o.laststatus = 3
  vim.o.statusline = "%!v:lua.nvim_pure_statusline()"

  vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Refresh custom statusline highlights",
    group = vim.api.nvim_create_augroup("nvim-pure-statusline-highlights", { clear = true }),
    callback = function()
      M.refresh_highlights()
    end,
  })
end

return M
