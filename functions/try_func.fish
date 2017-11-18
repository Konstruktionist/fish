# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function try_func -d "Experiments in fish scripting"

  function columns
    column -s '}' -t -x
  end

  # Files & their Paths:
  set -l XProtect '/System/Library/CoreServices/XProtect.bundle/Contents/version.plist'
  set -l Gatekeeper '/private/var/db/gkopaque.bundle/Contents/version.plist'
  set -l SIP '/System/Library/Sandbox/Compatibility.bundle/Contents/version.plist'
  set -l MRT '/System/Library/CoreServices/MRT.app/Contents/version.plist'
  set -l CoreSuggest '/System/Library/PrivateFrameworks/CoreSuggestionsInternals.framework/Versions/A/Resources/Assets.suggestionsassets/Contents/Info.plist'
  set -l IncompatibleKernelExt '/System/Library/Extensions/AppleKextExcludeList.kext/Contents/version.plist'
  # set -l ChineseWordList '/usr/share/mecabra/updates/com.apple.inputmethod.SCIM.bundle/Contents/version.plist'
  set -l CoreLSDK '/usr/share/kdrl.bundle/info.plist'

  set -l fileName XProtect Gatekeeper SIP MRT CoreSuggest IncompatibleKernelExt CoreLSDK
  # set -l filePath Xprotect Gatekeeper SIP SMRT CoreSuggest IncompatibleKernelExt CoreLSDK
  # set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}')

  echo "Versions of Apple malware protection"
  echo "------------------------------------"
  for val in $fileName
    switch $val
      case XProtect
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $XProtect)
        echo "$val               $version"
      case Gatekeeper
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $Gatekeeper)
        echo "$val             $version"
      case SIP
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $SIP)
        # echo "$val                    $version"
      case MRT
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $MRT)
        # echo "$val                    $version"
      case CoreSuggest
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreSuggest)
        # echo "$val            $version"
      case IncompatibleKernelExt
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $IncompatibleKernelExt)
        # echo "$val  $version"
      case CoreLSDK
        set version (awk -F[<>] '/CFBundleShortVersionString/ { getline; print $3}' $CoreLSDK)
        # echo "$val               $version"
    end
    echo "$val}$version" | columns

  end
  for value in $version
    string length $value
  end
end

#  Values we are looking for: 
# var versionKeyInDefaultsSystem: String {
#     switch self {
#     case .XProtect:
#         return "Version"
#     case .Gatekeeper, .SIP, .MRT, .CoreSuggestions, .IncompatibleKernelExt:
#         return "CFBundleShortVersionString"
#     case .ChineseWordList:
#         return "SUVersionString"
#     case .CoreLSDK:
#         return "CFBundleVersion"
#     }lL

# end
