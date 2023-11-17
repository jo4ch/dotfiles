local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}

theme.font = "JetBrains Mono Nerd Font Medium 7"
theme.font_awesome = "Font Awesome 7"

theme.fg_normal = "#c2c5c8"
theme.fg_focus = "#C64B3E"
theme.fg_urgent = "#CC9393"

theme.bg_normal = "#00000070"
theme.bg_focus = "#424B5C00"
theme.bg_urgent = "#424B5C"

theme.border_width = dpi(1)
theme.border_normal = "#434c5e"
theme.border_focus = "#C64B3E"
theme.border_marked = "#CC9393"

theme.taglist_fg_focus = "#C64B3E"
theme.tasklist_bg_focus = "#424B5C00"
theme.tasklist_bg_normal = "#2E344000"
theme.tasklist_fg_focus = "#C64B3E"
-- theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
-- theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.menu_height = dpi(0)
theme.menu_width = dpi(0)
theme.layout_txt_tile = "[t]"
theme.layout_txt_tileleft = "[l]"
theme.layout_txt_tilebottom = "[b]"
theme.layout_txt_tiletop = "[tt]"
theme.layout_txt_fairv = "[fv]"
theme.layout_txt_fairh = "[fh]"
theme.layout_txt_spiral = "[s]"
theme.layout_txt_dwindle = "[d]"
theme.layout_txt_max = "[m]"
theme.layout_txt_fullscreen = "[F]"
theme.layout_txt_magnifier = "[M]"
theme.layout_txt_floating = "[|]"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(2)

local markup = lain.util.markup

-- Clock
local clock = wibox.widget.textclock(
    markup.font(
        theme.fg_focus,
        markup(theme.fg_focus, "") .. markup.font(theme.font, markup(theme.fg_normal, "%H:%M "))
    )
)
clock.font = theme.font

-- Filesystem usage
local fs = lain.widget.fs({
    settings = function()
        widget:set_markup(
            markup.font(
                theme.font_awesome,
                markup(theme.fg_focus, "  ")
                .. markup.font(theme.font, markup(theme.fg_normal, fs_now["/"].percentage .. "%"))
            )
        )
        -- widget:set_markup(markup(gmc.color['teal900'], fs_now["/"].percentage .. "% "))
    end,
})

-- Internet connection check
local net = lain.widget.net({
    settings = function()
        if net_now.state == "up" then
            net_state = "On"
        else
            net_state = "Off"
        end

        -- widget:set_markup(markup.font(theme.font, markup(gray, "  ") .. net_state .. " "))

        widget:set_markup(
            markup.font(
                theme.font_awesome,
                markup(theme.border_focus, "  ") .. markup.font(theme.font, markup(theme.fg_normal, net_state))
            )
        )
    end,
})

-- Separator
local separator = wibox.widget.textbox(markup.font(theme.font, " "))

local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Textual layoutbox
    s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    awful.tag.attached_connect_signal(s, "property::selected", function()
        update_txt_layoutbox(s)
    end)
    awful.tag.attached_connect_signal(s, "property::layout", function()
        update_txt_layoutbox(s)
    end)
    s.mytxtlayoutbox:buttons(my_table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 2, function()
            awful.layout.set(awful.layout.layouts[1])
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(19) })

    -- Add widgets to the wibox
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,

        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            {
                s.mytaglist,
                widget = wibox.container.background,
            },
            separator,
            s.mytxtlayoutbox,
            --spr,
            s.mypromptbox,
            separator,
        },

        -- Middle widget
        s.mytasklist,

        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            clock,
            separator,
        },
    })
end

return theme
