# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function try_func
  set -l user (whoami)
  set -l host (hostname -s)
  set -l user_host "$user@$host"

  # Ideally we show no user@host info when we are on the local machine even
  # when we are root. However if we do  'sudo -s'  either local or over ssh we
  # have no information in our environment (env) to distinguish between the
  # two. So we show user@host when we are root & as a non-root user over ssh.
  # color of user@host is set by $user, either red (root) or blue (non-root)

  switch $user
    case root
      set_color -r red
      echo $user_host
      set_color normal
      echo -n ' '
    case '*'              # non-root
      # As non-root we can test if we have a SSH_TTY in our environment. If we
      # do we have an ssh-connection, and show a blue user@host info.
      # If we are on the local machine as a normal user we don't show user@host.
      if test -n "$SSH_TTY"
        set_color -r blue
        echo $user_host
        set_color normal
        echo -n ' '
      else
        echo -n ''
      end
  end
end
