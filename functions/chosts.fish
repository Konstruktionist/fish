# Compare the local date with the date on the net for my hosts file and see
# if it's behind
#
#     Dependencies: dateutils, wget
#     =============================
#     installed via homebrew
#
#     version 1.4
#     16-11-2017

function chosts -d 'check online hosts files for last update'

  # Save current working directory, so we can excecute this anywhere in the file system.
  set current_working_directory $PWD

  cd ~/workspace

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blueish purple

  # With curl we download the complete file and grep the date from it,
  # this takes time. If we only get the HTTP headers and grep those for the date
  # we will save a lot of time.

  set -l my_hosts_date (cat /etc/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')
  set -l swc_headers (wget -S --spider http://someonewhocares.org/hosts/zero/hosts -o swc_headers.txt)
  set -l mvps_headers (wget -S --spider http://winhelp2002.mvps.org/hosts.txt -o mvps_headers.txt)
  set -l yoyo_headers (wget -S --spider 'https://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&startdate%5Bday%5D=&startdate%5Bmonth%5D=&startdate%5Byear%5D=&mimetype=plaintext' -o yoyo_headers.txt)

  # Steven Black is a git repository on github, and refuses to give the
  # Last-Modified header so we have to download the whole lot and use grep and
  # awk to find the date
  set -l sb_date ( curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts | egrep 'Date:' | awk '{print $4, substr($3,1,3), $5}')

  # Extract the dates
  set -l swc_date (cat swc_headers.txt | egrep -i 'Last-Modified' | awk '{print $3, $4, $5}')
  set -l yoyo_date (cat yoyo_headers.txt | egrep -i 'Last-Modified' | awk '{print $3, $4, $5}')
  set -l mvps_date (cat mvps_headers.txt | egrep -i 'Last-Modified' | awk '{print $3, $4, $5}')

  # These are used later to fill in the right values
  set -l swc 'swc'
  set -l yoyo 'yoyo'
  set -l sb 'sb'
  set -l mvps 'mvps'

  # The my_hosts_date is just a string, here we convert it to a format that
  # dateutils can work with.
  set -l my_date (strptime -i "%d %b %Y" $my_hosts_date)


  echo -s ' My hosts file was updated on: ' $decor $my_hosts_date $normal

  for val in $swc $yoyo $sb $mvps
    switch $val
      case swc
        set name 'someonewhocares'
        set date $swc_date
      case yoyo
        set name '           yoyo'
        set date $yoyo_date
      case sb
        set name '    stevenblack'
        set date $sb_date
      case mvps
        set name '           mvps'
        set date $mvps_date
    end


    # Convert remote date strings for use with dateutils
    set -l distant_date (strptime -i "%d %b %Y" $date)

    # Calculate the difference in days between local and remote hosts files
    set -l difference (datediff $my_date $distant_date)

    # Figure out if remote is ahead (positive difference) or behind (negative
    # difference) and adjust color and message to it.
    if test $difference -le 0
      # We don't want to show negative numbers. (We have to calculate the
      # absolute value whithin double quotes, to allow variable substitution.
      # If we don't we get a wildcard error message)
      set abs ( math "$difference*-1")
      set display_color (set_color green)
      set ah_beh "behind"
    else
      set display_color (set_color brred)
      set abs $difference
      set ah_beh "ahead"
    end
    echo -ns "   " $name " updated on: " $date " which is " $display_color $abs " day(s) " $ah_beh $normal"."\n
  end

  # Clean up after ourselves
  rm *_headers.txt

  # Return to where we came from
  cd $current_working_directory
  
end

