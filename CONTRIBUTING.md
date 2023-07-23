# CONTRIBUTING

## Instructions/Rules
1. Please name all files according to the following format
    - Syntax
        ```console
        [language|technology].Makefile
        ```
    - Programming Languages
        - Try to stick to a 2-letter convention (if possible; i.e. cs = C#, Rust = rs, Python = py)
            - However, if the language's name is already short, you may just use that
                - Short names, for example, are like
                    + Zig
                    + C
    - Technologies
        - You may use the full name, 
            - but please use the canonical name
                - i.e.
                    + NodeJS = node
2. For all custom Makefiles for languages/technologies that already exists inside the [templates](templates) folder
    - Please place them inside the [custom](custom) folder 
        + Separated by languages
