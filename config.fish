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

# Add gem path to our $PATH as a first entry for commands
if status --is-login
  set PATH $HOME/.gem/ruby/2.0.0/bin $PATH
end

# expose PATH to graphical apps
#launchctl setenv PATH $PATH

# Setup the bookmark functionality
set -gx MARKPATH $HOME/.marks
command mkdir -p $MARKPATH

complete -c jump -f -a '(ls ~/.marks)'
complete -c unmark -f -a '(ls ~/.marks)'

# LESS with colors (options explained)
# R   allow raw control chars. ANSI only
# M   causes less to prompt even more verbosely than more
# S   cut off long lines, i.e. don't fold or wrap
# X   don't clear the sceen after quiting
# ~   causes lines after end of file to be displayed as blank lines
# g   highlight only last search matches
# i   smart case search
# s   causes consecutive blank lines to be squeezed into a single blank line
set -gx LESS "-RMSX~gis"

# Colorful man pages
# from http://pastie.org/pastes/206041/text
set -gx LESS_TERMCAP_mb (printf "\e[1;31m")        # begin blinking (red)
set -gx LESS_TERMCAP_md (printf "\e[1;91m")        # begin bold (light red)
set -gx LESS_TERMCAP_so (printf "\e[30;47m")       # begin standout-mode - info box (grey background, black text)
set -gx LESS_TERMCAP_us (printf "\e[04;36m")       # begin underline (cyan)
set -gx LESS_TERMCAP_se (printf "\e[0m")           # end standout-mode
set -gx LESS_TERMCAP_ue (printf "\e[0m")           # end underline
set -gx LESS_TERMCAP_me (printf "\e[0m")           # end mode

# grep colors
set -gx GREP_COLOR '4;32' # green underlined
set -gx GREP_OPTIONS "--color=auto"

# ls colors
set -gx LSCOLORS 'gxfxbgaeBxxfhehbaghbad'          # see man ls

# Settings for timing helper function
source ~/.config/fish/functions/fish_command_timer.fish
set fish_command_timer_enabled 1 # enable command timer
set fish_command_timer_color 808080 # light gray
set fish_command_timer_millis 1 # enable milli-seconds
set fish_command_timer_time_format '%H:%M:%S' # print 24 hour clock with minutes & seconds

# Change nvim cursor shape based on the mode we're in
set -gx NVIM_TUI_ENABLE_CURSOR_SHAPE 1

# Acces token for football stats
set -gx SOCCER_CLI_API_TOKEN "f8e416cdeeb24e33824e96b1bcfc3961"
