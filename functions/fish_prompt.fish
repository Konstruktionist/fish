function fish_prompt -d 'Write out the prompt'

  # What the prompt has to show
  #
  #   1. display username & host when in a ssh session
  #   2. current directory
  #   3. 1. git branch name (if we are in a git repo)
  #      2. wether or not the working copy is dirty
  #      3. git sha hash
  #      4. display up/down arrow if there is stuff to be pushed/pulled
  #   4. display prompt symbol (in red if last command exited with an error)

  set last_status $status
  set user_host ""

  # Set our colours
  # set -l normal_user_color $fish_color_normal
  set -l cwd_color $fish_color_cwd

  # Get the current values

  set -l cur_wd (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')
  set -l cur_user (whoami)
  set -l cur_host (hostname -s)

  # 1. ssh session
  if test -n "$SSH_CONNECTION"
    set -l host (hostname -s)
    set -l user (whoami)

    if test "$user" = "root"
      set user (set_color -r $fish_color_error)"$user" # Red if we're root
    else
      set user (set_color 6bb9f0)"$user" # Blue if not root
    end

    set user_host "$user@$host:"; set_color normal
    echo -n $user_host
  end

  # 2. current directory
  set_color $cwd_color; echo -n $cur_wd; set_color normal

  # 3. Git info
  prompt_git_status
  echo

  # 4. Prompt symbol
  if test "$last_status" -ne 0
    set_color $fish_color_error # Red
  end
   echo -n '▶︎ '
  set_color normal

end
