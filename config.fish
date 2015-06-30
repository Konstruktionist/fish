#!/usr/bin/env fish

# ---------------------------------------------------------
# 
# 	Setting up the fish shell to my liking
# 
# ---------------------------------------------------------

# Set architecture flags
set -gx ARCHFLAGS "-arch x86_64"

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
set -x LESS "-RSM~gIsw"

# Colorful man pages
# from http://pastie.org/pastes/206041/text
setenv -x LESS_TERMCAP_mb (set_color -o red)
setenv -x LESS_TERMCAP_md (set_color -o red)
setenv -x LESS_TERMCAP_me (set_color normal)
setenv -x LESS_TERMCAP_se (set_color normal)
setenv -x LESS_TERMCAP_so (set_color -b yellow -o black)
setenv -x LESS_TERMCAP_ue (set_color normal)
setenv -x LESS_TERMCAP_us (set_color -o green)

# grep colors
setenv -x GREP_COLOR '0;30;43' # black foreground, yellow background
setenv -x GREP_OPTIONS "--color=auto"

# setup syntax highlighting for cheatsheets
# set -Ux CHEATCOLORS true

# tell slrn what the default news server is
# setenv -x NNTPSERVER "reader.extremeusenet.nl"

# Latest build on OS X yosemite causes disk errors #1859
# this is a temporary fix for 2.1.1
function on_exit --on-process %self
  rm /tmp/fish.$USER/fishd.socket
end
