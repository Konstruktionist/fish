function xpstatus -d "Check version of XProtect"
  set version (defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep '\sVersion' | awk '{print $3}' | cut -c 1-4)

  set datum (GetFileInfo /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep 'modified' | awk '{print $2}')

  set timestamp (GetFileInfo /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep 'modified' | awk '{print $3}')
  
  echo -n "Xprotect is at version $version, updated on $datum at $timestamp."\n

end