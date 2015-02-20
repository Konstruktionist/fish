function ip
	set external (curl -s http://ipecho.net/plain)
	set wired (ipconfig getifaddr en0)
	set wifi (ipconfig getifaddr en1)

	if test -z $wired
	else
		printf '%sLAN  : %s%s%s\n' (set_color yellow) (set_color blue) $wired (set_color normal)
	end
	
	if test -z $wifi
	else
		printf '%sWLAN : %s%s%s\n' (set_color yellow) (set_color cyan) $wifi (set_color normal)
	end
	
	if test -z $external
	else
		printf '%sEXT  : %s%s%s\n' (set_color yellow) (set_color green) $external (set_color normal)
	end
end
