function prompt_git_status3 -d 'Write out the git status'

  # Try to get a branch name, if $branch is empty then this is not a git repo,
  #   and we have nothing to do
  set branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z "$branch"
    return
  end

  # Since we are in a git repo, set up status indicators/variables
  set fish_prompt_git_status_added '✚'
  set fish_prompt_git_status_modified '~'
  set fish_prompt_git_status_renamed '›'
  set fish_prompt_git_status_copied '»'
  set fish_prompt_git_status_deleted '✖︎'
  set fish_prompt_git_status_untracked '?'
  set fish_prompt_git_status_unmerged '!'
  set fish_prompt_git_status_order added modified renamed copied deleted untracked unmerged
  set git_arrows ""
  set git_arrow_up (set_color $fish_pager_color_prefix; echo -n "▲"; set_color normal)
  set git_arrow_down (set_color $fish_pager_color_prefix; echo -n "▼"; set_color normal)
  set dirty_status
  set staged
  set colon (set_color $fish_color_separator; echo -n ':')
  set open_bracket (set_color $fish_color_separator; echo -n '['; set_color normal)
  set close_bracket (set_color $fish_color_separator; echo -n ']'; set_color normal)
  set space ' '

  # Get the SHA1 value of a branch
  set gitsha (git rev-parse --short HEAD ^/dev/null)

  # Get the status of the repo, to see if there are any changes, NOT counting occurences
  set status_index (git status --porcelain ^/dev/null | cut -c 1-2 | sort -u)
  # Get the status of the repo, we use this to count occurences of changes
  set counting_index (git status --porcelain ^/dev/null | cut -c 1-2)

  # Handling clean repo's
  if test -z "$status_index"
    set clean_branch (set_color $fish_color_git_clean)
  end

  # Handling dirty repo's
  for i in $status_index
    if echo $i | grep '^[AMRCD]' >/dev/null
      set staged 1
    end

    switch $i
      case 'A '               ; set dirty_status $dirty_status added; set counted (count $counting_index)
      case 'M ' ' M'          ; set dirty_status $dirty_status modified; set counted (count $counting_index)
      case 'R '               ; set dirty_status $dirty_status renamed; set counted (count $counting_index)
      case 'C '               ; set dirty_status $dirty_status copied; set counted (count $counting_index)
      case 'D ' ' D'          ; set dirty_status $dirty_status deleted; set counted (count $counting_index)
      case '\?\?'             ; set dirty_status $dirty_status untracked; set counted (count $counting_index)
      case 'U*' '*U' 'DD' 'AA'; set dirty_status $dirty_status unmerged; set counted (count $counting_index)
    end
  end

  # Handling staging
  if set -q staged[1]
    set dirty_branch (set_color $fish_color_git_staged)
  else
    set dirty_branch (set_color $fish_color_git_dirty)
  end

  if test -z "$status_index"
    set branch_name ( echo -n "$clean_branch$branch")
  else
    set branch_name (echo -n "$dirty_branch$branch")
  end

  # Handling sha's
  if test -n "$gitsha"
    set sha (set_color $fish_color_git_sha; echo -n "$gitsha")
  end

  # Handling dirty states
  for i in $fish_prompt_git_status_order
    if contains $i in $dirty_status
      set color_name fish_color_git_$i
      set status_name fish_prompt_git_status_$i
      # set counted (count fish_prompt_git_status_$i)

      set dirty_state (set_color $$color_name; echo -n $$status_name; set_color $fish_color_dimmed; echo -n $counted; set_color normal)
    end
  end

  # Handling remote repo's
  command git rev-parse --abbrev-ref '@{upstream}' >/dev/null ^&1; and set has_upstream
  if set -q has_upstream
    command git rev-list --left-right --count 'HEAD...@{upstream}' | read -la git_status

    set git_commits_ahead $git_status[1]
    set git_commits_behind $git_status[2]

    # If either one of them is not 0, it means we're ahead/behind of remote
    if test "$git_commits_ahead" -ne "0"
      set git_arrows $git_arrow_up$git_commits_ahead
    end

    if test "$git_commits_behind" -ne "0"
      set git_arrows $git_arrow_down$git_commits_behind
    end

    # If both of them are not 0, we have diverged?
    if test "$git_commits_ahead" -ne "0"; and test "$git_commits_behind" -ne "0"
      set git_arrows $git_arrow_up$git_commits_ahead$space$git_arrow_down$git_commits_behind
    end
  end

  # Creating the prompt
  if test -z "$dirty_state"
    # Clean repo so we don't show the dirty state, but may have a difference with
    # upstream. Because it is the last item in the list it will not show if there
    # is no difference with upstream.
    echo -n "$colon$branch_name$space$sha$space$git_arrows"
  else
    # Dirty repo, so we show the that with symbols, for upstream same logic
    # applies as for clean repo
    echo -n "$colon$branch_name$space$sha$space$open_bracket$dirty_state$close_bracket$space$git_arrows"
  end
end
