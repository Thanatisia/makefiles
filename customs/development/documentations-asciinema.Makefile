## Makefile containing targets/rules/functions for documentation generating using asciinema and asciinema-agg

## Ingredients/Variables

### Documentation Settings
#### System Command
command ?= command-here
#### Demo Recording
demo_recording_output_filename ?= output.cast
#### Demo GIF
demo_gif_input_filename ?= output.cast
demo_gif_output_filename ?= output
demo_gif_output_format ?= gif
demo_gif_background_theme ?= monokai
demo_gif_foreground_font ?=
demo_gif_canvas_size ?= --cols 71 --rows 13
demo_gif_font_size ?= --font-size 16
#### Asciinema/agg options
asciinema_options ?= "--overwrite"
asciinema_agg_options ?= "--theme $(demo_gif_background_theme) $(demo_gif_canvas_size) $(demo_gif_font_size) $(demo_gif_foreground_font)"

### System
SHELL := bash
.PHONY := help record
.DEFAULT_RULES := help

## Targets/Rules
help:
	## Display help message
	@echo -e "help : Display this help message"
	@echo -e "record : Record the demo using asciinema-util (asciinema options)"
	@echo -e "convert : Convert the recorded demo .cast file using asciinema-util (asciinema-agg options)"

record:
	## Record the demo using asciinema-util (asciinema options)
	@asciinema rec -c "${command}" ${asciinema_options} ${demo_recording_output_filename}

convert:
	## Convert the recorded demo .cast file using asciinema-util (asciinema-agg options)
	@agg ${asciinema_agg_options} ${demo_gif_input_filename} ${demo_gif_output_filename}.${demo_gif_output_format}

