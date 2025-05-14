#!/bin/bash

dError() {
  echo -e "\033[31mERROR in yt-dlp!"
  rm "${path}/video${rnd}" 2> /dev/null
  rm "${path}/audio${rnd}" 2> /dev/null
  exit 1
}

fError() {
  echo -e "\033[31mERROR in ffmpeg!"
  rm "${path}/video${rnd}" 2> /dev/null
  rm "${path}/audio${rnd}" 2> /dev/null
  rm "${path}/result${rnd}.mp4" 2> /dev/null
  exit 1
}

uError() {
  echo -e "\033[31mUnknown ERROR!"
  rm "${path}/video${rnd}" 2> /dev/null
  rm "${path}/audio${rnd}" 2> /dev/null
  rm "${path}/result${rnd}.mp4" 2> /dev/null 
  exit 1
}

if [[ $1 == "" ]]
then
  read -p "Enter URL: " url
  read -p "Enter resolution: [def: 1080 (ENTER)] " res
  if [[ $res == "" ]] || [[ $res == "-" ]]
  then
    res="1080"
  fi
  read -p "Enter the directory path for the video: [def: ~/Downloads/yt-download (ENTER)] " path
  if [[ $path == "" ]] || [[ $path == "-" ]]
  then
    path="$(xdg-user-dir DOWNLOAD)/yt-download"
  fi
  read -p "Enter the path to yt-dlp (with file name) (i - installation version): [def: i (ENTER)] " dlp
  if [[ $dlp == "" ]] || [[ $dlp == "-" ]]
  then
    dlp="i"
  fi
  
  read -p "Choose mode old/new: [def: new (ENTER)] " mode
  if [[ $mode == "old" ]]
  then
    mode="old"
  else
    mode="new"
  fi

  read -p "Enter the path to cookies (.txt) (or press ENTER, but may not work): " cookies
  if [[ $cookies == "" ]] || [[ $cookies == "-" ]]
  then
    cookies=""
  else
    cookies="--cookies "$cookies
  fi
  echo ""
else
  echo -e "\033[32m═══════MODE═OF═VARs═FROM═ARGUMENTS═══════\033[37m"
  url=$1
  
  if [[ $2 == "" ]] || [[ $2 == "-" ]]
  then
    res="1080"
    dRes="(default)"
  else
    res=$2
    dRes=""
  fi
  
  if [[ $3 == "" ]] || [[ $3 == "-" ]]
  then
    path="$(xdg-user-dir DOWNLOAD)/yt-download"
    dPath="(default)"
  else
    path=$3
    dPath=""
  fi

  if [[ $4 == "" ]] || [[ $4 == "-" ]]
  then
    dlp="i"
    dDlp="(default)"
  else
    dlp=$4
    dDlp=""
  fi

  if [[ $5 == "old" ]] 
  then
    mode="old"
  else
    mode="new"
  fi

  if [[ $6 == "" ]] || [[ $6 == "-" ]]
  then
    cookies=""
    cook="none"
  else
    cookies="--cookies "$6  
    cook="$6"
  fi

  echo "url: $url"
  echo "res: $res $dRes"
  echo "path: $path $dPath"
  echo "dlp: $dlp $dDlp"
  echo "mode: $mode"
  echo "cookies: $cook" 
  echo ""
fi

if [[ $mode == "old" ]]
then

echo "Getting title..."
if [ $dlp == i ] 
then
  rname=$(yt-dlp ${cookies} --simulate --print "%(title)s" $url)
else
  chmod +x "$dlp"
  rname=$("$dlp" ${cookies} --simulate --print "%(title)s" $url)
fi
rname=${rname//'/'/'_'}
rname=${rname//' '/'_'}
rname=${rname//'\'/'_'}
rname=${rname//'|'/'_'}
rname=${rname//'$'/'_'}
rname=${rname//'#'/'_'}
rname=${rname//'"'/'_'}
rname=${rname//"'"/'_'}
rname=${rname//'?'/'_'}
rname=${rname//'!'/'_'}
if [ $rname == "" ]
then
  dError
fi
echo "Title: $rname"
echo ""
sleep 1

rnd=$RANDOM


if [[ $dlp == "i" ]]
then
  dlp=yt-dlp
fi

echo -e "\033[33m_____________VIDEO_DOWNLOAD_____________\033[37m"
sleep 1
"$dlp" ${cookies} -S "height:$res" -f "bv*" -o "video${rnd}" --path $path $url || dError
echo -e "\033[33m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
echo ""
sleep 1


echo -e "\033[36m_____________AUDIO_DOWNLOAD_____________\033[37m"
sleep 1
"$dlp" ${cookies} -S "height:${res}" -f "ba" -o "audio${rnd}" --path "${path}" $url || dError
echo -e "\033[36m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
sleep 1
echo ""


echo -e "\033[35m________________COMBINE_________________\033[37m"
sleep 1
ffmpeg -i "${path}/video${rnd}" -i "${path}/audio${rnd}" -c:v copy "${path}/result${rnd}.mp4" || fError
echo -e "\033[35m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
echo ""


echo "Removing sources..."
rm "${path}/video${rnd}"
rm "${path}/audio${rnd}"
echo "Removed"
echo ""
sleep 1

echo "Renaming..."
mv "${path}/result$rnd.mp4" "${path}/${rname}.mp4" || uError
echo "Renamed"
echo ""

rname=${path}/${rname}.mp4

else
  echo -e "\033[33m_____________VIDEO_DOWNLOAD_____________\033[37m"
  yt-dlp ${cookies} -S "height:${res}" --path "${path}" "$url" || dError
  echo -e "\033[33m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
  rname=$(find "${path}" -name "*.*" -printf "%T@ %Tc %p\n" | sort -n | head -n 1)
  words=($rname)
  rname="${words[@]:6}"
fi

sleep 1

echo -e " \033[32m_________"
echo "|  Done!  |"
echo -e " ‾‾‾‾‾‾‾‾‾\033[37m"

echo -e "\033[34mVideo: '${rname}'\033[37m"
if [[ $1 == "" ]]
then
  read -sn1 -p "Press any key to exit..."; echo
fi
echo ""
exit 0
