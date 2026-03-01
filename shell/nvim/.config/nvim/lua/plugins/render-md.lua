return {
	"MeanderingProgrammer/render-markdown.nvim",
	enabled = true,
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		link = {
			-- Turn on / off inline link icon rendering.
			enabled = true,
			-- Additional modes to render links.
			render_modes = false,
			-- How to handle footnote links, start with a '^'.
			footnote = {
				-- Turn on / off footnote rendering.
				enabled = true,
				-- Replace value with superscript equivalent.
				superscript = true,
				-- Added before link content.
				prefix = "",
				-- Added after link content.
				suffix = "",
			},
			-- Inlined with 'image' elements.
			image = "󰥶 ",
			-- Inlined with 'email_autolink' elements.
			email = "󰀓 ",
			-- Fallback icon for 'inline_link' and 'uri_autolink' elements.
			hyperlink = "󰌹 ",
			-- Applies to the inlined icon as a fallback.
			highlight = "RenderMarkdownLink",
			-- Applies to WikiLink elements.
			wiki = {
				icon = "󱗖 ",
				body = function()
					return nil
				end,
				highlight = "RenderMarkdownWikiLink",
			},
			-- Define custom destination patterns so icons can quickly inform you of what a link
			-- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
			-- patterns match a link the one with the longer pattern is used.
			-- The key is for healthcheck and to allow users to change its values, value type below.
			-- | pattern   | matched against the destination text                            |
			-- | icon      | gets inlined before the link text                               |
			-- | kind      | optional determines how pattern is checked                      |
			-- |           | pattern | @see :h lua-patterns, is the default if not set       |
			-- |           | suffix  | @see :h vim.endswith()                                |
			-- | priority  | optional used when multiple match, uses pattern length if empty |
			-- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
			custom = {
				web = { pattern = "^http", icon = "󰖟 " },
				github = { pattern = "github%.com", icon = "󰊤 " },
				gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
				stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
				wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
				youtube = { pattern = "youtube%.com", icon = "󰗃 " },
				tumblr = { pattern = "tumblr%.com", icon = " " },
			},
		},
		heading = {
			width = "full",
			icons = { "☽ ", "☿ ", "♀ ", "♂ ", "♃ ", "♄ " },
			right_pad = 1,
		},
		code = {
			width = "block",
		},
		dash = {
			width = 30,
			highlight = "Delimiter",
		},
		win_options = {
			conceallevel = {
				rendered = 3,
			},
		},
	},
}
