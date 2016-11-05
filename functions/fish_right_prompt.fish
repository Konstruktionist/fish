function fish_right_prompt

  set_color 808080 # grey
  # execution time last command & time of day
  echo -ns " $CMD_DURATION_STR | " (date +%H:%M:%S)
  # prompt_git_status
  set_color normal
end
