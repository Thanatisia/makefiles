## Makefile containing targets/rules/functions for documentation generating using asciinema

## Ingredients/Variables

### Documentation Settings
#### System Command
command ?= "command-here"
#### Demo Recording
demo_recording_output_filename ?= output.cast
#### Asciinema/agg options
asciinema_options ?= "--overwrite"

### System
SHELL := bash
.PHONY := help record
.DEFAULT_RULES := help

## Targets/Rules
help:
	## Display help message
	@echo -e "help : Display this help message"
	@echo -e "record : Record the demo using asciinema-util (asciinema options)"

record:
	## Record the demo using asciinema-util (asciinema options)
	@asciinema rec -c ${command} ${asciinema_options} ${demo_recording_output_filename}

