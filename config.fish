#!/usr/bin/env fish

# ---------------------------------------------------------
#
# 	Setting up the fish shell to my liking
#
# ---------------------------------------------------------

# Set architecture flags
set -gx ARCHFLAGS "-arch x86_64"

# Set the editor
set -gx EDITOR mate
# Let homebrew know about my preferred editor
set -gx HOMEBREW_EDITOR mate
set -gx VISUAL mate

# NOTE: Do NOT add path's to $PATH here
#  Why? See: https://fishshell.com/docs/current/tutorial.html#tut_path
# ====================================================================================

# expose PATH to graphical apps
#launchctl setenv PATH $PATH

# Setup the bookmark functionality
set -gx MARKPATH $HOME/.marks
command mkdir -p $MARKPATH

# setup ripgrep's config path
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc

complete -c jump -f -a '(ls ~/.marks)'
complete -c unmark -f -a '(ls ~/.marks)'

# LESS with colors (options explained)
# F   automatically exit if entire file fits on the first screen
# R   allow raw control chars. ANSI only
# M   causes less to prompt even more verbosely than more
# S   cut off long lines, i.e. don't fold or wrap
# X   don't clear the sceen after quiting
# ~   causes lines after end of file to be displayed as blank lines
# g   highlight only last search matches
# i   smart case search
# s   causes consecutive blank lines to be squeezed into a single blank line
set -gx LESS "-FRMSX~gis"

# Colorful man pages
# from http://stackoverflow.com/questions/34265221/how-to-colorize-man-page-in-fish-shell
set -gx LESS_TERMCAP_mb \e'[1;31m'        # begin blinking (red)
set -gx LESS_TERMCAP_md \e'[1;91m'        # begin bold (light red)
set -gx LESS_TERMCAP_so \e'[30;47m'       # begin standout-mode - info box (grey background, black text)
set -gx LESS_TERMCAP_us \e'[04;36m'       # begin underline (cyan)
set -gx LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -gx LESS_TERMCAP_ue \e'[0m'           # end underline
set -gx LESS_TERMCAP_me \e'[0m'           # end mode

# grep colors
set -gx GREP_COLOR '4;32'                 # green underlined

# ls colors
set -gx LSCOLORS 'gxfxbgdxBxxfhehbagabad'          # see man ls

# Settings for timing helper function
set fish_command_timer_enabled 1                # enable command timer
set fish_command_timer_color 808080             # light gray
set fish_command_timer_millis 1                 # enable milli-seconds
set fish_command_timer_time_format '%H:%M:%S'   # 24 hour clock with minutes & seconds

# Get access to tokens
source ~/.my_tokens

