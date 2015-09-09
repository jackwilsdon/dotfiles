import os, sys
from expand_variables import expand_variables

def _parse_from_dict(key, value):
    if isinstance(value, basestring):
        return DotFile(key, value)

    if ('destination' not in value
            or not isinstance(value['destination'], basestring)):
        return None

    if ('operating_system' not in value
            or not isinstance(value['operating_system'], basestring)):
        return DotFile(key, value['destination'])

    return DotFile(key, value['destination'], value['operating_system'])

def parse(obj):
    results = []

    for key in obj:
        if isinstance(obj[key], list):
            results.extend(_parse_from_list(key, obj[key]))
        elif isinstance(obj[key], dict):
            results.append(_parse_from_dict(key, obj[key]))
        elif isinstance(obj[key], basestring):
            results.append(DotFile(key, obj[key]))

    return [result for result in results if result is not None]

class DotFile(object):
    OS_MAPPINGS = {
        'osx': [ 'darwin' ],
        'linux': [ 'linux' ]
    }

    def __init__(self, source, destination, operating_system = '*'):
        self.source = source
        self.destination = destination
        self.operating_system = operating_system

    def get_expanded_source(self, variables):
        return os.path.abspath(self.source)

    def get_expanded_destination(self, variables):
        expanded_destination = expand_variables(self.destination, variables)
        relative_destination = os.path.join('~', expanded_destination)
        user_destination = os.path.expanduser(relative_destination)

        return os.path.abspath(user_destination)


    def does_apply(self):
        if self.operating_system == '*':
            return True

        if self.operating_system not in self.OS_MAPPINGS:
            return False

        return sys.platform.lower() in self.OS_MAPPINGS[self.operating_system]

    def create_path(self, destination):
        if not self.does_apply():
            return False

        directory = os.path.dirname(destination)

        if os.path.isdir(directory):
            return True

        if os.path.lexists(directory):
            return False

        os.makedirs(directory)

        return True

    def link(self, variables):
        if not self.does_apply():
            return False

        source = self.get_expanded_source(variables)
        destination = self.get_expanded_destination(variables)

        if not os.path.exists(source):
            return False

        if os.path.exists(destination):
            return os.path.realpath(destination) == source

        if not self.create_path(destination):
            return False

        os.symlink(source, destination)

        return True
