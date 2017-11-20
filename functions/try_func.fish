# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function try_func -d "Experiments in fish scripting"

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blue

  # Files & their Paths:
  set -l XProtect '/System/Library/CoreServices/XProtect.bundle/Contents/version.plist'
  set -l Gatekeeper '/private/var/db/gkopaque.bundle/Contents/version.plist'
  set -l SIP '/System/Library/Sandbox/Compatibility.bundle/Contents/version.plist'
  set -l MRT '/System/Library/CoreServices/MRT.app/Contents/version.plist'
  set -l CoreSuggest '/System/Library/PrivateFrameworks/CoreSuggestionsInternals.framework/Versions/A/Resources/Assets.suggestionsassets/Contents/Info.plist'
  set -l IncompatibleKernelExt '/System/Library/Extensions/AppleKextExcludeList.kext/Contents/version.plist'
  set -l CoreLSDK '/usr/share/kdrl.bundle/info.plist'

  set -l fileName XProtect Gatekeeper SIP MRT CoreSuggest IncompatibleKernelExt CoreLSDK

  # Get the versions of the files & display dates in understandable way
  echo "Name                    Version  Date"
  echo "--------------------------------------------"
  for val in $fileName
    switch $val
      case XProtect
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $XProtect)
        set datum (GetFileInfo $XProtect | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val               $decor $version $normal    $datum"
      case Gatekeeper
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $Gatekeeper)
        set datum (GetFileInfo $Gatekeeper | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val             $decor $version $normal     $datum"
      case SIP
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $SIP)
        set datum (GetFileInfo $SIP | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val                    $decor $version $normal    $datum"
      case MRT
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $MRT)
        set datum (GetFileInfo $MRT | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val                    $decor $version $normal    $datum"
      case CoreSuggest
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreSuggest)
        set datum (GetFileInfo $CoreSuggest | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val            $decor $version $normal    $datum"
      case IncompatibleKernelExt
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $IncompatibleKernelExt)
        set datum (GetFileInfo $IncompatibleKernelExt | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val  $decor $version $normal  $datum"
      case CoreLSDK
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreLSDK)
        set datum (GetFileInfo $CoreLSDK | grep 'modified' | awk '{print $2}' | strptime -i "%m/%d/%Y" -f "%d %b %Y")
        echo "$val               $decor $version $normal       $datum"        
    end
  end
end
