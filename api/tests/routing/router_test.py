from src.utils import global_variables
from src.routing.router import Router

class MockedController:
    pass

def discover_controllers_mocked(router_instance):
    Router.register_http_method({
        'type': 'POST', 'alias': None,'class_name': 'MockedController', 'method_name': 'class_method', 'auth_required': True
    })
    return [MockedController]

def test_router_register_router_instance_in_global_variables_when_instantiated():
    router = Router()
    assert router == global_variables.ROUTER_INSTANCE

def test_router_map_rutes_when_instantiated():
    Router._Router__discover_controllers = discover_controllers_mocked
    router = Router()
    assert 1 == len(router.routes)
    assert MockedController == router.routes[0].controller_class
    assert 'class_method' == router.routes[0].methods[0].method_name
    assert 1 == len(router.routes[0].methods)
    assert 'POST' == router.routes[0].methods[0].http_type
    assert None == router.routes[0].methods[0].alias
    assert router.routes[0].methods[0].auth_required