function motd -d "a british proxy"
	command youtube-dl -f 'mp4/flv' --proxy 'http://217.33.193.179:3128' $argv
end