# Makefile
# for VirtualBox

## Variables/Ingredients
### Device/Hardware variables
DISK_LABEL ?= "/dev/sdX"

### Hypervisor
HYPERVISOR = "VirtualBox"
HV_FLDR_BIN ?= "/path/to/hypervisor"
HV_MANAGE = "vboxmanage"
HV_HEADLESS = "vboxheadless"
HV_SDL = "vboxsdl"
HV_STOP = "vboxheadless"

### Storage/Virtual Disk variables
DISK_IMAGE_PATH ?= "/path/to/disk/image"
DISK_IMAGE_FILE ?= "disk.vdi"
DISK_IMAGE_SIZE ?= "xMiB"
VMDK_FILE_PATH ?= "/path/to/vmdk/"
VMDK_FILE_NAME ?= "file.vmdk"
VMDK_FILE_SIZE ?= "xMiB"

### Virtual Machine settings
VM_NAME ?= "vm-name"
VM_OPTS ?= "vm-opts"
VM_CONTROL_OPTS ?= 
INSPECT_OPTS ?= 
VRDE_PORT_NUMBER ?= 3389
VRDE_ADDRESS ?= 192.168.1.X

### System
# SHELL := /bin/bash
.PHONY := help help_Targets help_Variables
.DEFAULT_GOAL := help

## Others 
### Environment Variables
#### To Use: 
#### [ENV_VARIABLE=value] make {instructions}
CONF_OPTS =  # Configure Options

## Rules/Targets/Instructions

### General
help_Targets:
	## Display Rules/Targets
	@echo -e "======================="
	@echo -e " Rules/Targets "
	@echo -e "======================="
	@echo -e "General"
	@echo -e "\thelp_Targets         : Display all targets"
	@echo -e "\thelp_Variables       : Display all variables"
	@echo -e "\thelp                 : Display help menu"
	@echo -e "\tsetup                : Perform general setup"
	@echo -e "\tstart                : Begin/Startup Virtual Machine"
	@echo -e "\tvars                 : List all environment variables"
	@echo -e "Storage/Disk-related"
	@echo -e "\traw_disk_create      : Create RAW Disk file; Useful for booting up Physical devices in Virtual Machine"
	@echo -e "\traw_disk_attach      : Attach RAW disk file to Virtual Machine"
	@echo -e "\traw_disk_detach      : Detach RAW disk file from Virtual Machine"
	@echo -e "\tvirtual_disk_create  : Create a new (Virtual) Disk Image File for attaching"
	@echo -e "\tvirtual_disk_clone   : Clone a source Virtual Disk image to a new destination virtual disk image file; Set the SOURCE_VDI and DESTINATION_VDI variables"
	@echo -e "\tvirtual_disk_resize  : Resize Virtual Disk Image file to a new size; Specify the NEW_VDI_SIZE variable"
	@echo -e "\tvirtual_disk_mount   : Mount Virtual Disk Image file to a Virtual Machine"
	@echo -e "\tvirtual_disk_unmount : Unmount Virtual Disk Image file from Virtual Machine"
	@echo -e "\tvirtual_disk_unmount : Unmount Virtual Disk Image file from Virtual Machine"
	@echo -e "\tphysical_disk_mount   : Mount/Attach a physical disk (VMDK) file to a Virtual Machine"
	@echo -e "\tphysical_disk_unmount : Unmount/Detach a physical disk (VMDK) file from a Virtual Machine"
	@echo -e "Storage Controller-related"
	@echo -e "\tstorage_controller_create : Create a Storage Controller to attach to a Virtual Machine"
	@echo -e "VM/Hypervisor-focused"
	@echo -e "\tvm_create            : Create a Virtual Machine"
	@echo -e "\tvm_configure         : Allow user to specify settings they want to configure; Using the ${CONF_OPTS} environment variable"
	@echo -e "\tvm_configure_remote  : Configure Virtual Machine to be headless"
	@echo -e "\tvm_start_graphical   : Startup Virtual Machine with Graphical Environment"
	@echo -e "\tvm_start_headless    : Startup Virtual Machine headless"
	@echo -e "\tvm_control           : Allow user to manually specify what action to execute to the Virtual Machine's controls; Using environment variable ${VM_CONTROL_OPTS}"
	@echo -e "\tvm_pause             : Pause specified running Virtual Machine"
	@echo -e "\tvm_resume            : Resume specified paused Virtual Machine"
	@echo -e "\tvm_restart           : Restart the specified running Virtual Machine"
	@echo -e "\tvm_stop              : Stop specified Virtual Machine"
	@echo -e "\tvm_attach            : Attach to a detached Virtual Machine window (if it is running)"
	@echo -e "\tvm_show              : Show a hidden Virtual Machine window"
	@echo -e "\tvm_hide              : Hide a Virtual Machine window"
	@echo -e "\tvm_list              : List a hypervisor information using ${HV_MANAGE};  Please specify 'VM_LIST_KEYWORD=[your-search-query]"
	@echo -e "\tvm_list_all          : List all Virtual Machines"
	@echo -e "\tvm_list_running      : List all currently-running Virtual Machines"
	@echo -e "\tvm_inspect           : inspect and List Virtual Machine logs and information"
	@echo -e "VirtualBox-specific"
	@echo -e "\tvirtual_disk_unregister : De/unregister Virtual Disk from VirtualBox"
	@echo -e "\tvm_unregister        : De/unregister a registered Virtual Machine from VirtualBox"

