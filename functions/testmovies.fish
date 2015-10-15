# A script to extract the height of a movie file & if it's over 720
#  put their names in a file for further processing with Don Melton's
#   transcode-video tools.
#
#       dependency: mediainfo
#       =====================
#
#   version 1.0
#   15-10-2015
#
#   mediainfo returns Height if its over 999 with a space in it (like 1 080)
#   awk grabs the fields 3,4 & 5 and concatenates it to a string ending in pixels
#   (like '1080pixels', if there is no field 5 awk silently drops it)
#   cut is used to strip the sub-string pixels from the result
#   (set delimiter to 'p' and cut 1 field)

function testmovies -d 'find HD movies >= 720p'

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
end
