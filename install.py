import yaml, os
from lib import dotfile
from colorama import Fore

yaml_data = yaml.load(file('./dotfiles.yml'))

data = yaml_data.get('dotfiles', {})
dotfiles = []

for key in data:
    obj = { key: data[key] }
    dotfiles.extend(dotfile.parse(obj))

variables = os.environ
successes = 0
skipped = 0
failures = 0

for current_dotfile in dotfiles:
    source = current_dotfile.get_expanded_source(variables)
    destination = current_dotfile.get_expanded_destination(variables)

    relative_source = os.path.relpath(source, '.')
    relative_destination = os.path.relpath(destination, os.path.expanduser('~'))

    joined_source = os.path.join('.', relative_source)
    joined_destination = os.path.join('~', relative_destination)

    success = current_dotfile.link(variables)

    if success:
        successes += 1
        color = Fore.GREEN
    elif not current_dotfile.does_apply():
        skipped += 1
        color = Fore.YELLOW
    else:
        failures += 1
        color = Fore.RED

    print(joined_source + color + ' -> ' + Fore.RESET + joined_destination)
#    print(dotfile.link(os.environ))

print('-' * 10)
print(Fore.GREEN + str(successes) + Fore.RESET + ' successes')
print(Fore.YELLOW + str(skipped) + Fore.RESET + ' skipped')
print(Fore.RED + str(failures) + Fore.RESET + ' failures')
print('-' * 10)
