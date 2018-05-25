# A script to extract the height of movie files in a directory & if it's over
#  720 put their names in a file for further processing with Don Melton's
#   transcode-video tools.
#
#       dependency: mediainfo
#       =====================
#
#   version 1.4
#   04-04-2017
#
#   mediainfo returns Height if it's over 999 with a space in it (like '1 080')
#   awk grabs the fields 3,4 & 5 and concatenates it to a string ending in
#   pixels (like '1080pixels', if there is no field 5 awk silently drops it).
#   cut is used to strip the sub-string pixels from the result
#   (set delimiter to 'p' and cut 1 field)

function testmovies -d 'find HD movies >= 720p'
  #clean up from previous use
  if test -f "queue.txt"
    rm queue.txt
  end

  for file in *.mkv  *.m4v *.avi *.ts *.mov *.wmv
    set -l film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test "$film_Height" -ge 720
      echo $file >> queue.txt
    end
  end

  if test -f "queue.txt"
    set -l num_of_files (awk 'END{print NR}' queue.txt)
    echo -n $num_of_files; echo -n " HD movies added to"; set_color -i blue; echo " queue.txt"\n
    set_color -o brblue; echo "   ---  Added movies  ---"; set_color normal
    cat queue.txt
  else
    echo "No HD movie-files found."
  end

end
