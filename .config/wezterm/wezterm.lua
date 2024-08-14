local wezterm = require 'wezterm'

local function is_wsl()
	local f = io.open("/proc/version", "r")
	if f then
		local content = f:read("*all")
		f:close()
		return content:lower():match("microsoft") ~= nil
	end
	return false
end

local config = wezterm.config_builder()

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Windows
elseif wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
	config.font = wezterm.font('Maple Mono', { weight = 'Thin' }) -- "Thin", "ExtraLight", "Light", "DemiLight", "Book", "Regular"
	config.font_size = 16
	config.line_height = 1.4
else
	if is_wsl() then
		local wsl_domains = wezterm.default_wsl_domains()
		local wsl_ubuntu = 'WSL:Ubuntu-20.04'

		for _, dom in ipairs(wsl_domains) do
			if dom.name == wsl_ubuntu then
				dom.default_cwd = '~'
			end
		end

		config.default_domain = wsl_ubuntu
		config.wsl_domains = wsl_domains

		-- config.font = wezterm.font 'Fira Code Retina'
		config.font = wezterm.font('Rec Mono Linear', { weight = 'Thin' })
		-- config.font = wezterm.font('Rec Mono Casual', { weight = 'Thin' })
		-- config.font = wezterm.font('Rec Mono Duotone', { weight = 'Thin' })
		-- config.font = wezterm.font('MonoLisa Nerd Font', { weight = 'Light' })
		-- config.font = wezterm.font('Liga CPMono_v07 Plain', { weight = 'Thin' })
		-- config.font = wezterm.font 'Liga Share-TechMonoTrue'
		-- config.font = wezterm.font 'Syne Mono'
		-- config.font = wezterm.font 'Ligalex Mono'
		-- config.font = wezterm.font 'Liga Triplicate T3'
		-- config.font = wezterm.font 'LigaSrc Variable'
		-- config.font = wezterm.font 'Liga Courier Prime'
		-- config.font = wezterm.font 'Liga monoOne'
		-- config.font = wezterm.font 'Liga Office Code Pro D'
		-- config.font = wezterm.font('Jetbrains Mono', { weight = 'Thin' })
		-- config.font = wezterm.font('Liga InputMonoNarrow', { weight = 'Thin' })
		-- config.font = wezterm.font('Liga InputMono', { weight = 'Thin' })
		-- config.font = wezterm.font('Liga Inconsolata LGC', { weight = 'Thin' })
		-- config.font = wezterm.font('Liga Cousine', { weight = 'Thin' })
		-- config.font = wezterm.font('Liga Liberation Mono', { weight = 'Thin' })
		-- config.font = wezterm.font('SF Mono L', { weight = 'Thin' })
		-- config.font = wezterm.font('Liga Cousine', { weight = 'Thin' })
		-- config.font = wezterm.font('Dank Mono', { weight = 'Light' })
		config.font_size = 12
		config.line_height = 1.4
	else
		-- Other linux
	end
end

config.keys = {
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
}
-- config.color_scheme = 'Tomorrow Night Bright'
config.color_scheme = 'Tokyo Night'

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = '3%',
	right = '3%',
	top = '2%',
	bottom = '2%',
}
config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.3,
}

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.win32_system_backdrop = "Acrylic" -- "Mica" "Tabbed"

config.window_decorations = 'RESIZE'

return config
