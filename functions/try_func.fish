# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function try_func

  # Try to get a branch name, if $branch is empty then this is not a git repo,
  #   and we have nothing to do
  set branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z "$branch"
    return
  end

  # Colors
  set color_separator (set_color abb7b7)            # grey
  set color_git_clean (set_color 3cf73c)            # green
  set color_git_staged (set_color f1f227)           # bright yellow
  set color_git_dirty (set_color ff8787)            # red

  set color_git_added (set_color ffff00 --bold)     # yellow
  set color_git_copied (set_color aeabd3 --bold)    # purple
  set color_git_deleted (set_color ff8787)          # red
  set color_git_modified (set_color 00bfff --bold)  # blue
  set color_git_renamed (set_color f39c12 --bold)   # purple
  set color_git_unmerged (set_color ff8787 --bold)  # red
  set color_git_untracked (set_color f2ca27 --bold) # yellow
  set color_git_sha (set_color a9a9a9)              # light grey
  set color_git_status (set_color ff8c00)           # orange

  # Status indicators/variables
  set git_arrows ''
  set git_arrow_up '▲'
  set git_arrow_down '▼'
  set staged
  set colon ':'
  set obracket '┤'
  set cbracket '├'
  set space ' '
  set git_prompt_char_cleanstate '✔'
  set git_prompt_char_dirtystate '~'
  set git_prompt_char_invalidstate '✖'
  set git_prompt_char_stagedstate '●'
  set git_prompt_char_stashstate '$'
  set git_prompt_char_stateseparator '|'
  set git_prompt_char_untrackedfiles '?'
  set git_prompt_char_upstream_ahead '↑'
  set git_prompt_char_upstream_behind '↓'
  set git_prompt_char_upstream_diverged '<>'
  set git_prompt_char_upstream_equal '='
  set git_prompt_char_upstream_prefix ''

  set git_dir (git rev-parse --git-dir)

set -g ___fish_git_prompt_status_order stagedstate invalidstate dirtystate untrackedfiles
set -gx fish_prompt_git_status_order added modified renamed copied deleted untracked unmerged

  # Get the status of the repo, to see if there are any changes, NOT counting
  # occurrences
  set status_index (git status --porcelain ^/dev/null | string sub -l 2 | sort -u)

  # Handling sha's
  #   Get the SHA1 value of a branch
  set gitsha (git rev-parse --short HEAD ^/dev/null)
  set sha "$color_git_sha$gitsha"

  if test -z "$status_index"
    set branch_name ( echo -n "$clean_branch$branch")
  else
    set branch_name (echo -n "$dirty_branch$branch")
  end

  set changedFiles (command git diff --name-status | string match -r \\w)
  set stagedFiles (command git diff --staged --name-status | string match -r \\w)

  set dirtystate (math (count $changedFiles) - (count (string match -r "U" -- $changedFiles)) ^/dev/null)
  set invalidstate (count (string match -r "U" -- $stagedFiles))
  set stagedstate (math (count $stagedFiles) - $invalidstate ^/dev/null)
  set untrackedfiles (command git ls-files --others --exclude-standard | wc -l | string trim)

  set info

  # If `math` fails for some reason, assume the state is clean - it's the simpler path
  set -l state (math $dirtystate + $invalidstate + $stagedstate + $untrackedfiles ^/dev/null)
  if test -z "$state"
    or test "$state" = 0
    # Clean repo so we don't show the dirty state, but may have a difference with
    # upstream. Because it is the last item in the list it will not show if there
    # is no difference with upstream.
    set info "$color_separator$colon$color_git_clean$branch$space$sha$space$git_arrows"
  else

    #       set -l color_var ___fish_git_prompt_color_$i
    #       set -l color_done_var ___fish_git_prompt_color_{$i}_done
    #       set -l symbol_var ___fish_git_prompt_char_$i
    #
    #       set -l color $$color_var
    #       set -l color_done $$color_done_var
    #       set -l symbol $$symbol_var
    #
    #       set -l count
    #
    #       if not set -q __fish_git_prompt_hide_$i
    #         set count $$i
    #       end
    #
    #       set info "$info$color$symbol$count$color_done"
    #     end
    #   end
    # end
    #

    echo "Dirty"
  end
    echo $info
end
