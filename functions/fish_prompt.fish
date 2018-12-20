function fish_prompt -d 'Write out the prompt'

  # What the prompt has to show
  #
  #   1. display username & host when in a ssh session
  #   2. current directory
  #       shortened to 'x' chars per directory if path length is > 60 chars long
  #         where 'x' is defined by fish_prompt_pwd_dir_length (default = 1)
  #         This can be changed in config.fish
  #       otherwise show full path
  #   3. git info:  (from prompt_git_status) 
  #      a. git branch name (if we are in a git repo)
  #      b. wether or not the working copy is dirty
  #      c. git sha hash
  #      d. display up/down arrow if there is stuff to be pushed/pulled
  #   4. display prompt symbol (in red if last command exited with an error)

  set -l last_status $status
  set -l ssh_root_color ff8787
  set -l ssh_user_color 6bb9f0

  # Get the current working directory & simplify $HOME to ~
  set cur_wd (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')
  # Do we have to shorten the string?
  if test (string length $cur_wd) -gt 60
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 1
    set cur_wd (prompt_pwd)
  else
    set cur_wd $cur_wd
    # set cur_wd (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')
  end

  # 1. ssh session
  if test -n "$SSH_CONNECTION"
    set -l host (hostname -s)
    set -l user (whoami)

    # color of user@host is set by $user, either red (root) or blue (non-root)
    if test "$user" = "root"
      set user (set_color -r $ssh_root_color)"$user"
    else
      set user (set_color -r $ssh_user_color)"$user"
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
