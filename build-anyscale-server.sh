# export DOCKER_DEFAULT_PLATFORM=linux/amd64
# cd .devcontainer
# docker build . -t vscode-rayml
# docker run -v /Users/sofian/src:/home/ray --platform=linux/amd64 vscode-rayml
yarn
yarn gulp vscode-reh-web-linux-x64-min
tar -czf vscode-server-anyscale.tar ../vscode-reh-web-linux-x64
