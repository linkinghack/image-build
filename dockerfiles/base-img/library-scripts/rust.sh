#!/bin/bash

set -ex

USERNAME=${1:-"automatic"}
UPDATE_RC=${2:-"true"}

CURRENT_ARCH=$(uname -m)

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in ${POSSIBLE_USERS[@]}; do
        if id -u ${CURRENT_USER} > /dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} > /dev/null 2>&1; then
    USERNAME=root
fi

updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating ./etc/bash.bashrc and ./etc/zsh/zshrc..."
        if [[ "$(cat ./etc/bash.bashrc)" != *"$1"* ]]; then
            echo -e "$1" >> ./etc/bash.bashrc
        fi
        if [ -f "./etc/zsh/zshrc" ] && [[ "$(cat ./etc/zsh/zshrc)" != *"$1"* ]]; then
            echo -e "$1" >> ./etc/zsh/zshrc
        fi
    fi
}

# Download and install
sudo -u ${USERNAME} curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo -u ${USERNAME} sh -s -- -y -v --profile complete

# Update rc setting
updaterc "$(cat << EOF
case ":${PATH}:" in
    *:"/home/${USERNAME}/.cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="/home/${USERNAME}/.cargo/bin:$PATH"
        ;;
esac
EOF
)"
