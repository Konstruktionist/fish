function xpstatus -d "Check version of XProtect"

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blueish purple
  
  # XProtect
  set version (defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep '\sVersion' | awk '{print $3}' | cut -c 1-4)
  set datum (GetFileInfo /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
  set timestamp (GetFileInfo /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep 'modified' | awk '{print $3}' | strptime -i "%T" -f "%H:%M")

  echo -ns "Xprotect is at version " $decor $version $normal ", updated on " $datum " at " $timestamp"."\n
end
