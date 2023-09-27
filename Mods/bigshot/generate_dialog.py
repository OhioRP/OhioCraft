#!/bin/env python3

from sys import argv, stderr, stdout
import shlex

def usage(stream, pn):
    print(f"Usage: {pn} <DIALOGS> <NAME>", file=stream)
    print("  DIALOGS - single string containing all dialogs wrapped in quotation marks and separated by spaces", file=stream)
    print("  If `help` is provided instead of actual dialogs, this help is shown instead of generating the dialogs", file=stream)
    print(f"    EXAMPLE: {pn} \"\\\"Hello!\\\" \\\"How are you?\\\"\"", file=stream)
    print("  NAME - the name of the Lua table containing the function to start showing the dialogs", file=stream)

if __name__ == "__main__":
    if len(argv) < 2:
        print("ERROR: no argument was provided", file=stderr)
        usage(stderr, argv[0])
        exit(1)

    if argv[1] == "help":
        usage(stdout, argv[0])
        exit(0)
    else:
        if len(argv) < 3:
            print("ERROR: no name for the Lua table was provided", file=stream)
            usage(stderr, argv[0])
            exit(1)

        tokens = shlex.split(argv[1])
        # table name
        table_name = argv[2] + "_dialog"
        dialog_delay = 5
        source = f"""local {table_name} = {{}}

function {table_name}.show(player, theme_song, callback)
local handle = nil
if theme_song then
handle = minetest.sound_play({{ name = theme_song }}, {{ loop = true }})
end
"""
        ends = 0
        for i, token in enumerate(tokens):
            source += f"""minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= {dialog_delay} do end
end, function()
minetest.chat_send_player(player, \"{token}\")
"""
            if i == (len(tokens) - 1):
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

        print(source)
