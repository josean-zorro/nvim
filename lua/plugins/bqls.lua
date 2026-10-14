return {
  "kitagry/bqls.nvim",
  build = "./install.sh",
  config = function()
    require("bqls").setup({})
  end,
}
