# docker-kodexplorer
KodExplorer docker developement environment

docker build . -t kod

docker run -p 8008:80 -v "$PWD/kodexplorer":/var/www/html kod
