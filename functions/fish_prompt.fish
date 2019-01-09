function fish_prompt -d 'Write out the prompt'

  # What the prompt has to show
  #
  #   1. display username & host when in a ssh session
  #   2. username if we're logged in as root on localhost
  #   3. current directory
  #      a. shortened to 'x' chars per directory if path length is > 60 chars long
  #           where 'x' is defined by fish_prompt_pwd_dir_length (default = 1)
  #           This can be changed in config.fish
  #      b. otherwise show full path
  #   4. git info:  (from prompt_git_status) 
  #      a. git branch name (if we are in a git repo)
  #      b. wether or not the working copy is dirty
  #      c. git sha hash
  #      d. display up/down arrow if there is stuff to be pushed/pulled
  #   5. display prompt symbol (in red if last command exited with an error)

  set -l last_status $status
  set -l user (whoami)

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

  # 1. ssh session
  if test -n "$SSH_CONNECTION"
    set -l host (hostname -s)

    # color of user@host is set by $user, either red (root) or blue (non-root)
    if test "$user" = "root"
      set user (set_color -r red)"$user"
    else
      set user (set_color -r blue)"$user"
    end

    set user_host "$user@$host"
    echo -n $user_host; set_color normal ; echo -n ' '
  end

  # 2. Are we logged in as root on localhost?
  if test -z "$SSH_CONNECTION"
    if test "$user" = "root"
      set user (set_color -r red)"$user"
      echo -n $user; set_color normal; echo -n ' '
    else
      set user ''
      echo -n $user
    end
  end

  # 3. current directory
  set_color $fish_color_cwd; echo -n $cur_wd; set_color normal

  # 4. Git info
  prompt_git_status
  echo    # effectivly sets a newline (\n)

  # 5. Prompt symbol
  if test "$last_status" -ne 0
    set_color $fish_color_error # Red
  end
  echo -n '▶︎'  # BLACK RIGHT-POINTING TRIANGLE (U+25B6 U+FE0E)
  set_color normal

end
