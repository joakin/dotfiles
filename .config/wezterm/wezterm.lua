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

local font = nil
local font_size = 14
local useDefaultFrameFont = false
local function font_italic(font_name, regular_weight, italic)
  italic = italic == nil and true or italic

  config.font_rules = config.font_rules or {}

  -- Bold-and-italic
  table.insert(config.font_rules, {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = font_name,
      italic = italic,
      bold = true
    },
  })

  -- normal-intensity-and-italic
  table.insert(config.font_rules, {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font {
      family = font_name,
      weight = regular_weight or "Regular",
      italic = italic,
    },
  })

  -- half-intensity-and-italic (half-bright or dim)
  table.insert(config.font_rules, {
    intensity = 'Half',
    italic = true,
    font = wezterm.font {
      family = font_name,
      weight = 'Light',
      italic = italic,
    },
  })
end

local function font_bold(font_name, bold_weight)
  bold_weight = bold_weight or "Bold"

  config.font_rules = config.font_rules or {}

  table.insert(config.font_rules, {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font {
      family = font_name,
      weight = bold_weight,
    },
  })
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- Windows
elseif wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
  font_size = 16
  config.line_height = 1.4
  -- Weights: "Thin", "ExtraLight", "Light", "DemiLight", "Book", "Regular", "Medium", "DemiBold", "Bold", "ExtraBold", "Black", "ExtraBlack"
  -- font = wezterm.font('Maple Mono', { weight = 'Light' })
  font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Regular' })
  -- font_italic("Victor Mono", "DemiBold")
  font_italic("Codelia Ligatures")
  -- font_italic("Maple Mono", "Light")
  -- font = wezterm.font('Spline Sans Mono', { weight = 'Light' })
  -- font = wezterm.font('Xanh Mono', { weight = 'Regular' })
  -- font_size = 18
  -- font = wezterm.font('Monaspace Argon Var', { weight = 'Regular' })
  -- font = wezterm.font('Monaspace Krypton Var', { weight = 'Regular' })
  -- font = wezterm.font('Monaspace Neon Var', { weight = 'DemiLight' })
  -- font = wezterm.font('Monaspace Radon Var', { weight = 'Regular' })
  -- font = wezterm.font('Monaspace Xenon Var', { weight = 'Regular' })
  -- font_italic("Monaspace Radon Var", nil, false)
  -- font = wezterm.font('Comic Code Ligatures', { weight = 'Regular' })
  -- font_size = 15
  -- config.line_height = 1.6
  -- font = wezterm.font('Codelia Ligatures', { weight = 'Light' })
  -- font_size = 15
  -- font = wezterm.font('Operator Mono', { weight = 'Light' })
  -- font = wezterm.font('Operator Mono Lig', { weight = 'Light' })
  -- font = wezterm.font('Dank Mono', { weight = 'Regular' })
  -- font = wezterm.font('Share Tech Mono', { weight = 'Regular' })
  -- font = wezterm.font('Victor Mono', { weight = 'Regular' })
  -- font = wezterm.font('Script12 BT', { weight = 'Regular' })
  -- font_size = 20
  -- config.line_height = 1.2
  -- font = wezterm.font('Marista', { weight = 'Regular' })
  -- font_size = 24
  -- config.line_height = 0.9
  -- useDefaultFrameFont = true
  -- font = wezterm.font('Input Mono', { weight = 'Regular' })
  -- font = wezterm.font('Input Mono Narrow', { weight = 'Light' })
  -- font_bold("Input Mono Narrow", "Medium")
  -- font_italic("Maple Mono", "Light")
  -- font = wezterm.font('Sligoil', { weight = 'Regular' })
  -- font = wezterm.font('Steps Mono', { weight = 'Regular' })
  -- font = wezterm.font('Steps Mono', { weight = 'DemiBold' })
  -- font = wezterm.font('Olympe Mono', { weight = 'Regular' })
  -- font_size = 18
  -- font = wezterm.font('Azeret Mono', { weight = 'Regular' })
  -- font = wezterm.font('New Heterodox Mono', { weight = 'Regular' })
  -- font_size = 18
  -- config.line_height = 1.2
  -- font = wezterm.font('Ellograph CF', { weight = 'Book' })
  -- font = wezterm.font('Ra Mono', { weight = 'Regular' })
  -- font_size = 16
  -- config.line_height = 1.2
  -- font_italic("Codelia Ligatures", "Book")
  -- font = wezterm.font('PragmataPro for Powerline', { weight = 'Regular' })
  -- font = wezterm.font('Tchig Mono', { weight = 'Regular' })
  -- font = wezterm.font('Apercu Mono Pro', { weight = 'Regular' })

  -- font_italic("Victor Mono")
  -- font_italic("Dank Mono")
  -- font_italic("Codelia Ligatures")
  -- font_italic("Maple Mono", "Light")
  -- font_italic("Olympe Mono", nil, false)
  -- font_italic("Operator Mono Lig", "Light")
  --
  --
  -- font = wezterm.font('Departure Mono', { weight = 'Regular' })
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

    -- font = wezterm.font 'Fira Code Retina'
    font = wezterm.font('Rec Mono Linear', { weight = 'Thin' })
    -- font = wezterm.font('Rec Mono Casual', { weight = 'Thin' })
    -- font = wezterm.font('Rec Mono Duotone', { weight = 'Thin' })
    -- font = wezterm.font('MonoLisa Nerd Font', { weight = 'Light' })
    -- font = wezterm.font('Liga CPMono_v07 Plain', { weight = 'Thin' })
    -- font = wezterm.font 'Liga Share-TechMonoTrue'
    -- font = wezterm.font 'Syne Mono'
    -- font = wezterm.font 'Ligalex Mono'
    -- font = wezterm.font 'Liga Triplicate T3'
    -- font = wezterm.font 'LigaSrc Variable'
    -- font = wezterm.font 'Liga Courier Prime'
    -- font = wezterm.font 'Liga monoOne'
    -- font = wezterm.font 'Liga Office Code Pro D'
    -- font = wezterm.font('Jetbrains Mono', { weight = 'Thin' })
    -- font = wezterm.font('Liga InputMonoNarrow', { weight = 'Thin' })
    -- font = wezterm.font('Liga InputMono', { weight = 'Thin' })
    -- font = wezterm.font('Liga Inconsolata LGC', { weight = 'Thin' })
    -- font = wezterm.font('Liga Cousine', { weight = 'Thin' })
    -- font = wezterm.font('Liga Liberation Mono', { weight = 'Thin' })
    -- font = wezterm.font('SF Mono L', { weight = 'Thin' })
    -- font = wezterm.font('Liga Cousine', { weight = 'Thin' })
    -- font = wezterm.font('Dank Mono', { weight = 'Light' })
    font_size = 12
    config.line_height = 1.4
  else
    -- Other linux
  end
