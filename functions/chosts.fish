# Compare the local date with the date on the net for my hosts file and see
# if it's behind
#
#     Dependency : dateutils
#     ======================
#     project homepage: http://www.fresse.org/dateutils/
#     installed via homebrew
#
#     version 1.1
#     25-10-2016

function chosts -d 'check online hosts files for last update'

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blue

  # Get the dates from the hosts files & put them in a uniform format.
  # format is "dd Mon Year" where dd is the day of the month in numbers, Mon is
  # the 3-letter abreviation of the month name and Year is the year
  # including the century.
  set -l my_hosts (cat /etc/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')
  set -l swc ( curl -s http://someonewhocares.org/hosts/zero/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')
  set -l yoyo ( curl -s 'https://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&startdate%5Bday%5D=&startdate%5Bmonth%5D=&startdate%5Byear%5D=&mimetype=plaintext' | egrep -i 'last updated' | awk '{print $5, $6, $7}')
  set -l sb ( curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts | egrep 'Date:' | awk '{print $4, substr($3,1,3), $5}')
  set -l mvps (curl -s http://winhelp2002.mvps.org/hosts.txt | egrep -i 'Updated' | sed 's/^#[[:space:]]-*[[:space:]][A-z]*:[[:space:]]//' | awk '{print $1}' | awk -F - '{print $2, substr($1,1,3), $3}')

  # The date is just a string, here we convert it to a format that dateutils can
  # work with.
  set -l my_date (strptime -i "%d %b %Y" $my_hosts)


  echo -s ' My hosts file was updated on: ' $decor $my_hosts $normal

  for val in $swc $yoyo $sb $mvps
    switch $val
      case $swc
        set name 'someonewhocares'
      case $yoyo
        set name '           yoyo'
      case $sb
        set name '    stevenblack'
      case $mvps
        set name '           mvps'
    end
    # Convert remote date strings for use with dateutils
      set -l distant_date (strptime -i "%d %b %Y" $val)
      # Calculate the difference in days between local and remote hosts files
      set -l difference (datediff $my_date $distant_date)
      # Figure out if remote is ahead (positive difference) or behind (negative
      # difference) and adjust color and message to it.
        if test $difference -le 0
        # We don't want to show negative numbers. (It took some time to figure
        # out that we need to escape the * with a backslash. Without it we get
        # a wildcard error message.)
        set abs ( math $difference\*-1)
          set display_color (set_color yellow)
          set ah_beh "behind"
        else
          set display_color (set_color red)
          set abs $difference
          set ah_beh "ahead"
      end
    echo -ns "   " $name " updated on: " $val " which is " $display_color $abs $normal " day(s) " $ah_beh"."\n
  end
end
