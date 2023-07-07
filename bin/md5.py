#!/usr/bin/env python3

import hashlib, os, csv, sys
from pathlib import Path
import argparse

def md5_update_from_file(filename, hash):
    assert Path(filename).is_file()
    with open(str(filename), "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash.update(chunk)
    return hash


def md5_file(filename):
    return md5_update_from_file(filename, hashlib.md5()).hexdigest()

def parse_args(args=None):
    Description = "Pull the md5 checksums of all files"
    Epilog = "Example usage: python md5.py <DIR_IN> <FILE_OUT>"

    parser = argparse.ArgumentParser(description=Description, epilog=Epilog)
    parser.add_argument("DIR_IN", help="Input directory.")
    parser.add_argument("FILE_OUT", help="Output txt file.")
    return parser.parse_args(args)

def md5_run(DIR_IN, FILE_OUT):
    with open(FILE_OUT,'w',newline='\n') as output:
        wr=csv.writer(output, quoting=csv.QUOTE_ALL, delimiter=' ')
        wr.writerow(['md5','filename'])

        for dirpath, dirname, filename in os.walk(DIR_IN):
            for f in filename:
                relpath="/".join(dirpath.strip("/").split('/')[3:])
                md5=md5_file(os.path.join(dirpath,f))
                wr.writerow([os.path.join(relpath,f),md5])

def main(args=None):
    args = parse_args(args)
    md5_run(args.DIR_IN, args.FILE_OUT)


if __name__ == "__main__":
    sys.exit(main())
