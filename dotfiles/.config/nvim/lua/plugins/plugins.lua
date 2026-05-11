return {
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {"neoclide/coc.nvim", build = "yarn install --frozen-lockfile"},
  {"zbirenbaum/copilot.lua"},
  {"nvim-lua/plenary.nvim"},
  {"MunifTanjim/nui.nvim"},
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {"github/copilot.vim"},
  {"nvim-tree/nvim-web-devicons"},
  {"ryanoasis/vim-devicons"},
  {"junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
  {"junegunn/fzf.vim"},
  {"pappasam/vim-filetype-formatter"},
  {"tanvirtin/monokai.nvim"},
  {"airblade/vim-rooter"},
  {"tpope/vim-commentary"},
  {"ntpeters/vim-better-whitespace"},
  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  {"tpope/vim-surround"},
  {"tyru/open-browser.vim"},
  {"tyru/open-browser-github.vim"},
  {"ckarnell/Antonys-macro-repeater"}
}
