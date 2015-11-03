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

#	Add /usr/local/bin/ to our $PATH as a first entry for commands
# if status --is-login
#   set PATH /usr/local/bin $PATH
# end

# expose PATH to graphical apps
launchctl setenv PATH $PATH

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
setenv -gx LESS_TERMCAP_mb (set_color d14548)             # begin blinking (red)
setenv -gx LESS_TERMCAP_md (set_color d14548)             # begin bold (red)
setenv -gx LESS_TERMCAP_me (set_color normal)             # end mode
setenv -gx LESS_TERMCAP_so (set_color -b yellow -o black) # begin standout-mode - info box
setenv -gx LESS_TERMCAP_se (set_color normal)             # end standout-mode
setenv -gx LESS_TERMCAP_us (set_color 6193bc)             # begin underline (blue)
setenv -gx LESS_TERMCAP_ue (set_color normal)             # end underline

# grep colors
setenv -gx GREP_COLOR '0;30;43' # black text, yellow background
setenv -gx GREP_OPTIONS "--color=auto"

# ls colors
setenv -gx LSCOLORS 'gxfxbdaebxxehehbaghbad'          # see man ls
