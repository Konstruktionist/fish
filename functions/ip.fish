function ip
   set external (curl -s http://ipecho.net/plain)
   set wired (ipconfig getifaddr en0)
   set wifi (ipconfig getifaddr en1)

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
   # printf '%s \nDNS:\n'
   # scutil --dns | grep nameserver | sort | uniq
end
