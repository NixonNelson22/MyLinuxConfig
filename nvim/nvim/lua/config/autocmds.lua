vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		print("lint works")
		require("lint").try_lint()
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		print("format works")
		require("conform").format({ bufnr = args.buf })
	end,
})
