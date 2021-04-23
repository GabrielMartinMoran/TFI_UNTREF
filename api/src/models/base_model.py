import datetime
from utils.text_formatters import snake_to_lower_camel


class BaseModel:

    MODEL_VALIDATORS = []

    def __init__(self):
        self.validation_errors = []
        self.created_date = datetime.datetime.now()

    def is_valid(self) -> bool:
        self.validate()
        return len(self.validation_errors) == 0

    def to_json(self) -> dict:
        raise NotImplementedError()

    def validate(self):
        # Pasa por un set para que no haya duplicados
        self.validation_errors = list({
            x.attribute
            for x in self.MODEL_VALIDATORS
            if not x.validation_function(getattr(self, x.attribute), *x.args)
        })

    @staticmethod
    def from_json(json):
        return BaseModel()
