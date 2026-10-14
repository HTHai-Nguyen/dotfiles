from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
# from customWifi import Wlan
import subprocess

mod = "mod4"
terminal = "kitty"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen(["bash",home])

keys = [

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),

    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("pamixer --allow-boost -i 5"),
        desc="Increase volume"
        ),

    Key([], "XF86AudioLowerVolume",
        lazy.spawn("pamixer --allow-boost -d 5"),
        desc="Decrease volume"
        ),

    Key([], "XF86AudioMute",
        lazy.spawn("pamixer -t"),
        desc="Mute volume"
        ),

    Key([], "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        desc="Mute microphone"
        ),

    Key([], "XF86MonBrightnessUp",
        lazy.spawn(
           "brightnessctl s 5%+"
        ),
        desc="Increase brightness"
        ),

    Key([], "XF86MonBrightnessDown",
        lazy.spawn(
            "brightnessctl s 5%-"
        ),
        desc="Decrease brightness"
        ),

    Key([], "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc="Play/Pause"
        ),

    Key([], "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc="Next"
        ),
    Key([], "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc="Previous"
        ),
]

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [
    Group("1", label="\uf120"),
    Group("2", label="", matches=[Match(wm_class="firefox")]),
    Group("3", label="", matches=[Match(wm_class="chrome")]),
    Group("4", label="󰍳", matches=[Match(wm_class="minecraft")]),
    Group("5", label="\uf249", matches=[Match(wm_class="obsidian")]),
    Group("6", label="\uf075", matches=[Match(wm_class="discord")]),
]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.MonadTall(
    #     margin=9,
    #     border_on_single=True,
    #     border_focus="#0abdbd",
    #     border_normal="#014848",
    #     border_width=2,
    # ),
    layout.Columns(
        margin=9,
        border_on_single=True,
        border_focus="#0ABDBD",
        border_normal="#014848",
        border_width=2,
    ),
    layout.Max(
        border_focus="#0ABDBD",
        margin=50,
        single_margin=11,
        border_width=2,
    ),
    layout.Floating(
        margin=5,
        border_on_single=True,
        border_focus="#0abdbd",
        border_normal="#014848",
        border_width=2,
    ),
]

