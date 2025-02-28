#!/usr/bin/env python3
import argparse
import os
import re

def FromSingleFile(input_file="~/sandbox/Notepad/Notepad.md", output_dir="~/sandbox/Notepad/Notes"):
    input_file = os.path.expanduser(input_file)
    ouput_dir = os.path.expanduser(ouput_dir)
    os.mkdir(output_dir)

    with open(input_file, "r") as f:
        contents = f.readlines()
        fo = open(f"{output_dir}/000000_Notes.md", "w")
        for line in contents:
            if re.match("^# \d{6}$", line):
                fo.close()
                fo = open(f"{output_dir}/{line[2:-1]}.md", "w")
            fo.write(line)
        fo.close()


def ToSingleFile(input_dir="~/sandbox/Notepad/Notes", output_file="~/sandbox/Notepad/Notepad.md"):
    input_dir = os.path.expanduser(input_dir)
    output_file = os.path.expanduser(output_file)
    files = os.listdir(input_dir)
    files.sort()
    with open(output_file, "w") as f:
        for file in files:
            with open(os.path.join(input_dir, file), "r") as fi:
                lines = fi.read()
                f.write(lines)

if __name__=="__main__":
    parser = argparse.ArgumentParser(prog='NotepadFormatter', description="Format notepad to single file or directory")
    parser.add_argument('format', choices=['file', 'dir'], help='Convert notes format to \'file\' or \'dir\'[ectory]')
    args = parser.parse_args()

    if args.format == 'file':
        ToSingleFile()
    elif args.format == 'dir':
        FromSingleFile()
