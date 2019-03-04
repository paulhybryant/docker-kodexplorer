# docker-kodexplorer
KodExplorer docker developement environment

Swith to the 'dev' branch
docker build . -t kod-dev

Assuming your plugin directories are in $PWD
docker run -p 8008:80 -v "$PWD":/plugins kod-dev

Or use the image with 'dev' tag
