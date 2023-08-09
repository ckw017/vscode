# export DOCKER_DEFAULT_PLATFORM=linux/amd64
# cd .devcontainer
# docker build . -t vscode-rayml
# docker run -v /Users/cwong/vscode:/home/ray/vscode vscode-rayml
yarn
yarn gulp vscode-reh-web-linux-x64-min
tar -czf vscode-server-anyscale.tar ../vscode-reh-web-linux-x64
