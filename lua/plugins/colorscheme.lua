return {
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },

  -- keep the customized nightfly lualine theme
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local theme = vim.deepcopy(require("lualine.themes.nightfly"))
      local colors = {
        blue = "#65D1FF",
        green = "#3EFFDC",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        black = "#000000",
      }
      theme.normal.a.bg = colors.blue
      theme.insert.a.bg = colors.green
      theme.visual.a.bg = colors.violet
      theme.command = { a = { gui = "bold", bg = colors.yellow, fg = colors.black } }
      opts.options.theme = theme
    end,
  },
}
