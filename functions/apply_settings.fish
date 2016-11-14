# Source https://github.com/sgoumaz/dotfiles/blob/master/apply-settings.fish
function apply_settings -d 'setup fish universal variables'

  # setup fish universal variables

  set -U fish_color_autosuggestion 74fbfd --backgound=fae3a0 # cyan-like
  set -U fish_color_command 4eab31  # green
  set -U fish_color_comment 808080
  set -U fish_color_cwd 87af00 # green
  set -U fish_color_cwd_root b91e2e
  set -U fish_color_error d14548 --bold
  set -U fish_color_escape af5f5f
  set -U fish_color_history_current 87afd7
  set -U fish_color_host 5f87af
  set -U fish_color_match d7d7d7 --background=303030
  set -U fish_color_normal a1a1a1
  set -U fish_color_operator 81957c # Terminal green
  set -U fish_color_param 87afff
  set -U fish_color_quote fae3a0
  set -U fish_color_redirection cb1ed1
  set -U fish_color_search_match --background=000000  # black background
  set -U fish_color_status b91e2e
  set -U fish_color_user 5f875f
  set -U fish_color_valid_path --underline
  set -U fish_color_terminator f3b26d   # orange

  set -U fish_color_dimmed 808080
  set -U fish_color_separator 999

  # git colors

  set -U fish_color_git_clean 5f8700      # green
  set -U fish_color_git_staged fae3a0     # yellow
  set -U fish_color_git_dirty d14548      # red

  set -U fish_color_git_added 5f8700      # green
  set -U fish_color_git_copied magenta
  set -U fish_color_git_deleted 666
  set -U fish_color_git_modified 6193bc   # blue
  set -U fish_color_git_renamed magenta
  set -U fish_color_git_unmerged fae3a0   # yellow
  set -U fish_color_git_untracked d14548  # red
  set -U fish_color_git_sha 8a8a8a        # light gray

  set -U fish_pager_color_completion normal
  set -U fish_pager_color_description 555 yellow
  set -U fish_pager_color_prefix cyan
  set -U fish_pager_color_progress cyan
end
