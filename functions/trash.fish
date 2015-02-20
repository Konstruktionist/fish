function trash -d "empty all the Trash and the asl logs"
	# Empty the Trash on all mounted volumes and the main HDD
	# Also, clear Apple’s System Logs to improve shell startup speed
	sudo rm -rfv /Volumes/*/.Trashes
	sudo rm -rfv ~/.Trash
	sudo rm -rfv /private/var/log/asl/*.asl
end
