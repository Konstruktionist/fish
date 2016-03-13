function chost -d 'check someonewhocares.org for last update'
   curl -s http://someonewhocares.org/hosts/zero/hosts | egrep -i 'last updated'
end

