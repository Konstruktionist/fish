function fish_prompt -d 'Write out the prompt'

  # What the prompt has to show
  #
  #   1. display username & host when in a ssh session
  #   2. current directory
  #   3. 1. git branch name (if we are in a git repo)
  #      2. wether or not the working copy is dirty
  #      3. git sha hash
  #      4. display up/down arrow if there is stuff to be pushed/pulled (this
  #           will probably go into the prompt_git_status function)
  #   4. display prompt symbol (in red if last command exited with an error)

  set last_status $status

  # Get the current working directory & simplify $HOME to ~
  set -l cur_wd (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')

  # 1. ssh session
  if test -n "$SSH_CONNECTION"
    set -l host (hostname -s)
    set -l user (whoami)

    # color of user@host is set by $user, either red (root) or blue (non-root)
    if test "$user" = "root"
      set user (set_color -r $fish_color_error)"$user"
    else
      set user (set_color 6bb9f0)"$user"
    end

    set user_host "$user@$host"; echo -n $user_host; set_color normal ; echo -n " "
  end

  # 2. current directory
  set_color $fish_color_cwd; echo -n $cur_wd; set_color normal

  # 3. Git info
  prompt_git_status
  echo    # effectivly sets a newline (\n)

  # 4. Prompt symbol
  if test "$last_status" -ne 0
    set_color $fish_color_error # Red
  end
   echo -n '▶︎ '
  set_color normal

end
