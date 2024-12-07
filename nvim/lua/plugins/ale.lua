-- TODO: Evaluate if I use ale at all, and whether I still need it.
return {
	"dense-analysis/ale",
	config = function()
		vim.g.ale_ruby_robocop_auto_correct_all = 1
		vim.g.ale_linters = {
			cs = { "OmniSharp" },
		}
	end,
}
