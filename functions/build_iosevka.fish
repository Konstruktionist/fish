function build_iosevka -d "build custom version Iosevka font"
  cd ~/Downloads/Iosevka-master
  # Upgrade to latest version of required tools
  brew upgrade node ttfautohint otfcc-mac64
  # Install required libraries for nodejs
  npm install
  # The custom confiuration
  make custom-config design='v-asterisk-low'
  # Build font
  make custom
  cd dist/iosevka-custom
  # We have italics in gui & terminal, so we don't need obliques
  rm *oblique*
end
