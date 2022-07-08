# Brainfuck
*Created in 2017*<br>
This repo contains an interpreter for the esoteric programming language [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck).<br>
The interpreter is written in `c`.<br>
It also contains some example `brainfuck` programs.

# How to run
You can create your own `brainfuck` program in a file and run the command `./bf.exe [your_bf_program_file]`.<br>
You can also generate a `brainfuck` program that will print out the text given as an input file or as typed input text. For this you can run the command `perl brainfck.pl [file (optional)]`.

# Brainfuck syntax
| character | meaning                                                                                        |
|-----------|------------------------------------------------------------------------------------------------|
| '>'       | Increment the data pointer (point to the cell to the right)                                    |
| '<'       | Decrement the data pointer (poitn to the cell to the left)                                     |
| '+'       | Increment the byte at the data pointer (by one)                                                |
| '-'       | Decrement the byte at the data pointer (by one)                                                |
| '.'       | Output the byte at the data pointer                                                            |
| ','       | Accept one byte of input storing it's value in the byte at the data pointer                    |
| '['       | If the byte at the data pointer is zero jump forward to the command after the matching ']'     |
| ']'       | If the byte at the data pointer is nonzero jump backward to the command after the matching '[' |
