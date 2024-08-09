local wezterm = require 'wezterm'

local wsl_domains = wezterm.default_wsl_domains()
local wsl_ubuntu = 'WSL:Ubuntu-20.04'

for idx, dom in ipairs(wsl_domains) do
	if dom.name == wsl_ubuntu then
		dom.default_cwd = '~'
	end
end

return {
	default_domain = wsl_ubuntu,
	-- font = wezterm.font 'Fira Code Retina',
	-- font = wezterm.font('Rec Mono Linear', { weight = 'Thin' }),
	-- font = wezterm.font('Rec Mono Casual', { weight = 'Thin' }),
	-- font = wezterm.font('Rec Mono Duotone', { weight = 'Thin' }),
	-- font = wezterm.font('MonoLisa Nerd Font', { weight = 'Light' }),
	-- font = wezterm.font('Liga CPMono_v07 Plain', { weight = 'Thin' }),
	-- font = wezterm.font 'Liga Share-TechMonoTrue',
	-- font = wezterm.font 'Syne Mono',
	-- font = wezterm.font 'Ligalex Mono',
	-- font = wezterm.font 'Liga Triplicate T3',
	font = wezterm.font 'LigaSrc Variable',
	-- font = wezterm.font 'Liga Courier Prime',
	-- font = wezterm.font 'Liga monoOne',
	-- font = wezterm.font 'Liga Office Code Pro D',
	-- font = wezterm.font('Jetbrains Mono', { weight = 'Thin' }),
	-- font = wezterm.font('Liga InputMonoNarrow', { weight = 'Thin' }),
	-- font = wezterm.font('Liga InputMono', { weight = 'Thin' }),
	-- font = wezterm.font('Liga Inconsolata LGC', { weight = 'Thin' }),
	-- font = wezterm.font('Liga Cousine', { weight = 'Thin' }),
	-- font = wezterm.font('Liga Liberation Mono', { weight = 'Thin' }),
	-- font = wezterm.font('SF Mono L', { weight = 'Thin' }),
	-- font = wezterm.font('Liga Cousine', { weight = 'Thin' }),
	-- font = wezterm.font('Dank Mono', { weight = 'Light' }),
	font_size = 12,
	line_height = 1.4,
	keys = {
		{
			key = ',',
			mods = 'CTRL',
			action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS' },
		},
		{
			key = 's',
			mods = 'ALT',
			action = wezterm.action.SplitVertical
		},
		{
			key = 'v',
			mods = 'ALT',
			action = wezterm.action.SplitHorizontal
		},
		{
			key = 'l',
			mods = 'ALT',
			action = wezterm.action.ActivatePaneDirection 'Right'
		},
		{
			key = 'h',
			mods = 'ALT',
			action = wezterm.action.ActivatePaneDirection 'Left'
		},
		{
			key = 'k',
			mods = 'ALT',
			action = wezterm.action.ActivatePaneDirection 'Up'
		},
		{
			key = 'j',
			mods = 'ALT',
			action = wezterm.action.ActivatePaneDirection 'Down'
		},
		{
			key = 'l',
			mods = 'ALT|SHIFT',
			action = wezterm.action.AdjustPaneSize { 'Right', 20 }
		},
		{
			key = 'h',
			mods = 'ALT|SHIFT',
			action = wezterm.action.AdjustPaneSize { 'Left', 20 }
		},
		{
			key = 'j',
			mods = 'ALT|SHIFT',
			action = wezterm.action.AdjustPaneSize { 'Down', 5 }
		},
		{
			key = 'k',
			mods = 'ALT|SHIFT',
			action = wezterm.action.AdjustPaneSize { 'Up', 5 }
		},
		{
			key = 'z',
			mods = 'ALT',
			action = wezterm.action.TogglePaneZoomState
		},
		-- To be remapped:
		-- CTRL+SHIFT+ALT	LeftArrow	AdjustPaneSize={"Left", 1}
		-- CTRL+SHIFT+ALT	RightArrow	AdjustPaneSize={"Right", 1}
		-- CTRL+SHIFT+ALT	UpArrow	AdjustPaneSize={"Up", 1}
		-- CTRL+SHIFT+ALT	DownArrow	AdjustPaneSize={"Down", 1}
		-- CTRL+SHIFT	Z	TogglePaneZoomState
	},
	color_scheme = 'Tomorrow Night Bright',
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = '3%',
		right = '3%',
		top = '2%',
		bottom = '2%',
	},
	wsl_domains = wsl_domains,
	inactive_pane_hsb = {
		saturation = 0.5,
		brightness = 0.3,
	},
	background = {
		{
			source = { File = 'C:\\Users\\joaqu\\Pictures\\Wallpapers\\E-ztrloV3FI6JTNxq8sx5QFMpymWO0J4zfMppzrXWnS0sKncgcEsu0MJOQqcC2f6h3o7JEBg8x43fS2k1DJN31QY7i1w-wQIWxYuX-w99CI=w3840-h2160-p-k-no-nd-mv.png' },
			opacity = 0.98,
			hsb = {
				brightness = 0.01,
				hue = 1.0,
				saturation = 1.0,
			}
		}
	},
}