help_Variables:
	## Display Help Variables
	@echo -e "======================="
	@echo -e " Variables             "
	@echo -e "======================="
	### Physical Device
	@echo -e "DISK_LABEL      : Contains your target disk/device/block label you want to boot with"
	### Storage Controller Related
	@echo -e "STORAGE_CONTROLLER_NAME : Contains the name of the Storage Controller device; Values: [SATA Controller, IDE Controller]"
	@echo -e "STORAGE_CONTROLLER_TYPE : Contains the type of the Storage Controller device; Values: [SATA, IDE]"
	@echo -e "STORAGE_CONTROLLER_DEVICE_INDEX : Contains the storage controller's device to attach the storage medium to"
	### Storage Medium Related
	@echo -e "STORAGE_MEDIUM_TYPE : Contains the type of storage medium you want to mount/attach; Valid Types: [hdd]"
	@echo -e "STORAGE_PORT_NUMBER : Contains the port you want to attach the storage to within the storage controller device"
	### Virtual Disk Image files
	@echo -e "DISK_IMAGE_PATH : Contains the path to your disk image file (.vdi, .vhd, .qcow2 etc)"
	@echo -e "DISK_IMAGE_FILE : Contains the disk image filename"
	@echo -e "DISK_IMAGE_SIZE : Contains the size of the Disk Image file"
	@echo -e "SOURCE_VDI      : Contains the source Virtual Disk Image you want to clone with"
	@echo -e "DESTINATION_VDI : Contains the destination Virtual Disk Image you want to clone to"
	@echo -e "NEW_VDI_SIZE    : Specify the new Virtual Disk Image file size to resize to"
	### Virtual Machine VMDK files
	@echo -e "VMDK_FILE_PATH  : Contains the path to your Virtual Machine's Disk file (.vmdk)"
	@echo -e "VMDK_FILE_NAME  : Contains the Virtual Machine Disk file name"
	@echo -e "VMDK_FILE_SIZE  : Contains the size of the Virtual Machine Disk file"
	### Hypervisor-related
	@echo -e "HV_FLDR_BIN     : Contains the Hypervisor's BIN folder containing the executables"
	@echo -e "HV_MANAGE       : Contains the Hypervisor's Management function/utility (i.e. VirtualBox = vboxmanage)"
	@echo -e "HV_HEADLESS     : Contains the Hypervisor's Headless startup function/utility (i.e. VirtualBox = vboxheadless)"
	@echo -e "HV_SDL          : Contains the Hypervisor's SDL command" 
	@echo -e "HV_STOP         : Contains the Hypervisor's Stop command"
	### Virtual Machine settings
	@echo -e "CONF_OPTS       : Contains your configuration options you want to modify the VM with"
	@echo -e "VM_NAME         : Contains the target Virtual Machine's name"
	@echo -e "VM_OPTS         : Contains the target Virtual Machine's additional/other configurations to startup with"
	@echo -e "VM_CONTROL_OPTS : Contains the target Virtual Machine's system control options (i.e. reset, poweroff, pause, etc)"
	@echo -e "VM_LIST_KEYWORD : Contains a target keyword to parse into a hypervisor's list function (i.e. VirtualBox = vboxmanage list keyword)"
	@echo -e "INSPECT_OPTS    : Contains additional options for inspecting/logging of specified Virtual Machine"
	### VirtualBox-related
	@echo -e "VRDE_ADDRESS    : Contains the IP address for your Virtualization RDP Engine (VRDE) server; Used for VirtualBox"
	@echo -e "VRDE_PORT_NUMBER: Contains the port number to startup your Virtualization RDP Engine (VRDE) server; Used for VirtualBox"

