# What the prompt has to show
#
# 1. git branch name (if we are in a git repo)
#     display branch name in colors
# 2. state of the branch 
#     clean  = green
#     dirty  = red
#     staged = yellow
# 3. git sha hash
# 4. state of working directory
#     added     = + (with number of files)
#     modified  = ~ (with number of files)
#     renamed   = > (with number of files)
#     copied    = » (with number of files)
#     deleted   = x (with number of files)
#     untracked = ? (with number of files)
#     unmerged  = ! (with number of files)
#     stashes   = $ (with number)
#     staged    = ● (with number)
# 5. display up/down arrow if there is stuff to be pushed/pulled 

function prompt_git_status2
  # Is git installed? Without it there's nothing we can do
  if not command -sq git
    return 1
  end
  # Are we inside a git repository?
  set -l repo_info (command git rev-parse --gitdir --is-inside-git-dir --is-bare-repository --is-inside-work-tree HEAD ^/dev/null)
  test -n "$repo_info" # If this is empty it will return 1 and...
  or return            #  ... this will exit us to the calling function


  # Set up status indicators/variables
  set -g git_status_added '✚'
  set -g git_status_modified '~'
  set -g git_status_renamed '›'
  set -g git_status_copied '»'
  set -g git_status_deleted '✖︎'
  set -g git_status_untracked '?'
  set -g git_status_unmerged '!'
  set -g git_status_order added modified renamed copied deleted untracked unmerged
  set -g git_arrows ""
  set -g git_arrow_up "⇡"
  set -g git_arrow_down "⇣"
  set -g dirty_status
  set -g staged

  set -l start_git_prompt set_color $fish_color_separator; echo -n ":"; set_color normal
  # set -l branchname (git rev-parse --abbrev-ref HEAD ^/dev/null)
  # set -l status_index (git status --porcelain ^/dev/null | cut -c 1-2 | sort -u)

  set -l output (branch; echo -n ' '; state; echo -n ' ';sha; echo -n ' '; echo -n ' '; upstream)
  echo -n $output
end

# 1. Get the branch name and if we're not in a repo, send to /dev/null
function branch
  set -l branchname (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z "$branchname"
    return
  end

  set -l status_index (git status --porcelain ^/dev/null | cut -c 1-2 | sort -u)

  # 2. Get the state of the branch
  if test -z "$status_index"
    set_color $fish_color_git_clean; echo -n $branchname
    return
  end

  # Handling dirty repo's
  for i in $status_index
    if echo $i | grep '^[AMRCD]' >/dev/null
      set staged 1
    end

    switch $i
      case 'A '               ; set dirty_status $dirty_status added
      case 'M ' ' M'          ; set dirty_status $dirty_status modified
      case 'R '               ; set dirty_status $dirty_status renamed
      case 'C '               ; set dirty_status $dirty_status copied
      case 'D ' ' D'          ; set dirty_status $dirty_status deleted
      case '\?\?'             ; set dirty_status $dirty_status untracked
      case 'U*' '*U' 'DD' 'AA'; set dirty_status $dirty_status unmerged
    end
  end

  # Handling staging
  if set -q staged[1]
    set_color $fish_color_git_staged
  else
    set_color $fish_color_git_dirty
  end

  # set_color $fish_color_separator; echo -n ":"; set_color normal
  echo -n $start_git_prompt $branchname

end

# 3. Get sha value
function sha
  set git_sha (git rev-parse --short HEAD ^/dev/null)
  set_color $fish_color_git_sha; echo -n $git_sha; set_color normal
end

# Handling dirty states
function state
  set_color $fish_color_separator; echo -n '['

  for i in $git_status_order
    if contains $i in $dirty_status
      set -l color_name fish_color_git_$i
      set -l status_name git_status_$i

      set_color $$color_name; echo -n $$status_name
    end
  end

  set_color $fish_color_separator; echo -n ']'; set_color normal
end

# 5. Upstream info
function upstream
  set -l has_upstream (command git rev-parse --abbrev-ref '@{upstream}') # >/dev/null ^&1) #; and set -l has_upstream
  if set -q has_upstream
    set -l git_status (command git rev-list --left-right --count 'HEAD...@{upstream}') # | read -la git_status

    echo $git_status | read -l ahead behind

    # set -l git_commits_ahead $git_status[1]
    # set -l git_commits_behind $git_status[2]

    # If arrow is not 0, it means it's dirty
    if test "$ahead" -ne 0
      set git_arrows $git_arrow_up" "$ahead
    end

    if test "$behind" -ne 0
      set git_arrows $git_arrow_down" "$behind
    end

    set_color -o brgreen; echo -n " "$git_arrows
    set_color normal
  end
end

