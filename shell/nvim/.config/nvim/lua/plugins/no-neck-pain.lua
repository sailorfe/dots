return {
	'shortcuts/no-neck-pain.nvim',
	version = '*',
	opts = {
		width = 100,
	},
	vim.keymap.set("n", "<leader>nnp", "<Cmd>NoNeckPain<CR>", opts),
	vim.keymap.set('n', '<A-f>', '<cmd>:lua MiniFiles.open()<cr>'),
}
