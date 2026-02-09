return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	-- In Neovim 0.11+, treesitter highlighting and indentation are built-in.
	-- This plugin is now used primarily for installing/updating parsers.
	main = "nvim-treesitter",
	opts = {},
}
