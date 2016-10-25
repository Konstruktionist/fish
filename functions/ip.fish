function ip -d 'get ip address info'
   set external (curl -s http://ipecho.net/plain)
   set wired (ipconfig getifaddr en0)
   set wifi (ipconfig getifaddr en1)
   set DNS (scutil --dns | grep nameserver | sort | uniq | awk 'BEGIN{ORS="  "} {print $3}')

   if test -z $wired
   else
      echo -ns (set_color yellow) 'Ethernet  : '  (set_color normal) $wired \n
   end

   if test -z $wifi
   else
     echo -ns (set_color yellow) 'Wifi      : '  (set_color normal) $wifi \n
   end

   if test -z $external
   else
     echo -ns (set_color yellow) 'Public    : '  (set_color normal) $external \n
   end

   echo -ns (set_color yellow) 'DNS       : '  (set_color normal) $DNS \n
end
