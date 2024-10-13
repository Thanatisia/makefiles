# Makefile for golang

## Ingredients/Variables
### Compiler
GO_CC ?= go
GO_FLAGS ?= 
GO_RUN ?= .
GO_RUN_FLAGS?= # Define the CLI argument flags to parse/pass into the application
GO_ENTRYPOINT ?= . # Define your entry point source file 'main.go' path here

### Project sources
#### Package/library/module Dependencies
PKG_DEPS ?= # Specify your package dependencies to download/install/'get' here; i.e GitHub: github.com/author/package-name; Separate each package/module/library repository server URL with a space delimiter (' ')
#### Output directories
OUT_DIR ?= dist/bin
#### Output binary files
OUT_BIN ?= output.exe
#### Complete output destination filepath and filename
OUT_PATH ?= $(OUT_DIR)/$(OUT_BIN)

### Temporary environment variables
MOD_NAME ?= # For defining the 'package/module' alias to add to 'go.mod'
MOD_PATH ?= # For defining the path mapping/pointing to the alias to add to 'go.mod'

SHELL = /usr/bin/bash
.DEFAULT_RULES := help
.PHONY := help

## Multi-line Data Variable Definitions
define go_snippet_main
// Define module's package
package main

// Import dependencies and packages here
import (
	"fmt"
)

// Define main entry point function
func main() {
	fmt.Println("Hello World");
}
endef
export go_snippet_main

## Rules/Target/Recipe

help:
	## Display help menu
	@echo -e "help : Display this help menu"
	@echo -e "setup: Perform pre-requisite dependencies and project structure setup"
	@echo -e "build: Locally build the source files and output the executable/binary"
	@echo -e "run: Locally build the source files, run the executable/binary and delete it immediately"
	@echo -e "pull: Pull/Download the library/module/package from the remote repository server to the local project"
	@echo -e "refresh: Refresh/Reload/Tidy (aka go mod "tidy") the project root module file (go.mod)"
	@echo -e "init-module: Initialize a new 'go.mod' module definition file in the current working directory (basically initializing this directory into a working module)"
	@echo -e "append-module: Define a new library/module package and Append a 'replace' keyword into 'go.mod' mapping the package/module alias to the path to the module/library"

setup:
	## Perform pre-requisite dependencies and project structure setup
	@test -f main.go && echo -e "(-) Entry point init source file 'main.go' exists" || \
		echo -e "$$go_snippet_main" >> main.go && \
			echo -e "(+) Entry point init source file 'main.go' created" || \
			echo -e "(-) Error creating 'main.go'"

build:
	## Locally build the source files and output the executable/binary
	@${GO_CC} ${GO_FLAGS} build -o ${OUT_PATH} ${GO_ENTRYPOINT} && \
		echo -e "(+) Build successful" || \
		echo -e "(-) Build error"

run:
	## Locally build the source files, run the executable/binary and delete it immediately
	@test -f ${OUT_PATH} || echo -e "(-) ${OUT_PATH} does not exist" && \
		${GO_CC} ${GO_FLAGS} run ${GO_RUN} ${GO_RUN_FLAGS} && \
			echo -e "(+) Project ran successfully" || \
			echo -e "(-) Project error encountered"

pull:
	## Pull/Download the library/module/package from the remote repository server to the local project
	@${GO_CC} ${GO_FLAGS} get ${PKG_DEPS} && \
		echo -e "(+) Package dependencies obtained successfully" || \
		echo -e "(-) Error encountered obtaining package dependencies"

refresh:
	## Refresh/Reload/Tidy (aka go mod "tidy") the project root module file (go.mod)
	@${GO_CC} ${GO_FLAGS} mod tidy && \
		echo -e "(+) Project root go.mod module definitions refreshed" || \
		echo -e "(-) Error tidying project root go module definitions"

init-module:
	## Initialize a new 'go.mod' module definition file in the current working directory (basically initializing this directory into a working module)

	### Data Validation: Null Value Check - package/module alias is not provided
	@if [ "$(MOD_NAME)" = "" ]; then \
		echo -e "(-) Environment Variable 'MOD_NAME' not specified"; \
		exit 1; \
	fi

	### Begin initializing module
	@${GO_CC} ${GO_FLAGS} mod init ${MOD_NAME} && \
		echo -e "(+) Module '${MOD_NAME}' in '${MOD_PATH}' initialized successfully" || \
		echo -e "(-) Error initializing module '${MOD_NAME}' in '${MOD_PATH}'"

append-module:
	## Define a new library/module package and Append a 'replace' keyword into 'go.mod' mapping the package/module alias to the path to the module/library

	### Data Validation: Null Value Check - package/module alias is not provided
	@if [ "$(MOD_NAME)" = "" ]; then \
		echo -e "(-) Environment Variable 'MOD_NAME' not specified"; \
		exit 1; \
	fi

	### Data Validation: Null Value Check - package/module alias mapped path is not provided
	@if [ "$(MOD_PATH)" = "" ]; then \
		echo -e "(-) Environment Variable 'MOD_PATH' not specified"; \
		exit 1; \
	fi

	### Success
	@echo -e "${MOD_NAME} => ${MOD_PATH}"
	@echo -e "replace ${MOD_NAME} => ${MOD_PATH}" >> go.mod && \
		echo -e "(+) 'replace ${MOD_NAME} => ${MOD_PATH}' appended to go.mod module definitions successfully" || \
		echo -e "(-) Error adding 'replace ${MOD_NAME} => ${MOD_PATH}' to go.mod"

