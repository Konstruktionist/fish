function prompt_git_status -d 'Write out the git status'

  # Try to get a branch name, if $branch is empty then this is not a git repo,
  #   and we have nothing to do
  set branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z "$branch"
    return
  end

  # Since we are in a git repo, set up status indicators/variables
  set git_arrows ""
  set git_arrow_up (set_color $fish_color_status; echo -n "▲"; set_color normal)
  set git_arrow_down (set_color $fish_color_status; echo -n "▼"; set_color normal)
  set staged
  set colon (set_color $fish_color_separator; echo -n ':')
  set obracket (set_color $fish_color_separator; echo -n '┤'; set_color normal)
  set cbracket (set_color $fish_color_separator; echo -n '├'; set_color normal)
  set space ' '
  set git_dir (git rev-parse --git-dir)

  # Get the SHA1 value of a branch
  set gitsha (git rev-parse --short HEAD ^/dev/null)

  # Get the status of the repo, to see if there are any changes, NOT counting
  # occurrences
  set status_index (git status --porcelain ^/dev/null | string sub -l 2 | sort -u)
  # Get the status of the repo, we use this to count number of changed files
  set counting_index (git status --porcelain ^/dev/null | string sub -l 2)

  # Handling clean repo's
  if test -z "$status_index"
    set clean_branch (set_color $fish_color_git_clean)
  end

  # Handling dirty repo's
  for i in $status_index
    if echo $i | grep '^[AMRCD]' >/dev/null
      set staged 1
    end

    set status_added 0
    set status_modified 0
    set status_renamed 0
    set status_deleted 0
    set status_untracked 0
    set status_unmerged 0
    for line in $counting_index
      if test "$line" = '??'
        set status_untracked 1
        set unt_counted (count (echo $counting_index | string match -ar '\?\?'))
        continue
      end
      if string match -r '^(?:AA|DD|U.|.U)$' "$line" >/dev/null
        set status_unmerged 1
        set unm_counted (count (echo $counting_index | string match -ar 'U.|.U|DD|AA'))
        continue
      end
      if string match -r '^(?:[ACDMT][ MT]|[ACMT]D)$' "$line" >/dev/null
        set status_added 1
        set add_counted (count (echo $counting_index | string match -ar 'A '))
      end
      if string match -r '^[ ACMRT]D$' "$line" >/dev/null
        set status_deleted 1
        set del_counted (count (echo $counting_index | string match -ar 'D | D'))
      end
      if string match -r '^.[MT]$' "$line" >/dev/null
        set status_modified 1
        set mod_counted (count (echo $counting_index | string match -ar 'M | M'))
      end
      if string match -e 'R' "$line" >/dev/null
        set status_renamed 1
        set ren_counted (count (echo $counting_index | string match -ar 'R '))
      end
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
  if test -z "$status_index"
    # Clean repo so we don't show the dirty state, but may have a difference with
    # upstream. Because it is the last item in the list it will not show if there
    # is no difference with upstream.
    echo -n "$colon$branch_name $sha $git_arrows"
  else
    # Dirty repo, so we show that with symbols, for upstream same logic
    # applies as for clean repo
    echo -n "$colon$branch_name $sha $obracket"
    if test $status_added -ne 0
      echo -n (set_color ffff00 --bold)"+$add_counted"
    end
    if test $status_modified -ne 0
      echo -n (set_color 00bfff --bold)"~$mod_counted"
    end
    if test $status_renamed -ne 0
      echo -n (set_color f39c12 --bold)"≫$ren_counted"
    end
    if test $status_deleted -ne 0
      echo -n (set_color ff8787 --bold)"✖︎$del_counted"
    end
    if test $status_untracked -ne 0
      echo -n (set_color f2ca27 --bold)"?$unt_counted"
    end
    if test $status_unmerged -ne 0
      echo -n (set_color aeabd3 --bold)"!$unm_counted"
    end
    echo -n "$cbracket$space$git_arrows"
  end
end
