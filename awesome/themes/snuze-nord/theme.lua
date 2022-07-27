--[[

     Steamburn Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local watch = require("awful.widget.watch")
local spotify_widget = require("widgets.spotify-widget.spotify")
local logout_menu_widget = require("widgets.logout-menu-widget.logout-menu")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.zenburn_dir                               = require("awful.util").get_themes_dir() .. "zenburn"
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/steamburn"
-- theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "JetBrains Mono Nerd Font Medium 12"
theme.font_awesome                              = "Font Awesome 15"
theme.fg_normal                                 = "#D8DEE9"
theme.fg_focus                                  = "#81A1C1"
theme.fg_urgent                                 = "#CC9393"

theme.bg_normal                                 = "#424B5C80"
theme.bg_focus                                  = "#424B5C00"
theme.bg_urgent                                 = "#424B5C"

theme.border_width                              = dpi(2)
theme.border_normal                             = "#434c5e"
theme.border_focus                              = "#81A1C1"
theme.border_marked                             = "#CC9393"

theme.taglist_fg_focus                          = "#81A1C1"
theme.tasklist_bg_focus                         = "#424B5C00"
theme.tasklist_bg_normal                        = "#2E344000"
theme.tasklist_fg_focus                         = "#81A1C1"
-- theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
-- theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.menu_height                               = dpi(0)
theme.menu_width                                = dpi(140)
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.layout_txt_tile                           = "[t]"
theme.layout_txt_tileleft                       = "[l]"
theme.layout_txt_tilebottom                     = "[b]"
theme.layout_txt_tiletop                        = "[tt]"
theme.layout_txt_fairv                          = "[fv]"
theme.layout_txt_fairh                          = "[fh]"
theme.layout_txt_spiral                         = "[s]"
theme.layout_txt_dwindle                        = "[d]"
theme.layout_txt_max                            = "[m]"
theme.layout_txt_fullscreen                     = "[F]"
theme.layout_txt_magnifier                      = "[M]"
theme.layout_txt_floating                       = "[|]"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(5)
theme.titlebar_close_button_normal              = theme.zenburn_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.zenburn_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.zenburn_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.zenburn_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.zenburn_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.zenburn_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.zenburn_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.zenburn_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.zenburn_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.zenburn_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.zenburn_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.zenburn_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.zenburn_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.zenburn_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.zenburn_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.zenburn_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.zenburn_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.zenburn_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.zenburn_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.zenburn_dir.."/titlebar/maximized_focus_active.png"

-- lain related
theme.layout_txt_termfair                       = "[termfair]"
theme.layout_txt_centerfair                     = "[centerfair]"

local markup = lain.util.markup
local gray   = "#D8DEE9"
local highlight = "#81A1C1"

-- Textclock



local mytextclock = wibox.widget.textclock(markup.font(theme.font_awesome, markup(highlight, "  ") .. markup.font(theme.font, markup(gray, "%H:%M "))))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Roboto Mono Medium 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Mail IMAP check
--[[ to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup(gray, mail) .. count)
    end
})
--]]

-- MPD
theme.mpd = lain.widget.mpd({
    settings = function()
        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup.font(theme.font, markup(gray, artist) .. title))
    end
})

-- CPU
local cpu = lain.widget.sysload({
    settings = function()
        widget:set_markup(markup.font(theme.font_awesome, markup(highlight, "  ") .. markup.font(theme.font, markup(gray, load_1))))
    end
})

-- MEM
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font_awesome, markup(highlight, "  ") .. markup.font(theme.font, markup(gray, mem_now.used))))
    end
})

-- Can't create more than one fs widget
local fs = lain.widget.fs({
	settings  = function()
		widget:set_markup(markup.font(theme.font_awesome, markup(highlight, "  ") .. markup.font(theme.font, markup(gray, fs_now["/"].percentage .. "%"))))
		-- widget:set_markup(markup(gmc.color['teal900'], fs_now["/"].percentage .. "% "))
	end
})

-- /home fs
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    partition = "/home",
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10.5" },
})
--]]
--Volume bar

-- Battery
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc
        if bat_now.ac_status == 1 then perc = perc .. " Plug" end
        widget:set_markup(markup.font(theme.font, markup(gray, " Bat ") .. perc .. " "))
    end
})

-- Net checker
local net = lain.widget.net({
    settings = function()
        if net_now.state == "up" then net_state = "On"
        else net_state = "Off" end

        -- widget:set_markup(markup.font(theme.font, markup(gray, "  ") .. net_state .. " "))

        widget:set_markup(markup.font(theme.font_awesome, markup(highlight, "  ") .. markup.font(theme.font, markup(gray, net_state ))))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    settings = function()
        header = "  "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M"
        else
            vlevel = vlevel .. ""
        end
		

        widget:set_markup(markup.font(theme.font_awesome, markup(highlight, header) .. markup.font(theme.font, markup(gray, vlevel))))
        -- widget:set_markup(markup.font(theme.font_awesome, markup(gray, header) .. markup(highlight, vlevel)))
    end
})
--
-- Weather
--[[ to be set before use
theme.weather = lain.widget.weather({
    --APPID =
    city_id = 2643743, -- placeholder (London)
})
--]]

-- Separators
local spr = wibox.widget.textbox(markup.font("Roboto Mono Medium 11", " "))
-- local song  = wibox.widget.textbox(markup.font("JetBrains Mono 11", " "))

local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Textual layoutbox
    s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    awful.tag.attached_connect_signal(s, "property::selected", function () update_txt_layoutbox(s) end)
    awful.tag.attached_connect_signal(s, "property::layout", function () update_txt_layoutbox(s) end)
    s.mytxtlayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(28) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
			{
				s.mytaglist,
				-- fg     = '#ff0000',
				-- bg		= '#ff00ff',
				widget = wibox.container.background
			},
            -- s.mytaglist,
            spr,
            s.mytxtlayoutbox,
            --spr,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- wibox.widget.systray(),

            layout = wibox.layout.fixed.horizontal,
			{
				spotify_widget({
					font = 'Roboto Mono Medium 11',
					max_length = 100,
					show_tooltip = false,
					dim_when_paused = true,
					dim_opacity = 0.5
					-- play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
					-- pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg'
				}),
				-- fg     = '#ff0000',
				-- bg		= '#ff00ff',
				widget = wibox.container.background
			},

            -- spr,
			-- song,
            cpu.widget,
            spr,
            mem.widget,
            spr,
			fs.widget,
			spr,
            net.widget,
            spr,
			-- theme.weather.widget,
            theme.volume.widget,
            spr,
            mytextclock,
			logout_menu_widget{
				-- font = 'Play 14',
				-- onlock = function() awful.spawn.with_shell('i3lock-fancy') end
			},
			spr
        },
    }
end

return theme
