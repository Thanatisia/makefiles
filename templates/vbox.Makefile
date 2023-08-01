# Makefile
# for VirtualBox

## Variables/Ingredients
### Hypervisor
HYPERVISOR = "VirtualBox"
HV_MANAGE = "vboxmanage"
HV_HEADLESS = "vboxheadless"
HV_STOP = "vboxheadless"

### Virtual Machine settings
VM_NAME = "vm-name"
VM_OPTS = "vm-opts"
VM_CONTROL_OPTS = ""
VRDE_PORT_NUMBER = 3389
VRDE_ADDRESS = 192.168.1.X

### System
# SHELL := /bin/bash
.PHONY := help
.DEFAULT_RULES := help

## Others 
### Environment Variables
#### To Use: 
#### [ENV_VARIABLE=value] make {instructions}
CONF_OPTS =  # Configure Options

## Rules/Targets/Instructions

### General
help:
	## Display help menu
	@echo -e "help                   : Display help menu"
	@echo -e "General"
	@echo -e "\tstart                : Begin/Startup Virtual Machine"
	@echo -e "\tvars                 : List all environment variables"
	@echo -e "VM/Hypervisor-focused"
	@echo -e "\tvm_configure         : Allow user to specify settings they want to configure; Using the ${CONF_OPTS} environment variable"
	@echo -e "\tvm_configure_remote  : Configure Virtual Machine to be headless"
	@echo -e "\tvm_start_graphical   : Startup Virtual Machine with Graphical Environment"
	@echo -e "\tvm_start_headless    : Startup Virtual Machine headless"
	@echo -e "\tvm_control           : Allow user to manually specify what action to execute to the Virtual Machine's controls; Using environment variable ${VM_CONTROL_OPTS}"
	@echo -e "\tvm_pause             : Pause specified running Virtual Machine"
	@echo -e "\tvm_resume            : Resume specified paused Virtual Machine"
	@echo -e "\tvm_restart           : Restart the specified running Virtual Machine"
	@echo -e "\tvm_stop              : Stop specified Virtual Machine"
	@echo -e "\tvm_list              : List a hypervisor information using ${HV_MANAGE};  Please specify 'VM_LIST_KEYWORD=[your-search-query]"
	@echo -e "\tvm_list_all          : List all Virtual Machines"
	@echo -e "\tvm_list_running      : List all currently-running Virtual Machines"

start:
	## Begin/Startup Virtual Machine
	### Change this according to the default start method
	@make -s vm_configure_remote vm_start_headless

vars:
	## List all variables used in the Makefile
	@echo -e "CONF_OPTS       : ${CONF_OPTS}"
	@echo -e "HV_MANAGE       : ${HV_MANAGE}"
	@echo -e "HV_HEADLESS     : ${HV_HEADLESS}"
	@echo -e "HV_STOP         : ${HV_STOP}"
	@echo -e "VM_NAME         : ${VM_NAME}"
	@echo -e "VM_OPTS         : ${VM_OPTS}"
	@echo -e "VM_CONTROL_OPTS : ${VM_CONTROL_OPTS}"
	@echo -e "VM_LIST_KEYWORD : ${VM_LIST_KEYWORD}"
	@echo -e "VRDE_ADDRESS    : ${VRDE_ADDRESS}"
	@echo -e "VRDE_PORT_NUMBER: ${VRDE_PORT_NUMBER}"


### Virtual Machine/Hypervisor-focused
vm_configure:
	## Allow user to specify settings they want to configure
	## Using the ${CONF_OPTS} environment variable
	${HV_MANAGE} modifyvm ${VM_NAME} ${CONF_OPTS}

vm_configure_remote:
	## Configure Virtual Machine to be headless
	${HV_MANAGE} modifyvm ${VM_NAME} --vrde on --vrdeport ${VRDE_PORT_NUMBER} --vrdeaddress ${VRDE_ADDRESS}

vm_start_graphical:
	## Startup Virtual Machine with graphical
	${HV_MANAGE} startvm ${VM_NAME} ${VM_OPTS}

vm_start_headless:
	## Startup Virtual Machine headless
	# @${HV_HEADLESS} ${VM_NAME} --vrde on -vrdeport ${VRDE_PORT_NUMBER} -vrdeaddress ${VRDE_ADDRESS} &
	## Same as
	## vboxmanage startvm "vm-name" --type headless
	${HV_HEADLESS} --startvm ${VM_NAME} ${VM_OPTS} &

vm_control:
	## Allow user to manually specify what action to execute to the Virtual Machine's controls
	## Using environment variable ${VM_CONTROL_OPTS}
	@echo -e "${VM_CONTROL_OPTS} Virtual Machine ${VM_NAME}"
	${HV_MANAGE} controlvm ${VM_NAME} ${VM_CONTROL_OPTS}

vm_pause:
	## Pause the specified running Virtual Machine
	@echo -e "Pause Virtual Machine ${VM_NAME}"
	${HV_MANAGE} controlvm ${VM_NAME} pause

vm_resume:
	## Resume the specified paused Virtual Machine
	@echo -e "Resuming Virtual Machine ${VM_NAME}"
	${HV_MANAGE} controlvm ${VM_NAME} resume

vm_restart:
	## Restart the specified running Virtual Machine
	@echo -e "Restart Virtual Machine ${VM_NAME}"
	${HV_MANAGE} controlvm ${VM_NAME} reset

vm_stop:
	## Stop the specified Virtual Machine
	@echo -e "Stop Virtual Machine ${VM_NAME}"
	## ${HV_MANAGE} controlvm ${VM_NAME} acpipowerbutton]
	${HV_MANAGE} controlvm ${VM_NAME} poweroff

vm_list:
	## List a Virtual Machine specified by user
	${HV_MANAGE} list ${VM_LIST_KEYWORD}

vm_list_all:
	## List all Virtual Machines
	${HV_MANAGE} list vms

vm_list_running:
	## List all running Virtual Machines
	${HV_MANAGE} list runningvms


