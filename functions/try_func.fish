# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function try_func
  # Check the EFI version of a Mac
  set current_efi_version (/usr/libexec/efiupdater | grep "Raw" | cut -d ':' -f2 | sed 's/ //')
  echo "Current EFI version $current_efi_version"
  set latest_efi_version (ls -La /usr/libexec/firmwarecheckers/eficheck/EFIAllowListShipping.bundle/allowlists/ | grep "$current_efi_version")
  echo "Latest EFI version  $latest_efi_version"

  if test -z $latest_efi_version
    set_color red
    echo "EFI FAILED"
    set_color normal
  else
    set_color green
    echo "EFI PASSED"
    set_color normal
  end
end
