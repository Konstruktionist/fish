function ip -d 'get ip address info'
   set external (curl -s http://ipecho.net/plain)
   set wired (ipconfig getifaddr en0)
   set wifi (ipconfig getifaddr en1)
   set DNS (scutil --dns | grep nameserver | sort | uniq | awk 'BEGIN{ORS="  "} {print $3}')

   if test -z $wired
   else
      printf '%sEthernet  : %s%s%s\n' (set_color yellow) (set_color normal) $wired
   end

   if test -z $wifi
   else
      printf '%sWifi      : %s%s%s\n' (set_color yellow) (set_color normal) $wifi
   end

   if test -z $external
   else
      printf '%sExtern    : %s%s%s\n' (set_color yellow) (set_color normal) $external
   end

   printf '%sDNS       : %s%s%s\n' (set_color yellow) (set_color normal) $DNS
end
