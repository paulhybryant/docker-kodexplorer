# docker-kodexplorer
KodExplorer docker developement environment

docker build . -t kod

Assuming your plugin directories are in $PWD
docker run -p 8008:80 -v "$PWD":/plugins kod