help:
	## Display help menu
	@make -s help_Targets 
	@echo -e ""
	@make -s help_Variables

setup:
	## Manage/Setup Environment

vars:
	## List all variables used in the Makefile
	### System/Environment Variables
	@echo -e "PATH            : ${PATH}"
	### Physical Device
	@echo -e "DISK_LABEL      : ${DISK_LABEL}"
	### Storage Controller Related
	@echo -e "STORAGE_CONTROLLER_NAME : ${STORAGE_CONTROLLER_NAME}"
	@echo -e "STORAGE_CONTROLLER_TYPE : ${STORAGE_CONTROLLER_TYPE}"
	@echo -e "STORAGE_CONTROLLER_DEVICE_INDEX : ${STORAGE_CONTROLLER_DEVICE_INDEX}"
	### Storage Medium Related
	@echo -e "STORAGE_MEDIUM_TYPE : ${STORAGE_MEDIUM_TYPE}"
	@echo -e "STORAGE_PORT_NUMBER : ${STORAGE_PORT_NUMBER}"
	### Virtual Disk Image files
	@echo -e "DISK_IMAGE_PATH : ${DISK_IMAGE_PATH}"
	@echo -e "DISK_IMAGE_FILE : ${DISK_IMAGE_FILE}"
	@echo -e "DISK_IMAGE_SIZE : ${DISK_IMAGE_SIZE}"
	@echo -e "SOURCE_VDI      : ${SOURCE_VDI}"
	@echo -e "DESTINATION_VDI : ${DESTINATION_VDI}"
	@echo -e "NEW_VDI_SIZE    : ${NEW_VDI_SIZE}"
	### Virtual Machine VMDK files
	@echo -e "VMDK_FILE_PATH  : ${VMDK_FILE_PATH}"
	@echo -e "VMDK_FILE_NAME  : ${VMDK_FILE_NAME}"
	@echo -e "VMDK_FILE_SIZE  : ${VMDK_FILE_SIZE}"
	### Hypervisor-related]
	@echo -e "HV_FLDR_BIN     : ${HV_FLDR_BIN}"
	@echo -e "HV_MANAGE       : ${HV_MANAGE}"
	@echo -e "HV_HEADLESS     : ${HV_HEADLESS}"
	@echo -e "HV_STOP         : ${HV_STOP}"
	### Virtual Machine settings
	@echo -e "CONF_OPTS       : ${CONF_OPTS}"
	@echo -e "VM_NAME         : ${VM_NAME}"
	@echo -e "VM_OPTS         : ${VM_OPTS}"
	@echo -e "VM_CONTROL_OPTS : ${VM_CONTROL_OPTS}"
	@echo -e "VM_LIST_KEYWORD : ${VM_LIST_KEYWORD}"
	@echo -e "INSPECT_OPTS    : ${INSPECT_OPTS}"
	### VirtualBox-related
	@echo -e "VRDE_ADDRESS    : ${VRDE_ADDRESS}"
	@echo -e "VRDE_PORT_NUMBER: ${VRDE_PORT_NUMBER}"

start:
	## Begin/Startup Virtual Machine
	### Change this according to the default start method
	@make -s vm_configure_remote vm_start_headless

### Storage-related
raw_disk_create:
	## Create RAW Disk file
	### Useful for booting up Physical devices in Virtual Machine
	${HV_MANAGE} internalcommands createrawvmdk -filename ${VMDK_FILE_PATH}/${VMDK_FILE_NAME} -rawdisk ${DISK_LABEL} -register

