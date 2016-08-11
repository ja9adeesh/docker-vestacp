VestaCP on Docker [![Build Status](https://travis-ci.org/lagun4ik/dockerizedVestaCP.svg?branch=master)](https://travis-ci.org/lagun4ik/dockerizedVestaCP)
----

A dockerized version of VestaCP. [Without FTP server](#ssh-and-ftp).

## Usage

Running VestaCP docker image

`nginx + php7`
```bash
docker run -d \
  --restart=always \
  -p 2222:22 -p 80:80 -p 8083:8083 -p 3306:3306 -p 443:443 \
  -p 25:25 -p 993:993 -p 110:110  -p 53:53 -p 53:53/udp -p 54:54 \
  -v /var/vesta:/vesta \
  lagun4ik/vestacp:php7
```

`apache + nginx + php5`
```bash
docker run -d \
  --restart=always \
  -p 2222:22 -p 80:80 -p 8083:8083 -p 3306:3306 -p 443:443 \
  -p 25:25 -p 993:993 -p 110:110  -p 53:53 -p 53:53/udp -p 54:54 \
  -v /var/vesta:/vesta \
  lagun4ik/vestacp:latest
```



## Authorization

`Login: admin`
`Password: admin`

## Authorization mysql

`Login: root`
`Password: admin`

## SSH and FTP

Use SFTP instead of FTP.

SSH and SFTP are available on the `2222` port
