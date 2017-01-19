function xpstatus -d "Check version of XProtect"

  # Re-usable colors
  set normal (set_color normal)
  set decor (set_color 87afff) # blue

  set version (defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep '\sVersion' | awk '{print $3}' | cut -c 1-4)

  set datum (GetFileInfo /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep 'modified' | awk '{print $2}')

  set timestamp (GetFileInfo /System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist | grep 'modified' | awk '{print $3}')

  # Split date string into components
  set day (echo $datum | awk -F / '{print $2}')
  set month (echo $datum | awk -F / '{print $1}')
  set year (echo $datum | awk -F / '{print $3}')

  # Convert month numbers to short month names for display purposes
  for val in $month
    switch $val
      case 01
        set month_name 'Jan'
      case 02
        set month_name 'Feb'
      case 03
        set month_name 'Mar'
      case 04
        set month_name 'Apr'
      case 05
        set month_name 'May'
      case 06
        set month_name 'Jun'
      case 07
        set month_name 'Jul'
      case 08
        set month_name 'Aug'
      case 09
        set month_name 'Sep'
      case 10
        set month_name 'Oct'
      case 11
        set month_name 'Nov'
      case 12
        set month_name 'Dec'
    end
  end

  echo -ns "Xprotect is at version " $decor $version $normal ", updated on " $day " " $month_name " " $year " at " $timestamp"."\n

end
