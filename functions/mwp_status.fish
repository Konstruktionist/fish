function mwp_status -d "Check Apple's malware protection status"

  # Dependency: dateutils
  # =====================
  # installed via homebrew

  # Re-usable colors
  set normal (set_color normal)
  set version_color (set_color 87afff) # blueish purple
  set green (set_color 76c376)
  set red (set_color ff8787)

  # Files & their Paths:
  # These paths will change with macOS 10.15 (Catalina). See:
  # https://eclecticlight.co/2019/08/21/its-time-to-test-your-scripts-against-catalinas-path-changes/
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
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $XProtect)

        #   How the 'datum' part works:
        #   The stat utility displays info about the file pointed to by '$file'.
        #   Useful flag is -s. man page says:
        #     -s  Display information in 'shell output', suitable for initializing variables.
        #   Pass it to __k_userFriendlyDatum function

        set datum (stat -s  $XProtect | __k_userFriendlyDatum)
        echo "$file               $version_color $k_version $normal    $datum"
      case Gatekeeper
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $Gatekeeper)
        set datum (stat -s  $Gatekeeper | __k_userFriendlyDatum)
        echo "$file             $version_color $k_version $normal     $datum"
      case SIP
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $SIP)
        set datum (stat -s  $SIP | __k_userFriendlyDatum)
        echo "$file                    $version_color $k_version $normal    $datum"
      case MRT
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $MRT)
        set datum (stat -s  $MRT | __k_userFriendlyDatum)
        echo "$file                    $version_color $k_version $normal    $datum"
      case CoreSuggest
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreSuggest)
        set datum (stat -s  $CoreSuggest | __k_userFriendlyDatum)
        echo "$file            $version_color $k_version $normal    $datum"
      case IncompatibleKernelExt
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $IncompatibleKernelExt)
        set datum (stat -s  $IncompatibleKernelExt | __k_userFriendlyDatum)
        echo "$file  $version_color $k_version $normal  $datum"
      case CoreLSDK
        set k_version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreLSDK)
        set datum (stat -s  $CoreLSDK | __k_userFriendlyDatum)
        echo "$file               $version_color $k_version $normal       $datum"
    end
  end

  echo '-----'
  set SIP_status (csrutil status | awk '{print $5}')
  switch $SIP_status
    case enabled.
      echo "System Integrity Protection status:$green enabled $normal"
    case disabled.
      echo "System Integrity Protection status:$red disabled $normal"
    case '*'
      echo "Unknown"
  end

end

# convert result of stat to a human readable date
function __k_userFriendlyDatum
  #       NOTE: leading underscores keeps this hidden from `functions` not
  #             `functions -a`.
  #             __k_ prefix is used for my hidden semi-private functions.
  #
  #   We got info from `stat` in a space separated format.
  #     Put everything on it's own line with:
  #       tr '\ ' '\n'
  #   stat gives 4 timestamps in this order: st_atime, st_mtime, st_ctime, st_birthtime
  #      st_atime = last access time in seconds since the epoch
  #      st_mtime = last modify time in seconds since the epoch
  #      st_ctime = inode change time (NOT creation time!) in seconds since the epoch
  #      st_birthtime = time when the inode was created in seconds since the epoch
  #   The timestamp we need is st_ctime, it is the time that the file was changed on OUR disk,
  #     the other timestamps represent the time that Apple modified the file
  #   Search for the inode changed time with:
  #     egrep -i 'st_ctime'
  #   Let cut grab the value we are interested in:
  #     cut -d = -f 2
  #   This is the epoch value (i.e. time since unix began)
  #   Transform this into a human readable format taking into account locale setting (-l)
  #     strptime -l -i "%s" -f "%d %b %Y %H:%M"

  tr '\ ' '\n' | egrep -i 'st_ctime' | cut -d = -f 2 | strptime -l -i "%s" -f "%d %b %Y %H:%M"
end
