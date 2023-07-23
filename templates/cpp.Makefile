# Makefile
# for 
# C++ projects

## Variables/Ingredients
### Build systems
CC = g++
CFLAGS = 
BUILD_DIR = build/
PREFIX = /usr/local/bin

### Project
SRC = main.cpp # Source files
OUT = main.o # Object files
BIN = project-name # Binary files

.PHONY := help
.DEFAULT_RULES := help

## Rules/Targets/Instructions

### Object Builds

### General
help:
	## Display Help menu
	@echo -e "help     : Display this help menu"
	@echo -e "build    : Build/Compile/Make source files into binary"
	@echo -e "clean    : Clean/Remove all temporary files generated during compilation"
	@echo -e "install  : Install the compiled files into the system"
	@echo -e "uninstall: Uninstall/remove the compiled files from the system"
	@echo -e "run      : Compile the source code, run and delete the files"

build: 
	## Build/Compile/Make source files into binary
	### Generate object files
	@${CC} ${CFLAGS} ${SRC} -c

	### Compile using object files
	@${CC} ${CFLAGS} ${OBJ} -o ${BIN}

install:
	## Install the compiled files into the system
	@install -m 0755 ${BUILD_DIR}/${BIN} ${PREFIX}

uninstall:
	## Uninstall/remove the compiled files from the system
	@rm ${PREFIX}/${BIN}

run:
	## Compile the source code, run and delete the files
	### Compile source file
	@make -s build

	### Run the binary
	@./${BUILD_DIR}/${BIN} 

	### Delete built files 
	@rm ${BUILD_DIR}/${BIN}

clean:
	## Clean/Remove all temporary files generated during compilation
	@rm -r ${BUILD_DIR}

