# from:
# http://stackoverflow.com/questions/22650715/running-last-command-with-sudo-in-fish-only-works-if-it-has-no-arguments
function sudo -d 'Run command using sudo (use !! for last command)'
  if test (count $argv) -gt 0
    switch $argv[1]
      case '!!'
        if test (count $argv) -gt 1
          set cmd "command sudo $history[1] $argv[2..-1]"
        else
          set cmd "command sudo $history[1]"
        end
        eval $cmd
      case '*'
        set cmd "command sudo $argv"
        eval $cmd
    end
  else
    command sudo fish
  end
end
