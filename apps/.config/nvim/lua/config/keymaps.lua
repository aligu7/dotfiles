-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Typst Preview
vim.keymap.set("n", "<leader>tp", ":TypstPreview<cr>", { desc = "Typst Preview" })
vim.keymap.set("n", "<leader>tP", ":TypstPreviewStop<cr>", { desc = "Stop Typst Preview" })

-- Typst Evince Watcher (Background Compilation + PDF Viewer)
--
-- Delegates to typst-watch, which owns both the `typst watch` process and the
-- viewer, so closing the PDF stops the watcher. Starting them from here
-- detached (as this used to do) left a watcher running forever after the
-- viewer was gone, which kept rewriting the PDF.
local function typst_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" or not file:match("%.typ$") then
    vim.notify("Current buffer is not a valid Typst file!", vim.log.levels.WARN)
    return nil
  end
  return file
end

vim.keymap.set("n", "<leader>te", function()
  local file = typst_file()
  if not file then
    return
  end
  vim.fn.jobstart({ "typst-watch", file }, { detach = true })
  vim.notify("Watching " .. vim.fn.fnamemodify(file, ":t") .. " - close the PDF to stop", vim.log.levels.INFO)
end, { desc = "Typst Watch + Evince Viewer" })

vim.keymap.set("n", "<leader>tS", function()
  local file = typst_file()
  if not file then
    return
  end
  vim.fn.jobstart({ "typst-watch", "--stop", file }, { detach = true })
  vim.notify("Stopped watching " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
end, { desc = "Stop Typst Watch" })

vim.keymap.set("n", "<leader>tl", function()
  local file = typst_file()
  if not file then
    return
  end
  local lines = vim.fn.systemlist({ "typst-watch", "--log", file })
  if #lines == 0 then
    vim.notify("No watch log for " .. vim.fn.fnamemodify(file, ":t") .. " yet", vim.log.levels.WARN)
    return
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype = "log"
  vim.bo[buf].modifiable = false
  vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Typst Watch Log" })
