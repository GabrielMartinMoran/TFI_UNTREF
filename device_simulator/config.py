import os

TIME_BETWEEN_MEASUREMENTS = 5  # segundos
BASE_UI_PATH = os.path.join(os.path.dirname(
    os.path.realpath(__file__)), 'resources', 'base_ui.txt')

DEVICES = [
    {'name': 'Lámpara fluorescente', 'voltage': 220, 'current': 0.16},
    {'name': 'Lámpara de 100 watts', 'voltage': 220, 'current': 0.45},
    {'name': 'Aparato de video', 'voltage': 220, 'current': 0.45},
    {'name': 'Heladera', 'voltage': 220, 'current': 3.64},
    {'name': 'Freezer', 'voltage': 220, 'current': 3.18},
    {'name': 'Horno microondas', 'voltage': 220, 'current': 6.82},
    {'name': 'Cafetera', 'voltage': 220, 'current': 5.45},
    {'name': 'Secador de pelo', 'voltage': 220, 'current': 6.82},
    {'name': 'Radio', 'voltage':220, 'current': 0.91},
    {'name': 'Televisor', 'voltage': 220, 'current': 1.14},
    {'name': 'Computadora', 'voltage': 220, 'current': 1.82},
    {'name': 'Impresora', 'voltage': 220, 'current': 1.59},
    {'name': 'Dispenser de agua', 'voltage': 220, 'current': 2.27}
]


class COLORS:
    END_COLOR = '\033[0m'
    MAGENTA = '\033[35m'
    WHITE = '\033[37m'
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'

API_URL = 'http://localhost:5000/api'