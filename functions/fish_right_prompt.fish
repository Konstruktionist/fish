function fish_right_prompt

	set_color $fish_color_autosuggestion[1]
	printf '[%s]' (date +%H:%M:%S)
	set_color normal
end
