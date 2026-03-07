return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find Old Files" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find Marks" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find Commands" },
		{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
		{ "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Find Registers" },
		{ "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
	},
}
