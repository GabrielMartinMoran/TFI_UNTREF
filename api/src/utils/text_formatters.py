def snake_to_camel(word):
    return ''.join(x.capitalize() or '_' for x in word.split('_'))

def snake_to_lower_camel(word):
    components = word.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])
