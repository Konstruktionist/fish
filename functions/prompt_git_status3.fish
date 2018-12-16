function prompt_git_status3 -d 'Write out the git status'

  # Set up status indicators/variables
  set -l fish_prompt_git_status_added '✚'
  set -l fish_prompt_git_status_modified '~'
  set -l fish_prompt_git_status_renamed '›'
  set -l fish_prompt_git_status_copied '»'
  set -l fish_prompt_git_status_deleted '✖︎'
  set -l fish_prompt_git_status_untracked '?'
  set -l fish_prompt_git_status_unmerged '!'
  set -l fish_prompt_git_status_order added modified renamed copied deleted untracked unmerged
  set -l git_arrows ""
  set -l git_arrow_up "▲"
  set -l git_arrow_down "▼"
  set -l dirty_status
  set -l staged
  set -l colon (set_color $fish_color_separator; echo -n ':')
  set -l space ' '

  # Get the branch name and if we're not in a git repo, send to /dev/null
  set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z "$branch"
    return
  end

  # Get the SHA1 value of a branch and if we're not in a git repo, send to /dev/null
  set -l gitsha (git rev-parse --short HEAD ^/dev/null)

  # set_color $fish_color_separator; echo -n ':'

  # Get the status of the repo, to see if there are any changes, NOT counting occurences
  set -l status_index (git status --porcelain ^/dev/null | cut -c 1-2 | sort -u)

  # Handling clean repo's
  if test -z "$status_index"
    set -l clean_branch (set_color $fish_color_git_clean; echo -n $branch)
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
    set -l dirty_branch (set_color $fish_color_git_staged; echo -n $branch)
  else
    set -l dirty_branch (set_color $fish_color_git_dirty; echo -n $branch)
  end

  if test -z "$status_index"
    set branch_name $clean_branch
  else
    set branch_name $dirty_branch
  end

  # echo -n $repo_status

  # Handling sha's
  if test -n "$gitsha"
    set -l sha $gitsha
  end

  # Handling dirty states
  # set_color $fish_color_separator; echo -n '['
  for i in $fish_prompt_git_status_order
    if contains $i in $dirty_status
      set -l color_name fish_color_git_$i
      set -l status_name fish_prompt_git_status_$i

      set -l dirty state (set_color $$color_name; echo -n $$status_name)
    end
  end
  # set_color $fish_color_separator; echo -n ']'; set_color normal


  # Handling remote repo's
  command git rev-parse --abbrev-ref '@{upstream}' >/dev/null ^&1; and set -l has_upstream
  if set -q has_upstream
    command git rev-list --left-right --count 'HEAD...@{upstream}' | read -la git_status

    set -l git_commits_ahead $git_status[1]
    set -l git_commits_behind $git_status[2]

    # If either one of them is not 0, it means we're ahead/behind of remote
    if test "$git_commits_ahead" -ne "0"
      set git_arrows $git_arrow_up$git_commits_ahead
    end

    if test "$git_commits_behind" -ne "0"
      set git_arrows $git_arrow_down$git_commits_behind
    end

    # set_color $fish_color_status; echo -n " "$git_arrows
    # set_color normal
  end

  # Creating the prompt
  echo -n "$colon$branch_name$space$sha'['$dirty_state']'$git_arrows"
end
