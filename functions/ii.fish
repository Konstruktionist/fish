function ii --description 'display useful host related informaton'

	#  Set up the colors
	set rescol (set_color blue)
	set norcol (set_color white)
	
	# local variables
	
	set cur_host (hostname -s)
	set kerninfo (uname -vp)
	# set cur_users (w -h)
	set datum (date)
	set stats (uptime)
	# set nloc (scselect)
	set ip (curl -s ip.appspot.com)

	echo -e "\nYou are logged on $rescol $cur_host" $norcol
	echo -e "\nAdditionnal information:\n $rescol $kerninfo" $norcol
	echo -e "\nUsers logged on: $rescol "; w -h; echo -e $norcol
	echo -e "Current date:\n $rescol $datum" $norcol
	echo -e "\nMachine stats:\n $rescol $stats" $norcol
	echo -e "\nCurrent network location: $rescol "; scselect; echo -e $norcol
	echo -e "Public facing IP Address:\n $rescol $ip" $norcol 
	echo -e "\nDNS Configuration:\n $rescol " ; scutil --dns
	echo
end