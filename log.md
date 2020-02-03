# Install VLC

[Официальный сайт](https://www.videolan.org/)

[Complete Guide for Using Snap Packages In Ubuntu and Other Linux Distributions](https://itsfoss.com/use-snap-packages-ubuntu-16-04/)

```sh
sudo -i
apt install snapd
snap install vlc
snap refresh vlc #--channel=stable#candidate#beta#edge
```

## Настройка VLM как переключателя потоков с управлением по http

Конфигурационный файл `conf.vlm`:  
```sh

# VLC media player VLM command batch
# http://www.videolan.org/vlc/

new cam1 broadcast
setup cam1 input "file:///media/technocrat/nix_part/projects/research_videolan/v1.mp4"
setup cam1 loop
setup cam1 output #transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:rtp{sdp=rtsp://:8554/virtcam}
setup cam1 option file-caching=1000

new cam2 broadcast
setup cam2 input "file:///media/technocrat/nix_part/projects/research_videolan/v2.mp4"
setup cam2 loop
setup cam2 output #transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:rtp{sdp=rtsp://:8554/virtcam}
setup cam2 option file-caching=1000

new cam3 broadcast
setup cam3 input "file:///media/technocrat/nix_part/projects/research_videolan/v3.mkv"
setup cam3 loop
setup cam3 output #transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:rtp{sdp=rtsp://:8554/virtcam}
setup cam3 option file-caching=1000

# setup cam1 enabled
# setup cam2 enabled
# setup cam3 enabled

# control cam1 play
# control cam2 play
# control cam3 play

```

Очень помогло с пониманием конфигурации:  
[How to Create a Linux VLC Streaming Media Server for Your Home](https://www.makeuseof.com/tag/create-linux-vlc-streaming-media-server-home/)

Запуск VLM, как сервера, с файлом конфигурации, с http управлением по адресу 192.168.8.5 на порту 8085, с паролем pass
```sh
/snap/bin/vlc -v --vlm-conf ./conf.vlm -I http --http-host 192.168.8.5 --http-port 8085 --http-password pass
```

Запуск VLC, как клиента
```sh
/snap/bin/vlc rtsp://192.168.8.5:8554/virtcam --no-qt-error-dialogs --loop --no-audio --no-video-title-show
```

## http запросы для управления трансляцией

[Активировать поток с камеры 1](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=setup%20cam1%20enabled)  
[Транслировать поток с камеры 1](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=control%20cam1%20play)

[Остановить поток с камеры 1](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=control%20cam1%20stop)  
[Дезактивировать поток с камеры 1](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=setup%20cam1%20disabled)

[Активировать поток с камеры 2](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=setup%20cam2%20enabled)  
[Транслировать поток с камеры 2](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=control%20cam2%20play)

[Остановить поток с камеры 2](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=control%20cam2%20stop)  
[Дезактивировать поток с камеры 2](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=setup%20cam2%20disabled)

[Активировать поток с камеры 3](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=setup%20cam3%20enabled)  
[Транслировать поток с камеры 3](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=control%20cam3%20play)

[Остановить поток с камеры 3](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=control%20cam3%20stop)  
[Дезактивировать поток с камеры 3](http://192.168.8.5:8085/requests/vlm_cmd.xml?command=setup%20cam3%20disabled)

[Посмотреть чего нибудь](http://192.168.8.5:8085/requests/vlm.xml)

## Очень полезная команда

Читать до конца, есть расширенный режим справки.

```sh
/snap/bin/vlc --help
```

## Источники

[Streaming HowTo/VLM](https://wiki.videolan.org/Documentation:Streaming_HowTo/VLM/#Advanced_example)  
[Control VLC via a browser](https://wiki.videolan.org/Control_VLC_via_a_browser/)  
[Modules/http intf](https://wiki.videolan.org/Documentation:Modules/http_intf/#VLC_2.0.0_and_later)  
[Streaming HowTo/Advanced Streaming Using the Command Line](https://wiki.videolan.org/Documentation:Streaming_HowTo/Advanced_Streaming_Using_the_Command_Line/)  
[Streaming HowTo/Command Line Examples](https://wiki.videolan.org/Documentation:Streaming_HowTo/Command_Line_Examples/)  
[Streaming HowTo/VLM](https://wiki.videolan.org/Documentation:Streaming_HowTo/VLM/)  
[VLC HTTP requests](https://wiki.videolan.org/VLC_HTTP_requests/)  
[]()
[]()
[]()
[]()

### Публичные Webcams

(http://95.215.176.83:10090/video49.mjpg)  
(http://95.215.176.83:8084/mjpg/video.mjpg)  
(http://62.117.66.226:5118/mjpg/video.mjpg)

#### Куча

```sh
/snap/bin/vlc /media/technocrat/nix_part/projects/research_videolan/MakingThePacific.mkv --sout '#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:rtp{sdp=rtsp://:8554/pubcam}'
/snap/bin/vlc http://95.215.176.83:10090/video49.mjpg --sout '#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:rtp{sdp=rtsp://:8554/pubcam}'
/snap/bin/vlc http://95.215.176.83:10090/video49.mjpg --sout '#transcode{vcodec=h264,vb=3500,width=1920,height=1080,acodec=mp3,ab=192,channels=2,samplerate=44100,scodec=none}:rtp{sdp=rtsp://:8554/pubcam}'
/snap/bin/vlc http://95.215.176.83:10090/video49.mjpg --sout '#standard{access=http,mux=ogg,dst=192.168.8.5:8080}'

/snap/bin/vlc http://95.215.176.83:10090/video49.mjpg --sout '#standard{access=http,mux=ogg,dst=192.168.8.5:8080}' -I http --http-host 192.168.8.5 --http-port 8085 --http-password vlan
```

Run on the client(s): 

```sh
vlc rtsp://192.168.8.5:8554/pubcam
```

```sh
#primary interface
-I http
--intf http

#secondary interface
--extraintf http
```

```sh
/snap/bin/vlc -I http --http-host 192.168.8.5 --http-port 8085 --http-password pass --vlm-conf ./conf.vlm --rtsp-host 0.0.0.0 --rtsp-port 554
```
