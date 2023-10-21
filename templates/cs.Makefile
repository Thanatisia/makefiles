# Makefile for C# compilation

## Variables/Ingredients

### Compiler
CC_DIR := C:/WINDOWS/Microsoft.NET/Framework64
CC_VER := v4.0.30319
CC := csc.exe
CFLAGS := 

### Source and Output Files
SRC_DIR := src
SOURCES := "src\CLI\main.cs"
OUT := 

.PHONY := help
.DEFAULT_GOALS := help

## Targets/Rules/Recipes
help:
	## Display help menu
	@echo -e "help  : Display help menu"
	@echo -e "build : Compile source codes into binary"

build:
	## Compile files
	@${CC_DIR}/${CC_VER}/${CC} ${CFLAGS} ${SOURCES}


