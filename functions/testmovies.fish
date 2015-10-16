# A script to extract the height of a movie file & if it's over 720
#  put their names in a file for further processing with Don Melton's
#   transcode-video tools.
#
#       dependency: mediainfo
#       =====================
#
#   version 1.1
#   16-10-2015
#
#   mediainfo returns Height if its over 999 with a space in it (like 1 080)
#   awk grabs the fields 3,4 & 5 and concatenates it to a string ending in pixels
#   (like '1080pixels', if there is no field 5 awk silently drops it)
#   cut is used to strip the sub-string pixels from the result
#   (set delimiter to 'p' and cut 1 field)

function testmovies -d 'find HD movies >= 720p'
  #clean up from previous use
  if test -f queue.txt
    rm queue.txt
    else
    echo -n ''
  end

  for file in *.mkv
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 719
       echo $file >> queue.txt
    end
	end

  for file in *.m4v
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 719
       echo $file >> queue.txt
    end
  end

  for file in *.avi
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 719
       echo $file >> queue.txt
    end
  end

  for file in *.ts
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 719
       echo $file >> queue.txt
    end
  end

  for file in *.mov
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 719
       echo $file >> queue.txt
    end
  end

  for file in *.wmv
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 719
       echo $file >> queue.txt
    end
  end

  if test -f queue.txt
    # Add 0 to awk result to be sure it's a number.  See: man awk -> BUGS
    set -l num_of_files (awk 'END{print NR}+0' queue.txt)
    echo -n "HD movies added to queue.txt: "; set_color yellow; echo $num_of_files; set_color normal
  else
    echo "No HD movie-files found."
  end

end
