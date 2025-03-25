#!/bin/bash

dError() {
  echo -e "\033[31mERROR in yt-dlp!"
  if [ -f "${path}/video${rnd}" ]
  then
    rm "${path}/video${rnd}"
  fi
  if [ -f "${path}/audio${rnd}" ]
  then
    rm "${path}/audio${rnd}"
  fi
  exit 1
}

fError() {
  echo -e "\033[31mERROR in ffmpeg!"
  rm "${path}/video${rnd}"
  rm "${path}/audio${rnd}"
  if [ -f "${path}/result${rnd}.mp4" ]
  then
    rm "${path}/result${rnd}.mp4"
  fi
  exit 1
}

uError() {
  echo -e "\033[31mUnknown ERROR!"
  rm "${path}/result${rnd}.mp4"
  rm "${path}/${rnd}-${rname}.mp4"
  exit 1
}

if [[ $1 == "" ]]
then
  read -p "Enter URL: " url
  read -p "Enter resolution: " res
  if [[ $res == "" ]] || [[ $res == "-" ]]
  then
    res="1080"
  fi
  read -p "Enter the directory path for the video: " path
  if [[ $path == "" ]] || [[ $path == "-" ]]
  then
    path="$(xdg-user-dir DOWNLOAD)/yt-download"
  fi
  read -p "Enter the path to yt-dlp (with file name) (i - installation version): " dlp
  if [[ $dlp == "" ]] || [[ $dlp == "-" ]]
  then
    dlp="i"
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

  if [[ $5 == "" ]] || [[ $5 == "-" ]]
  then
    cookies=""
  else
    cookies="--cookies "$5 
  fi

  echo "url: $url"
  echo "res: $res $dRes"
  echo "path: $path $dPath"
  echo "dlp: $dlp $dDlp"
  echo "cookies: $5" 
  echo ""
fi

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


echo -e "\033[33m_____________VIDEO_DOWNLOAD_____________\033[37m"
sleep 1
if [ $dlp == i ] 
then
  yt-dlp ${cookies} -S "height:$res" -f "bv*" -o "video${rnd}" --path $path $url || dError
else
  "$dlp" ${cookies} -S "height:$res" -f "bv*" -o "video${rnd}" --path $path $url || dError
fi
echo -e "\033[33m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
echo ""
sleep 1


echo -e "\033[36m_____________AUDIO_DOWNLOAD_____________\033[37m"
sleep 1
if [ $dlp == i ] 
then
  yt-dlp ${cookies} -S "height:$res" -f "ba" -o "audio${rnd}" --path $path $url || dError
else
  "$dlp" ${cookies} -S "height:$res" -f "ba" -o "audio${rnd}" --path $path $url || dError
fi
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
mv "${path}/result$rnd.mp4" "${path}/${rnd}-${rname}.mp4" || uError
echo "Renamed"
echo ""
sleep 1

echo -e " \033[32m_________"
echo "|  Done!  |"
echo -e " ‾‾‾‾‾‾‾‾‾\033[37m"

echo -e "\033[34mVideo: '${path}/${rnd}-${rname}.mp4'\033[37m"
if [[ $1 == "" ]]
then
  read -sn1 -p "Press any key to exit..."; echo
fi
echo ""
exit 0
