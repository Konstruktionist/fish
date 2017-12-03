function xpstatus -d "Check version of XProtect"

  # Dependency: dateutils
  # =====================
  # installed via homebrew

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blueish purple
  set XProtect '/System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist'
  
  # XProtect
  set version (defaults read $XProtect | grep '\sVersion' | awk '{print $3}' | cut -c 1-4)
  set datum (stat -s  $XProtect | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y at %H:%M")

  echo -ns "Xprotect version is " $decor $version $normal ", updated on " $datum "."\n
end
