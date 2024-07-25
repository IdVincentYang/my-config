# vi: ft=sh
# [doc](https://just.systems/man/zh/)
# [grammar](https://github.com/casey/just/blob/master/GRAMMAR.md)
# [cheetsheet](https://cheatography.com/linux-china/cheat-sheets/justfile/)

kPWD := justfile_directory()

default:
    @just --justfile '{{justfile()}}' --list

var:
    @just --justfile '{{justfile()}}' --evaluate

install-asdf:
    brew install asdf
    ln -s "./asdf/tool-versions" "${HOME}/.tool-versions"

install-hammerspoon:
    brew install --cask --no-quarantine hammerspoon
    defaults write org.hammerspoon.Hammerspoon MJConfigFile "${XDG_CONFIG_HOME:-$HOME/.config}"/hammerspoon/init.lua


install-openvanilla:
    brew install openvanilla
    mkdir -p "${HOME}/Library/Application Support/OpenVanilla/UserData/TableBased/erbi.cin"
    ln -s "./backups/erbi/OpenVanilla/erbi.cin" "${HOME}/Library/Application Support/OpenVanilla/UserData/TableBased/erbi.cin"

install-iina:
    brew install --cask iina
    mkdir -p "${HOME}/Library/Application Support/com.colliderli.iina/input_conf/IINA_MY.conf"
    ln -s "${HOME}/.config/backups/iina/input_conf/IINA_MY.conf" "Library/Application Support/com.colliderli.iina/input_conf/IINA_MY.conf"
    


local-setup:
    #!/usr/bin/env bash
    set -euxo pipefail
    _LOCAL="${HOME}/.local"
    if [ ! -e "$_LOCAL" ]; then
        mkdir "$_LOCAL}"
    fi
    if [ -d "$_LOCAL" ]; then
        cd "$_LOCAL"
        if [ ! -e ".git" ]; then
            git init
        fi
        _GITIGNORE=.gitignore
        if [ ! -e "$_GITIGNORE" ]; then
            echo "/*" > .gitignore
            git add -f "$_GITIGNORE"
            git commit -m "[update] $_GITIGNORE"
        fi
        _GITMODULES=.gitmodules
        if [ ! -e "$_GITMODULES" ]; then
            touch "$_GITMODULES"
            git add -f "$_GITMODULES"
            git commit -m "[update] $_GITMODULES"
        fi
        _JUSTFILE=justfile
        if [[ ! -e "$_JUSTFILE" ]]; then
            ln -s "{{kPWD}}/justfile.local" "justfile"
        fi
    else
        echo "Invalid directory: $_LOCAL"
    fi

serv-pm2-setup:
    pm2 start "${HOME}/.local/bin/autoadb" -- "${HOME}/.config/backups/raycast/scirpt-commands/pixel4scrcpy.sh {}"
    pm2 start "/opt/homebrew/bin/openresty" --name serv_openresty_sites -- -c "${HOME}/Sites/nginx.conf" -e "${HOME}/Sites/_nginx/error.log" -g "daemon off;" -p "${HOME}/Sites/_nginx"
