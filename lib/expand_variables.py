import re

def _expand_variables_replace(variables, match):
    variable_name = match.group(1)

    if variable_name not in variables:
        return match.group()

    return variables[variable_name]

def expand_variables(string, variables):
    return re.sub(r'%\((.*?)\)',
        lambda match: _expand_variables_replace(variables, match), string)
