-- custom/added plugins to lazyload
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
    {
        "someone-stole-my-name/yaml-companion.nvim",
    },
}
return plugins

