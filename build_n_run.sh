if [ ! -d  $(pwd)/output ]; then
    mkdir  $(pwd)/output
fi

docker build --platform linux/amd64 -t amitex_fftp .
docker run -v $(pwd)/output:/mnt/output -i --rm -it amitex_fftp 
