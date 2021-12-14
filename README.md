# dockerized-gitkraken-gui

Fork from [danielporto/dockerized-gitkraken-gui](https://github.com/danielporto/dockerized-gitkraken-gui),
and do some changes:

- debian:buster to `debian:buster-slim`
- golang:1.14-buster to `golang:1.16-buster`
- Add DataGrip
- Move out DataGrip, GoLand and IdeaUI from dockerfile
- Add Skype
- Remove `Keepassxc`, `BitWarden`

1. Download DataGrip, GoLand and IdeaUI,
2. Move to app,
3. Edit `menu.xml`