import types
from src.utils.validators.int_validator import IntValidator
from src.utils.validators.float_validator import FloatValidator
from src.models.base_model import BaseModel
from src.utils.json_utils import get_json_prop

class Measure(BaseModel):

    MODEL_VALIDATORS = [
        IntValidator('timestamp', min=0),
        FloatValidator('voltage', min=0),
        FloatValidator('current', min=0),
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
        if isinstance(model.voltage, int):
            model.voltage = float(model.voltage)
        model.current = get_json_prop(json, 'current')
        if isinstance(model.current, int):
            model.current = float(model.current)
        return model