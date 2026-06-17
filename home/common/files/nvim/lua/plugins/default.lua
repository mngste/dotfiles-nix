return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = opts or {}
      opts.auto_install = false
      opts.ensure_installed = {
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "vimdoc",
        "nix",
        "bash",
      }
      return opts
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = {} },
      checkbox = { enabled = false },
    },
  },
}
