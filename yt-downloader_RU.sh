#!/bin/bash

dError() {
  echo -e "\033[31mОШИБКА В yt-dlp!"
  rm "${path}/video${rnd}"
  rm "${path}/audio${rnd}"
  exit 1
}

if [[ $1 == "" ]]
then
  read -p "Введите URL: " url
  read -p "Введите разрешение: " res
  if [[ $res == "" ]] || [[ $res == "-" ]]
  then
    res="1080"
  fi
  read -p "Введите путь к каталогу с видео: " path
  if [[ $path == "" ]] || [[ $path == "-" ]]
  then
    path="$(xdg-user-dir DOWNLOAD)/yt-download"
  fi
  read -p "Введите путь до yt-dlp (с названием файла) (i - установочная версия): " dlp
  if [[ $dlp == "" ]] || [[ $dlp == "-" ]]
  then
    dlp="i"
  fi
  echo ""
else
  echo -e "\033[32m═════РЕЖИМ═ПЕРЕМЕННЫХ═ИЗ═АРГУМЕНТОВ═════\033[37m"
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


echo -e "\033[33m____________СКАЧИВАНИЕ_ВИДЕО____________\033[37m"
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


echo -e "\033[36m____________СКАЧИВАНИЕ_АУДИО____________\033[37m"
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


echo -e "\033[35m______________ОБЪЕДИНЕНИЕ_______________\033[37m"
sleep 1
ffmpeg -i "${path}/video${rnd}" -i "${path}/audio${rnd}" -c:v copy "${path}/result${rnd}.mp4"
echo -e "\033[35m‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\033[37m"
echo ""


echo "Удаление исходников..."
rm "${path}/video${rnd}"
rm "${path}/audio${rnd}"
echo "Удалено"
echo ""

echo "Переименовывание..."
if [ $dlp == i ] 
then
rname=$(yt-dlp --simulate --print "%(title)s" $url)
else
rname=$("$dlp" --simulate --print "%(title)s" $url)
fi
mv "${path}/result$rnd.mp4" "${path}/${rnd}-${rname}.mp4"
echo "Переименовано"
echo ""

echo -e " \033[32m_________"
echo "| Готово! |"
echo -e " ‾‾‾‾‾‾‾‾‾\033[37m"

echo -e "\033[34mВидео: ${path}/${rnd}-${rname}.mp4\033[37m"
read -sn1 -p "Нажмите любую клавишу чтобы выйти..."; echo
exit 0
