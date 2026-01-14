return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup()
		vim.keymap.set("n", "<leader>sr", "<cmd>GrugFar<cr>", { desc = "Search & Replace" })
		vim.keymap.set("n", "<leader>sw", function()
			require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
		end, { desc = "Search current word" })
	end,
}
