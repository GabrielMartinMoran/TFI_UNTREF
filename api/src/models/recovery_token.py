from datetime import datetime
from src.models.base_model import BaseModel
from src.utils.json_utils import get_json_prop
from src.utils.hashing import hash_password
from src.utils.id_generator import generate_unique_id
from src import config


class RecoveryToken(BaseModel):

    MODEL_VALIDATORS = []

    def __init__(self, us_id: str):
        super().__init__()
        self.user_id = us_id
        self.token_value = generate_unique_id()
        self.generated_date = datetime.utcnow()

    def to_json(self):
        return {
            'user_id': self.user_id,
            'tokenValue': self.token_value,
            'generatedDate': self.generated_date,
        }
