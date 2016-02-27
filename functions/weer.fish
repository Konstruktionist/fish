function weer -d "Get weather information"
  command curl -4 http://wttr.in/$argv
end