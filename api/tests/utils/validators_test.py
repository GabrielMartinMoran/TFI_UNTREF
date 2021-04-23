import pytest
import sys
from src.utils.validators import *

TEXT_REGEX = '[A-Z]+'

def test_regex_returns_true_if_matching_regex():
    assert regex('ASD', TEXT_REGEX)

def test_regex_returns_false_if_not_matching_regex():
    assert not regex('123', TEXT_REGEX)

def test_regex_returns_false_if_data_is_none():
    assert not regex(None, TEXT_REGEX)

def test_regex_returns_false_if_pattern_is_none():
    assert not regex('ASD', None)

def test_min_length_returns_true_if_data_len_is_equal_to_min():
    assert min_length('ASD', 3)

def test_min_length_returns_true_if_data_len_is_greater_than_min():
    assert min_length('ASD', 2)

def test_min_length_returns_false_if_data_len_is_less_than_min():
    assert not min_length('ASD', 4)

def test_min_length_returns_false_if_data_is_none():
    assert not min_length(None, 4)

def test_max_length_returns_true_if_data_len_is_equal_to_max():
    assert min_length('ASD', 3)

def test_max_length_returns_true_if_data_len_is_lower_than_max():
    assert min_length('ASD', 2)

def test_max_length_returns_false_if_data_len_is_greater_than_max():
    assert not min_length('ASD', 4)

def test_max_length_returns_false_if_data_is_none():
    assert not min_length(None, 4)

def test_length_between_returns_false_if_data_is_none():
    assert not length_between(None, 0, 100)

def test_length_between_returns_false_if_data_len_is_lower_than_min():
    assert not length_between('ASD', 4, 100)

def test_length_between_returns_false_if_data_len_is_greater_than_max():
    assert not length_between('ASD', 0, 2)

def test_length_between_returns_true_if_data_len_is_between_min_and_max():
    assert length_between('ASD', 0, 4)

def test_length_between_returns_true_if_data_len_is_equal_to_min():
    assert length_between('ASD', 3, 4)

def test_length_between_returns_true_if_data_len_is_equal_to_max():
    assert length_between('ASD', 2, 3)

def test_not_null_returns_true_if_data_is_not_none():
    assert not_null('ASD')

def test_not_null_returns_false_if_data_is_none():
    assert not not_null(None)