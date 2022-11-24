# ReverseEngineeringInDocker
Docker image for Android reverse engineering tools. Android逆向工程工具Docker镜像

# Version

1. V1.0: Add vnc server, jdk 11, Jadx
2. V1.1: Add Homebrew
3. V1.2: Add Python, pyenv, pip3, setuptools
4. V1.3: Add frida

# Usage

- Build

```
docker build .
```

- Start

```
docker run -d --name YourName --shm-size 2G -P -p 8118:5901 -p 8119:6901 -e VNC_RESOLUTION=1920x1080 -e VNC_PW=ppllmmoo -v ~/:/metaworld:cached reverseengineeringindocker:VERSION
```

- Jadx

```
$HOME/jadx-gui
```

- Connect by vnc client

```
Port 8118
```

- Connect by Web Browser(HTML client)

```
http://HOST:8119/vnc.html
```

- Set VNC resolution depth and poassword

```
-e VNC_COL_DEPTH=24
-e VNC_COL_DEPTH=1920x1080
-e VNC_PW=PASSWD
```

- Run docker as root

```
--user 0
```

# LICENSE
```text
                    Apache License
                Version 2.0, January 2004
            http://www.apache.org/licenses/
```

