vlc -vvv input_stream --sout '#rtp{dst=192.168.8.8,port=1234,sdp=rtsp://localhost:8080/test.sdp}'
