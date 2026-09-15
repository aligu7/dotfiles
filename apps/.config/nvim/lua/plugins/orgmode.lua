return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require("orgmode").setup({
        org_agenda_files = { "~/org/**/*.org" },
        org_default_notes_file = "~/org/refile.org",
        org_capture_templates = {
          t = { description = "Task", template = "* TODO %?\n  %u" },
          n = { description = "Note", template = "* %?\n  %u" },
        },
      })
    end,
  },
}
