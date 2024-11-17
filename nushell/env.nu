# Nushell Environment Config File
#
# version = "0.90.1"

def create_left_prompt [] {
    let home =  $nu.home-path

    # Perform tilde substitution on dir
    # To determine if the prefix of the path matches the home dir, we split the current path into
    # segments, and compare those with the segments of the home dir. In cases where the current dir
    # is a parent of the home dir (e.g. `/home`, homedir is `/home/user`), this comparison will
    # also evaluate to true. Inside the condition, we attempt to str replace `$home` with `~`.
    # Inside the condition, either:
    # 1. The home prefix will be replaced
    # 2. The current dir is a parent of the home dir, so it will be uneffected by the str replace
    let dir = (
        if ($env.PWD | path split | zip ($home | path split) | all { $in.0 == $in.1 }) {
            ($env.PWD | str replace $home "~")
        } else {
            $env.PWD
        }
    )

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X %p') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

if $nu.is-login {
$env.CMD_DURATION_MS = '151'
$env.COLORTERM = 'truecolor'
$env.CUDA_PATH = '/opt/cuda'
$env.DBUS_SESSION_BUS_ADDRESS = 'unix:path=/run/user/1000/bus'
$env.DEBUGINFOD_URLS = 'https://debuginfod.archlinux.org '
$env.DIRS_LIST = '[/home/mrteathyme]'
$env.DIRS_POSITION = '0'
$env.DISPLAY = ':0'
$env.ENV_CONVERSIONS = '{PATH: {from_string: <Closure 1212>, to_string: <Closure 1214>}, Path: {from_string: <Closure 1216>, to_string: <Closure 1218>}}'
$env.GREETD_SOCK = '/run/greetd-18585.sock'
$env.HOME = '/home/mrteathyme'
$env.HYPRLAND_CMD = 'Hyprland'
$env.HYPRLAND_INSTANCE_SIGNATURE = '84ab8d11e8951a6551d1e1bf87796a8589da6d47_1709156044'
$env.LANG = 'en_AU.UTF-8'
$env.LAST_EXIT_CODE = '0'
$env.LOGNAME = 'mrteathyme'
$env.LOG_ANSI = '{CRITICAL: , ERROR: , WARNING: , INFO: , DEBUG: }'
$env.LOG_LEVEL = '{CRITICAL: 50, ERROR: 40, WARNING: 30, INFO: 20, DEBUG: 10}'
$env.LOG_PREFIX = '{CRITICAL: CRT, ERROR: ERR, WARNING: WRN, INFO: INF, DEBUG: DBG}'
$env.LOG_SHORT_PREFIX = '{CRITICAL: C, ERROR: E, WARNING: W, INFO: I, DEBUG: D}'
$env.MAIL = '/var/spool/mail/mrteathyme'
$env.MOTD_SHOWN = 'pam'
$env.MOZ_ENABLE_WAYLAND = '1'
$env.NU_LIB_DIRS = '[/home/mrteathyme/.config/nushell/scripts]'
$env.NU_LOG_DATE_FORMAT = '%Y-%m-%dT%H:%M:%S%.3f'
$env.NU_LOG_FORMAT = '%ANSI_START%%DATE%|%LEVEL%|%MSG%%ANSI_STOP%'
$env.NU_PLUGIN_DIRS = '[/home/mrteathyme/.config/nushell/plugins]'
$env.NU_VERSION = '0.90.1'
$env.NVCC_PREPEND_FLAGS = '-ccbin /opt/cuda/bin'
$env.OLDPWD = '/home/mrteathyme'
$env.PATH = '[/usr/local/sbin, /usr/local/bin, /usr/bin, /opt/cuda/bin, /opt/cuda/nsight_compute, /opt/cuda/nsight_systems/bin, /usr/bin/site_perl, /usr/bin/vendor_perl, /usr/bin/core_perl, /usr/lib/rustup/bin]'
$env.PROMPT_COMMAND = '<Closure 1205>'
$env.PROMPT_COMMAND_RIGHT = '<Closure 1206>'
$env.PROMPT_INDICATOR = '<Closure 1207>'
$env.PROMPT_INDICATOR_VI_INSERT = '<Closure 1208>'
$env.PROMPT_INDICATOR_VI_NORMAL = '<Closure 1209>'
$env.PROMPT_MULTILINE_INDICATOR = '<Closure 1210>'
#$env.PWD = '/home/mrteathyme'
$env.QT_QPA_PLATFORMTHEME = 'qt5ct'
$env.SHELL = '/usr/bin/bash'
$env.SHLVL = '0'
$env.TERM = 'xterm-256color'
$env.TERM_PROGRAM = 'WezTerm'
$env.TERM_PROGRAM_VERSION = '20240203-110809-5046fc22'
$env.USER = 'mrteathyme'
$env.WAYLAND_DISPLAY = 'wayland-1'
$env.WEZTERM_CONFIG_DIR = '/home/mrteathyme/.config/wezterm'
$env.WEZTERM_CONFIG_FILE = '/home/mrteathyme/.config/wezterm/wezterm.lua'
$env.WEZTERM_EXECUTABLE = '/usr/bin/wezterm-gui'
$env.WEZTERM_EXECUTABLE_DIR = '/usr/bin'
$env.WEZTERM_PANE = '0'
$env.WEZTERM_UNIX_SOCKET = '/run/user/1000/wezterm/gui-sock-39562'
$env.XCURSOR_SIZE = '24'
$env.XDG_BACKEND = 'wayland'
$env.XDG_CURRENT_DESKTOP = 'Hyprland'
$env.XDG_RUNTIME_DIR = '/run/user/1000'
$env.XDG_SEAT = 'seat0'
$env.XDG_SESSION_CLASS = 'greeter'
$env.XDG_SESSION_ID = '4'
$env.XDG_SESSION_TYPE = 'wayland'
$env.XDG_VTNR = '1'
$env._ = '/usr/bin/wezterm'
$env._JAVA_AWT_WM_NONREPARENTING = '1'
}




# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
$env.PATH = ($env.PATH | split row (char esep) | prepend '/usr/bin/')
$env.GTK_THEME = 'catppuccin-mocha-pink-standard+default'

zoxide init --hook pwd --cmd cd nushell | save -f ~/.zoxide.nu
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
