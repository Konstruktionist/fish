function fish_right_prompt

   set_color $fish_color_comment
   printf '[%s]' (date +%H:%M:%S)
   # prompt_git_status
   set_color normal
end
