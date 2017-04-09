function bup -d 'Brew update & upgrade'

  set_color -i yellow;
  echo -e '\n==> Updating Brew ...'
  set_color normal;
  brew update;
  set_color -i yellow;
  echo -e '\n==> Upgrading Brew ...'
  set_color normal;
  brew upgrade;
  set_color -i yellow;
  echo -e '\n==> Cleaning up Brew ...'
  set_color normal;
  brew cleanup;
end
