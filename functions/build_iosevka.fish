function build_iosevka -d "build custom version Iosevka font"

  # Dependencies: nodejs, ttfautohint & otfcc
  # =========================================
  # installed via homebrew


  # Save current working directory, so we can excecute this anywhere in the file system.
  set current_working_directory $PWD

  cd ~/GitRepos/Iosevka

  # Upgrade to latest version of required tools
  # brew upgrade node ttfautohint otfcc-mac64 make
  #   I update brew every day with the bup function, so I don't need this

  # Install required libraries for nodejs
  npm install
  # The custom configuration
  # using (brew installed) gmake because macOS version is too old
  gmake custom-config design='v-asterisk-low v-underscore-low v-brace-straight v-numbersign-slanted'
  # Build font
  gmake custom
  # We have italics in gui & terminal, so we don't need obliques
  cd dist/iosevka-custom/ttf
  rm *oblique*.ttf

  # Return to where we came from
  cd $current_working_directory
end
