local M = {}

M.copilot_enabled = true -- Enable copilot
M.copilot_debug = false -- Enable debug modes
--M.copilot_keymap = "<leader>cp" -- Keymap to trigger copilot
M.copilot_url = "https://copilot.githubapp.com" -- Copilot URL
M.copilot_timeout = 5000 -- Timeout for copilot request
M.copilot_max_results = 10 -- Max results to show in floating window
M.copilot_max_lines = 1000 -- Max lines to send to copilot
M.copilot_max_num_results = 3 -- Max number of results to show in floating window
M.copilot_preferred_sources = {
    "github",
    "gitlab",
    "bitbucket",
    "gist",
} -- Preferred sources for copilot

M.copilot_preferred_languages = {
    "lua",
    "python",
    "go",
    "rust",
    "perl",
    "bash",
    "dockerfile",
    "sh",
    "helm",
    "yaml",
    "json",
} -- Preferred languages for copilot

M.copilot_filetypes = {
    "lua",
    "python",
    "go",
    "rust",
    "perl",
    "bash",
    "dockerfile",
    "sh",
    "helm",
    "yaml",
    "json",
} -- Filetypes to trigger copilot

return M
