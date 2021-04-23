import pytest
from src.controllers.users_controller import UsersController
from src.models.user import User


@pytest.fixture
def controller():
    cont = UsersController()
    # Mockeamos el metodo jsonify_response
    cont._BaseController__jsonify_response = lambda x, y: {
        'body': x, 'code': y}
    return cont


def test_user_controllers_instantiate_user_repository_when_instantiated(controller):
    assert controller.user_repository is not None


def test_create_returns_validation_error_when_user_in_json_body_is_not_valid(controller):
    controller.get_json_body = lambda: {
        'email': 'invalid_email', 'password': 'Passw0rd', 'username': 'Username'}
    actual = controller.create()
    assert actual['code'] == 400
    assert 'email' in actual['body']['invalid_properties']


def test_create_returns_error_when_user_with_same_email_already_exists(controller):
    controller.get_json_body = lambda: {
        'email': 'test@email.com', 'password': 'Passw0rd', 'username': 'Username', 'preferredLanguage': 'ES', 'preferredCurrency': 'ARS'}
    controller.user_repository.email_exists = lambda x: True
    actual = controller.create()
    assert actual['code'] == 500
    assert actual['body']['message'] == 'User with same email already exists'


def test_create_returns_error_when_can_not_insert_user_in_database(controller):
    controller.get_json_body = lambda: {
        'email': 'test@email.com', 'password': 'Passw0rd', 'username': 'Username', 'preferredLanguage': 'ES', 'preferredCurrency': 'ARS'}
    controller.user_repository.email_exists = lambda x: False
    controller.user_repository.insert = lambda x: (
        _ for _ in ()).throw(Exception('Error'))
    actual = controller.create()
    assert actual['code'] == 500
    assert actual['body']['message'] == 'An error has ocurred when creating user'


def test_create_returns_ok_when_user_is_created(controller):
    controller.get_json_body = lambda: {
        'email': 'test@email.com', 'password': 'Passw0rd', 'username': 'Username', 'preferredLanguage': 'ES', 'preferredCurrency': 'ARS'}
    controller.user_repository.email_exists = lambda x: False
    expected = 'new_user_id'
    controller.user_repository.insert = lambda x: expected
    actual = controller.create()
    assert actual['code'] == 201
    assert actual['body']['id'] == expected


def test_get_user_avatar_returns_error_when_email_is_none(controller):
    actual = controller.get_user_avatar(None)
    assert actual['code'] == 400
    assert 'email' in actual['body']['invalid_properties']


def test_get_user_avatar_returns_error_when_email_is_empty(controller):
    actual = controller.get_user_avatar('')
    assert actual['code'] == 400
    assert 'email' in actual['body']['invalid_properties']


def test_get_returns_json_with_avatar_prop_when_called(controller):
    expected = 'user_avatar'
    controller.user_repository.get_user_avatar = lambda x: expected
    actual = controller.get_user_avatar('test@test.com')
    assert actual['code'] == 200
    assert actual['body']['avatar'] == expected


def test_get_logged_user_data_returns_error_when_user_not_found(controller):
    controller.user_repository.get_by_id = lambda id, get_avatar: None
    actual = controller.get_logged_user_data()
    assert actual['code'] == 500
    assert actual['body']['message'] == 'Invalid user'


def test_get_logged_user_data_returns_user_when_user_found(controller):
    user = User()
    user.user_id = 'user_id'
    controller.user_repository.get_by_id = lambda id, get_avatar: user
    actual = controller.get_logged_user_data()
    assert actual['code'] == 200
    assert actual['body']['id'] == user.user_id


def test_get_returns_error_when_user_id_is_none(controller):
    actual = controller.get(None)
    assert actual['code'] == 500
    assert actual['body']['message'] == 'Invalid user id'


def test_get_returns_error_when_user_id_is_empty(controller):
    actual = controller.get('')
    assert actual['code'] == 500
    assert actual['body']['message'] == 'Invalid user id'


def test_get_returns_error_when_user_id_not_exists(controller):
    controller.user_repository.get = lambda id: None
    actual = controller.get('unexistent_id')
    assert actual['code'] == 500
    assert actual['body']['message'] == 'Invalid user id'


def test_get_returns_user_when_user_id_exists(controller):
    user = User()
    user.user_id = 'user_id'
    controller.user_repository.get = lambda id: user
    actual = controller.get('user_id')
    assert actual['code'] == 200
    assert actual['body']['id'] == user.user_id
