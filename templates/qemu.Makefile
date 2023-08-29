# Makefile for QEMU/KVM Virtual Machine Management
## Variables/Ingredients
### General
cwd = $(CURDIR)
MAKEFILE ?= $(CURDIR)/$(shell basename $(CURDIR))

### Aliases
CPU := -cpu
DRIVE := -drive
DAEMON := -daemonize
MEMORY := -m
VNC := -vnc

### Virtual Machine and Systems
ARCHITECTURE ?= aarch64
VM_NAME ?= your_vm_name
VM_MEMORY ?= 1024
VM_OPTS ?= -machine virt-5.2 -daemonize
ISO_DISK_IMAGE ?= 
DRIVE_BOOT_ORDER ?= d
DRIVE_FILE_FORMAT ?= raw
SELECTED_PROCESS_ID ?=

### Hard Disk (.qow2/.vhd etc)
HARD_DISK_FORMAT ?= qcow2
HARD_DISK_FILE ?= alpine.qcow2
HARD_DISK_SIZE ?= 8G
HARD_DISK_CREATE_OPTS ?= 

### Display Out/Networking 
#### VNC Server
VNC_SERVER_IP ?= 127.0.0.1
VNC_SERVER_PORT ?= 5900
VNC_SERVER_MONITOR ?= 00
VNC_CLIENT_DIR ?= /usr/share/novnc
VNC_CLIENT_PORT ?= 6080
VNC_CLIENT_OPTIONS ?= 

### Environment
SHELL := /bin/bash
.PHONY := help all_variables all_targets show_variables create_img
.DEFAULT_RULES := help

## Recipes/Targets/Rules

### General
help:
	## Display Help
	@echo -e "==================="
	@echo -e "Display all targets"
	@echo -e "==================="
	@make -s all_targets -f ${MAKEFILE}
	@echo -e ""
	@echo -e "====================="
	@echo -e "Display all variables"
	@echo -e "====================="
	@make -s all_variables -f ${MAKEFILE}

all_variables:
	## Display Variables
	@echo -e "MAKEFILE              : Specify the directory and filename of the Makefile to run"
	@echo -e "ARCHITECTURE          : Specify the target machine CPU architecture to emulate/create/start the Virtual Machine in"
	@echo -e "VM_NAME               : Specify the Virtual Machine's name"
	@echo -e "VM_MEMORY             : Specify the Virtual Machine's Memory/RAM; Default: 1024"
	@echo -e "VM_OPTS               : Specify other options for the Virtual Machine to start with; Defaults: -machine virt-5.2 -daemonize"
	@echo -e "ISO_DISK_IMAGE        : Specifiy the Disk image (.iso etc) to mount to the cdrom parameter; Used for Installations/mounting CDROM"
	@echo -e "DRIVE_BOOT_ORDER      : Specify the disk drive's boot order (x = /dev/sdX; i.e. a = /dev/sda, b = /dev/sdb,...); Default: d (/dev/sdd)"
	@echo -e "DRIVE_FILE_FORMAT     : Specify the file format of the drive file on create; Default: raw"
	@echo -e "SELECTED_PROCESS_ID   : Specify a process ID to kill"
	@echo -e "HARD_DISK_FORMAT      : Specify format of the virtual drive to create (i.e. vhd/qcow2)"
	@echo -e "HARD_DISK_FILE        : Specify file name of the virtual drive to create"
	@echo -e "HARD_DISK_SIZE        : Specify file size of the virtual drive to create"
	@echo -e "HARD_DISK_CREATE_OPTS : Specify other options to include to the virtual drive to create"
	@echo -e "VNC_SERVER_IP         : Specify the IP Address of the VNC Server; Default: '127.0.0.1'"
	@echo -e "VNC_SERVER_PORT       : Specify the Port number of the VNC Server; Default: '5900'"
	@echo -e "VNC_SERVER_MONITOR    : Specify the Display Output Monitor number; Default: ':0' = 1st Monitor = '00'"
	@echo -e "VNC_CLIENT_DIR        : Specify the directory path of the Web/Browser-based VNC Client (NoVNC); Default: '/usr/share/novnc'"
	@echo -e "VNC_CLIENT_PORT       : Specify the port number of the Web/Browser-based VNC Client WebUI"
	@echo -e "VNC_CLIENT_OPTIONS    : Specify other options for the Web/Browser-based VNC Client WebUI"
    
