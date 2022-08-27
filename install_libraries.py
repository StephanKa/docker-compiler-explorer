import os
import argparse
import subprocess


BASE_PATH = "/compiler-explorer"
LIB_PATH = "libs"


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--name', required=True, help='Please provide a name for the library.')
    parser.add_argument('-u', '--url', required=True, help='Please provide a github url.')
    parser.add_argument('-v', '--versions', required=True, nargs='+', help='Please provide git tags for given library.')
    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()
    print(f"{args.name} - {args.url} - {args.versions}")
    if not os.path.exists(BASE_PATH):
        os.mkdir(BASE_PATH)

    if not os.path.exists(f"{BASE_PATH}/{LIB_PATH}"):
        os.mkdir(f"{BASE_PATH}/{LIB_PATH}")

    WHOLE_LIB_PATh = f"{BASE_PATH}/{LIB_PATH}/{args.name}"
    if not os.path.exists(WHOLE_LIB_PATh):
        os.mkdir(WHOLE_LIB_PATh)

    git_repo = args.url
    if not git_repo.endswith(".git"):
        git_repo = f"{git_repo}.git"

    os.chdir(WHOLE_LIB_PATh)
    for version in args.versions:
        subprocess.call(["git", "clone", "--single-branch", "--branch", f"{version}", f"{git_repo}", f"{version}"])
