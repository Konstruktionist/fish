# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function try_func

  set normal (set_color normal)

  set -l my_hosts (cat /etc/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')

  set -l my_date (strptime -i "%d %b %Y" $my_hosts)

  echo -s 'My current hosts file was updated on: ' $my_hosts


  # Check Someonewhocares.org
  set -l swc ( curl -s http://someonewhocares.org/hosts/zero/hosts | egrep -i 'last updated' | awk '{print $5, $6, $7}')
  set -l distant_date (strptime -i "%d %b %Y" $swc)
  set -l difference (datediff $my_date $distant_date)
    if test $difference -le 0
    set abs ( math $difference\*-1)
      set display_color (set_color yellow)
      set ah_beh "behind"
    else
      set display_color (set_color red)
      set abs $difference
      set ah_beh "ahead"
    end
  echo -ns "  someonewhocares updated on: " $swc " which is " $display_color $abs $normal " day(s) " $ah_beh"."\n


  # Check yoyo
  set -l yoyo ( curl -s 'https://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&startdate%5Bday%5D=&startdate%5Bmonth%5D=&startdate%5Byear%5D=&mimetype=plaintext' | egrep -i 'last updated' | awk '{print $5, $6, $7}')
  set -l distant_date (strptime -i "%d %b %Y" $yoyo)
  set -l difference (datediff $my_date $distant_date)
    if test $difference -le 0
    set abs ( math $difference\*-1)
      set display_color (set_color yellow)
      set ah_beh "behind"
    else
      set display_color (set_color red)
      set abs $difference
      set ah_beh "ahead"
    end
  echo -ns "             yoyo updated on: " $yoyo " which is " $display_color $abs $normal " day(s) " $ah_beh"."\n


  # Check StevenBlack
  set -l StevenBlack ( curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-social/hosts | egrep 'Date:' | awk '{print $4, $3, $5}')
  set -l distant_date (strptime -i "%d %b %Y" $StevenBlack)
  set -l difference (datediff $my_date $distant_date)
    if test $difference -le 0
    set abs ( math $difference\*-1)
      set display_color (set_color yellow)
      set ah_beh "behind"
    else
      set display_color (set_color red)
      set abs $difference
      set ah_beh "ahead"
    end
  echo -ns "      StevenBlack updated on: " $StevenBlack " which is " $display_color $abs $normal " day(s) " $ah_beh"."\n


  # Check MVPS
  set -l mvps (curl -s http://winhelp2002.mvps.org/hosts.txt | egrep -i 'Updated' | sed 's/^#[[:space:]]-*[[:space:]][A-z]*:[[:space:]]//' | awk '{print $1}' | awk -F - '{print $2, $1, $3}')
  set -l distant_date (strptime -i "%d %B %Y" $mvps)
  set -l difference (datediff $my_date $distant_date)
    if test $difference -le 0
    set abs ( math $difference\*-1)
      set display_color (set_color yellow)
      set ah_beh "behind"
    else
      set display_color (set_color red)
      set abs $difference
      set ah_beh "ahead"
    end
  echo -ns "             mvps updated on: " $mvps " which is " $display_color $abs $normal " day(s) " $ah_beh"."\n

end
