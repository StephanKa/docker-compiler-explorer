import yaml
import os
from jinja2 import Environment, FileSystemLoader


def main():
    """
    Execute all work for parsing and validating.
    """
    with open(f'{os.getcwd()}/config/configuration.yml', 'r') as stream:
        data_loaded = yaml.load(stream, Loader=yaml.Loader)

    file_loader = FileSystemLoader(f'{os.getcwd()}/template')
    env = Environment(loader=file_loader)

    # generate Dockerfile
    template = env.get_template('Dockerfile.jinja2')
    output = template.render(gcc=data_loaded['compiler']['gcc'], clang=data_loaded['compiler']['clang'], libraries=data_loaded['libs'],
                             tools=data_loaded['tools'])

    if not os.path.exists(f'{os.getcwd()}/generated'):
        os.mkdir(f'{os.getcwd()}/generated')
    with open(f'{os.getcwd()}/generated/Dockerfile', 'w') as f:
        f.write(output)

    # generate cpp.properties
    template = env.get_template('cpp.properties.jinja2')
    output = template.render(gcc=data_loaded['compiler']['gcc'], clang=data_loaded['compiler']['clang'], libraries=data_loaded['libs'],
                             tools=data_loaded['tools'])

    if not os.path.exists(f'{os.getcwd()}/generated'):
        os.mkdir(f'{os.getcwd()}/generated')
    with open(f'{os.getcwd()}/generated/cpp.properties', 'w') as f:
        f.write(output)

    maximum_compiler_count = max([len(i) for i in data_loaded['compiler']])
    template = env.get_template('README.md.jinja2')
    output = template.render(compiler=data_loaded['compiler'], libraries=data_loaded['libs'])

    with open(f'{os.getcwd()}/README.md', 'w') as f:
        f.write(output)


if __name__ == '__main__':
    main()
