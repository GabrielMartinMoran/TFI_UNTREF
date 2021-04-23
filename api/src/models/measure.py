from src.utils.validator import Validator
import src.utils.validators as validators
from src.models.base_model import BaseModel
from src.utils.json_utils import get_json_prop

class Measure(BaseModel):

    MODEL_VALIDATORS = [
        Validator('timestamp', validators.not_null),
        Validator('voltage', validators.not_null),
        Validator('current', validators.not_null),
    ]

    def __init__(self):
        super().__init__()
        self.timestamp = None
        self.voltage = None
        self.current = None

    def to_json(self):
        return {
            'timestamp': self.timestamp,
            'voltage': self.voltage,
            'current': self.current
        }

    @staticmethod
    def from_json(json):
        model = Measure()
        model.timestamp = get_json_prop(json, 'timestamp')
        model.voltage = get_json_prop(json, 'voltage')
        model.current = get_json_prop(json, 'current')
        return model