raw_disk_attach:
	## Attach RAW disk to the Virtual Machine
	${HV_MANAGE} storageattach ${VM_NAME} --storagectl ${STORAGE_CONTROLLER_NAME} --port ${STORAGE_PORT_NUMBER} --device ${STORAGE_CONTROLLER_DEVICE_INDEX} --type ${STORAGE_MEDIUM_TYPE} --medium ${VMDK_FILE_PATH}/${VMDK_FILE_NAME}

raw_disk_detach:
	## Detach/Remove RAW disk from the Virtual Machine
	${HV_MANAGE} storageattach ${VM_NAME} --storagectl ${STORAGE_CONTROLLER_NAME} --port ${STORAGE_PORT_NUMBER} --device ${STORAGE_CONTROLLER_DEVICE_INDEX} --type ${STORAGE_MEDIUM_TYPE} --medium none

virtual_disk_create:
	## Create Virtual Disk file for storage
	${HV_MANAGE} createmedium disk -filename ${DISK_IMAGE_PATH}/${DISK_IMAGE_FILE} --size ${DISK_IMAGE_SIZE}

virtual_disk_clone:
	## Clone an old virtual disk to new virtual disk
	${HV_MANAGE} clonemedium ${SOURCE_VDI} ${DESTINATION_VDI} --existing

virtual_disk_resize:
	## Resize VDI disks
	${HV_MANAGE} modifymedium disk ${DISK_IMAGE_PATH}/${DISK_IMAGE_FILE} --resize ${NEW_VDI_SIZE}

virtual_disk_mount:
	## Mount Virtual Drive to a target virtual machine
	${HV_MANAGE} storageattach ${VM_NAME} --storagectl ${STORAGE_CONTROLLER_TYPE} --port ${STORAGE_PORT_NUMBER} --medium ${DISK_IMAGE_PATH}/${DISK_IMAGE_FILE} --type ${STORAGE_MEDIUM_TYPE}

virtual_disk_unmount:
	## Unmount Virtual Drive from a target virtual machine
	${HV_MANAGE} storageattach ${VM_NAME} --storagectl ${STORAGE_CONTROLLER_TYPE} --port ${STORAGE_PORT_NUMBER} --medium none

virtual_disk_unregister:
	## Unregister a Virtual Disk from VirtualBox
	${HV_MANAGE} closemedium disk ${DISK_IMAGE_PATH}/${DISK_IMAGE_FILE}

physical_disk_mount:
	## Mount a Physical Disk/Device into a Virtual Machine
	@make -s raw_disk_attach

physical_disk_unmount:
	## Unmount a Physical Disk/Device from a Virtual Machine
	@make -s raw_disk_detach

### Storage Controller-related
storage_controller_create:
	## Create a Storage Controller and Prepare to attach RAW disk to Virtual Machine
	${HV_MANAGE} storagectl ${VM_NAME} --name ${STORAGE_CONTROLLER_NAME} --add ${STORAGE_CONTROLLER_TYPE}

### Virtual Machine/Hypervisor-focused
vm_create:
	## Create a new Virtual Machine and Register it with VirtualBox
	${HV_MANAGE} createvm -name ${VM_NAME} -register

vm_unregister:
	## De/Unregister a registered Virtual Machine from VirtualBox
	${HV_MANAGE} -name ${VM_NAME} --deregister

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

vm_attach:
	## Attach to a detach Virtual Machine window
	${HV_SDL} --startvm ${VM_NAME} --separate &

vm_show:
	## Show a hidden Virtual Machine GUI
	@echo -e "Showing hidden Virtual Machine ${VM_NAME}"
	${HV_MANAGE} startvm ${VM_NAME} --type separate

vm_hide:
	## Hide a Virtual Machine Display
	@echo -e "Hiding Virtual Machine ${VM_NAME}"
	@echo -e "WIP"

vm_list:
	## List a Virtual Machine specified by user
	${HV_MANAGE} list ${VM_LIST_KEYWORD}

vm_list_all:
	## List all Virtual Machines
	${HV_MANAGE} list vms

vm_list_running:
	## List all running Virtual Machines
	${HV_MANAGE} list runningvms

vm_inspect:
	## inspect and List Virtual Machine logs and information
	${HV_MANAGE} showvminfo ${VM_NAME} ${INSPECT_OPTS}

