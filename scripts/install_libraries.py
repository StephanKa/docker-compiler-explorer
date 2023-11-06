import os
import argparse
import subprocess
import sys

BASE_PATH = '/compiler-explorer'
LIB_PATH = 'libs'


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--name', required=True, help='Please provide a name for the library.')
    parser.add_argument('-u', '--url', required=True, help='Please provide a github url.')
    parser.add_argument('-v', '--versions', required=True, nargs='+', help='Please provide git tags for given library.')
    if sys.version_info < (3, 9):
        parser.add_argument('-i', '--install-lib', default=False, action='store_true', help='Will build and install the library')
    else:
        parser.add_argument('-i', '--install-lib', default=False, action=argparse.BooleanOptionalAction, help='Will build and install the library')
    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()
    print(f'{args.name} - {args.url} - {args.versions}')
    if not os.path.exists(BASE_PATH):
        os.mkdir(BASE_PATH)

    if not os.path.exists(f'{BASE_PATH}/{LIB_PATH}'):
        os.mkdir(f'{BASE_PATH}/{LIB_PATH}')

    WHOLE_LIB_PATH = f'{BASE_PATH}/{LIB_PATH}/{args.name}'
    if not os.path.exists(WHOLE_LIB_PATH):
        os.mkdir(WHOLE_LIB_PATH)

    git_repo = args.url
    if not git_repo.endswith('.git'):
        git_repo = f'{git_repo}.git'

    for version in args.versions:
        os.chdir(WHOLE_LIB_PATH)
        subprocess.call(['git', 'clone', '--single-branch', '--branch', f'{version}', f'{git_repo}', f'{version}'])
        if args.install_lib:
            os.makedirs(f'{WHOLE_LIB_PATH}/{version}/build')
            os.chdir(f'{WHOLE_LIB_PATH}/{version}/build')
            subprocess.call(['cmake', '-DCMAKE_POSITION_INDEPENDENT_CODE=TRUE', '..'])
            subprocess.call(['make', 'install'])
