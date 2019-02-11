# With thanks to Leonard Hecker who reworked the sorin theme for fish.
# Mostly for its logic, see:
# https://github.com/fish-shell/fish-shell/blob/082450b1e711c75f6722bf7d8651cda8f835fd1e/share/tools/web_config/sample_prompts/sorin.fish#L111-L140

function prompt_git_status -d 'Write out the git status'

  # Try to get a branch name, if $branch is empty then this is not a git repo,
  #   and we have nothing to do
  set branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if test -z "$branch"
    return
  end

  # Colors
  #   branch
  set color_git_clean (set_color 3cf73c)              # green
  set color_git_staged (set_color f1f227)             # bright yellow
  set color_git_dirty (set_color ff8787)              # red
  #  states
  set color_git_added (set_color ffff00 --bold)       # yellow
  set color_git_deleted (set_color ff8787 --bold)     # red
  set color_git_modified (set_color d6affe --bold)    # purple
  set color_git_renamed (set_color 00bfff --bold)     # blue
  set color_git_unmerged (set_color ff8787 --bold)    # red
  set color_git_untracked (set_color f2ca27 --bold)   # yellow
  set color_git_stashed (set_color cyan)
  #  other
  set color_git_sha (set_color a9a9a9)                # light grey
  set color_separator (set_color abb7b7)              # grey
  set color_arrow (set_color ff8c00)                  # orange
  set color_reset (set_color normal)

  set git_arrows ""
  set git_arrow_up $color_arrow'▲'$color_reset
  set git_arrow_down $color_arrow'▼'$color_reset
  set staged
  set colon $color_separator':'
  set obracket $color_separator'┤'$color_reset
  set cbracket $color_separator'├'$color_reset
  set space ' '

  # Get the status of the repo, to see if there are any changes, NOT counting
  # occurrences
  set status_index (git status --porcelain 2> /dev/null | string sub -l 2 | sort -u)
  # Get the status of the repo, we use this to iterate over the occuring states
  set counting_index (git status --porcelain 2> /dev/null | string sub -l 2)

  # Handling clean repo's
  if test -z "$status_index"
    set clean_branch $color_git_clean
  end

  # Handling dirty repo's
  for status_chars in $status_index
    if echo $status_chars | grep '^[AMRCD]' > /dev/null
      set staged 1
    end

    set status_added 0
    set status_modified 0
    set status_renamed 0
    set status_deleted 0
    set status_untracked 0
    set status_unmerged 0
    for line in $counting_index
        #  NOTE: The method below doesn't work.
        #   set add_counted (count (echo $counting_index | string match -ar 'A |AD|AM|D |M.'))
        #  Because the echo $counting_index puts the characters on one line we
        #  wind up with something like:
        #  A   D ??
        #  which is seen as a match with A-space & D-space & gives a count of 2
        #  instead of A-space space-D which would give the correct count of 1
        #  Replacing $counting_index with the actual call does work.
      if test "$line" = '??'
        set status_untracked 1
        set unt_counted (count (git status --porcelain 2> /dev/null  | string match -ar '\?\?'))
        continue
      end
      if string match -r '^(?:AA|DD|U.|.U)$' "$line" > /dev/null
        set status_unmerged 1
        set unm_counted (count (git status --porcelain 2> /dev/null | string match -ar 'AA|UU|DU|UD'))
        continue
      end
      if string match -r '^(?:[ACDMT][ MT]|[ACMT]D)$' "$line" > /dev/null
        set status_added 1
        set add_counted (count (git status --porcelain 2> /dev/null | string sub -l 2 | string match -ar 'A |AD|AM|D |M.'))
      end
      if string match -r '^[ ACMRT]D$' "$line" > /dev/null
        set status_deleted 1
        set del_counted (count (git status --porcelain 2> /dev/null | string match -ar 'AD| D|MD|RD|D '))
      end
      if string match -r '^.[MT]$' "$line" > /dev/null
        set status_modified 1
        set mod_counted (count (git status --porcelain 2> /dev/null | string match -ar 'AM|MM|RM| M'))
      end
      if string match -e 'R' "$line" > /dev/null
        set status_renamed 1
        set ren_counted (count (git status --porcelain 2> /dev/null | string match -ar 'R '))
      end
    end
  end

  # Handling staging
  if set -q staged[1]
    set dirty_branch $color_git_staged
  else
    set dirty_branch $color_git_dirty
  end

  if test -z "$status_index"
    set branch_name $clean_branch$branch
  else
    set branch_name $dirty_branch$branch
  end

  # Handling sha's
  #   Get the SHA1 value of current branch
  set gitsha (git rev-parse --short HEAD 2> /dev/null)
  set sha $color_git_sha$gitsha

  # Handling stash status
  # (git stash list) is very slow. => Avoid using it.
  set status_stashed 0
  if test -f "$git_dir/refs/stash"
    set status_stashed 1
  else if test -r "$git_dir/commondir"
    read -d \n -l commondir <"$git_dir/commondir"
    if test -f "$commondir/refs/stash"
      set status_stashed 1
    end
  end

  # Handling remote repo's
  command git rev-parse --abbrev-ref '@{upstream}' > /dev/null 2>&1; and set has_upstream
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
    # Clean repo so we don't show the states, but may have a difference with
    # upstream or have something stashed. Show those if this is the case
    echo -n "$colon$branch_name $sha $git_arrows"
    if test $status_stashed -ne 0
      echo -n " $color_git_stashed●$color_reset"
    end
  else
    # Dirty repo, so we show status with symbols & counts, for upstream and
    #  stashes same logic applies as for clean repo
    echo -n "$colon$branch_name $sha $obracket"
    if test $status_added -ne 0
      echo -n "$color_git_added+$add_counted"
    end
    if test $status_modified -ne 0
      echo -n "$color_git_modified~$mod_counted"
    end
    if test $status_renamed -ne 0
      echo -n "$color_git_renamed≫$ren_counted"
    end
    if test $status_deleted -ne 0
      echo -n "$color_git_deleted✖︎$del_counted"
    end
    if test $status_untracked -ne 0
      echo -n "$color_git_untracked?$unt_counted"
    end
    if test $status_unmerged -ne 0
      echo -n "$color_git_unmerged!$unm_counted"
    end
    echo -n "$cbracket $git_arrows"
    if test $status_stashed -ne 0
      echo -n " $color_git_stashed●$color_reset"
    end
  end
end
