local options = {
  --ensure_installed = { "lua" },
  ensure_installed = { "rust", "go", "php", "html", "css", "perl",
	"bash", "json", "markdown", "c", "lua", "vim", "vimdoc",
	"todotxt", "terraform", "sql", "regex", "mermaid", "markdown_inline", "ini", "diff",
	"comment", "dockerfile"
  },
  sync_install = false,
  auto_install = true,
  matchup = {
      enable = true, -- mandatory, false will disable the whold extension
      disable_virtual_text = true,
      disable = { "html" }, -- optional, list of languages that will be disabled
      -- include_match_words = false,
  },
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    -- additional_vim_regex_highlighting = true,
  },
  autopairs = {
      enable = true,
  },
  indent = { enable = true, disable = { "python", "css", "rust" } },
  context_commentstring = {
      enable = true,
      enable_autocmd = false,
  },
  autotag = {
      enable = true,
      disable = { "xml", "markdown" },
  },
  incremental_selection = {
      enable = true,
  },
  --- highlight = {
  ---   enable = true,
  ---   use_languagetree = true,
  --- },

  --- indent = { enable = true },
}

return options
