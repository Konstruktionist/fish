# At last! A Linux free replacement
#
# Author: Olivier Refalo - https://github.com/orefalo
# from https://github.com/fisherman/free/tree/master/functions

function free -d "an osx substitution for linux 'free' command"

  if test (uname) = "Darwin"
    # Use vm_stat and sysctl to get system info
    set vmstat (vm_stat | string match -r "[0-9]+")

    # "Pages free:"
    set pfree $vmstat[2]
    # "Pages wired down:"
    set pwired $vmstat[7]
    # "Pages inactive:"
    set pinact $vmstat[4]
    # "Anonymous pages:"
    set panon $vmstat[15]
    # "Pages occupied by compressor:"
    set pcomp $vmstat[17]
    # "Pages purgeable:"
    set ppurge $vmstat[8]
    # "File-backed pages:"
    set pfback $vmstat[14]

    set total_mem (sysctl -n hw.memsize)

    # Arithmetics
    set total_mem (math "$total_mem / 1073741824")
    set pfree (math -s2 "$pfree * 4096 / 1073741824")
    set pwired (math -s2 "$pwired * 4096 / 1073741824")
    set pinact (math -s2 "$pinact * 4096 / 1073741824")
    set panon (math -s2 "$panon * 4096 / 1073741824")
    set pcomp (math -s2 "$pcomp * 4096 / 1073741824")
    set ppurge (math -s2 "$ppurge * 4096 / 1073741824")
    set pfback (math -s2 "$pfback * 4096 / 1073741824")

    # OSX Activity monitor formulas
    # thanks to http://apple.stackexchange.com/questions/81581/why-does-free-active-inactive-speculative-wired-not-equal-total-ram
    set free (math -s2 "$pfree + $pinact" )
    set cached (math "$pfback + $ppurge" )
    set appmem  (math -s2 "$panon - $ppurge")
    set used (math -s2 "$appmem + $pwired + $pcomp")

    # Display the hud
    printf '                 total     used     free   appmem    wired   compressed\n'
    printf 'Mem:          %6.2fGb %6.2fGb %6.2fGb %6.2fGb %6.2fGb %6.2fGb\n' $total_mem $used $free $panon $pwired $pcomp
    printf '+/- Cache:             %6.2fGb %6.2fGb\n' $cached $pinact
    sysctl -n -o vm.swapusage | awk '{   if( $3+0 != 0 )  printf( "Swap(%2.0f%s):    %6.0fMb %6.0fMb %6.0fMb\n", ($6+0)*100/($3+0), "%", ($3+0), ($6+0), $9+0); }'
    sysctl -n -o vm.loadavg | awk '{printf( "Load Avg:        %3.2f %3.2f %3.2f\n", $2, $3, $4);}'
  else
    printf "Sorry, this version of free only runs on OSX"
  end
end
