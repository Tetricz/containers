#!/bin/sh
cd /jmusic-bot
if [ ! -e ./config.txt ]; then
    envsubst < "/config.txt.sample" > "./config.txt"
fi
if [ ! -e ./JMusic* ]; then
    echo "Jarfile not found"
    echo "Downloading JMusic jarfile"
    curl -L $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') \
    -o /jmusic-bot/$(echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/')
	echo "Setting current version"
	echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/' > /jmusic-bot/.version
elif [ -e ./.version ]; then
	online=$(echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/')
	echo "Online Version: ${online}"
	current=$(cat /jmusic-bot/.version)
	echo "Current Version: ${current}"
	if [ -n ${online} ]; then
		if [ ${online} != ${current} ]; then
			echo "Version mismatch"
			echo "Downloading latest version..."
			curl -L $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') \
			-o /jmusic-bot/$(echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/')
			echo "Removing old version"
			rm -v ${current}
			echo "Setting current version"
			echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/' > /jmusic-bot/.version
		fi
	else
		echo "Check internet connection or dns settings"
	fi
elif [ ! -e ./.version ]; then
	online=$(echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/')
	echo "Online Version: ${online}"
	current=$(cat /jmusic-bot/.version)
	echo "Current Version: ${current}"
	if [ -n ${online} ]; then
		if [ ${online} != ${current} ]; then
			echo "Version mismatch"
			echo "Downloading latest version..."
			curl -L $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') \
			-o /jmusic-bot/$(echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/')
			echo "Removing old version"
			rm -v ${current}
			echo "Setting current version"
			echo $(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -i 'browser_download_url.*\.jar' | sed 's/.*\(http.*\)"/\1/') | sed 's/.*\/\([^\/]*\)/\1/' > /jmusic-bot/.version
		fi
	else
		echo "Check internet connection or dns settings"
	fi
fi

echo "Starting server"
java -Dnogui=true -jar $(ls JMusic*)