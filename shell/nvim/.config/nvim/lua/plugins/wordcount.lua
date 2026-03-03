return {
	dir = "~/.config/nvim/lua/wordcount",
	name = "wordcount",
	config = function()
		vim.api.nvim_create_user_command("WordCount", function()
			require("wordcount").count()
		end, {})
		vim.keymap.set("n", "<leader>wc", ":WordCount<CR>", { desc = "Word count" })
	end,
}
