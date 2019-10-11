if [ -d /home/$(whoami)/gits/mybash/ ]; then
	for file in /home/$(whoami)/gits/mybash/*
		do
			if [ -f "$file" ]; then
				source "$file";
			fi;
		done
elif [ -d /home/$(whoami)/mybash/ ]; then
	for file in /home/$(whoami)/mybash/*
		do
			if [ -f "$file" ]; then
				source "$file";
			fi;
		done
else
	mkdir mybash
	if [ ! -z "$(git config user.name)" ]; then
		if [ -f /home/$(whoami)/.ssh/id_rsa ]; then
			git clone git@github.com:$(git config user.name)/mybash mybash &> /dev/null;
		else
			git clone https://github.com/$(git config user.name)/mybash.git mybash &> /dev/null;
		fi;
		echo "Cloning git..."
	elif [ "$(curl -s https://api.github.com/users/$(whoami)/repos | jq | wc -l)" -gt 10 ] ; then
			git config --global user.name $(whoami);
	else
			echo "Found no git related.";
	fi;
fi;
