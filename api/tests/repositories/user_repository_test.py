from src.utils.image_encoder import ImageEncoder
import requests
from tests.repositories.mocked_collection import MockedCollection
import pytest
from src.models.user import User
from src.repositories.user_repository import UserRepository
from src.utils import global_variables
from src import config

@pytest.fixture
def repository():
    global_variables.MONGO_CLIENT_INSTANCE = {
        config.DB_NAME: {
            UserRepository.COLLECTION_NAME: MockedCollection()
        }
    }
    return UserRepository()

user_json = {'id': '6081c8a36cd29124023621b0', 'email': 'test@test.com'}

def test_get_by_email_returns_user_when_user_with_same_email_is_registered(repository: UserRepository):
    repository.collection.prepare_return('find_one', user_json)
    actual = repository.get_by_email(user_json['email'])
    assert actual.user_id == user_json['id']

def test_get_by_email_returns_none_when_user_with_provided_email_is_not_registered(repository: UserRepository):
    repository.collection.prepare_return('find_one', None)
    actual = repository.get_by_email(user_json['email'])
    assert actual is None


def test_email_exists_returns_true_when_user_with_same_email_is_registered(repository: UserRepository):
    repository.get_by_email = lambda x: User()
    actual = repository.email_exists(user_json['email'])
    assert actual

def test_email_exists_returns_false_when_user_with_same_email_is_not_registered(repository: UserRepository):
    repository.get_by_email = lambda x: None
    actual = repository.email_exists(user_json['email'])
    assert not actual

def test_get_by_id_returns_user_when_user_with_same_id_exists(repository: UserRepository):
    repository.collection.prepare_return('find_one', user_json)
    actual = repository.get_by_id(user_json['id'])
    assert actual.user_id == user_json['id']

def test_get_by_id_returns_user_with_avatar_when_get_avatar_is_true_and_user_exists(repository: UserRepository):
    repository.collection.prepare_return('find_one', user_json)
    # Usamos el email para validar que llegue como parametro
    avatar = user_json['email']
    repository.get_user_avatar = lambda x: avatar
    actual = repository.get_by_id(user_json['id'], get_avatar=True)
    assert actual.user_id == user_json['id']
    assert actual.avatar == avatar

def test_get_user_avatar_returns_base64_avatar(repository: UserRepository):
    class Response:
        content = b'1'
    resp = Response()
    requests.get = lambda x: resp
    actual = repository.get_user_avatar(user_json['email'])
    assert ImageEncoder.BASE_64_ENCODING_PREFIX in actual

def test_insert_adds_user_to_collection(repository: UserRepository):
    class Inserted:
        inserted_id = '12345'
    repository.collection.prepare_return('insert_one', Inserted())
    user = User.from_json(user_json)
    actual = repository.insert(user)
    assert actual == Inserted.inserted_id

def test_get_returns_user_when_user_with_same_id_is_registered(repository: UserRepository):
    repository.collection.prepare_return('find_one', user_json)
    actual = repository.get(user_json['id'])
    assert actual.user_id == user_json['id']

def test_get_returns_none_when_user_with_provided_id_is_not_registered(repository: UserRepository):
    repository.collection.prepare_return('find_one', None)
    actual = repository.get(user_json['id'])
    assert actual is None