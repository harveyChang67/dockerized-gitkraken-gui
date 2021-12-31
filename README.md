# dockerized-gitkraken-gui

Fork from [danielporto/dockerized-gitkraken-gui](https://github.com/danielporto/dockerized-gitkraken-gui),
and there are some changes:

- debian:buster to `debian:buster-slim`
- golang:1.14-buster to `golang:1.16-buster`
- Install `DataGrip`, `GoLand` and `IdeaIU` from install_apps.sh
- Add `Skype`
- Comment the `Skype`, `Keepassxc`, `BitWarden` temporarily

Usage:
1. run docker-compose
2. run /src/install_apps.sh in `app` container

PS.
Start the VSCode for the first time, 