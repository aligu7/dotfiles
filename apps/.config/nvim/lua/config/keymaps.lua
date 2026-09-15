-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Typst Preview
vim.keymap.set("n", "<leader>tp", ":TypstPreview<cr>", { desc = "Typst Preview" })
vim.keymap.set("n", "<leader>tP", ":TypstPreviewStop<cr>", { desc = "Stop Typst Preview" })

-- Typst Evince Watcher (Background Compilation + PDF Viewer)
vim.keymap.set("n", "<leader>te", function()
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Check if the current file is a Typst file
  if current_file == "" or not current_file:match("%.typ$") then
    vim.notify("Current buffer is not a valid Typst file!", vim.log.levels.WARN)
    return
  end

  -- Derive the output PDF path by replacing .typ with .pdf
  local pdf_file = current_file:gsub("%.typ$", ".pdf")

  -- 1. Run 'typst watch' safely in the background
  vim.fn.jobstart({ "typst", "watch", current_file }, { detach = true })

  -- 2. Open 'evince' on the generated PDF in the background
  vim.fn.jobstart({ "evince", pdf_file }, { detach = true })

  vim.notify("Started Typst watch & Evince for: " .. vim.fn.fnamemodify(pdf_file, ":t"), vim.log.levels.INFO)
end, { desc = "Typst Watch + Evince Viewer" })
