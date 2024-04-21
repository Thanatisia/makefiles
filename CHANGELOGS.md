# CHANGLEOGS

## Table of Contents
+ [2024-03-14](#2024-03-14)
+ [2024-04-14](#2024-04-14)
+ [2024-04-15](#2024-04-15)
+ [2024-04-21](#2024-04-21)

## Entry Logs
### 2024-03-14
#### 1558H
- Updates
    - Updated 'docker.Makefile' in 'templates/'
        - Updated targets, instructions and variables to be more current 
            + based on the format of the docker Makefile I used in my newer projects

### 2024-03-23
#### 1455H
- Updates
    - Updated 'docker.Makefile' in 'templates/'
        - Added new instructions/targets
            + proc : Display processes of the container
            + exec : Execute command in container

### 2024-04-14
#### 1704H
- New
    - Added new directory 'python' in 'custom/'
        + Added new custom Makefile 'python-venv.Makefile' in for Python Virtual Environment management
- Updates
    - Updated document 'README.md' in 'custom/'
        + Added new entry

### 2024-04-15
#### 1722H
- New
    + Added a windows variant 'python-venv.windows.Makefile' of 'python-venv.linux.Makefile' in 'customs/python'
- Updates
    + Renamed 'python-venv.Makefile' => 'python-venv.linux.Makefile' in 'customs/python'

### 2024-04-21
#### 1515H
- Updates
    - Updated document 'README.md' in 'custom/'
        + Added linux and windows support entries to 'python virtual environment automanager' Makefile template
    - Updated Makefile 'python-venv.linux.Makefile' in 'custom/python'
        + Added target to chroot into the Virtual Environment with custom variables for customizing the prompt
    - Updated Makefile 'python-venv.windows.Makefile' in 'custom/python'
        + Added target to chroot into the Virtual Environment with custom variables for customizing the prompt

