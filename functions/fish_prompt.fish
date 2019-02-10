function fish_prompt -d 'Write out the prompt'

  # What the prompt has to show
  #
  #   1. display username & host when in a ssh session or sudo -s locally
  #   2. current directory
  #      a. shortened to 'x' chars per directory if path length is > 60 chars long
  #           where 'x' is defined by fish_prompt_pwd_dir_length (default = 1)
  #           This can be changed in config.fish
  #      b. otherwise show full path
  #   3. git info:  (from prompt_git_status)
  #      a. git branch name (if we are in a git repo)
  #      b. wether or not the working copy is dirty
  #      c. git sha hash
  #      d. display up/down arrow if there is stuff to be pushed/pulled
  #   4. display prompt symbol 
  #      in red if last command exited with an error + leading error code in []

  set -l last_status $status
  set -l user (whoami)
  set -l host (hostname -s)
  set -l user_host "$user@$host"

  # Get the current working directory & simplify $HOME to ~
  set cur_wd (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')
  # Do we have to shorten the string?
  if test (string length $cur_wd) -gt 60
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 1
    set cur_wd (prompt_pwd)
  else
    set cur_wd $cur_wd
  end

  # 1. display username & host when in a ssh session or sudo -s locally
  # Ideally we show no user@host info when we are on the local machine even
  # when we are root. I would like to show just root on local machine after
  # we do sudo -s. However if we do  'sudo -s'  either local or over ssh we
  # have no information in our environment (env) to distinguish between the
  # two. So we show user@host when we are root & as a non-root user over ssh
  # and after sudo -s locally.
  # color of user@host is set by $user, either red (root) or blue (non-root)

  switch $user
    case root
      set_color -r red
      echo -n $user_host
      set_color normal
      echo -n ' '
    case '*'              # non-root
      # As non-root we can test if we have a SSH_TTY in our environment. If we
      # do we have an ssh-connection, and show a blue user@host info.
      # If we are on the local machine as a normal user we don't show user@host.
      if test -n "$SSH_TTY"
        set_color -r blue
        echo -n $user_host
        set_color normal
        echo -n ' '
      else
        echo -n ''
      end
  end

  # 2. current directory
  set_color $fish_color_cwd; echo -n $cur_wd; set_color normal

  # 3. Git info
  prompt_git_status
  echo    # effectivly sets a newline (\n)

  # 4. Prompt symbol
  if test "$last_status" -ne 0
    set_color $fish_color_error # Red
    echo -n "[$last_status]"
  end
  # prompt indicator = BLACK CIRCLE (U+25CF) followed by INTERROBANG (U+203D) and a space
  set_color -o; echo -n '●‽ '
  set_color normal
end
