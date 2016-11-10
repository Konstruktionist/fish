#!/usr/bin/env fish

# ---------------------------------------------------------
#
# 	Setting up the fish shell to my liking
#
# ---------------------------------------------------------

# Set architecture flags
set -U ARCHFLAGS "-arch x86_64"

# Set the editor
set -U EDITOR mate
# Let homebrew know about my preferred editor
setenv -gx HOMEBREW_EDITOR mate
setenv -gx VISUAL mate

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
setenv -gx LESS_TERMCAP_mb (printf "\e[1;31m")        # begin blinking (red)
setenv -gx LESS_TERMCAP_md (printf "\e[1;91m")        # begin bold (light red)
setenv -gx LESS_TERMCAP_me (printf "\e[0m")           # end mode
setenv -gx LESS_TERMCAP_se (printf "\e[0m")           # end standout-mode
setenv -gx LESS_TERMCAP_so (printf "\e[1;30;43m")     # begin standout-mode - info box (yellow background, bold black text)
setenv -gx LESS_TERMCAP_ue (printf "\e[0m")           # end underline
setenv -gx LESS_TERMCAP_us (printf "\e[04;36m")       # begin underline (cyan)

# grep colors
setenv -gx GREP_COLOR '1;30;43' # bright/bold black text, yellow background
setenv -gx GREP_OPTIONS "--color=auto"

# ls colors
setenv -gx LSCOLORS 'gxfxbgaeBxxfhehbaghbad'          # see man ls

# Settings for timing helper function
source ~/.config/fish/functions/helper_fish_command_timer.fish
set fish_command_timer_millis 1 # enable milli-seconds
set fish_command_timer_time_format '%d %b %H:%M:%S'
set fish_command_timer_export_cmd_duration_str 1

# Acces token for football stats
set -gx SOCCER_CLI_API_TOKEN "f8e416cdeeb24e33824e96b1bcfc3961"

# disable Google analytics for homebrew
set -gx HOMEBREW_NO_ANALYTICS 1

abbr tv transcode-video --mp4 --720p --target small --quick --audio-width all=stereo --add-subtitle nld
abbr vidl youtube-dl -f pg-nettv
abbr quad xattr -d com.apple.quarantine
