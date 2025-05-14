#!/usr/bin/env python3
import argparse
import os
import re

from pathlib import Path

def FromSingleFile(input_file="~/sandbox/Notepad/Notepad.md", output_dir="~/sandbox/Notepad/Notes"):
    input_file = os.path.expanduser(input_file)
    ouput_dir = os.path.expanduser(ouput_dir)
    # TODO: Change to use Pathlib: `Path(output_dir).mkdir(parents=True, exist_ok=True)`
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
    # TODO: Change to use Pathlib
    input_dir = os.path.expanduser(input_dir)
    output_file = os.path.expanduser(output_file)
    files = os.listdir(input_dir)
    files.sort()
    with open(output_file, "w") as f:
        for file in files:
            with open(os.path.join(input_dir, file), "r") as fi:
                lines = fi.read()
                f.write(lines)

def ExtractTicket(ticket, output_file, input_file="~/sandbox/Notepad/Notepad.md"):
    input_file = os.path.expanduser(input_file)
    current_date = ""
    in_ticket = False
    in_code = False
    with open(output_file, "w") as fo:
        fo.write(f"# {ticket}\n")
        with open(input_file, "r") as f:
            contents = f.readlines()
            for line in contents:
                if re.match("^# \d{6}$", line):
                    current_date = line[2:]
                    in_ticket = False
                    in_code = False
                if re.match("```\w$", line):
                    in_code = True
                if re.match("```$", line):
                    in_code = False
                if re.match("^## ", line) and not in_code:
                    in_ticket = False
                if re.match(f"^## {ticket}$", line) and not in_code:
                    in_ticket = True
                    fo.write(f"\n## {current_date}")
                elif in_ticket:
                    fo.write(line)

def ExportTicket(ticket):
    tmp_file = "./tmp.md"
    ToSingleFile(output_file=tmp_file)
    Path("Tickets").mkdir(parents=True, exist_ok=True)
    ExtractTicket(ticket, f"Tickets/{ticket}.md", tmp_file)

if __name__=="__main__":
    parser = argparse.ArgumentParser(prog='NotepadFormatter', description="Format notepad to single file or directory")
    parser.add_argument('--format', choices=['file', 'dir'], help='Convert notes format to \'file\' or \'dir\'[ectory]')
    parser.add_argument('--ticket', type=str, help='Ticket name')
    args = parser.parse_args()

    if args.format == 'file':
        ToSingleFile()
    elif args.format == 'dir':
        FromSingleFile()
    if args.ticket:
        ExportTicket(args.ticket)
