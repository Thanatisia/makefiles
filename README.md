# Makefiles all-in-one templates repository

## Information
### Background
```
The goal is to have a centralized, all-in-one Makefile template lookup repository 
for various languages, technologies and categories that you can just Plug-and-Play
```

## Setup
### Dependencies
#### Mandatory
- Build Tools
    - Build Essentials: base-devel (pacman-based), build-essential (apt-based)
        + make
        + git

#### Optionals
- C programming
    + gcc: The GNU C Compiler; typically packaged with the GNU core utils and base development packages
    + g++: The GNU C++ Compiler; typically packaged with the GNU core utils and base development packages
    + gdb: The GNU Debugger; Dumps out the application memory for debugging purposes
- C# programming
    + dotnet: The DotNet framework developed by Microsoft for C# Compilation, DotNet Web Applications (i.e ASP(dotnet))
    + roslyn: A generic, Open Source C# Compiler
- Java programming
    + java: Java CLI utility
    + javac: Java Compiler
- Rust programming
    + cargo: Rust project management utility
    + rustc: The Rust Compiler
- Python programming
    + python3: The python3 interpreter

### Pre-Requisites
- For Windows
    + Install MinGW-w64 (for 64-bit)

### How to use?
- Obtaining the Makefile
    - Clone the repository
        ```console
        git clone --recursive https://github.com/Thanatisia/makefiles
        ```
    - Search for your target programming language
        - Search for the Makefile templates
            - Download the target Makefile
                - Using curl
                    - Default
                        ```console
                        curl -L -O https://raw.githubusercontent.com/Thanatisia/makefiles/main/tree/templates/[language].Makefile
                        ```
                    - Using custom filename
                        ```console
                        curl -L https://raw.githubusercontent.com/Thanatisia/makefiles/main/tree/templates/[language].Makefile Makefile
                        ```

- Modify the Makefile
    + According to necessity

- Invoke/Execute the Makefile
    - Default
        ```console
        make <instructions>
        ```
    - Using custom filename
        ```console
        make -f [language].Makefile <instructions>
        ```

## Documentations
### Currently supported templates
#### Programming Languages
+ [c](templates/c.Makefile)
+ [c++](templates/cpp.Makefile)
+ [python](templates/py.Makefile)
#### Technologies
+ [docker](templates/docker.Makefile)

### Planned templates
#### Programming Languages
+ ASSEMBLY: as.Makefile
+ C#: cs.Makefile
+ Golang: go.Makefile
+ OCAML: ml.Makefile
+ Rust: rs.Makefile
+ Zig: zig.Makefile
#### Technologies
+ Dotnet: dotnet.Makefile
+ NodeJS: node.Makefile

## Wiki

## Resources

## References

## Remarks

