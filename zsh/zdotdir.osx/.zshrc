# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/zdotdir.osx/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################################################
# "read" Usage: read -r [VAR]
#   -r causes the string to be interpreted "raw" (without considering backslash escapes)
#
# extension="${basename##*.}"
# filename="${basename%.*}"
################################################################################

# 导出二笔输入法码表路径: Path of ErBi
export PEB="${XDG_CONFIG_HOME}/backups/erbi/OpenVanilla/erbi.cin"

# 导出 source.sparsebundle 的路径
export PSRC_BUNDLE="${HOME}/archives.noindex/Public/Source.sparsebundle"
export PSRC_DIR="/Volumes/Source"

export no_proxy="localhost, 127.0.0.1, ::1"

if [ $VIM ]; then
        export PS1='[VIM]\h:\w\$ '
fi

# Setting terminal proxy via clash
# source "${BASH_CFG}/proxy"
# proxyset -s "socks5h://127.0.0.1:7890" "http://127.0.0.1:7890"

source "${ZSH_CFG}/zshrc"

source "${BASH_CFG}/alias"
source "${BASH_CFG}/alias.osx"

source "$BASH_CFG/utils"

################################################################################
# command tools config begin:

# adb
if which adb > /dev/null; then
    # default android device: pixel4 XL
    export ANDROID_SERIAL="99031FFBA00CPX"
fi

# broot config
if which broot > /dev/null; then
    # This script was automatically generated by the broot program
    # More information can be found in https://github.com/Canop/broot
    # This function starts broot and executes the command
    # it produces, if any.
    # It's needed because some shell commands, like `cd`,
    # have no useful effect if executed in a subshell.
    function br {
        local cmd cmd_file code
        cmd_file=$(mktemp)
        if broot --outcmd "$cmd_file" "$@"; then
            cmd=$(<"$cmd_file")
            command rm -f "$cmd_file"
            eval "$cmd"
        else
            code=$?
            command rm -f "$cmd_file"
            return "$code"
        fi
    }
fi

# ffmpeg
# export FONTCONFIG_PATH=/usr/local/etc/fonts

# fzf config: https://github.com/junegunn/fzf.vim
if which fzf > /dev/null; then
    source $BASH_CFG/fzf
fi

# go config
# export GOPATH=~/go/.path
# export GOBIN=~/go/.bin
# export PATH=${GOBIN}:${PATH}

# java config
# JAVA_LAUNCHER_VERBOSE=1 # for debug?
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# homebrew
if which brew > /dev/null ; then
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

# wine config(no use on apple silicon)
# Override wine default storage folder $XDG_DATA_HOME to it's sub dir wineprefixes/default
#export WINE_PREFIX_ROOT="${XDG_DATA_HOME}/wineprefixes"
#export WINEPREFIX="${WINE_PREFIX_ROOT}/default"
# If want change wine environment, can source "$BASH_CFG/wine" for helper function:
#   - winenv
#   - wine
# After MacOS 10.15, MacOS don't support 32 bit binary, but 32 bit wine includes in wine-stable yet.
#   So WINEARCH must be win64 and alias 32 bit binaries to 64 bit version.
#export WINEARCH=win64
#alias wine=wine64

# Command tools config end.
################################################################################

#   If not in Warp.app load some zsh plugins.

if [[ ! "$__CFBundleIdentifier" =~ "warp" ]]; then
    source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # map ctrl+j, ctrl+k to history-substring-search
    source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

    bindkey "^n" history-substring-search-down
    bindkey "^p" history-substring-search-up

    bindkey "^j" down-line-or-history
    bindkey "^k" up-line-or-history
fi

# To customize prompt, run `p10k configure` or edit ${ZDOTDIR}/.p10k.zsh.
[[ ! -f "${ZDOTDIR}/.p10k.zsh" ]] || source "${ZDOTDIR}/.p10k.zsh"

export __ZDOTLOADED="$__ZDOTLOADED:$ZDOTDIR/.zshrc"
