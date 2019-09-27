if [ -d /home/$(whoami)/gits/mybash/ ]; then
	for file in /home/$(whoami)/gits/mybash/*
		do
			source "$file";
		done
else
	mkdir mybash
	if [ ! -z "$(git config user.name)" ]; then
		if [ -f /home/$(whoami)/.ssh/id_rsa ]; then
			git clone git@github.com:$(git config user.name)/bashprofile mybash;
		else
			git clone https://github.com/$(git config user.name)/bashprofile.git mybash;
		fi;
	elif [ "$(curl -s https://api.github.com/users/$(whoami)/repos | jq | wc -l)" -gt 10 ] ; then
			git config --global user.name $(whoami);
	else
			echo "Found no git related.";
	fi;
fi;
