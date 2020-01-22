#!/usr/bin/env python2
from subprocess import check_output
import os
import sys

def get_pass(acct):
    script_dir = os.path.dirname(os.path.realpath(__file__))
    return check_output([os.path.join(script_dir, "get_password.sh"), acct])[:-1].decode().strip("\n")

if __name__ == "__main__":
    print(get_pass(sys.argv[1]))
