class MethodRoute:  # pylint: disable=too-few-public-methods

    def __init__(self, controller_class, method_name, http_type, alias, auth_required): # pylint: disable=too-many-arguments

        self.controller_class = controller_class
        self.method_name = method_name
        self.http_type = http_type
        self.alias = alias
        self.auth_required = auth_required

    def get_path(self):
        return self.alias if self.alias is not None else F'/{self.method_name}'
