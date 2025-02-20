# bash-ytdlp
<h1>English</h1>

<h2>Description</h2>
This is a simple bash script that simplifies working with yt-dlp and makes download video from YouTube more comfortable. <br>
Its main goal: to make it easier to download videos in a specific resolution.

<h2>Requirements</h2>
<ul>
  <li><b>Yt-dlp</b> - latest version (built-in support for the portable version from the <a href="https://github.com/yt-dlp/yt-dlp">official github repository</a>)</li>
  <li><b>Ffmpeg</b> - stable version</li>
</ul>
<h2>Usage</h2>
<h3>Install:</h3>

```bash
git clone https://github.com/wotoryze/bash-ytdlp
cd ./bash-ytdlp
chmod +x ./yt-downloader_EN.sh
```
<h3>First way:</h3>

```bash
./yt-downloader_EN.sh
```
And enter args

<h3>Second way</h3>

```bash
./yt-downloader_EN.sh <URL> (resolution) (path) (yt-dlp)
<> - required arguments
() - optional arguments
```
<h3>Arguments</h3>
<ul>
  <li><b>URL</b> - URL to video. <b>Required</b> argument</li>
  <li><b>resolution</b> - Video resolution. Default is "1080". For example - "720". <b>Optional</b> argument, if you want to skip this argument but not the next ones, replace it with "-".</li>
  <li><b>path</b> - Path to the directory where the video will be saved. Default is "~/Downloads/yt-download". For example - "/home/user/Video". <b>Optional</b> argument, if you want to skip this argument but not the next ones, replace it with "-".</li>
  <li><b>yt-dlp</b> - Path to yt-dlp (with filename), if you have the installed version of yt-dlp, enter "i", but I still recommend downloading the latest version as a file. Default is "i". For example - "./yt-dlp_linux". <b>Optional</b> argument, if you want to skip this argument but not the next ones, replace it with "-".</li>
</ul>

<h1>Русский</h1>

<h2>Описание</h2>
Это простой bash скрипт, который упрощает работу с yt-dlp и делает скачивание видео с YouTube более комфортным. <br>
Его основная цель: облегчить загрузку видео в определенном разрешении.

<h2>Требования</h2>
<ul>
  <li><b>Yt-dlp</b> - последняя версия (встроена поддержка файловой версии из <a href="https://github.com/yt-dlp/yt-dlp">оффициального github репозитория</a>)</li>
  <li><b>Ffmpeg</b> - стабильная версия</li>
</ul>
<h2>Использование</h2>
<h3>Установка:</h3>

```bash
git clone https://github.com/wotoryze/bash-ytdlp
cd ./bash-ytdlp
chmod +x ./yt-downloader_RU.sh
```
<h3>Первый способ:</h3>

```bash
./yt-downloader_RU.sh
```
И ввести аргументы.

<h3>Второй способ:</h3>

```bash
./yt-downloader_RU.sh <URL> (разрешение) (путь) (yt-dlp)
<> - обязательные аргументы
() - опциональные аргументы
```
<h3>Аргументы</h3>
<ul>
  <li><b>URL</b> - URL к видео. <b>Обязательный</b> аргумент</li>
  <li><b>разрешение</b> - Разрешение видео. По умолчанию - "1080". Например - "720". <b>Опциональный</b> аргумент, если вы хотите пропустить этот аргумент, но не следующие, замените его на "-".</li>
  <li><b>путь</b> - Путь к каталогу, в котором будет сохранено видео. По умолчанию - "~/Downloads/yt-download". Например - "/home/user/Video". <b>Опциональный</b> аргумент, если вы хотите пропустить этот аргумент, но не следующие, замените его на "-".</li>
  <li><b>yt-dlp</b> - Путь к yt-dlp (с именем файла), если у вас установочная ​​версия yt-dlp, введите «i», но я все же рекомендую скачать последнюю версию в виде файла. По умолчанию - "i". Например - "./yt-dlp_linux". <b>Опциональный</b> аргумент, если вы хотите пропустить этот аргумент, но не следующие, замените его на "-".</li>
</ul>
