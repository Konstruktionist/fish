# Source https://github.com/sgoumaz/dotfiles/blob/master/apply-settings.fish
function apply_settings -d 'setup fish universal variables'

  # setup fish universal variables

  set -U fish_color_normal fefefe
  set -U fish_color_command 38f689  # green
  set -U fish_color_quote f5d76e
  set -U fish_color_redirection dda0dd
  set -U fish_color_end f4b350   # orange
  set -U fish_color_error ff8787 --bold
  set -U fish_color_param 89c4f4
  set -U fish_color_comment d2d7d3  --italics
  set -U fish_color_match dadfe1
  set -U fish_color_search_match 383f4c --background=bdc3c7  # gray background
  set -U fish_color_operator d4b300 # dark yellow
  set -U fish_color_escape aea8d3 # like backslahes for spaces
  set -U fish_color_cwd f7ca18 #yellow
  set -U fish_color_autosuggestion 00ced1  # cyan-like
  set -U fish_color_cwd_root f1a9a0
  set -U fish_color_history_current bdb0bb
  set -U fish_color_host 19b5fe
  set -U fish_color_status ff8c00
  set -U fish_color_user 76c376
  set -U fish_color_valid_path --underline

  set -U fish_pager_color_prefix 6bb9f0 # blue - the color of the prefix string, i.e. the string that is to be completed
  set -U fish_pager_color_completion 00bbff # bright blue - the color of the completion itself
  set -U fish_pager_color_description 34b9db --italics # gray - the color of the completion description
  set -U fish_pager_color_progress 383f4c --background=bdc3c7 # the color of the progress bar at the bottom left corner
  set -U fish_pager_color_secondary add8e6 # the background color of the every second completion

  # Custom colors used for prompt

  set -U fish_color_dimmed bdc3c7
  set -U fish_color_separator abb7b7

  # git colors

  set -U fish_color_git_clean 3cf73c      # green
  set -U fish_color_git_staged ffd700     # yellow
  set -U fish_color_git_dirty ff8787      # red

  set -U fish_color_git_added 00d400      # green
  set -U fish_color_git_copied aeabd3     # purple
  set -U fish_color_git_deleted ff8787    # red
  set -U fish_color_git_modified 00bfff   # blue
  set -U fish_color_git_renamed f39c12    # purple
  set -U fish_color_git_unmerged ff8787   # red
  set -U fish_color_git_untracked f2ca27  # yellow
  set -U fish_color_git_sha a9a9a9        # light gray
end
