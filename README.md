# bash-ytdlp
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
chmod +x ./yt-downloader.sh
```
<h3>First way:</h3>

```bash
./yt-downloader_EN.sh
```
And enter args

<h3>Second way</h3>

```bash
./yt-downloader_EN.sh <URL> (resolution) (path) (yt-dlp) (cookies)
<> - required arguments
() - optional arguments
```
<h3>Arguments</h3>
<ul>
  <li><b>URL</b> - URL to video. <b>Required</b> argument</li>
  <li><b>resolution</b> - Video resolution. Default is "1080". For example - "720". <b>Optional</b> argument, if you want to skip this argument but not the next ones, replace it with "-".</li>
  <li><b>path</b> - Path to the directory where the video will be saved. Default is "~/Downloads/yt-download". For example - "/home/user/Video". <b>Optional</b> argument, if you want to skip this argument but not the next ones, replace it with "-".</li>
  <li><b>yt-dlp</b> - Path to yt-dlp (with filename), if you have the installed version of yt-dlp, enter "i", but I still recommend downloading the latest version as a file. Default is "i". For example - "./yt-dlp_linux". <b>Optional</b> argument, if you want to skip this argument but not the next ones, replace it with "-".</li>
  <li><b>cookies</b> - Path to text file with browser cookies, this may be needed for yt-dlp, if everything works for you without it, you can leave it out. <a href="https://github.com/yt-dlp/yt-dlp/wiki/FAQ#how-do-i-pass-cookies-to-yt-dlp">Why?</a> <b>Optional</b> argument. For example - "./cookies.txt".</li>
</ul>
