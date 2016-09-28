# Compare the local date with the date on the net for my hosts file and see
# if it's behind
#
#     Dependency : dateutils
#     ======================
#     project homepage: http://www.fresse.org/dateutils/
#     installed via homebrew
#
#     version 1.0
#     28-03-2016

function chost -d 'check someonewhocares.org for last update'
   set -l my_hosts (cat /etc/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')
   set -l distant_hosts (curl -s http://someonewhocares.org/hosts/zero/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')
   set -l distant_date (strptime -i "%d %b %Y" $distant_hosts)
   set -l my_date (strptime -i "%d %b %Y" $my_hosts)
   set -l difference (datediff $my_date $distant_date)
   echo -s 'Online version updated on:   ' $distant_hosts
   echo -ns "My current hosts file dated: $my_hosts which is $difference day(s) behind."\n
end

