
local function select_type()
  -- 現在のカーソル位置の行を取得
  local line = vim.api.nvim_get_current_line()

  -- 先頭の '#' と空白を除去
  line = line:gsub("^#%s*", "")

  -- 最初の単語を取得
  local word = vim.split(line, "%s+")[1] or ""
  local title = word .. ": "

  local bufnr = vim.api.nvim_get_current_buf()

  -- バッファ全体を削除
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, line_count, false, {})

  -- title を挿入
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { title })

  -- 最初の行・最初の文字へ移動
  vim.api.nvim_win_set_cursor(0, { 1, 0 })

  -- インサートモードに入る
  vim.api.nvim_feedkeys("i", "n", false)
end

-- バッファローカルに <CR><CR> を割り当て
vim.keymap.set("n", "<CR><CR>", select_type, { buffer = true, desc = "Select type and clear buffer" })