colors = [["#1f2428", "#1d2428"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#5f875f", "#5f875f"],
          ["#000000", "#000000"],
          ["#51afef", "#51afef"],
          ["#259ec1", "#259ec1"],
          ["#46d9ff", "#46d9ff"],
          ["#1f5b70", "#1f5b70"],
          ["#d84949", "#d84949"],
          ["#008080", "#008080"]]

widget_defaults = dict(
    font="JetBrainsMonoNerdFont",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

class WidgetTweaker:
    def __init__(self, func):
        self.format = func

@WidgetTweaker
def volume(output):
    if output.endswith('%'):
        volume = int(output[:-1])

        icons = {
            range(0, 33): '󰕿',
            range(33, 66): '󰖀',
            range(66, 150): '󰕾'
        }

        icon = icons[next(filter(lambda r: volume in r, icons.keys()))]

        return icon
    elif output == 'M':
        return '󰕿'
    else:
        return output

# def brightness(output):
#     if output.endswith('%'):
#         brightness = int(output[:-1])
#
#         icons = {
#             range(0, 33): '󰃞 ',  # Low brightness
#             range(33, 66): '󰃟 ',  # Medium brightness
#             range(66, 101): '󰃠 '   # High brightness
#         }
#
#         icon = icons[next(filter(lambda r: brightness in r, icons.keys()))]
#         return icon + str(brightness)
#     else:
#         return output
#
# def get_brightness():
#     try:
#         # Get brightness output (replace 'light' with your brightness command if different)
#         output = subprocess.check_output(["light", "-G"], text=True).strip()
#         # Convert to percentage
#         currentbrightness = f"{int(float(output))}%"
#         return brightness(currentbrightness)
#     except Exception as e:
#         return f"Error: {e}"
#
# brightness_widget = widget.GenPollText(
#     func=get_brightness,
#     update_interval=0.01,
#     fontsize=16,
#     background=colors[0],
#     foreground="ffffff",  # Adjust the color as needed
#     mouse_callbacks={
#         'Button4': lambda: subprocess.call(["brightnessctl", "s", "5%+"]),  # Increase brightness
#         'Button5': lambda: subprocess.call(["brightnessctl", "s", "5%-"])   # Decrease brightness
#     }
# )

batteryIcons = [
    '\uf240 ',
    '\uf241 ',
    '\uf242 ',
    '\uf243 ',
    '\uf244 ',
]


class CustomBattery(widget.Battery):
    def _get_icon(self, percent):
        """Return the appropriate battery icon based on percentage."""
        if percent is None:
            return '?'
        if percent >= 80.0:
            return batteryIcons[0]  # Full
        elif percent >= 60:
            return batteryIcons[1]  # 3/4
        elif percent >= 40:
            return batteryIcons[2]  # Half
        elif percent >= 20:
            return batteryIcons[3]  # 1/4
        else:
            return batteryIcons[4]  # Empty

    def build_string(self, status):
        """Override the text displayed by the Battery widget."""
        percent = status.percent * 100 if status.percent and status.percent <= 1 else status.percent
        char = self._get_icon(percent)
        return f"{char}"

def parse_app_name(text):
    """Parse the text to extract only the application name."""
    # Define patterns to strip from the window title
    for suffix in ["fakepickle@harsh", "Mozilla Firefox", "Visual Studio Code", "Obsidian"]:
        if suffix in text and suffix == "fakepickle@harsh":
            return "Alacritty"
        elif text.endswith(suffix) and suffix == "Mozilla Firefox":
            return "Firefox"
        elif text.endswith(suffix) and suffix == "Visual Studio Code":
            return "VS Code"
        elif suffix in text:
            return suffix
    return text

calendar_visible = False
def toggle_calendar():
    global calendar_visible
    if calendar_visible:
        qtile.cmd_spawn("eww close calendar")
    else:
        qtile.cmd_spawn("eww open calendar")
    calendar_visible = not calendar_visible

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename="~/pictures/arch-logo.png",
                    scale="False",
                    mouse_callbacks={'Button1':lazy.spawn({os.path.expanduser('~/.config/rofi/scripts/powermenu')})},
                    background=colors[0],
                ),
                widget.GroupBox(
                    fontsize = 24, font='JetBrainsMono Nerd Font Mono',
                    borderwidth = 4, rounded = False, padding=10,
                    active = colors[2], inactive = colors[11],
                    highlight_color = colors[1], highlight_method = "line",
                    this_current_screen_border = colors[10], this_screen_border = colors [10],
                    other_current_screen_border = colors[6], other_screen_border = colors[10],
                    foreground = colors[2], background = colors[0]
                ),
                widget.Spacer(
                    length=10,
                    background=colors[0],
                ),
                widget.CurrentLayout(
                    mode="icon",
                    background=colors[0],
                    fontsize=16,
                    scale=0.5,
                ),
                widget.CurrentLayout(
                    fontsize=16,
                    background=colors[0],
                ),
                widget.Prompt(
                    background=colors[0],
                ),
                widget.Spacer(
                    background=colors[0],
                ),
                widget.WindowName(
                    background=colors[0],
                    parse_text=parse_app_name,
                    fontsize=16,
                    font="JetBrainsMono Nerd Font",
                    width=bar.CALCULATED,  # Allow the widget to adjust dynamically
                    max_chars=60,  # Truncate if needed to fit the bar
                ),
                widget.Spacer(
                    background=colors[0],
                ),
                
                # brightness_widget,

                # CPU
                widget.CPU(                 
                    format = " {load_percent}%",
                    foreground = colors[2],
                    background = colors[0],
                    fontsize=16,
                    font="JetBrainsMono Nerd Font",
                    update_interval = 2,
                    mouse_callbacks = {
                        'Button1': lambda : qtile.cmd_spawn(f"{terminal} -e btop")
                    }
                ), 
                widget.Spacer(
                        length=15,
                        background=colors[0],
                ),

                widget.Memory(
                    format = " {MemUsed:.0f}{mm}",
                    foreground = colors[2],
                    background = colors[0],
                    fontsize=16,
                    font="JetBrainsMono Nerd Font",
                    update_interval = 2,
                    mouse_callbacks = {
                        'Button1': lambda : qtile.cmd_spawn(f"{terminal} -e htop")
                    }
                ),
                widget.Spacer(
                        length=15,
                        background=colors[0],
                ),

                widget.GenPollText( # Volume
                    update_interval=1,
                    func=lambda: "  " if subprocess.getoutput("pamixer --get-mute") == "true"
                    else f" {subprocess.getoutput('pamixer --get-volume')}%",
                    fontsize=18,
                    background=colors[0],
                ),
                widget.Spacer(
                    length=15,
                    background=colors[0],
                ),
                CustomBattery(
                    full_char="🔋",  # Full icon
                    update_interval=0.01,
                    fontsize=24,
                    background=colors[0],
                ),
                widget.Battery(
                    format="{percent:2.0%}",
                    background=colors[0],
                    fontsize=16,
                    update_interval=0.01,  # Update interval to monitor battery status
                    notify_below=10,     # Send notification if battery percentage goes below this
                    mouse_callbacks={'Button1':lazy.spawn(f'{os.path.expanduser("~/.config/qtile/scripts/battery.sh")}')},
                ),
                widget.Spacer(
                    length=10,
                    background=colors[0],
                ),
                # Wlan(
                #     ethernet_interface="enp5s0",
                #     ethernet_message="",
                #     interface="wlp4s0",  # Adjust to your wireless interface name
                #     format="{icon} {essid} {percent:2.0%}",
                #     disconnected_message="󰤭 Disconnected",
                #     fontsize=16,
                #     background=colors[0],
                #     use_ethernet=True,
                # ),
                widget.Spacer(
                    length=15,
                    background=colors[0],
                ),
                widget.Clock(
                    background=colors[0],
                    format=" %H:%M",
                    mouse_callbacks={
                        'Button1': toggle_calendar,
                    },
                    fontsize=16,
                ),
                widget.Spacer(
                    length=15,
                    background=colors[0],
                ),
                
                widget.Systray(
                    background=colors[0],
                ),
                widget.Spacer(
                    length=15,
                    background=colors[0],
                ),

                widget.QuickExit(
                        fontsize=24,
                        default_text="󰩈 ", countdown_format="󰩈 {}", 
                        padding=3,
                        background=colors[0],
                ),
            ],
            36,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "Qtile"
