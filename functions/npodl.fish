function npodl -d "download a file from the npo website"
  # get the list of all the the available formats and detect the highest quality
  set format (youtube-dl -F $argv | grep -i '42C033@' | grep -i 'mp4a.40.2@192k' | awk '{print $1}')

  # download this file
  youtube-dl -f $format $argv
end
  