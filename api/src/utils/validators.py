import math
import re

def regex(data, pattern):
    if not data or not pattern:
        return False
    pat = re.compile(pattern)
    return pat.match(data) is not None

def min_length(data, minl=0):
    if data is None:
        return False
    return minl <= len(data)

def max_length(data, maxl=math.inf):
    if data is None:
        return False
    return len(data) <= maxl

def length(data, length=math.inf):
    if data is None:
        return False
    return len(data) == length

def length_between(data, minl=0, maxl=math.inf):
    return min_length(data, minl) and max_length(data, maxl)

def not_null(data):
    return data is not None

def greater_than(data, min_value=0):
    return data > min_value

def value_in(data, possible_values):
    return data in possible_values
