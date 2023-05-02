#!/usr/bin/env python3

import argparse
import os
import re
import subprocess
import sys


def build_arg_parser():
    parser = argparse.ArgumentParser(
        description="Get a vault password from user keyring"
    )

    parser.add_argument(
        "--vault-id",
        action="store",
        default=None,
        dest="vault_id",
        help="name of the vault secret to get from keyring",
    )
    return parser


def main():
    arg_parser = build_arg_parser()
    args = arg_parser.parse_args()

    session_key = None

    keyctl = subprocess.Popen(
        ["keyctl", "show", "@u"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    stdout, stderr = keyctl.communicate()
    for line in stdout.split("\n"):
        if "1Password op Session" in line:
            session_key = line.lstrip().split(" ")[0]
            key = subprocess.Popen(
                ["keyctl", "pipe", session_key],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True,
            )
            session_key, stderr = key.communicate()

    if not session_key:
        session_key = ""
        print(
            "No OP session key found. If not using biometric authentication this will fail.",
            file=sys.stderr,
        )

    op_args = [
            "op",
            "item",
            "get",
            args.vault_id,
            "--vault",
            "Technical",
            "--fields",
            "password",
    ]

    process = subprocess.Popen(
        op_args,
        env=dict(os.environ, OP_SESSION_my=session_key),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    stdout, stderr = process.communicate()

    if stdout == "":
        sys.stderr.write(f"op could not find key='{args.vault_id}'\n")
        sys.stderr.write(stderr)
        sys.exit(1)
    else:
        password = re.sub(r'^"|"$', "", stdout)
        sys.stdout.write(password)


if __name__ == "__main__":
    main()
