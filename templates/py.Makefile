# Makefile
# for 
# Python projects

## Variables/Ingredients
### Interpreter/Runner
RUN = python
RUN_FLAGS = 

### Project
SRC_DIR = src/
SRC = main.py # Source files

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
	@echo -e "run      : Run the source files"

run:
	## Compile the source code, run and delete the files
	### Run python script
	${RUN} ${RUN_FLAGS} ${SRC_DIR}/${SRC} "parameters here"
