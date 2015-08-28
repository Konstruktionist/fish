#!/usr/bin/env fish

# ---------------------------------------------------------
#
# 	Setting up the fish shell to my liking
#
# ---------------------------------------------------------

# Set architecture flags
set -Ux ARCHFLAGS "-arch x86_64"

# Set the editor
set -Ux EDITOR mate

#	Add /usr/local/bin/ to our $PATH as a first entry for commands
if status --is-login
	set PATH /usr/local/sbin $PATH
   # Add bin in home directory to $PATH
   set PATH $HOME/bin $PATH
end

# expose PATH to graphical apps
# launchctl setenv PATH $PATH

# Setup the bookmark functionality
set -gx MARKPATH $HOME/.marks
command mkdir -p $MARKPATH

complete -c jump -f -a '(ls ~/.marks)'
complete -c unmark -f -a '(ls ~/.marks)'

# LESS with colors
# from http://blog.0x1fff.com/2009/11/linux-tip-color-enabled-pager-less.html
set -Ux LESS "-RSM~gis"

# Colorful man pages
# from http://pastie.org/pastes/206041/text
setenv -x LESS_TERMCAP_mb (set_color red)                # begin blinking
setenv -x LESS_TERMCAP_md (set_color red)                # begin bold
setenv -x LESS_TERMCAP_so (set_color -b yellow -o black) # begin standout-mode - info box
setenv -x LESS_TERMCAP_us (set_color green)              # begin underline
setenv -x LESS_TERMCAP_se (set_color normal)             # end standout-mode
setenv -x LESS_TERMCAP_ue (set_color normal)             # end underline
setenv -x LESS_TERMCAP_me (set_color normal)             # end mode

# grep colors
setenv -x GREP_COLOR '0;30;43' # black text, yellow background
setenv -x GREP_OPTIONS "--color=auto"

# ls colors
setenv -x LSCOLORS 'gxfxbdaebxxehehbaghbad'					# see man ls