all_targets:
	## Display Help
	@echo -e "all_targets        : Display all targets"
	@echo -e "show_variables     : Display all variables"
	@echo -e "show_usage         : Show all example usages, snippets and examples"
	@echo -e "show_process       : Show all QEMU processes"
	@echo -e "kill_process       : Kill the specified process (SELECTED_PROCESS_ID)"
	@echo -e "create_img         : Create QEMU Hard Disk image"
	@echo -e "start_vm_installer : Startup a Virtual Machine meant for installation (with .iso installer image)"
	@echo -e "start_vm_multiarch : Startup a Virtual Machine on different architectures"
	@echo -e "connect_novnc      : Connect VNC Server connection to Web/Browser-based VNC Client WebUI"

show_variables:
	## Show all current variables
	@echo -e "MAKEFILE              : ${MAKEFILE}"
	@echo -e "ARCHITECTURE          : ${ARCHITECTURE}"
	@echo -e "VM_NAME               : ${VM_NAME}"
	@echo -e "VM_MEMORY             : ${VM_MEMORY}"
	@echo -e "VM_OPTS               : ${VM_OPTS}"
	@echo -e "ISO_DISK_IMAGE        : ${ISO_DISK_IMAGE}"
	@echo -e "DRIVE_BOOT_ORDER      : ${DRIVE_BOOT_ORDER}"
	@echo -e "DRIVE_FILE_FORMAT     : ${DRIVE_FILE_FORMAT}"
	@echo -e "SELECTED_PROCESS_ID   : ${SELECTED_PROCESS_ID}"
	@echo -e "HARD_DISK_FORMAT      : ${HARD_DISK_FORMAT}"
	@echo -e "HARD_DISK_FILE        : ${HARD_DISK_FILE}"
	@echo -e "HARD_DISK_SIZE        : ${HARD_DISK_SIZE}"
	@echo -e "HARD_DISK_CREATE_OPTS : ${HARD_DISK_CREATE_OPTS}"
	@echo -e "VNC_SERVER_IP         : ${VNC_SERVER_IP}"
	@echo -e "VNC_SERVER_PORT       : ${VNC_SERVER_PORT}"
	@echo -e "VNC_SERVER_MONITOR    : ${VNC_SERVER_MONITOR}"
	@echo -e "VNC_CLIENT_DIR        : ${VNC_CLIENT_DIR}"
	@echo -e "VNC_CLIENT_PORT       : ${VNC_CLIENT_PORT}"
	@echo -e "VNC_CLIENT_OPTIONS    : ${VNC_CLIENT_OPTIONS}"

show_usage:
	## Show all example usages,snippets and examples
	@echo -e "- Specifying environment variables explicitly: 'VARIABLE_NAME=VALUE make -f \$$VARIABLE_NAME {rules/targets}'"
	@echo -e "- Basic Usage                                : 'ARCHITECTURE=[your-architecture] VM_NAME=vm-name VM_MEMORY=1024 VM_OPTS="-machine [machine-name] -daemonize" ISO_DISK_IMAGE="path-to-disk-image.iso" HARD_DISK_FILE="path-to-qcow2-file" DRIVE_BOOT_ORDER=a make -f qemu.Makefile [target|rules]'"
	@echo -e "- Use this Makefile from another directory   : 'MAKEFILE=[makefile-path] make -f \$$MAKEFILE {rules/targets}'"

show_process:
	## Show all QEMU processes
	@pgrep -lfa qemu

kill_process:
	## Kill the specified process
	@kill ${SELECTED_PROCESS_ID}

### Virtual Disk Image and Drives
create_img:
	## Create QEMU Hard Disk Image
	qemu-img create -f ${HARD_DISK_FORMAT} ${HARD_DISK_FILE} ${HARD_DISK_SIZE} ${HARD_DISK_CREATE_OPTS}

### Virtual Machine and System
start_vm_installer:
	## Start a Virtual Machine meant for installation (with .iso installer image)
	qemu-system-${ARCHITECTURE} -name ${VM_NAME} -m ${VM_MEMORY} ${VM_OPTS} -cdrom ${ISO_DISK_IMAGE} -vnc :${VNC_SERVER_MONITOR} -boot order=${DRIVE_BOOT_ORDER} -drive file=${HARD_DISK_FILE},format=${DRIVE_FILE_FORMAT}

start_vm_multiarch:
	## Start Virtual Machine on different architectures
	qemu-system-${ARCHITECTURE} -name ${VM_NAME} -m ${VM_MEMORY} ${VM_OPTS}

### VNC
connect_novnc:
	## Redirect VNC Server connection to Web/Browser-based VNC Client WebUI
	websockify -D --web=${VNC_CLIENT_DIR} ${VNC_CLIENT_OPTIONS} ${VNC_CLIENT_PORT} ${VNC_SERVER_IP}:59${VNC_SERVER_MONITOR}


