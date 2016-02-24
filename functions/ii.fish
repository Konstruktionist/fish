function ii -d 'display useful host related informaton'


	# local variables

	set cur_host (hostname -s)
	set kerninfo (uname -vp)
	# set cur_users (w -h)
	set datum (date)
	set stats (uptime)
	# set nloc (scselect)
	set ip (curl -s http://ipecho.net/plain)

	echo -e "\nYou are logged onto: $cur_host"
	echo -e "\nAdditionnal information:\n $kerninfo"
	echo -e "\nUsers logged on: "; w -h; echo -e
	echo -e "Current date:\n $datum"
	echo -e "\nMachine stats:\n $stats"
	echo -e "\nCurrent network location: "; scselect; echo -e
	echo -e "Public facing IP Address:\n $ip"
	echo -e "\nDNS servers: "; scutil --dns | grep nameserver | sort | uniq | awk -F : '{print $2}'
	echo
end
