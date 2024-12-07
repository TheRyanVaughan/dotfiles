-- TODO: I like this, lets add a keymap to toggle the line diffs on/off (and perhaps word diff) so I can preview PR changes easily
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		-- this is a  new line
		signs = { -- this line was edited
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	},
}
