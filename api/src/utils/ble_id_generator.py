import datetime
import random

BLE_ID_PATTERN = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
TIMESTAMP_MULTIPLIER = 1000000


def generate_ble_id():
    chars_lenght = len(BLE_ID_PATTERN.replace('-', ''))
    unique = generate_unique_id(chars_lenght)
    ble_id = ''
    for char in BLE_ID_PATTERN:
        if char == '-':
            ble_id += '-'
            continue
        ble_id += unique[0]
        unique = unique[1:]
    return ble_id


def get_hextimestamp():
    timestamp = datetime.datetime.now(datetime.timezone.utc).timestamp()
    full_int_timestamp = int(timestamp * TIMESTAMP_MULTIPLIER)
    return to_hex_str(full_int_timestamp)


def get_random_id(size):
    hex_chars = [to_hex_str(x) for x in range(0, 16)]
    result = ''
    for x in range(size):
        result += random.choice(hex_chars)
    return result


def generate_unique_id(size) -> str:
    hex_time_id = get_hextimestamp()
    random_id = get_random_id(size - len(hex_time_id))
    result_id = hex_time_id + random_id
    return result_id[:size]


def to_hex_str(value: int):
    # [2:] para quitar el 0x luego de convertirlo
    return str(hex(value))[2:]
