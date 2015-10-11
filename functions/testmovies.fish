# A script to extract the height of a movie file & if it's over 720
#  put their names in a file for further processing with Don Melton's
#   transcode-video tools
#
# It's working!! 11-10-2015
#

function testmovies -d 'find HD movies > 720p'

	for file in *.mkv
		set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 720
       echo $file >> queue.txt
    end
	end

  for file in *.m4v
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 720
       echo $file >> queue.txt
    end
  end

  for file in *.avi
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 720
       echo $file >> queue.txt
    end
  end

  for file in *.ts
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 720
       echo $file >> queue.txt
    end
  end

  for file in *.mov
    set film_Height (mediainfo $file | grep 'Height' | awk '{print $3 $4 $5}' | cut -d p -f 1)
    if test $film_Height -gt 720
       echo $file >> queue.txt
    end
  end
end
