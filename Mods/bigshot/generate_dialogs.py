#!/bin/env python3

from sys import argv, stderr, stdin, stdout
import shlex
from typing import *

def generate_dialogs(dialogs: List[str], table_name: str) -> str:
    table_name += "_dialog"
    dialog_delay = 5
    source = f"""local {table_name} = {{}}

function {table_name}.show(player, theme_song, callback)
local handle = nil
if theme_song then
handle = minetest.sound_play({{ name = theme_song }}, {{ loop = true, pos = minetest.get_player_by_name(player):get_pos() }})
end
"""
    ends = 0
    for i, token in enumerate(dialogs):
        chat_name = table_name.replace('_dialog', '').capitalize()
        source += f"""minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= {dialog_delay} do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<{chat_name}> ") .. {repr(token)})
"""
        if i == (len(dialogs) - 1):
            source += """if theme_song then
minetest.sound_stop(handle)
end
if callback then
callback()
end
"""
        ends += 1
    for i in range(ends):
        source += "end)"
    source += "end"
    source += f"\n\nreturn {table_name}"
    return source

def usage(stream: IO, pn: str):
    print(f"Usage: {pn} [OPTIONS] <NAME>", file=stream)
    print("  Options:", file=stream)
    print("    -i <FILEPATH>   Use file in <FILEPATH> as a list of dialogs. If not supplied, reads from stdin.", file=stream)
    print("    -o <FILEPATH>   Use file in <FILEPATH> as output for the generated Lua file. If not supplied, writes to stdout.", file=stream)
    print("    -h              Shows this help.", file=stream)
    print("  Name:", file=stream)
    print("    Name for the Lua table containing the generated functions.", file=stream)

if __name__ == "__main__":
    args = list(reversed(argv))
    program_name = args.pop()

    input_file: str = ""
    output_file: str = ""
    table_name: str = ""
    while len(args) > 0:
        match args.pop():
            case "-i":
                if len(args) < 1:
                    print("ERROR: no input file was provided", file=stderr)
                    usage(stdout, program_name)
                    exit(1)
                input_file = args.pop()
            case "-o":
                if len(args) < 1:
                    print("ERROR: no output file was provided", file=stderr)
                    usage(stdout, program_name)
                    exit(1)
                output_file = args.pop()
            case "-h":
                usage(stdout, program_name)
                exit(0)
            case name:
                table_name = name
    if table_name == "":
        print("ERROR: no name for the Lua table was provided", file=stderr)
        usage(stderr, program_name)
        exit(1)

    input_stream = stdin if input_file == "" else open(input_file, 'r')
    output_stream = stdout if output_file == "" else open(output_file, 'w')

    dialogs = [line.rstrip() for line in input_stream]
    print(generate_dialogs(dialogs, table_name), file=output_stream)
