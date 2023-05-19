local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "craigmac/vim-mermaid"
  },
  {
    "towolf/vim-helm"
  },
}
return plugins

