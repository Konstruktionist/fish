function mwp_status -d "Check Apple's malware protection status"

  # Dependency: dateutils
  # =====================
  # installed via homebrew

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blueish purple

  # Files & their Paths:
  set -l XProtect '/System/Library/CoreServices/XProtect.bundle/Contents/version.plist'
  set -l Gatekeeper '/private/var/db/gkopaque.bundle/Contents/version.plist'
  set -l SIP '/System/Library/Sandbox/Compatibility.bundle/Contents/version.plist'
  set -l MRT '/System/Library/CoreServices/MRT.app/Contents/version.plist'
  set -l CoreSuggest '/System/Library/PrivateFrameworks/CoreSuggestionsInternals.framework/Versions/A/Resources/Assets.suggestionsassets/Contents/Info.plist'
  set -l IncompatibleKernelExt '/System/Library/Extensions/AppleKextExcludeList.kext/Contents/version.plist'
  set -l CoreLSDK '/usr/share/kdrl.bundle/info.plist'

  set -l fileName XProtect Gatekeeper SIP MRT CoreSuggest IncompatibleKernelExt CoreLSDK

  # Get the versions of the files & display dates in an understandable way
  echo "Name                    Version  Updated"
  echo "--------------------------------------------------"
  for file in $fileName
    switch $file
      case XProtect
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $XProtect)

        #   How the 'datum' part works:
        #   The stat utility displays information about the file pointed to by 'file'.
        #   Useful flag is -s. man page says:
        #     -s  Display information in 'shell output', suitable for initializing variables.
        #   Put everything on it's own line with
        #     tr '\ ' '\n'
        #   stat gives 4 timestamps in this order: st_atime, st_mtime, st_ctime, st_birthtime
        #      st_atime = last access time in seconds since the epoch
        #      st_mtime = last modify time in seconds since the epoch
        #      st_ctime = inode change time (NOT creation time!) in seconds since the epoch
        #      st_birthtime = time when the inode was created in seconds since the epoch
        #   The timestamp we need is st_ctime, it is the time that the file was changed on OUR disk,
        #     the other timestamps represent the time that Apple modified the file
        #   Search for the inode changed time with
        #     egrep -i 'st_ctime'
        #   Let cut grab the value we are interested in
        #     cut -d = -f 2
        #   This is the epoch value (i.e. time since unix began)
        #   Transform this into a human readable format taking into account locale setting (-l)
        #     strptime -l -i "%s" -f "%d %b %Y %H:%M"

        set datum (stat -s  $XProtect | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file               $decor $version $normal    $datum"
      case Gatekeeper
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $Gatekeeper)
        set datum (stat -s  $Gatekeeper | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file             $decor $version $normal     $datum"
      case SIP
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $SIP)
        set datum (stat -s  $SIP | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file                    $decor $version $normal    $datum"
      case MRT
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $MRT)
        set datum (stat -s  $MRT | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file                    $decor $version $normal    $datum"
      case CoreSuggest
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreSuggest)
        set datum (stat -s  $CoreSuggest | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file            $decor $version $normal    $datum"
      case IncompatibleKernelExt
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $IncompatibleKernelExt)
        set datum (stat -s  $IncompatibleKernelExt | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file  $decor $version $normal  $datum"
      case CoreLSDK
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreLSDK)
        set datum (stat -s  $CoreLSDK | tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M")
        echo "$file               $decor $version $normal       $datum"
    end
  end
  echo '---'
  csrutil status
end
