# Copied from https://github.com/sgoumaz/dotfiles

set -gx fish_prompt_git_status_added '+'
set -gx fish_prompt_git_status_modified '•'
set -gx fish_prompt_git_status_renamed '›'
set -gx fish_prompt_git_status_copied '»'
set -gx fish_prompt_git_status_deleted '–'
set -gx fish_prompt_git_status_untracked '?'
set -gx fish_prompt_git_status_unmerged '!'

set -gx fish_prompt_git_status_order added modified renamed copied deleted untracked unmerged

function prompt_git_status --description 'Write out the git status'
  set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z $branch
    return
  end

  set_color $fish_color_separator; echo -n ':'

  set -l index (git status --porcelain ^/dev/null|cut -c 1-2|sort -u)

  if test -z "$index"
    set_color $fish_color_git_clean; echo -n $branch

    set_color $fish_color_separator; echo -n '['

    set_color $fish_color_git_clean; echo -n '✓'

    set_color $fish_color_separator; echo -n ']'

    set_color normal
    return
  end

  set -l gs
  set -l staged

  for i in $index
    if echo $i | grep '^[AMRCD]' >/dev/null
      set staged 1
    end

    switch $i
      case 'A '               ; set gs $gs added
      case 'M ' ' M'          ; set gs $gs modified
      case 'R '               ; set gs $gs renamed
      case 'C '               ; set gs $gs copied
      case 'D ' ' D'          ; set gs $gs deleted
      case '\?\?'             ; set gs $gs untracked
      case 'U*' '*U' 'DD' 'AA'; set gs $gs unmerged
    end
  end

  if set -q staged[1]
    set_color $fish_color_git_staged
  else
    set_color $fish_color_git_dirty
  end

  echo -n $branch

  set_color $fish_color_separator; echo -n '['

  for i in $fish_prompt_git_status_order
    if contains $i in $gs
      set -l color_name fish_color_git_$i
      set -l status_name fish_prompt_git_status_$i

      set_color $$color_name; echo -n $$status_name
    end
  end

  set_color $fish_color_separator; echo -n ']'

  set_color normal
end


# # Fish git prompt
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showuntrackedfiles 'yes'
# set __fish_git_prompt_showupstream 'auto'
# set -g __fish_git_prompt_showupstream "informative"
# set __fish_git_prompt_color_branch yellow
# set __fish_git_prompt_color_upstream_ahead green
# set __fish_git_prompt_color_upstream_behind red
#
# # Status Chars
# set __fish_git_prompt_char_dirtystate '⚡'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_untrackedfiles '☡'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '+'
# set __fish_git_prompt_char_upstream_behind '-'
#
# function prompt_git_status --description 'Write out the git status'
#  printf '%s ' (__fish_git_prompt)
#
#   set_color normal
# end
