# How to build and run [Amitex](https://amitexfftp.github.io/AMITEX/) in a Docker container

1. Install the Docker Engine. See https://docs.docker.com/engine/install/ for a guide.
2. Download the [Dockerfile](Dockerfile).
3. Build the container using the Dockerfile.
  - On GNU/Linux, MacOS or Windows1x-WSL:
    - From the terminal, run
      ```bash
      docker build --platform linux/amd64 -t amitex_fftp .
      ```
4. Run the container and test Amitex:
  - On GNU/Linux, MacOS or Windows1x-WSL:
    - From the terminal, run
      ```bash
      mkdir  $(pwd)/output
      docker run -v $(pwd)/output:/mnt/output -i --rm -it amitex_fftp
      ```
    - A new prompt will appear, e.g. :
      ```bash
      jovyan@b1b2776ac71f:/usr/local/src/amitex_fftp-v8.17.13/validation
      ```
    - To test Amitex, run:
      ```bash
      ./script_tests.sh > /mnt/output/output.txt 2> /mnt/output/error.txt
      ```
    - On the host, i.e. your actual computer, two new files (`/mnt/output/output.txt` and `/mnt/output/error.txt`) will be created.

