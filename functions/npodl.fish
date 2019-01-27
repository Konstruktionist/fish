function npodl -d "download a video from the npo website"

  # Dependencies: youtube-dl
  # ========================
  # installed via homebrew

  # get the list of all the the available formats and detect the highest quality
  set format (youtube-dl -F $argv | grep -i '42C033@' | awk '{print $1}' | xargs | string sub --start=-8)

  # download this file
  youtube-dl -f $format $argv
end

