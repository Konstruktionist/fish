function tv -d 'Transcode video to 720p mp4'
  transcode-video --mp4 --720p --target small --quick --audio-width all=stereo --add-subtitle nld $argv
end
  
