function plainvim --description 'Start vim without vimrc in nocompatible mode'
  # -u NONE prevents vim from loading vimrc
  # -U NONE prevents vim from loading gvimrc
  # -N tells vim to use no-compatible mode
	vim -u NONE -N
end
