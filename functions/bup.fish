function bup -d 'Brew update & upgrade'

	echo -e '==> Updating Brew ...\n'
	brew update;
	brew upgrade;
   echo -e '\n==> Cleaning up Brew ...\n'
   brew cleanup;

end
