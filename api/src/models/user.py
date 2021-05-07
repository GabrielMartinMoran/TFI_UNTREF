from src.utils.validators.string_validator import StringValidator
from src.utils import validation_patterns
from src.models.base_model import BaseModel
from src.utils.json_utils import get_json_prop
from src.utils.hashing import hash_password

class User(BaseModel):

    MIN_USER_LENGTH = 3
    MAX_USER_LENGTH = 32

    MODEL_VALIDATORS = [
        StringValidator('username', min_len=MIN_USER_LENGTH, max_len=MAX_USER_LENGTH),
        StringValidator('email', regex=validation_patterns.EMAIL_VALIDATION_PATTERN),
        StringValidator('password', nullable=True, regex=validation_patterns.PASSWORD_VALIDATION_PATTERN),
        StringValidator('hashed_password', message='password is not valid'),
    ]

    def __init__(self):
        super().__init__()
        self.user_id = None
        self.username = None
        self.email = None
        self.avatar = None
        self.password = None
        self.hashed_password = None

    def to_json(self, include_hashed_password=False, creating_user=False):
        result = {
            'username': self.username,
            'email': self.email,
            'id': self.user_id,
            'avatar': self.avatar,
            'createdDate': self.created_date
        }
        if include_hashed_password:
            result['hashedPassword'] = self.hashed_password
        return result

    @staticmethod
    def from_json(json):
        model = User()
        model.user_id = str(get_json_prop(json, 'id', '_id'))
        model.username = get_json_prop(json, 'username')
        model.email = get_json_prop(json, 'email').lower()
        model.avatar = get_json_prop(json, 'avatar')
        model.bio = get_json_prop(json, 'bio')
        model.password = get_json_prop(json, 'password')
        if 'createdDate' in json:
            model.created_date = get_json_prop(json, 'createdDate')
        if model.password:
            model.hashed_password = hash_password(model.password)
        else:
            model.hashed_password = get_json_prop(json, 'hashedPassword')
        return model

    def password_matches(self, non_hashed_password) -> bool:
        return self.hashed_password == hash_password(non_hashed_password)