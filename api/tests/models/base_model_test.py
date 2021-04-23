import pytest
from src.models.base_model import *

@pytest.fixture
def base_model():
    return BaseModel()

def test_new_base_model_validation_errors_must_be_an_empy_list(base_model):
    assert base_model.validation_errors == []


def test_to_dict_raise_exception_when_not_implemented(base_model):
    with pytest.raises(Exception):
        base_model.to_dict()

def test_is_valid_returns_true_when_no_validation_errors(base_model):
    base_model.to_dict = lambda x : {}
    assert base_model.is_valid()