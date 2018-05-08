song="";
artist="";
tempsong="";

#Notify with album artwork, song, and artist
notify () {

	#Grab artwork and save to /tmp/icon.icns
	id=`osascript -e "tell application \"Spotify\" to id of current track as string"`;
	url="$(curl -sX GET https://embed.spotify.com/oembed\?url\=$id | cut -d '"' -f 24)";
	eval $"curl -o /tmp/icon.icns $url";

	eval $"osascript -e 'display dialog \""$song"\" with title \""$artist"\" with icon alias \"Macintosh HD:tmp:icon.icns\"'"
	
	#Delete icon once finished
	eval $"rm /tmp/icon.icns"
}

while [ true ]; do

	#Grab current song and artist
	song=`osascript -e "tell application \"Spotify\" to name of current track as string"`;
	artist=`osascript -e "tell application \"Spotify\" to artist of current track as string"`;

	#Notify if song is new
	if [ "$song" != "$tempsong" ]; then
		tempsong=$song;
		notify;
	fi 

	#Check every second
	sleep 1;
done;
