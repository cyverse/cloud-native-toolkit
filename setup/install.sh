#!/bin/bash

if [ `id -u` -ne 0 ]; then
    echo
    echo "You must execute this script as either root or use 'sudo $0'"
    echo "exiting..."
    echo
    exit 1
fi


# function detect_distro
# description detect the distro, borrowed from https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script
detect_distro () {
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        # Older SuSE/etc.
        :
    elif [ -f /etc/redhat-release ]; then
        # Older Red Hat, CentOS, etc.
        :
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
        VER=$(uname -r)
    fi
}

install_ansible_Ubuntu() {
    apt-get install -y ansible
    if [ $? != 0 ]; then
        echo "?Could not install ansible, this may be ok"
        exit 1
    fi
}

detect_distro

if [ -z "$OS" -o -z "$VER" ]; then
    echo "OS or VERSION is not supported. You will need to setup the toolkit separate. Refer to README.md."
else
    echo "Detected $OS $VER"
fi

echo "Installing ansible"
eval install_ansible_$OS

if [ -f ansible/requirements.yaml ]; then
    echo "Installing requirements.yaml"
    ansible-galaxy install -r ansible/requirements.yaml
    if [ $? != 0 ]; then
        echo "?Could not install ansible galaxy roles, this may be ok"
    fi
fi

echo "Executing setup playbook"
ansible-playbook ansible/setup.yaml
if [ $? != 0 ]; then
    echo "?The installation process failed."
fi