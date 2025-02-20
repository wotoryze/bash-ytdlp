#!/bin/bash

dError() {
  echo -e "\033[31mERROR in yt-dlp!"
  rm "${path}/video${rnd}"
  rm "${path}/audio${rnd}"
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

  if [[ $4 == "" ]]
  then
    dlp="i"
    dDlp="(default)"
  else
    dlp=$4
    dDlp=""
  fi

  echo "url: $url"
  echo "res: $res $dRes"
  echo "path: $path $dPath"
  echo "yt-dlp: $dlp $dDlp"
  echo ""
  sleep 1
fi

rnd=$RANDOM


echo -e "\033[33m_____________VIDEO_DOWNLOAD_____________\033[37m"
sleep 1
if [ $dlp == i ] 
then
  yt-dlp -S "height:$res" -f "bv*" -o "video${rnd}" --path $path $url || dError
else
  chmod +x "$dlp"
  "$dlp" -S "height:$res" -f "bv*" -o "video${rnd}" --path $path $url || dError
fi
echo -e "\033[33m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
echo ""
sleep 1


echo -e "\033[36m_____________AUDIO_DOWNLOAD_____________\033[37m"
sleep 1
if [ $dlp == i ] 
then
  yt-dlp -S "height:$res" -f "ba" -o "audio${rnd}" --path $path $url || dError
else
  "$dlp" -S "height:$res" -f "ba" -o "audio${rnd}" --path $path $url || dError
fi
echo -e "\033[36m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
sleep 1
echo ""


echo -e "\033[35m________________COMBINE_________________\033[37m"
sleep 1
ffmpeg -i "${path}/video${rnd}" -i "${path}/audio${rnd}" -c:v copy "${path}/result${rnd}.mp4"
echo -e "\033[35m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
echo ""


echo "Removing sources..."
rm "${path}/video${rnd}"
rm "${path}/audio${rnd}"
echo "Removed"
echo ""

echo "Renaming..."
if [ $dlp == i ] 
then
rname=$(yt-dlp --simulate --print "%(title)s" $url)
else
rname=$("$dlp" --simulate --print "%(title)s" $url)
fi
mv "${path}/result$rnd.mp4" "${path}/${rnd}-${rname}.mp4"
echo "Renamed"
echo ""

echo -e " \033[32m_________"
echo "|  Done!  |"
echo -e " ‾‾‾‾‾‾‾‾‾\033[37m"

echo -e "\033[34mВидео: ${path}/${rnd}-${rname}.mp4\033[37m"
read -sn1 -p "Press any key to exit..."; echo
exit 0
