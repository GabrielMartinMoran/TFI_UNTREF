class Validator:  # pylint: disable=too-few-public-methods

    def __init__(self, attribute, validation_function, *args):
        self.attribute = attribute
        self.validation_function = validation_function
        self.args = args
