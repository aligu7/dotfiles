return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vue_ls = {
          -- Prevent the server from locking up on massive directories
          init_options = {
            typescript = {
              tsdk = "", -- Required for Hybrid mode to function without locking
            },
            -- Disable heavy parsing features if they lag your machine
            languageFeatures = {
              references = true,
              definition = true,
              diagnostics = true,
              semanticTokens = false, -- Disabling this significantly speeds up initial load
            },
          },
          -- Ensure it boots relative to package.json, avoiding parent directory scans
          root_dir = require("lspconfig").util.root_pattern("package.json", "nuxt.config.ts"),
        },
      },
    },
  },
}
