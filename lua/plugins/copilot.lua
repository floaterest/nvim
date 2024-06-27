return function()
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})

	require("copilot.command").disable()
end
