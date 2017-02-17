function weer -d "Get weather information"
  command curl -4 -H "Accept-Language: nl" wttr.in/$argv
end
