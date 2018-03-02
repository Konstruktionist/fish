# Copied from https://github.com/sgoumaz/dotfiles
#
# Added comments so I know what's going on a few weeks from now
# Added SHA1 value code
# ---------------------------------------------------------------------------------------------------------------------

#
#  How to get the change count into the prompt?
#   Also how to get the ahead and behind count?

set -gx fish_prompt_git_status_added '✚'
set -gx fish_prompt_git_status_modified '~'
set -gx fish_prompt_git_status_renamed '›'
set -gx fish_prompt_git_status_copied '»'
set -gx fish_prompt_git_status_deleted '✖︎'
set -gx fish_prompt_git_status_untracked '?'
set -gx fish_prompt_git_status_unmerged '!'
set -gx fish_prompt_git_status_order added modified renamed copied deleted untracked unmerged

function prompt_git_status -d 'Write out the git status'

  # Get the SHA1 value of a branch and if we're not in a git repo, send to /dev/null

  set -l gitsha (git rev-parse --short HEAD ^/dev/null)

  # Get the branch name and if we're not in a git repo, send to /dev/null

  set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z $branch
    return
  end

  # If used in fish_right_prompt, comment out next line
  set_color $fish_color_separator; echo -n ':'

  # Get the status of the repo, to see if there are any changes, NOT counting occurences

  set -l index (git status --porcelain ^/dev/null|cut -c 1-2|sort -u)

  # We are in a clean repo

  if test -z $index
    set_color $fish_color_git_clean; echo -n $branch

    echo -n ' '

    set_color $fish_color_git_sha; echo -n $gitsha; set_color normal

    echo -n ' '

    set_color $fish_color_separator; echo -n '['

    set_color $fish_color_git_clean; echo -n '✓'

    set_color $fish_color_separator; echo -n ']'

    set_color normal
    return
  end

  # Handling dirty repo's

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

  if test -n $gitsha

    echo -n ' '

    set_color $fish_color_git_sha; echo -n $gitsha; set_color normal

    echo -n ' '

  end

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
