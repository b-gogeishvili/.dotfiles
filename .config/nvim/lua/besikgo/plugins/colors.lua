function SetUpColorScheme(color)
	color = color or "rose-pine"

	vim.cmd("colorscheme " .. color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require('rose-pine').setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})

			-- SetUpColorScheme()
		end
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
		config = function()
			require("tokyonight").setup({
				style = "storm", -- `storm`, `moon`, `night` and `day`
				transparent = true, 
				terminal_colors = true, 
				styles = {
					keywords = { italic = false },
					sidebars = "dark", 
					floats = "dark", 
				},
			})

			SetUpColorScheme("tokyonight")

		end
	},

}
