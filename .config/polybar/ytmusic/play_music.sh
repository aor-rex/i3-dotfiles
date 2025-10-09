#!/usr/bin/env bash


#get api key from https://www.last.fm/api/account/create
API_KEY="yourlastfmapikey"
USER="lastfmusername"

# Fetch most recent track
data=$(curl -s "https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=$USER&api_key=$API_KEY&format=json&limit=1")


artist=$(echo "$data" | jq -r '.recenttracks.track[0].artist["#text"]')
title=$(echo "$data" | jq -r '.recenttracks.track[0].name')
nowplaying=$(echo "$data" | jq -r '.recenttracks.track[0]["@attr"].nowplaying')

player_status="$(playerctl status 2>/dev/null)"

if [ "$nowplaying" != "true" ] && [ "$player_status" = "Paused" ]; then
    exit 0
fi

# pausing & playing music
if [ "$nowplaying" = "true" ]; then
    song="$title - $artist"
    status_icon=""
else
    song="No Music"
    status_icon=""

fi

if [ "$player_status" = "Paused" ]; then
    status_icon=""
    song="(Paused) $song"
fi

yt_icon=""

controls="%{A1:playerctl previous:}%{A} %{A1:playerctl play-pause:}$status_icon%{A} %{A1:playerctl next:}%{A}"

echo "$yt_icon $song $controls"

