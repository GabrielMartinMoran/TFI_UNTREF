from typing import List
from .method_route import MethodRoute

class ControllerRoute:
    def __init__(self, controller_class):
        self.controller_class = controller_class
        self.methods : List[MethodRoute] = []

    def add_method(self, method_name, http_type, alias, auth_required):
        met_route = MethodRoute(self.controller_class, method_name, http_type, alias, auth_required)
        self.methods.append(met_route)

    def route(self):
        controller_name = self.controller_class.__name__
        return controller_name.lower().replace('controller', '')

    def controller_name(self):
        return self.controller_class.__name__
