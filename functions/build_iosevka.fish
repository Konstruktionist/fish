function build_iosevka -d "build custom version Iosevka font"

  # Dependencies: nodejs, ttfautohint & otfcc
  # =========================================
  # installed via homebrew


  # Save current working directory, so we can excecute this anywhere in the
  # file system
  set current_working_directory $PWD

  # Are we on a machine without a Iosevka git-repository?
  if not test -d "$HOME/GitRepos/Iosevka"
    # Then create one
    cd $HOME/GitRepos
    git clone https://github.com/be5invis/Iosevka.git
  end

  # We have one, so let's move to the repository
  cd $HOME/GitRepos/Iosevka
  # Start from a clean slate i.e. remove build & dist folders
  set_color f7ca18; echo "Cleaning up from last build"; set_color normal
  rm  -rf ./build ./dist

  # Update to latest version
  git pull

  # Upgrade to latest version of required tools
  # brew upgrade node ttfautohint otfcc-mac64
  #   I update brew every day with the bup function, so I don't need this

  # Install required libraries for nodejs
  set_color f7ca18; echo "Updating build tools"; set_color normal
  npm install
  npm install ajv
  # Install the missed dependancies
  npm update --dev

  # Put the custom configuration in place
  cp $HOME/workspace/Iosevka_private-build-plans.toml private-build-plans.toml

  # Build font
  set_color f7ca18; echo "Building Iosevka...."; set_color normal
  npm run build -- contents:iosevka-custom

  # Check for build errors and bail out if there are any
  if test $status -ne 0
    set_color ff2600; echo " => Building Iosevka FAILED!"; set_color normal
  else
    cd dist/iosevka-custom/ttf
    set_color f7ca18; echo "Archiving fonts on desktop"; set_color normal
    7z a -t7z Iosevka-custom
    mv Iosevka-custom.7z $HOME/Desktop/
    set_color f7ca18; echo "Placing fonts into $HOME/Library/Fonts"; set_color normal
    mv *.ttf $HOME/Library/Fonts/
  end

  # Return to where we came from
  cd $current_working_directory
end
