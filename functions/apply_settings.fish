function apply_settings -d 'setup fish universal variables'

  # setup fish universal variables

  set -U fish_color_normal fefefe
  set -U fish_color_command 38f689                               # green
  set -U fish_color_quote f5d76e
  set -U fish_color_redirection dda0dd
  set -U fish_color_end f4b350                                   # orange
  set -U fish_color_error ff8787 --bold
  set -U fish_color_param 89c4f4
  set -U fish_color_comment d2d7d3 --italics
  set -U fish_color_match dadfe1
  set -U fish_color_search_match 383f4c --background=ffffff      # white background
  set -U fish_color_operator d4b300                              # dark yellow
  set -U fish_color_escape ffd700                                # like backslashes for spaces
  set -U fish_color_cwd f7ca18                                   # yellow
  set -U fish_color_autosuggestion 808080                        # grey
  set -U fish_color_cwd_root f1a9a0
  set -U fish_color_history_current bdb0bb
  set -U fish_color_host 19b5fe
  set -U fish_color_status ff8c00
  set -U fish_color_user 76c376
  set -U fish_color_valid_path --underline
  set -U fish_color_selection 383f4c --bold  --background=00d400

  set -U fish_pager_color_prefix 6bb9f0                          # blue - the color of the prefix string, i.e. the string that is to be completed
  set -U fish_pager_color_completion ffffff                      # white- the color of the completion itself
  set -U fish_pager_color_description 808080 --italics           # grey - the color of the completion description
  set -U fish_pager_color_progress 383f4c --background=bdc3c7    # the color of the progress bar at the bottom left corner
  set -U fish_pager_color_secondary add8e6                       # the background color of the every second completion
  
  # fix character width for emoji's (affects the prompt character)
  # As reported: https://github.com/fish-shell/fish-shell/issues/5501
  # Terminal > Profiles > Advanced: check Unicode East Asian Ambiguous characters are wide
  # iTerm > Profiles > Text: check Ambiguous characters are double-width
  set -U fish_emoji_width 2
end
