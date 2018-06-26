function efi-check -d "Check the EFI version of a Mac"
  # Check the EFI version of this Mac
  set current_efi_version (/usr/libexec/efiupdater | grep "Raw" | cut -d ' ' -f5)
  echo "Current EFI version $current_efi_version"
  # see if current version appears in the list of latest versions
  set latest_efi_version (ls -La /usr/libexec/firmwarecheckers/eficheck/EFIAllowListShipping.bundle/allowlists/ | grep "$current_efi_version")
  echo "Latest EFI version  $latest_efi_version"

  # if our current_efi_version does not appear in the latest version list (is empty)
  if test -z "$latest_efi_version"
    set_color red
    echo "EFI is not up-to-date."
    set_color normal
  # if it does appear in the list (what we hope for)
  else
    set_color green
    echo "EFI is up to date."
    set_color normal
  end
end
