# Makefile to streamline the installation of each package
# by creating a virtual environment and installing into it

## Variables

### Environment Variables
ENV_VAR_PS1 ?= $(PS1)

### Git Packages
PROJECT_AUTHOR ?= author-name# Set this as the project author's name
PROJECT_NAME ?= project-name# Set as the target project repository name to clone
PROJECT_SUBDIRECTORY ?= .# Set as /path/to/project/root
GIT_REMOTE_REPOSITORY_SERVER ?= https://github.com# Set the git remote repository server ip address/domain

### Python
PY_EXEC ?= python

### Python PyPI Packages
PIP_DEPENDENCIES ?= -Ur requirements.txt# Set a list/array of all python pip packages to install via PyPI; Recommended: -Ur requirements.txt

### Virtual Environment Configurations
VENV_DIRECTORY ?= env
VENV_SCRIPTS ?= $(VENV_DIRECTORY)/Scripts
VENV_PYTHON_BIN ?= $(VENV_SCRIPTS)/$(PY_EXEC)
VENV_PROMPT ?= ($(VENV_DIRECTORY)) $(ENV_VAR_PS1)> #${PS1:-}

### Source Codes
SOURCE_FILE_DIR = .
SOURCE_FILE_NAME = main.py # Source file to be executed
ARGS ?= # CLI Arguments to be parsed into the file

## Rules/Targets
EDITOR ?= nvim
SHELL := /bin/bash
.PHONY := help setup
.DEFAULT_RULES := help

help:
	## display help menu
	@echo -e "help: Display Help Menu"
	@echo -e "usage: Display various usage snippets"
	@echo -e "setup : Perform pre-requisite setup"
	@echo -e "pip-install : Install python-pip if it does not exist using the 'ensurepip' python module"
	@echo -e "pip-script-install : Install python-pip if it does not exist using the 'get-pip.py' standalone script"
	@echo -e "pip-upgrade : Upgrade python-pip to the latest version"
	@echo -e "install-git : Install the specified project via a git repository"
	@echo -e "install-pip : Install the specified package via pip"
	@echo -e "get-venv-git-packages : chroots into the virtual environment and print the installed git repository packages"
	@echo -e "get-venv-pip-packages : chroots into the virtual environment and print the installed pip repository packages"
	@echo -e "get-venv-packages : chroots into the virtual environment and print the installed python packages"
	@echo -e "refresh-packages : Reinstall all packages/dependencies"
	@echo -e "edit : Passthrough and edit a file through the virtual environment"
	@echo -e "run : Passthrough/run a python file through the virtual environment"
	@echo -e "enter : Chroot into the Virtual Environments root filesystem"

usage:
	## Display usages
	@echo -e "install git and pip packages: PROJECT_NAME=[custom-package-to-install] make install-pip install-git"

setup:
	@test -d ${VENV_DIRECTORY} || ${PY_EXEC} -m venv ${VENV_DIRECTORY}

$(PROJECT_NAME): setup
	@${VENV_DIRECTORY}/Scripts/python -m pip install "git+${GIT_REMOTE_REPOSITORY_SERVER}/${PROJECT_AUTHOR}/${PROJECT_NAME}#subdirectories=${PROJECT_SUBDIRECTORY}"

pip-install:
	## Install python-pip if it does not exist using the 'ensurepip' python module
	@${VENV_PYTHON_BIN} -m ensurepip --upgrade

pip-script-install:
	## Install python-pip if it does not exist using the 'get-pip.py' standalone script
	@curl -L -O https://bootstrap.pypa.io/get-pip.py && \
		echo -e "[+] Python pip bootstrap installation script 'get-pip.py' downloaded successfully"; python get-pip.py || \
		echo -e "[-] Error downloading the Python pip bootstrap installation script 'get-pip.py'"

pip-upgrade:
	## Upgrade python-pip to the latest version
	@${VENV_PYTHON_BIN} -m pip install --upgrade pip

install-git: setup $(PROJECT_NAME)

install-pip: setup
	@${VENV_DIRECTORY}/Scripts/python -m pip install ${PIP_DEPENDENCIES}

get-venv-git-packages: setup
	@${VENV_DIRECTORY}/Scripts/python -m pip freeze list | grep "@"

get-venv-pip-packages: setup
	@${VENV_DIRECTORY}/Scripts/python -m pip freeze list | grep --invert-match "@"

get-venv-packages: setup
	@${VENV_DIRECTORY}/Scripts/python -m pip freeze list

refresh-packages: setup
	## Reinstall all packages/dependencies
	@${VENV_PYTHON_BIN} -m pip install -r requirements.txt --force-reinstall --no-cache-dir

edit: setup
	## Passthrough and edit a file through the virtual environment
	@test -f ${SOURCE_FILE_DIR}/${SOURCE_FILE_NAME} && \
		. ${VENV_DIRECTORY}/Scripts/activate && ${EDITOR} ${SOURCE_FILE_DIR}/${SOURCE_FILE_NAME} || \
		echo -e "Source File ${SOURCE_FILE_DIR}/${SOURCE_FILE_NAME} does not exists."

run: setup
	## Passthrough/run a python file through the virtual environment
	@test -f ${SOURCE_FILE_DIR}/${SOURCE_FILE_NAME} && \
		${VENV_DIRECTORY}/Scripts/python ${SOURCE_FILE_DIR}/${SOURCE_FILE_NAME} ${ARGS} || \
		echo -e "Source File ${SOURCE_FILE_DIR}/${SOURCE_FILE_NAME} does not exists."

enter: setup
	## Chroot into the Virtual Environments root filesystem
	## Command: $$SHELL --rcfile <(echo "export PS1=\"(utils-chroot) ${PS1:-}\"")
	@. ${VENV_DIRECTORY}/Scripts/activate && \
		$$SHELL --rcfile <(echo "export PS1=\"${VENV_PROMPT}\"")

