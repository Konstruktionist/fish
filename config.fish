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
  set PATH $HOME/.gem/ruby/2.3.0/bin $PATH
end

# expose PATH to graphical apps
#launchctl setenv PATH $PATH

# Setup the bookmark functionality
set -gx MARKPATH $HOME/.marks
command mkdir -p $MARKPATH

complete -c jump -f -a '(ls ~/.marks)'
complete -c unmark -f -a '(ls ~/.marks)'

# LESS with colors
# from http://blog.0x1fff.com/2009/11/linux-tip-color-enabled-pager-less.html
set -gx LESS "-RSM~gis"

# Colorful man pages
# from http://pastie.org/pastes/206041/text
setenv -gx LESS_TERMCAP_mb (printf "\e[1;31m")        # begin blinking (red)
setenv -gx LESS_TERMCAP_md (printf "\e[1;31m")        # begin bold (red)
setenv -gx LESS_TERMCAP_me (printf "\e[0m")           # end mode
setenv -gx LESS_TERMCAP_se (printf "\e[0m")           # end standout-mode
setenv -gx LESS_TERMCAP_so (printf "\e[1;30;43m")     # begin standout-mode - info box (yellow background, bold black text)
setenv -gx LESS_TERMCAP_ue (printf "\e[0m")           # end underline
setenv -gx LESS_TERMCAP_us (printf "\e[04;36m")       # begin underline (cyan)

# grep colors
setenv -gx GREP_COLOR '1;30;43' # bright/bold black text, yellow background
setenv -gx GREP_OPTIONS "--color=auto"

# ls colors
setenv -gx LSCOLORS 'gxfxbdaeBxxehehbaghbad'          # see man ls

set -gx SOCCER_CLI_API_TOKEN "f8e416cdeeb24e33824e96b1bcfc3961"

# disable Google analytics for homebrew
set -gx HOMEBREW_NO_ANALYTICS 1

abbr tv transcode-video --mp4 --720p --target small --quick --audio-width all=stereo --add-subtitle nld
abbr vidl youtube-dl -f pg-nettv
