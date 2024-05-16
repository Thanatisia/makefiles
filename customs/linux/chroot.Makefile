# Makefile to simplify and automate chrooting

## Ingredients/Variables

### Chroot/Root filesystem
chroot_bin ?= arch-chroot
chroot_opts ?=
rootfs_dir ?= "/mnt"

### Make
.DEFAULT_RULES := help
.PHONY := help

## Rules/Targets
help:
	## Display help
	@echo -e "help: Display this message"
	@echo -e "enter: Chroot and enter into the target root filesystem"

setup:
	## Prepare/Setup chroot pre-requisites
	### Mount Pseudo virtual filesystems before chroot
	

enter: setup
	## Chroot and enter/jump into the target root filesystem
	@${chroot_bin} ${chroot_opts} ${rootfs_dir}