end

if font then
  config.font = font
end
config.font_size = font_size

config.keys = {
  {
    key = ',',
    mods = 'CTRL',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS' },
  },
  -- Apparently this helps with multiline in claude code
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },
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
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Right', 20 }
  },
  {
    key = 'h',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Left', 20 }
  },
  {
    key = 'j',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 }
  },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 }
  },
  {
    key = 'z',
    mods = 'ALT',
    action = wezterm.action.TogglePaneZoomState
  },
  -- To be remapped:
  -- CTRL+SHIFT+ALT  LeftArrow  AdjustPaneSize={"Left", 1}
  -- CTRL+SHIFT+ALT  RightArrow  AdjustPaneSize={"Right", 1}
  -- CTRL+SHIFT+ALT  UpArrow  AdjustPaneSize={"Up", 1}
  -- CTRL+SHIFT+ALT  DownArrow  AdjustPaneSize={"Down", 1}
  -- CTRL+SHIFT  Z  TogglePaneZoomState
}

-- config.color_scheme = 'GruvboxDark'
-- config.color_scheme = 'Tomorrow Night Bright'
config.color_scheme = 'Tokyo Night'
-- config.color_scheme = 'Gruvbox Light'

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

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.win32_system_backdrop = "Acrylic" -- "Mica" "Tabbed"

config.window_decorations = 'RESIZE'

if not useDefaultFrameFont then
  config.window_frame = {
    font = font,
    font_size = font_size,
  }
end

-- Disabled because <del> doesn't work in neovim
-- https://github.com/wez/wezterm/pull/5025
config.enable_kitty_keyboard = false

local function segments_for_right_status(window)
  local active_tab = window:active_tab()
  local panes_info = active_tab:panes_with_info()
  local pane_count = #panes_info
  local segments = {}

  -- Find the active pane and check if it's zoomed
  for _, pane_info in ipairs(panes_info) do
    if pane_info.is_active and pane_info.is_zoomed then
      table.insert(segments, string.format("Fullscreen · %d", pane_count))
      break
    end
  end

  table.insert(segments, wezterm.strftime('%a, %-d %b · %H:%M'))

  return segments
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to = bg
  local gradient_from = gradient_to:lighten(0.1)
  if #segments == 1 then
    gradient_from = bg
  end

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  wezterm.log_info(gradient)

  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
