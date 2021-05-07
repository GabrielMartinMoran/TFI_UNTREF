from src.models.measure import Measure
from src.utils.validators.string_validator import StringValidator
from src.models.base_model import BaseModel
from src.utils.json_utils import get_json_prop

class Device(BaseModel):

    MIN_NAME_LENGTH = 1
    MAX_NAME_LENGTH = 32
    BLE_ID_LENGTH = 36

    MODEL_VALIDATORS = [
        StringValidator('name', min_len=MIN_NAME_LENGTH, max_len=MAX_NAME_LENGTH),
        StringValidator('ble_id', fixed_len=BLE_ID_LENGTH)
    ]

    def __init__(self):
        super().__init__()
        self.device_id = None
        self.name = None
        self.ble_id = None
        self.measures = []
        self.active = False
        self.turned_on = False

    def to_json(self):
        return {
            'id': self.device_id,
            'name': self.name,
            'bleId': self.ble_id,
            'measures': [measure.to_json() for measure in self.measures],
            'active': self.active,
            'turnedOn': self.turned_on
        }

    @staticmethod
    def from_json(json):
        model = Device()
        model.device_id = str(get_json_prop(json, 'id', '_id') or '')
        model.name = get_json_prop(json, 'name')
        model.ble_id = (get_json_prop(json, 'bleId') or '').lower()
        model.active = get_json_prop(json, 'active') or False
        model.turned_on = get_json_prop(json, 'turnedOn') or False
        if 'measures' in json:
            model.measures = [Measure.from_json(x) for x in get_json_prop(json, 'measures')]
        if 'createdDate' in json:
            model.created_date = get_json_prop(json, 'createdDate')
        return model
