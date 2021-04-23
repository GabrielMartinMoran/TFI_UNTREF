import pytest
import datetime
from src.models.user import User
from src.utils.hashing import hash_password


@pytest.fixture
def user():
    user = User()
    user.email = 'test@test.com'
    user.username = 'username'
    user.hashed_password = hash_password('Passw0rd')
    user.preferred_language = 'ES'
    user.preferred_currency  = 'ARS'
    return user

@pytest.fixture
def user_json():
    return {
        'id': '1234',
        'username': 'username',
        'email': 'test@test.com',
        'avatar': 'image_avatar',
        'bio': 'bio',
        'verified': True,
        'verificationToken': 'token',
        'createdDate': 'date',
        'password': 'Password',
        'preferredLanguage': 'ES',
        'preferredCurrency': 'ARS'
    }

def test_is_valid_returns_false_when_username_is_null(user):
    user.username = None
    assert not user.is_valid()

def test_is_valid_returns_false_when_username_len_greater_than_32(user):
    user.username = "A" * 33
    assert not user.is_valid()

def test_is_valid_returns_false_when_username_len_is_lower_than_3(user):
    user.username = "AA"
    assert not user.is_valid()

def test_is_valid_returns_false_when_email_is_null(user):
    user.email = None
    assert not user.is_valid()

def test_is_valid_returns_false_when_email_is_invalid(user):
    user.email = 'invalidemail@invalid'
    assert not user.is_valid()

def test_is_valid_with_no_hashed_password_returns_false(user):
    user.hashed_password = None
    assert not user.is_valid()

def test_is_valid_with_no_preferred_currency_returns_false(user):
    user.preferred_currency = None
    assert not user.is_valid()

def test_is_valid_with_no_preferred_language_returns_false(user):
    user.preferred_language = None
    assert not user.is_valid()

def test_is_valid_returns_true_when_all_properties_are_valid(user):
    assert user.is_valid()

def test_from_json_not_maps_created_date_when_not_provided(user_json):
    del user_json['createdDate']
    actual = User.from_json(user_json)
    assert actual.created_date != 'date'

def test_from_json_set_hashed_password_with_password_hashed_when_password_is_provided(user_json):
    user_json['password'] = "NEW_PASSWORD"
    actual = User.from_json(user_json)
    assert actual.hashed_password == hash_password(user_json['password'])

def test_from_json_returns_user_when_json_is_provided(user_json):
    actual = User.from_json(user_json)
    assert actual.user_id == user_json['id']
    assert actual.username == user_json['username']
    assert actual.email == user_json['email']
    assert actual.avatar == user_json['avatar']
    assert actual.bio == user_json['bio']
    assert actual.hashed_password == hash_password(user_json['password'])
    assert actual.created_date == user_json['createdDate']
    assert actual.verified == user_json['verified']
    assert actual.verification_token == user_json['verificationToken']
    assert actual.preferred_currency == user_json['preferredCurrency']
    assert actual.preferred_language == user_json['preferredLanguage']

def test_password_matches_returns_true_when_hashed_password_is_equal_to_result_of_password_hashing(user):
    assert user.password_matches('Passw0rd')

def test_password_matches_returns_false_when_hashed_password_is_different_than_result_of_password_hashing(user):
    assert not user.password_matches('NotPassw0rd')

def test_is_valid_bio_returns_true_when_bio_len_is_lower_or_equal_to_5000():
    assert User.is_valid_bio('')
    assert User.is_valid_bio('A' * 4999)
    assert User.is_valid_bio('A' * 5000)

def test_is_valid_bio_returns_false_when_bio_len_is_greater_than_5000():
    assert not User.is_valid_bio('A' * 5001)