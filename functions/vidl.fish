function vidl -d 'Download video with predefined settings'

  # Dependencies: youtube-dl
  # ========================
  # installed via homebrew

  youtube-dl -f pg-nettv $argv
end
  
