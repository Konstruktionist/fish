function build_iosevka -d "build custom version Iosevka font"

  # Save current working directory, so we can excecute this anywhere in the file system.
  set current_working_directory $PWD

  cd ~/Downloads/Iosevka-master

  # Upgrade to latest version of required tools
  # brew upgrade node ttfautohint otfcc-mac64
  #   I update brew every day with the bup function, so I don't need this

  # Install required libraries for nodejs
  npm install
  # The custom configuration
  make custom-config design='v-asterisk-low v-underscore-low v-brace-straight v-numbersign-slanted'
  # Build font
  make custom
  cd dist/iosevka-custom
  # We have italics in gui & terminal, so we don't need obliques
  rm *oblique*

  # Return to where we came from
  cd $current_working_directory
end
