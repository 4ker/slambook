all:
	rsync -a ./ --rsh='ssh -p3022' tzx@localhost:~/git/slambook